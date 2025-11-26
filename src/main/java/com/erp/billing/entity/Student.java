package com.erp.billing.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "students")
public class Student {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "student_id")
    private Integer studentId;
    
    @Column(name = "roll_number", unique = true, nullable = false, length = 50)
    private String rollNumber;
    
    @Column(name = "first_name", length = 100)
    private String firstName;
    
    @Column(name = "last_name", length = 100)
    private String lastName;
    
    @Column(name = "email", unique = true, nullable = false, length = 150)
    private String email;
    
    @Column(name = "photograph_path", length = 255)
    private String photographPath;
    
    @Column(name = "cgpa", precision = 4, scale = 2)
    private BigDecimal cgpa;
    
    @Column(name = "total_credits")
    private Integer totalCredits;
    
    @Column(name = "graduate_year")
    private Integer graduateYear;
    
    @Column(name = "domain_id")
    private Integer domainId;
    
    @Column(name = "specialisation_id")
    private Integer specialisationId;
    
    @Column(name = "placement_id")
    private Integer placementId;
    
    @Column(name = "password", nullable = false, length = 255)
    private String password;
    
    // Constructors
    public Student() {
    }
    
    public Student(Integer studentId, String rollNumber, String firstName, String lastName, String email, 
                   String photographPath, BigDecimal cgpa, Integer totalCredits, Integer graduateYear, 
                   Integer domainId, Integer specialisationId, Integer placementId, String password) {
        this.studentId = studentId;
        this.rollNumber = rollNumber;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.photographPath = photographPath;
        this.cgpa = cgpa;
        this.totalCredits = totalCredits;
        this.graduateYear = graduateYear;
        this.domainId = domainId;
        this.specialisationId = specialisationId;
        this.placementId = placementId;
        this.password = password;
    }
    
    // Getters and Setters
    public Integer getStudentId() {
        return studentId;
    }
    
    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }
    
    public String getRollNumber() {
        return rollNumber;
    }
    
    public void setRollNumber(String rollNumber) {
        this.rollNumber = rollNumber;
    }
    
    public String getFirstName() {
        return firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String getLastName() {
        return lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhotographPath() {
        return photographPath;
    }
    
    public void setPhotographPath(String photographPath) {
        this.photographPath = photographPath;
    }
    
    public BigDecimal getCgpa() {
        return cgpa;
    }
    
    public void setCgpa(BigDecimal cgpa) {
        this.cgpa = cgpa;
    }
    
    public Integer getTotalCredits() {
        return totalCredits;
    }
    
    public void setTotalCredits(Integer totalCredits) {
        this.totalCredits = totalCredits;
    }
    
    public Integer getGraduateYear() {
        return graduateYear;
    }
    
    public void setGraduateYear(Integer graduateYear) {
        this.graduateYear = graduateYear;
    }
    
    public Integer getDomainId() {
        return domainId;
    }
    
    public void setDomainId(Integer domainId) {
        this.domainId = domainId;
    }
    
    public Integer getSpecialisationId() {
        return specialisationId;
    }
    
    public void setSpecialisationId(Integer specialisationId) {
        this.specialisationId = specialisationId;
    }
    
    public Integer getPlacementId() {
        return placementId;
    }
    
    public void setPlacementId(Integer placementId) {
        this.placementId = placementId;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
}

