package com.erp.billing.service;

import com.erp.billing.dto.BillHistoryResponse;
import com.erp.billing.dto.BillResponse;
import com.erp.billing.dto.PaymentResponse;
import com.erp.billing.entity.Bill;
import com.erp.billing.entity.StudentBill;
import com.erp.billing.entity.StudentPayment;
import com.erp.billing.exception.ResourceNotFoundException;
import com.erp.billing.repository.BillRepository;
import com.erp.billing.repository.StudentBillRepository;
import com.erp.billing.repository.StudentPaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BillService {
    
    @Autowired
    private StudentBillRepository studentBillRepository;
    
    @Autowired
    private BillRepository billRepository;
    
    @Autowired
    private StudentPaymentRepository studentPaymentRepository;
    
    public BillHistoryResponse getBillHistory(Integer studentId) {
        List<StudentBill> studentBills = studentBillRepository.findByStudentId(studentId);
        
        if (studentBills.isEmpty()) {
            throw new ResourceNotFoundException("No bills found for student with ID: " + studentId);
        }
        
        List<BillResponse> dueBills = new ArrayList<>();
        List<BillResponse> paidBills = new ArrayList<>();
        
        for (StudentBill studentBill : studentBills) {
            Bill bill = billRepository.findById(studentBill.getBillId())
                    .orElseThrow(() -> new ResourceNotFoundException("Bill not found with ID: " + studentBill.getBillId()));
            
            List<StudentPayment> payments = studentPaymentRepository.findByStudentIdAndBillId(studentId, bill.getId());
            BigDecimal totalPaid = payments.stream()
                    .map(StudentPayment::getAmount)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            BigDecimal remainingAmount = bill.getAmount().subtract(totalPaid);
            boolean isPaid = remainingAmount.compareTo(BigDecimal.ZERO) <= 0;
            
            List<PaymentResponse> paymentResponses = payments.stream()
                    .map(payment -> new PaymentResponse(
                            payment.getId(),
                            payment.getBillId(),
                            payment.getDescription(),
                            payment.getAmount(),
                            payment.getPaymentDate()
                    ))
                    .collect(Collectors.toList());
            
            BillResponse billResponse = new BillResponse(
                    bill.getId(),
                    bill.getDescription(),
                    bill.getAmount(),
                    bill.getBillDate(),
                    bill.getDeadline(),
                    totalPaid,
                    remainingAmount,
                    isPaid,
                    paymentResponses
            );
            
            if (isPaid) {
                paidBills.add(billResponse);
            } else {
                dueBills.add(billResponse);
            }
        }
        
        return new BillHistoryResponse(dueBills, paidBills);
    }
    
    public BillResponse getBillDetails(Integer studentId, Integer billId) {
        StudentBill studentBill = studentBillRepository.findByStudentIdAndBillId(studentId, billId)
                .orElseThrow(() -> new ResourceNotFoundException("Bill not found for student"));
        
        Bill bill = billRepository.findById(billId)
                .orElseThrow(() -> new ResourceNotFoundException("Bill not found with ID: " + billId));
        
        List<StudentPayment> payments = studentPaymentRepository.findByStudentIdAndBillId(studentId, billId);
        BigDecimal totalPaid = payments.stream()
                .map(StudentPayment::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal remainingAmount = bill.getAmount().subtract(totalPaid);
        boolean isPaid = remainingAmount.compareTo(BigDecimal.ZERO) <= 0;
        
        List<PaymentResponse> paymentResponses = payments.stream()
                .map(payment -> new PaymentResponse(
                        payment.getId(),
                        payment.getBillId(),
                        payment.getDescription(),
                        payment.getAmount(),
                        payment.getPaymentDate()
                ))
                .collect(Collectors.toList());
        
        return new BillResponse(
                bill.getId(),
                bill.getDescription(),
                bill.getAmount(),
                bill.getBillDate(),
                bill.getDeadline(),
                totalPaid,
                remainingAmount,
                isPaid,
                paymentResponses
        );
    }
}

