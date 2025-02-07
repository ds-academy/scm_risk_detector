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
    private Integer riskIdx;           // RISK_IDX
    private String companyCode;        // COMPANY_CODE
    private String modelName;          // MODEL_NAME
    private String analysisResult;     // ANALYSIS_RESULT
    private Date testDate;             // TEST_DATE
    private Date predictDate;          // PREDICT_DATE
    private BigDecimal riskScore;      // RISK_SCORE

    // Null-safe getter
    public BigDecimal getRiskScore() {
        return riskScore != null ? riskScore : BigDecimal.ZERO;
    }
}
