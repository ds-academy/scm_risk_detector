package com.scm.model;

import java.math.BigDecimal;
import java.util.Date; // java.util.Date 사용

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RiskDTO {
    private Integer RISK_IDX;           
    private String COMPANY_CODE;        
    private String MODEL_NAME;          
    private String ANALYSIS_RESULT;     
    private Date TEST_DATE;             // java.util.Date 사용
    private Date PREDICT_DATE;          // java.util.Date 사용
    private BigDecimal RISK_SCORE;      
}
