package com.kh.member.controller;

import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.member.model.service.MemberService;
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class MemberLoginServlet
 */

@WebServlet("/member/login")
public class MemberLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.인코딩
        request.setCharacterEncoding("utf-8");
        
        //2.파라미터핸들링
        String memberId = request.getParameter("memberId");
        String password = request.getParameter("password");
        System.out.printf("[%s, %s]\n",memberId, password);
        
        
        //return 1 : 로그인성공
        //return 0 : 패스워드 틀림
        //return -1 : 존재하지않는 아이디 .
        Member m = new Member();
        m.setMemberId(memberId);
        m.setPassword(password);
        
        //3.업무로직요청
        int result = new MemberService().loginCheck(m);
        System.out.println("[로그인 결과 :"+result+"]");
        
        //4.view단 처리
        String view = "";
        
        //로그인 실패한 경우사용.
        String msg = "";
        String loc = "/";
        
        //0.로그인후 이전페이지로 리다이렉트하기.
        String referer = request.getHeader("Referer");
        String origin = request.getHeader("Origin");
        String url = request.getRequestURL().toString();
        String uri = request.getRequestURI();
        //Uniform Resource Locator/Indicator
        //uri = url + urn
        
        
        System.out.println("referer="+referer);
        //http://localhost:9090/mvc/board/boardList
        System.out.println("origin="+origin);
//        http://localhost:9090
        System.out.println("url="+url);
//        http://localhost:9090/mvc/member/login
        System.out.println("uri="+uri);
//        /mvc/member/login
        
        //크롬외 브라우져용
        if(origin == null) {
        	origin = url.replace(uri, "");
        }
        
        
        //1.로그인 성공한 경우
        //@실습문제 : 로그인에 성공한 경우, 로그인한 회원정보를 db로 부터
        //가져와서 request객체의 memberLoggedIn속성에 저장하세요.
        //service단 메소드명 : selectOne
        if(result == MemberService.LOGIN_OK) {
        	//쿠키관련
        	String saveId = request.getParameter("saveId");
        	//체크된 경우, on
        	//체크되지 않은 경우 null
        	System.out.println("saveId=" + saveId);
        	
        	//쿠키생성 server단에서, 보관을 client단에서.
        	if(saveId != null) {
        		Cookie c = new Cookie("saveId", memberId);
        		c.setMaxAge(7*24*60*60); //쿠키유효기간: 단위는 초
        		c.setPath("/mvc");//쿠키유효디렉토리 설정
        		response.addCookie(c);
        	}
        	else {
        		//현재 등록된 쿠키삭제 목적
        		Cookie c = new Cookie("saveId", memberId);
        		c.setMaxAge(0);//유효기간을 0으로 설정해서 삭제
        		c.setPath("/mvc");//쿠키유효디렉토리 설정
        		response.addCookie(c);
        	}
        	
        	
        	Member logm = new MemberService().selectOne(m.getMemberId());
        	
        	//request객체로부터 세션객체 가져오기
        	//getSession(true) : 기본값. 
        	//세션이 있으면, 해당세션을 반납, 없으면, 새로 생성후 반납
        	//getSession(false) : 세션이 있으면, 해당세션을 반납.
        	//없으면 null을 반납.
        	
        	HttpSession session = request.getSession(true);
        	
        	//timeout설정 : web.xml보다 우선순위 높음
        	//단위 초
        	session.setMaxInactiveInterval(1*60);
        	System.out.println("세션객체 아이디 : "+session.getId());
        	
        	String ip = request.getRemoteAddr();
        	System.out.println("[ip = "+ip+"]");
        	session.setAttribute("ip", ip);
        	
        	session.setAttribute("logm", logm);
        	
            //페이지 리다이렉트 : 클라이언트 돌려보낸후, 해당 url로 다시 요청하도록 함.
//        	response.sendRedirect(request.getContextPath()); 
        	response.sendRedirect(referer);
        	
        	
        	
        	
        }
        //2.로그인 실패한 경우
        else {
        	view = "/WEB-INF/views/common/msg.jsp";
        	if(result == MemberService.WRONG_PASSWORD) {
        		msg = "패스워드를 잘못 입력하셨습니다.";
        	}
        	else if(result == MemberService.ID_NOT_EXIST) {
        		msg = "존재하지 않는 아이디 입니다.";
        	}
        	request.setAttribute("msg", msg);
            request.setAttribute("loc", loc);
            
            RequestDispatcher reqDispatcher
        	= request.getRequestDispatcher(view);
            reqDispatcher.forward(request, response);
        }
        
        
 
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}