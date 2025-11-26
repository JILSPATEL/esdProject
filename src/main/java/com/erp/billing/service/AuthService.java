package com.erp.billing.service;

import com.erp.billing.dto.LoginRequest;
import com.erp.billing.dto.LoginResponse;
import com.erp.billing.entity.Student;
import com.erp.billing.exception.UnauthorizedException;
import com.erp.billing.repository.StudentRepository;
import com.erp.billing.security.GoogleTokenVerifier;
import com.erp.billing.security.JwtUtil;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthService {
    
    @Autowired
    private StudentRepository studentRepository;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    @Autowired
    private GoogleTokenVerifier googleTokenVerifier;
    
    public LoginResponse login(LoginRequest loginRequest) {
        GoogleIdToken.Payload payload = googleTokenVerifier.verify(loginRequest.getCredential());
        String email = payload.getEmail();
        
        if (email == null || email.isBlank()) {
            throw new UnauthorizedException("Google account email is missing");
        }
        
        Student student = studentRepository.findByEmail(email)
                .orElseThrow(() -> new UnauthorizedException("Email is not registered in the system"));
        
        Boolean emailVerified = (Boolean) payload.get("email_verified");
        if (emailVerified != null && !emailVerified) {
            throw new UnauthorizedException("Google account email is not verified");
        }
        
        String token = jwtUtil.generateToken(student.getEmail(), student.getStudentId());
        return new LoginResponse(
                token,
                student.getEmail(),
                student.getStudentId(),
                student.getFirstName(),
                student.getLastName(),
                student.getRollNumber(),
                "Google login successful"
        );
    }
}

