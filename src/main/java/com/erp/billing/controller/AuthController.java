package com.erp.billing.controller;

import com.erp.billing.dto.ApiResponse;
import com.erp.billing.dto.LoginRequest;
import com.erp.billing.dto.LoginResponse;
import com.erp.billing.service.AuthService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*")
public class AuthController {

    @Autowired
    private AuthService authService;

    @Autowired
    private com.erp.billing.repository.StudentRepository studentRepository;

    @PostMapping("/login")
    public ResponseEntity<ApiResponse<LoginResponse>> loginWithGoogle(@Valid @RequestBody LoginRequest loginRequest) {
        LoginResponse response = authService.login(loginRequest);
        return ResponseEntity.ok(ApiResponse.success(response, "Google login successful"));
    }

    @GetMapping("/me")
    public ResponseEntity<ApiResponse<LoginResponse>> getCurrentUser() {
        org.springframework.security.core.Authentication authentication = org.springframework.security.core.context.SecurityContextHolder
                .getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(401).body(ApiResponse.error("User not authenticated"));
        }

        String email = null;
        Object principal = authentication.getPrincipal();

        if (principal instanceof org.springframework.security.core.userdetails.UserDetails) {
            email = ((org.springframework.security.core.userdetails.UserDetails) principal).getUsername();
        } else if (principal instanceof String) {
            email = (String) principal;
        }

        if (email == null) {
            return ResponseEntity.status(401).body(ApiResponse.error("User email not found"));
        }

        com.erp.billing.entity.Student student = studentRepository.findByEmail(email)
                .orElseThrow(() -> new com.erp.billing.exception.UnauthorizedException("User not found"));

        LoginResponse response = new LoginResponse(
                null, // Token not needed here as client has it
                student.getEmail(),
                student.getStudentId(),
                student.getFirstName(),
                student.getLastName(),
                student.getRollNumber(),
                "User profile retrieved");

        return ResponseEntity.ok(ApiResponse.success(response, "User profile retrieved"));
    }
}
