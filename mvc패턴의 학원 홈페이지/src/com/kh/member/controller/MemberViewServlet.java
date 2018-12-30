package com.kh.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.member.model.service.MemberService;
import com.kh.member.model.vo.Member;

/**
* Servlet implementation class MemberViewServlet
*/
@WebServlet(name="MemberViewServlet", urlPatterns="/member/memberView")
public class MemberViewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1. encoding
    	request.setCharacterEncoding("utf-8");
    	//2. parameterHandling
    	String memberId = request.getParameter("memberId");
    	
    	//3. businessLogic
    	Member m = new MemberService().selectOne(memberId);
    	System.out.println("member@memberViewServlet = " + m);
    	
    
    	//4. view
    	//비정상적인 요청으로 해당회원정보 없을 경우
    	String view = "/WEB-INF/views/member/memberView.jsp";
    	String msg = "";
    	String loc = "/";
    	
    	if(m.getMemberId() == null) {
    		view = "/WEB-INF/views/common/msg.jsp";
    		msg = "해당 회원이 존재하지 않습니다.";
    	}
    	
    	request.setAttribute("member", m);
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