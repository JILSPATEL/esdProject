package com.erp.billing.dto;

import java.util.List;

public class BillHistoryResponse {
    private List<BillResponse> dueBills;
    private List<BillResponse> paidBills;
    
    public BillHistoryResponse() {
    }
    
    public BillHistoryResponse(List<BillResponse> dueBills, List<BillResponse> paidBills) {
        this.dueBills = dueBills;
        this.paidBills = paidBills;
    }
    
    public List<BillResponse> getDueBills() {
        return dueBills;
    }
    
    public void setDueBills(List<BillResponse> dueBills) {
        this.dueBills = dueBills;
    }
    
    public List<BillResponse> getPaidBills() {
        return paidBills;
    }
    
    public void setPaidBills(List<BillResponse> paidBills) {
        this.paidBills = paidBills;
    }
}

