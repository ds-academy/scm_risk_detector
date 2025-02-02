package com.scm.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CustomerDTO {
	private String USER_ID;
	private String USER_NAME;
	private String PASSWORD;
	private String MOBILE;
	private String EMAIL;
}
