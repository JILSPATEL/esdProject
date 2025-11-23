package com.erp.billing.service;

import com.erp.billing.dto.LoginRequest;
import com.erp.billing.dto.LoginResponse;
import com.erp.billing.entity.Student;
import com.erp.billing.exception.UnauthorizedException;
import com.erp.billing.repository.StudentRepository;
import com.erp.billing.security.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

@Service
public class AuthService {
    
    @Autowired
    private StudentRepository studentRepository;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    @Autowired
    private AuthenticationManager authenticationManager;
    
    public LoginResponse login(LoginRequest loginRequest) {
        try {
            Student student = studentRepository.findByEmail(loginRequest.getEmail())
                    .orElseThrow(() -> new UnauthorizedException("Invalid email or password"));
            
            // For demo purposes: use email as password (since password field doesn't exist in DB)
            // In production, you should have a password field and use password encoder
            try {
                authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                        loginRequest.getEmail(),
                        loginRequest.getPassword()
                    )
                );
            } catch (BadCredentialsException e) {
                // For demo: if authentication fails, check if password matches email
                // This is a workaround since we don't have password in DB
                if (!loginRequest.getPassword().equals(loginRequest.getEmail())) {
                    throw new UnauthorizedException("Invalid email or password");
                }
            }
            
            String token = jwtUtil.generateToken(student.getEmail(), student.getStudentId());
            
            return new LoginResponse(token, student.getEmail(), student.getStudentId(), "Login successful");
        } catch (BadCredentialsException e) {
            throw new UnauthorizedException("Invalid email or password");
        }
    }
}

