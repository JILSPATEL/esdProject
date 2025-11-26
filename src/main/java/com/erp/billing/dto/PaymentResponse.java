package com.erp.billing.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class PaymentResponse {
    private Integer paymentId;
    private Integer billId;
    private String description;
    private BigDecimal amount;
    private LocalDateTime paymentDate;
    
    public PaymentResponse() {
    }
    
    public PaymentResponse(Integer paymentId, Integer billId, String description, 
                          BigDecimal amount, LocalDateTime paymentDate) {
        this.paymentId = paymentId;
        this.billId = billId;
        this.description = description;
        this.amount = amount;
        this.paymentDate = paymentDate;
    }
    
    // Getters and Setters
    public Integer getPaymentId() {
        return paymentId;
    }
    
    public void setPaymentId(Integer paymentId) {
        this.paymentId = paymentId;
    }
    
    public Integer getBillId() {
        return billId;
    }
    
    public void setBillId(Integer billId) {
        this.billId = billId;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public BigDecimal getAmount() {
        return amount;
    }
    
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }
    
    public LocalDateTime getPaymentDate() {
        return paymentDate;
    }
    
    public void setPaymentDate(LocalDateTime paymentDate) {
        this.paymentDate = paymentDate;
    }
}

