package com.erp.billing.service;

import com.erp.billing.dto.BillHistoryResponse;
import com.erp.billing.dto.BillResponse;
import com.erp.billing.entity.Bill;
import com.erp.billing.entity.StudentBill;
import com.erp.billing.entity.StudentPayment;
import com.erp.billing.exception.ResourceNotFoundException;
import com.erp.billing.mapper.BillMapper;
import com.erp.billing.repository.BillRepository;
import com.erp.billing.repository.StudentBillRepository;
import com.erp.billing.repository.StudentPaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class BillService {
    
    @Autowired
    private StudentBillRepository studentBillRepository;
    
    @Autowired
    private BillRepository billRepository;
    
    @Autowired
    private StudentPaymentRepository studentPaymentRepository;
    
    @Autowired
    private BillMapper billMapper;
    
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
            BillResponse billResponse = billMapper.toBillResponse(bill, payments);
            
            if (Boolean.TRUE.equals(billResponse.getIsPaid())) {
                paidBills.add(billResponse);
            } else {
                dueBills.add(billResponse);
            }
        }
        
        return new BillHistoryResponse(dueBills, paidBills);
    }
    
    public BillResponse getBillDetails(Integer studentId, Integer billId) {
        // Verify student has access to this bill
        studentBillRepository.findByStudentIdAndBillId(studentId, billId)
                .orElseThrow(() -> new ResourceNotFoundException("Bill not found for student"));
        
        Bill bill = billRepository.findById(billId)
                .orElseThrow(() -> new ResourceNotFoundException("Bill not found with ID: " + billId));
        
        List<StudentPayment> payments = studentPaymentRepository.findByStudentIdAndBillId(studentId, billId);
        return billMapper.toBillResponse(bill, payments);
    }
}

