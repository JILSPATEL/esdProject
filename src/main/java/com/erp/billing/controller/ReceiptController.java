package com.erp.billing.controller;

import com.erp.billing.dto.BillResponse;
import com.erp.billing.dto.PaymentResponse;
import com.erp.billing.security.JwtUtil;
import com.erp.billing.service.BillService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.time.format.DateTimeFormatter;

@RestController
@RequestMapping("/api/receipts")
@CrossOrigin(origins = "*")
public class ReceiptController {
    
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
    
    @GetMapping("/{billId}/download")
    public ResponseEntity<byte[]> downloadReceipt(
            @PathVariable Integer billId,
            HttpServletRequest request) {
        Integer studentId = getStudentIdFromRequest(request);
        BillResponse billResponse = billService.getBillDetails(studentId, billId);
        
        // Generate receipt content
        String receiptContent = generateReceiptContent(billResponse);
        byte[] receiptBytes = receiptContent.getBytes(StandardCharsets.UTF_8);
        
        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=receipt_" + billId + ".txt");
        headers.add(HttpHeaders.CONTENT_TYPE, "text/plain");
        
        return new ResponseEntity<>(receiptBytes, headers, HttpStatus.OK);
    }
    
    private String generateReceiptContent(BillResponse billResponse) {
        StringBuilder receipt = new StringBuilder();
        receipt.append("========================================\n");
        receipt.append("         FEE RECEIPT\n");
        receipt.append("========================================\n\n");
        receipt.append("Bill ID: ").append(billResponse.getBillId()).append("\n");
        receipt.append("Description: ").append(billResponse.getDescription()).append("\n");
        receipt.append("Bill Date: ").append(billResponse.getBillDate()).append("\n");
        receipt.append("Deadline: ").append(billResponse.getDeadline()).append("\n");
        receipt.append("Total Amount: $").append(billResponse.getAmount()).append("\n");
        receipt.append("Total Paid: $").append(billResponse.getTotalPaid()).append("\n");
        receipt.append("Remaining Amount: $").append(billResponse.getRemainingAmount()).append("\n");
        receipt.append("Status: ").append(billResponse.getIsPaid() ? "PAID" : "DUE").append("\n\n");
        
        if (!billResponse.getPayments().isEmpty()) {
            receipt.append("Payment History:\n");
            receipt.append("----------------------------------------\n");
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            for (PaymentResponse payment : billResponse.getPayments()) {
                receipt.append("Payment ID: ").append(payment.getPaymentId()).append("\n");
                receipt.append("Amount: $").append(payment.getAmount()).append("\n");
                receipt.append("Date: ").append(payment.getPaymentDate().format(formatter)).append("\n");
                if (payment.getDescription() != null) {
                    receipt.append("Description: ").append(payment.getDescription()).append("\n");
                }
                receipt.append("----------------------------------------\n");
            }
        }
        
        receipt.append("\n========================================\n");
        receipt.append("Thank you for your payment!\n");
        receipt.append("========================================\n");
        
        return receipt.toString();
    }
}

