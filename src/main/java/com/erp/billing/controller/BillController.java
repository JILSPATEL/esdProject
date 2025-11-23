package com.erp.billing.controller;

import com.erp.billing.dto.ApiResponse;
import com.erp.billing.dto.BillHistoryResponse;
import com.erp.billing.dto.BillResponse;
import com.erp.billing.security.JwtUtil;
import com.erp.billing.service.BillService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/bills")
@CrossOrigin(origins = "*")
public class BillController {
    
    @Autowired
    private BillService billService;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    private Integer getStudentIdFromRequest(HttpServletRequest request) {
        String authHeader = request.getHeader(HttpHeaders.AUTHORIZATION);
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            return jwtUtil.getStudentIdFromToken(token);
        }
        throw new RuntimeException("Unable to extract student ID from token");
    }
    
    @GetMapping("/history")
    public ResponseEntity<ApiResponse<BillHistoryResponse>> getBillHistory(HttpServletRequest request) {
        Integer studentId = getStudentIdFromRequest(request);
        BillHistoryResponse response = billService.getBillHistory(studentId);
        return ResponseEntity.ok(ApiResponse.success(response, "Bill history retrieved successfully"));
    }
    
    @GetMapping("/{billId}")
    public ResponseEntity<ApiResponse<BillResponse>> getBillDetails(
            @PathVariable Integer billId,
            HttpServletRequest request) {
        Integer studentId = getStudentIdFromRequest(request);
        BillResponse response = billService.getBillDetails(studentId, billId);
        return ResponseEntity.ok(ApiResponse.success(response, "Bill details retrieved successfully"));
    }
}

