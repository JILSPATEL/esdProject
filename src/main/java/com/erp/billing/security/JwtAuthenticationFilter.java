package com.erp.billing.security;

import com.erp.billing.security.TokenService.GoogleTokenInfo;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

/**
 * Filter that validates tokens for protected endpoints.
 * Supports both Google ID Token (via Cookie) and JWT (via Authorization
 * Header).
 */
@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private static final String ID_TOKEN_COOKIE_NAME = "ID_TOKEN";

    @Autowired
    private TokenService tokenService;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private UserDetailsService userDetailsService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        // 1. Try JWT from Authorization Header first (Client-side flow)
        // 1. Try JWT from Authorization Header first (Client-side flow)
        String jwtToken = extractJwtToken(request);
        if (jwtToken != null) {
            try {
                String email = jwtUtil.getEmailFromToken(jwtToken);
                if (email != null && jwtUtil.validateToken(jwtToken, email)) {
                    // Check if we need to set/overwrite authentication
                    // This is crucial for multi-tab support where cookies might be shared (User B)
                    // but the header sends a specific user's token (User A).
                    org.springframework.security.core.Authentication existingAuth = SecurityContextHolder.getContext()
                            .getAuthentication();

                    if (existingAuth == null || !existingAuth.getName().equals(email)) {
                        authenticateUser(request, email);
                    }
                }
            } catch (Exception e) {
                // Ignore and try next method
            }
        }

        // 2. Try Google ID Token from Cookie (Server-side flow)
        if (SecurityContextHolder.getContext().getAuthentication() == null) {
            String idToken = extractIdTokenFromCookie(request);
            if (idToken != null) {
                try {
                    GoogleTokenInfo info = tokenService.validateIdToken(idToken);
                    if (info.getEmail() != null && info.isEmailVerified()) {
                        authenticateUser(request, info.getEmail());
                    }
                } catch (Exception e) {
                    // Ignore
                }
            }
        }

        filterChain.doFilter(request, response);
    }

    private void authenticateUser(HttpServletRequest request, String email) {
        UserDetails userDetails = userDetailsService.loadUserByUsername(email);
        UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                userDetails, null, userDetails.getAuthorities());
        authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        SecurityContextHolder.getContext().setAuthentication(authToken);
    }

    private String extractJwtToken(HttpServletRequest request) {
        String authorizationHeader = request.getHeader("Authorization");
        if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
            return authorizationHeader.substring(7);
        }
        return null;
    }

    private String extractIdTokenFromCookie(HttpServletRequest request) {
        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if (ID_TOKEN_COOKIE_NAME.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
}
