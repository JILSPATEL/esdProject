package com.erp.billing.repository;

import com.erp.billing.entity.StudentBill;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StudentBillRepository extends JpaRepository<StudentBill, Integer> {
    List<StudentBill> findByStudentId(Integer studentId);
    
    @Query("SELECT sb FROM StudentBill sb WHERE sb.studentId = :studentId AND sb.billId = :billId")
    Optional<StudentBill> findByStudentIdAndBillId(@Param("studentId") Integer studentId, @Param("billId") Integer billId);
}

