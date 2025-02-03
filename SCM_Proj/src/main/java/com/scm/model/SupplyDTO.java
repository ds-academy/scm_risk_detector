package com.scm.model;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class SupplyDTO {
	private int SCM_IDX;
	private String SCM_KEY;
	private String PRODUCT;
	private BigDecimal RATIO;
	private String LOC_NAME;
	private char ISO;
	private String ADDRESS;
	private String STATE;
	private BigDecimal LAT;
	private BigDecimal LON;
}
