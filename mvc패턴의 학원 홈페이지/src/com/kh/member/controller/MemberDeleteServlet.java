package com.kh.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.member.model.service.MemberService;

/**
 * Servlet implementation class MemberDeleteServlet
 */
@WebServlet("/member/memberDelete")
public class MemberDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. encoding
    	request.setCharacterEncoding("utf-8");
    	
    	
    	//2. 파라미터 핸들링
    	
    	String memberId = request.getParameter("memberId");
    	
    	
    	int result = new MemberService().memberDelete(memberId);
    	
    	
    	String view = "/WEB-INF/views/common/msg.jsp";
    	String msg = "";
    	String loc = "/";
    	
    	if(result>0) {
    		HttpSession session = request.getSession(false);
    		
    		//세션 무효화
    		if(session != null) {
    			session.invalidate();
    		}
    		msg = "삭제 완료입니다.";
    	}else {
    		msg = "삭제 실패입니다.";
    	}
    	
    	request.setAttribute("memberId", memberId);
    	request.setAttribute("msg", msg);
    	request.setAttribute("loc", loc);
    	
    	
    	
    	RequestDispatcher reqDispatcher
        = request.getRequestDispatcher(view);
        reqDispatcher.forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
