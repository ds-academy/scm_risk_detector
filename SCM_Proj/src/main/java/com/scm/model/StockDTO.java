	package com.scm.model;
	
	import java.math.BigDecimal;
	import java.sql.Timestamp; 
	import java.math.BigInteger; 
	
	import lombok.AllArgsConstructor;
	import lombok.Data;
	import lombok.NoArgsConstructor;
	
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public class StockDTO {
	    private String COMPANY_CODE; // 회사코드
	    private Timestamp DATE; // 날짜
	    private BigDecimal OPEN; // 시가
	    private BigDecimal HIGH; // 최고가
	    private BigDecimal LOW; // 최저가
	    private BigDecimal CLOSE; // 종가
	    private BigInteger VOLUME; // 거래량
	}
	
