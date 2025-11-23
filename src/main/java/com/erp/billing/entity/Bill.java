package com.erp.billing.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "bills")
public class Bill {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;
    
    @Column(name = "description", columnDefinition = "TEXT")
    private String description;
    
    @Column(name = "amount", nullable = false, precision = 10, scale = 2)
    private BigDecimal amount;
    
    @Column(name = "bill_date")
    private LocalDate billDate;
    
    @Column(name = "deadline")
    private LocalDate deadline;
    
    // Constructors
    public Bill() {
    }
    
    public Bill(Integer id, String description, BigDecimal amount, LocalDate billDate, LocalDate deadline) {
        this.id = id;
        this.description = description;
        this.amount = amount;
        this.billDate = billDate;
        this.deadline = deadline;
    }
    
    // Getters and Setters
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
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
}

