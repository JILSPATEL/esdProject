package com.erp.billing.controller;

import com.erp.billing.entity.Student;
import com.erp.billing.exception.UnauthorizedException;
import com.erp.billing.repository.StudentRepository;
import com.erp.billing.security.JwtUtil;
import com.erp.billing.security.TokenService;
import com.erp.billing.security.TokenService.GoogleTokenInfo;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Controller
public class OAuthController {

    @Value("${spring.security.oauth2.client.registration.google.client-id}")
    private String clientId;

    @Value("${spring.security.oauth2.client.registration.google.client-secret}")
    private String clientSecret;

    @Value("${app.oauth2.redirect-uri}")
    private String redirectUri;

    @Value("${app.frontend.url:http://localhost:5173}")
    private String frontendUrl;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private JwtUtil jwtUtil;

    @GetMapping("/login")
    public void login(HttpServletResponse response) throws IOException {
        String scope = "openid email profile";
        String authUrl = "https://accounts.google.com/o/oauth2/v2/auth" +
                "?client_id=" + clientId +
                "&redirect_uri=" + URLEncoder.encode(redirectUri, StandardCharsets.UTF_8) +
                "&response_type=code" +
                "&scope=" + URLEncoder.encode(scope, StandardCharsets.UTF_8) +
                "&access_type=offline";
        response.sendRedirect(authUrl);
    }

    @GetMapping("/oauth2/callback")
    public void callback(@RequestParam("code") String code,
            @RequestParam(value = "error", required = false) String error,
            HttpServletRequest request,
            HttpServletResponse response) throws IOException {

        if (error != null) {
            response.sendRedirect(frontendUrl + "/?error=" + URLEncoder.encode(error, StandardCharsets.UTF_8));
            return;
        }

        try {
            // 1. Exchange code for tokens
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

            MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
            map.add("client_id", clientId);
            map.add("client_secret", clientSecret);
            map.add("code", code);
            map.add("grant_type", "authorization_code");
            map.add("redirect_uri", redirectUri);

            HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(map, headers);
            ResponseEntity<String> tokenResponse = restTemplate.postForEntity(
                    "https://oauth2.googleapis.com/token", entity, String.class);

            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode root = objectMapper.readTree(tokenResponse.getBody());
            String idToken = root.path("id_token").asText();

            // 2. Validate ID token
            GoogleTokenInfo tokenInfo = tokenService.validateIdToken(idToken);

            if (tokenInfo.getEmail() == null) {
                throw new UnauthorizedException("Google account email is missing");
            }

            if (!tokenInfo.isEmailVerified()) {
                throw new UnauthorizedException("Google account email is not verified");
            }

            // 3. Check if user exists
            Student student = studentRepository.findByEmail(tokenInfo.getEmail()).orElse(null);

            // If student not found, redirect to norecord page
            if (student == null) {
                response.sendRedirect(frontendUrl + "/no-record");
                return;
            }

            // 4. Generate JWT
            String jwtToken = jwtUtil.generateToken(student.getEmail(), student.getStudentId());

            // 5. Set Cookie
            Cookie cookie = new Cookie("ID_TOKEN", idToken); // Storing Google ID Token in cookie as per original flow
            cookie.setHttpOnly(true);
            cookie.setSecure(false); // Set to true in production
            cookie.setPath("/");
            cookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
            response.addCookie(cookie);

            // Also set JWT cookie for our own auth
            Cookie jwtCookie = new Cookie("JWT_TOKEN", jwtToken);
            jwtCookie.setHttpOnly(true);
            jwtCookie.setSecure(false);
            jwtCookie.setPath("/");
            jwtCookie.setMaxAge(7 * 24 * 60 * 60);
            response.addCookie(jwtCookie);

            // 6. Redirect to frontend callback with token
            response.sendRedirect(frontendUrl + "/auth/callback?token=" + jwtToken);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(frontendUrl + "/?error="
                    + URLEncoder.encode("Login failed: " + e.getMessage(), StandardCharsets.UTF_8));
        }
    }
}
