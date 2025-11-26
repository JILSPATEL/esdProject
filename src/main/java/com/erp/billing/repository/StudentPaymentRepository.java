package com.erp.billing.repository;

import com.erp.billing.entity.StudentPayment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentPaymentRepository extends JpaRepository<StudentPayment, Integer> {
    List<StudentPayment> findByStudentId(Integer studentId);
    
    @Query("SELECT sp FROM StudentPayment sp WHERE sp.studentId = :studentId AND sp.billId = :billId")
    List<StudentPayment> findByStudentIdAndBillId(@Param("studentId") Integer studentId, @Param("billId") Integer billId);
}

