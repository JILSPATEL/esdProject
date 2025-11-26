package com.erp.billing.controller;

import com.erp.billing.dto.BillResponse;
import com.erp.billing.dto.PaymentResponse;
import com.erp.billing.security.JwtUtil;
import com.erp.billing.service.BillService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Text;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.io.font.constants.StandardFonts;

@RestController
@RequestMapping("/api/receipts")
@CrossOrigin(origins = "*")
public class ReceiptController {
    
    @Autowired
    private BillService billService;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    private Integer getStudentIdFromRequest(HttpServletRequest request) {
        String authHeader = request.getHeader(HttpHeaders.AUTHORIZATION);
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            return jwtUtil.getStudentIdFromToken(token);
        }
        throw new RuntimeException("Unable to extract student ID from token");
    }
    
    @GetMapping("/{billId}/download")
    public ResponseEntity<byte[]> downloadReceipt(
            @PathVariable Integer billId,
            HttpServletRequest request) {
        Integer studentId = getStudentIdFromRequest(request);
        BillResponse billResponse = billService.getBillDetails(studentId, billId);
        
        // Generate PDF receipt
        byte[] pdfBytes = generatePdfReceipt(billResponse);
        
        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=receipt_" + billId + ".pdf");
        headers.add(HttpHeaders.CONTENT_TYPE, "application/pdf");
        
        return new ResponseEntity<>(pdfBytes, headers, HttpStatus.OK);
    }
    
    private byte[] generatePdfReceipt(BillResponse billResponse) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        
        try {
            PdfWriter writer = new PdfWriter(baos);
            PdfDocument pdfDoc = new PdfDocument(writer);
            Document document = new Document(pdfDoc);
            
            // Title
            Paragraph title = new Paragraph("FEE RECEIPT")
                    .setTextAlignment(TextAlignment.CENTER)
                    .setFontSize(20)
                    .setBold();
            document.add(title);
            
            document.add(new Paragraph("\n"));
            
            // Bill Details
            document.add(new Paragraph("Bill ID: " + billResponse.getBillId()).setFontSize(12));
            document.add(new Paragraph("Description: " + billResponse.getDescription()).setFontSize(12));
            document.add(new Paragraph("Bill Date: " + billResponse.getBillDate()).setFontSize(12));
            document.add(new Paragraph("Deadline: " + billResponse.getDeadline()).setFontSize(12));
            document.add(new Paragraph("Total Amount: $" + billResponse.getAmount()).setFontSize(12));
            document.add(new Paragraph("Total Paid: $" + billResponse.getTotalPaid()).setFontSize(12));
            document.add(new Paragraph("Remaining Amount: $" + billResponse.getRemainingAmount()).setFontSize(12));
            document.add(new Paragraph("Status: " + (billResponse.getIsPaid() ? "PAID" : "DUE"))
                    .setFontSize(12)
                    .setBold());
            
            document.add(new Paragraph("\n"));
            
            // Payment History
            if (!billResponse.getPayments().isEmpty()) {
                document.add(new Paragraph("Payment History")
                        .setFontSize(14)
                        .setBold());
                document.add(new Paragraph("\n"));
                
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                for (PaymentResponse payment : billResponse.getPayments()) {
                    document.add(new Paragraph("Payment ID: " + payment.getPaymentId()).setFontSize(11));
                    document.add(new Paragraph("Amount: $" + payment.getAmount()).setFontSize(11));
                    document.add(new Paragraph("Date: " + payment.getPaymentDate().format(formatter)).setFontSize(11));
                    if (payment.getDescription() != null) {
                        document.add(new Paragraph("Description: " + payment.getDescription()).setFontSize(11));
                    }
                    document.add(new Paragraph("\n"));
                }
            }
            
            document.add(new Paragraph("\n"));
            document.add(new Paragraph("Thank you for your payment!")
                    .setTextAlignment(TextAlignment.CENTER)
                    .setFontSize(12)
                    .setItalic());
            
            document.close();
            
        } catch (Exception e) {
            throw new RuntimeException("Error generating PDF receipt", e);
        }
        
        return baos.toByteArray();
    }
}

