package com.erp.billing.mapper;

import com.erp.billing.dto.BillResponse;
import com.erp.billing.dto.PaymentResponse;
import com.erp.billing.entity.Bill;
import com.erp.billing.entity.StudentPayment;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class BillMapper {
    
    public BillResponse toBillResponse(Bill bill, List<StudentPayment> payments) {
        BigDecimal totalPaid = payments.stream()
                .map(StudentPayment::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal remainingAmount = bill.getAmount().subtract(totalPaid);
        boolean isPaid = remainingAmount.compareTo(BigDecimal.ZERO) <= 0;
        
        List<PaymentResponse> paymentResponses = payments.stream()
                .map(this::toPaymentResponse)
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
    
    private PaymentResponse toPaymentResponse(StudentPayment payment) {
        return new PaymentResponse(
                payment.getId(),
                payment.getBillId(),
                payment.getDescription(),
                payment.getAmount(),
                payment.getPaymentDate()
        );
    }
}

