package com.kh.member.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.member.model.service.MemberService;
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class MemberEnrollEndServlet
 */
@WebServlet("/member/memberEnrollEnd")
public class MemberEnrollEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.인코딩
        request.setCharacterEncoding("utf-8");
        
        //2.파라미터 핸들링
        String memberId = request.getParameter("memberId");
        String password = request.getParameter("password");
        String memberName = request.getParameter("memberName");
        int age = Integer.parseInt(request.getParameter("age"));
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        
        String[] hobby = request.getParameterValues("hobby");
        String hobbysum = "";
        
        
        System.out.printf("%s %s %s %s %s %s %s %s"
        		, memberId, password, memberName, age, email, phone, address, gender);
        
        for(int i = 0; i<hobby.length; i++) {
        	System.out.printf(hobby[i]);
        	hobbysum += hobby[i]+",";
        }
        Member m = new Member(memberId, password, memberName, gender, age, email, phone,
        					  address, hobbysum, null);
        
        
        
        
        //3. 업무 로직 요청
        String view = "";
        String msg = "";
        String loc = "/";
        int result = new MemberService().join(m);
        
        if(result>0) {
        	
        	msg = "회원가입 성공 했습니다.";
        	
        	request.setAttribute("msg", msg);
            request.setAttribute("loc", loc);
            
            RequestDispatcher reqDispatcher
            =request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
            reqDispatcher.forward(request, response);
        } else {
        	msg = "회원가입 실패 했습니다.";
        	
        	request.setAttribute("msg", msg);
            request.setAttribute("loc", loc);
            
            RequestDispatcher reqDispatcher
            =request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
            reqDispatcher.forward(request, response);
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
