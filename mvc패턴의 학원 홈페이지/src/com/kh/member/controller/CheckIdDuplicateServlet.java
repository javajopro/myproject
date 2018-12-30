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
 * Servlet implementation class CheckIdDuplicateServlet
 */
@WebServlet("/member/checkIdDuplicate")
public class CheckIdDuplicateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.인코딩
        request.setCharacterEncoding("utf-8");
        
        //2.parameterHandling
        String memberId = request.getParameter("memberId");
        
        //3.businessLogic
        Member m = new MemberService().selectOne(memberId);
        
        
        //사용가능여부를 isUsable변수에 담기
        boolean isUsable = m.getMemberId()==null?true:false;
        
        
        //view단 jsp에서 사용할 데이터를 request의 속성값으로 보관
        request.setAttribute("isUsable", isUsable);
        request.setAttribute("memberId", memberId);
        
        
        //4.view
        //checkIdDuplicate.jsp
        request.getRequestDispatcher("/WEB-INF/views/member/checkIdDuplicate.jsp")
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
