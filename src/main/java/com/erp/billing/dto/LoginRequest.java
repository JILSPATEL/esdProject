package com.erp.billing.dto;

import jakarta.validation.constraints.NotBlank;

/**
 * Carries the Google ID token issued on the client side.
 */
public class LoginRequest {
    
    @NotBlank(message = "Google credential is required")
    private String credential;
    
    public LoginRequest() {
    }
    
    public LoginRequest(String credential) {
        this.credential = credential;
    }
    
    public String getCredential() {
        return credential;
    }
    
    public void setCredential(String credential) {
        this.credential = credential;
    }
}

