package com.kh.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.member.model.service.MemberService;
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class MemberUpdateEnd
 */
@WebServlet("/member/memberUpdateEnd")
public class MemberUpdateEnd extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String memberId = request.getParameter("memberId");
		String memberName = request.getParameter("memberName");
		int age = Integer.parseInt(request.getParameter("age"));
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String gender = request.getParameter("gender");
		String[] arr = request.getParameterValues("hobby");
		String hobby = "";
		
		
		
		
		for(int i = 0; i<arr.length; i++) {
			hobby += arr[i] + ",";
		}
		Member m = new Member();
		m.setMemberId(memberId);
		m.setMemberName(memberName);
		m.setAge(age);
		m.setEmail(email);
		m.setPhone(phone);
		m.setAddress(address);
		m.setGender(gender);
		m.setHobby(hobby);
		
		int result = 0 ;
		
		result = new MemberService().updateEnd(m);
		
		String view = "/WEB-INF/views/common/msg.jsp";
		String msg = "";
		String loc = "/member/memberView?memberId="+memberId;
		
		if(result > 0) {
			msg = "회원 정보 수정 완료!";
		}
		else {
			msg= "회원 정보 수정 실패!";
		}
		
		
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher(view)
			   .forward(request, response);
		
		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
