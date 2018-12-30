package com.kh.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import com.kh.member.model.service.MemberService;

/**
 * VO Value Object 
 * DTO Data Transfer Object
 * DO Domain Object
 * Entity 
 * Bean
 * 
 * 데이터베이스의 한 행의 정보가 담길 수 있는 객체
 */
public class Member implements Serializable, HttpSessionBindingListener {
	
	/**
	 * 
	 */
	
	private static final long serialVersionUID = 1L;
	
	protected String memberId;
	protected String password;
	protected String memberName;
	protected String gender;//char를 다루는 sql패키지의 메소드부재
	protected int age;
	protected String email;
	protected String phone;
	protected String address;
	protected String hobby;
	protected Date enrollDate;
	
	public Member() {}

	public Member(String memberId, String password, String memberName, String gender, int age, String email,
			String phone, String address, String hobby, Date enrollDate) {
		this.memberId = memberId;
		this.password = password;
		this.memberName = memberName;
		this.gender = gender;
		this.age = age;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.hobby = hobby;
		this.enrollDate = enrollDate;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	@Override
	public String toString() {
		return memberId + "\t" + password + "\t" + memberName + "\t"
			+ gender + "\t" + age + "\t" + email + "\t" + phone + "\t" 
			+ address + "\t" + hobby + "\t" + enrollDate;
	}

	@Override
	public void valueBound(HttpSessionBindingEvent e) {
		//member_logger테이블에 해당회원의 로그인내역 insert요청
		//ip는 HttpServletRequest객체의 getRemoteAddr메소드
		String ip = (String) e.getSession().getAttribute("ip");

		
		System.out.println("ip@valueBound="+ip);
		
		
		int result = new MemberService().loginInsert(memberId, 1, ip);
		
		if(result>0) {
			System.out.println(memberName+"["+memberId+"]님이 로그인!");
			
		}else {
			System.out.println("로그인 실패!");
		}
		
		
	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent e) {
		//member_logger테이블에 해당회원의 로그아웃내역 insert요청
		//session속성값에 접근이 불가하다.
		//ip = "" -> db에 null로 insert
		
		int result = new MemberService().logoutInsert(memberId, 0, "null");
		
		if(result>0) {		
			System.out.println(memberName+"["+memberId+"]님이 로그아웃!");
		}else {
			System.out.println("로그아웃 실패!");
		}
	}

}
