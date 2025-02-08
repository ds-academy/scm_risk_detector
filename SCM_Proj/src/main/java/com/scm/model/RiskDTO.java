package com.scm.model;

import java.math.BigDecimal;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RiskDTO {
    private Integer RISK_IDX;           // RISK_IDX
    private String COMPANY_CODE;        // COMPANY_CODE
    private String MODEL_NAME;          // MODEL_NAME
    private String ANALYSIS_RESULT;     // ANALYSIS_RESULT
    private Date TEST_DATE;             // TEST_DATE
    private Date PREDICT_DATE;          // PREDICT_DATE
    private BigDecimal RISK_SCORE;      // RISK_SCORE

    
}
