package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// lombok 연결하기
@Data
@AllArgsConstructor // 전체 필드를 가지고 생성자 메소드를 생성!
@NoArgsConstructor // 기본의 생성자 매소드를 생성!
public class MemberDTO {
	// 회원 데이터를 저장할 수 있도록 나만의 자료형 만들기!
	// 1. 필드 --> 테이블의 컬럼명과 일치시키기
	private String email;
	private String pw;
	private String tel;
	private String address;
	/**
	 * @param email
	 * @param tel
	 * @param address
	 */
	public MemberDTO(String email, String tel, String address) {
		super();
		this.email = email;
		this.tel = tel;
		this.address = address;
	}
	
	// 2. 메소드 --> getter, setter
//	public String getEmail() {
//		return email;
//	}
//
//	public void setEmail(String email) {
//		this.email = email;
//	}
//
//	public String getPw() {
//		return pw;
//	}
//
//	public void setPw(String pw) {
//		this.pw = pw;
//	}
//
//	public String getTel() {
//		return tel;
//	}
//
//	public void setTel(String tel) {
//		this.tel = tel;
//	}
//
//	public String getAddress() {
//		return address;
//	}
//
//	public void setAddress(String address) {
//		this.address = address;
//	} 
	
	

}
