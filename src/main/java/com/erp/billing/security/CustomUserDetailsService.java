package com.erp.billing.security;

import com.erp.billing.entity.Student;
import com.erp.billing.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class CustomUserDetailsService implements UserDetailsService {
    
    @Autowired
    private StudentRepository studentRepository;
    
    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Student student = studentRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Student not found with email: " + email));
        
        // For demo purposes: use email as password (since password field doesn't exist in DB)
        // In production, you should have a password field and use BCryptPasswordEncoder
        // The password encoder will handle the comparison
        return new User(student.getEmail(), student.getEmail(), new ArrayList<>());
    }
}

