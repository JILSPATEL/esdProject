package com.erp.billing.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "student_bills")
public class StudentBill {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;
    
    @Column(name = "student_id", nullable = false)
    private Integer studentId;
    
    @Column(name = "bill_id", nullable = false)
    private Integer billId;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "student_id", insertable = false, updatable = false)
    private Student student;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bill_id", insertable = false, updatable = false)
    private Bill bill;
    
    // Constructors
    public StudentBill() {
    }
    
    public StudentBill(Integer id, Integer studentId, Integer billId, Student student, Bill bill) {
        this.id = id;
        this.studentId = studentId;
        this.billId = billId;
        this.student = student;
        this.bill = bill;
    }
    
    // Getters and Setters
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public Integer getStudentId() {
        return studentId;
    }
    
    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }
    
    public Integer getBillId() {
        return billId;
    }
    
    public void setBillId(Integer billId) {
        this.billId = billId;
    }
    
    public Student getStudent() {
        return student;
    }
    
    public void setStudent(Student student) {
        this.student = student;
    }
    
    public Bill getBill() {
        return bill;
    }
    
    public void setBill(Bill bill) {
        this.bill = bill;
    }
}

