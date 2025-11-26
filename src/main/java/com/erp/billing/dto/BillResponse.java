package com.erp.billing.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public class BillResponse {
    private Integer billId;
    private String description;
    private BigDecimal amount;
    private LocalDate billDate;
    private LocalDate deadline;
    private BigDecimal totalPaid;
    private BigDecimal remainingAmount;
    private Boolean isPaid;
    private List<PaymentResponse> payments;
    
    public BillResponse() {
    }
    
    public BillResponse(Integer billId, String description, BigDecimal amount, LocalDate billDate, 
                       LocalDate deadline, BigDecimal totalPaid, BigDecimal remainingAmount, 
                       Boolean isPaid, List<PaymentResponse> payments) {
        this.billId = billId;
        this.description = description;
        this.amount = amount;
        this.billDate = billDate;
        this.deadline = deadline;
        this.totalPaid = totalPaid;
        this.remainingAmount = remainingAmount;
        this.isPaid = isPaid;
        this.payments = payments;
    }
    
    // Getters and Setters
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
    
    public LocalDate getBillDate() {
        return billDate;
    }
    
    public void setBillDate(LocalDate billDate) {
        this.billDate = billDate;
    }
    
    public LocalDate getDeadline() {
        return deadline;
    }
    
    public void setDeadline(LocalDate deadline) {
        this.deadline = deadline;
    }
    
    public BigDecimal getTotalPaid() {
        return totalPaid;
    }
    
    public void setTotalPaid(BigDecimal totalPaid) {
        this.totalPaid = totalPaid;
    }
    
    public BigDecimal getRemainingAmount() {
        return remainingAmount;
    }
    
    public void setRemainingAmount(BigDecimal remainingAmount) {
        this.remainingAmount = remainingAmount;
    }
    
    public Boolean getIsPaid() {
        return isPaid;
    }
    
    public void setIsPaid(Boolean isPaid) {
        this.isPaid = isPaid;
    }
    
    public List<PaymentResponse> getPayments() {
        return payments;
    }
    
    public void setPayments(List<PaymentResponse> payments) {
        this.payments = payments;
    }
}

