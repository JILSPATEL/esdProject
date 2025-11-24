package com.erp.billing.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * Utility to generate BCrypt password hashes for students
 * Run this as: mvnw.cmd exec:java
 */
public class GeneratePasswordHashes {
    
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        
        // Student passwords in format: first_name@roll_number
        String[][] students = {
            {"John", "STU001", "John@STU001"},
            {"Jane", "STU002", "Jane@STU002"},
            {"Michael", "STU003", "Michael@STU003"},
            {"Emily", "STU004", "Emily@STU004"},
            {"David", "STU005", "David@STU005"},
            {"Sarah", "STU006", "Sarah@STU006"},
            {"Robert", "STU007", "Robert@STU007"},
            {"Lisa", "STU008", "Lisa@STU008"},
            {"James", "STU009", "James@STU009"},
            {"Amanda", "STU010", "Amanda@STU010"}
        };
        
        System.out.println("-- ============================================");
        System.out.println("-- Generated BCrypt Password Hashes");
        System.out.println("-- Password Format: first_name@roll_number");
        System.out.println("-- ============================================");
        System.out.println();
        
        System.out.println("-- SQL UPDATE statements (copy and run in MySQL):");
        System.out.println();
        System.out.println("USE esd_project;");
        System.out.println();
        
        for (String[] student : students) {
            String password = student[2];
            String hash = encoder.encode(password);
            System.out.println("UPDATE students SET password = '" + hash + "' WHERE roll_number = '" + student[1] + "'; -- " + password);
        }
        
        System.out.println();
        System.out.println("-- ============================================");
        System.out.println("-- Student Login Credentials:");
        System.out.println("-- ============================================");
        for (String[] student : students) {
            System.out.println("-- " + student[0] + ": " + student[2]);
        }
    }
}

