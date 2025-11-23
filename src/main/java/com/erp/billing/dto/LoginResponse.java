package com.erp.billing.dto;

public class LoginResponse {
    private String token;
    private String email;
    private Integer studentId;
    private String message;
    
    public LoginResponse() {
    }
    
    public LoginResponse(String token, String email, Integer studentId, String message) {
        this.token = token;
        this.email = email;
        this.studentId = studentId;
        this.message = message;
    }
    
    public String getToken() {
        return token;
    }
    
    public void setToken(String token) {
        this.token = token;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public Integer getStudentId() {
        return studentId;
    }
    
    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
}

