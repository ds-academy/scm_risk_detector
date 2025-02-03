package com.scm.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CustomerDTO {
	private String USER_ID; // 고객 ID
	private String USER_NAME; // 고객명
	private String PASSWORD; // 패스워드
	private String MOBILE; // 연락처
	private String EMAIL; // 이메일
}
