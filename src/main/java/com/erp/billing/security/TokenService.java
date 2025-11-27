package com.erp.billing.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@Service
public class TokenService {

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    public GoogleTokenInfo validateIdToken(String idToken) {
        String url = "https://oauth2.googleapis.com/tokeninfo?id_token=" + idToken;
        try {
            String response = restTemplate.getForObject(url, String.class);
            Map<String, Object> body = objectMapper.readValue(response, Map.class);

            GoogleTokenInfo info = new GoogleTokenInfo();

            Object emailObj = body.get("email");
            info.setEmail(emailObj != null ? (String) emailObj : null);

            Object emailVerifiedObj = body.get("email_verified");
            if (emailVerifiedObj != null && !"null".equals(String.valueOf(emailVerifiedObj))) {
                info.setEmailVerified(Boolean.parseBoolean(String.valueOf(emailVerifiedObj)));
            } else {
                info.setEmailVerified(false);
            }

            Object expiresInObj = body.get("expires_in");
            if (expiresInObj != null && !"null".equals(String.valueOf(expiresInObj))) {
                try {
                    info.setExpiresInSeconds(Long.parseLong(String.valueOf(expiresInObj)));
                } catch (NumberFormatException e) {
                    info.setExpiresInSeconds(0L);
                }
            } else {
                info.setExpiresInSeconds(0L);
            }

            return info;
        } catch (Exception e) {
            throw new RuntimeException("Failed to validate token", e);
        }
    }

    public static class GoogleTokenInfo {
        private String email;
        private boolean emailVerified;
        private long expiresInSeconds;

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public boolean isEmailVerified() {
            return emailVerified;
        }

        public void setEmailVerified(boolean emailVerified) {
            this.emailVerified = emailVerified;
        }

        public long getExpiresInSeconds() {
            return expiresInSeconds;
        }

        public void setExpiresInSeconds(long expiresInSeconds) {
            this.expiresInSeconds = expiresInSeconds;
        }
    }
}
