package com.kh.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.kh.member.model.vo.Member;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter(servletNames = { "MemberViewServlet" })
public class LoginFilter implements Filter {

    /**
     * Default constructor. 
     */
    public LoginFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		//@실습문제: 로그인하지 않거나, 로그인한 본인이 아닌 회원정보를
		//요청할 시에 "잘못된 경로로 접근하셨습니다." 경고창을 띄우고, 
		//index페이지로 이동하세요.
		//System.out.println("[loginFilter!!!]");
		
		//1.로그인하지 않고 사용자정보조회 => 
		//session객체 memberLoggedIn 속성값의 null여부
		//2.본인이 아닌 사용자 정보 조회 => 
		//session객체의 memberLoggedIn.getMemberId()와 요청파라미터의 memberId값을 비교
		
		HttpSession session = ((HttpServletRequest)request).getSession();
		Member memberLoggedIn = (Member)session.getAttribute("logm");
		
		//요청memberId
		String reqmemberId = request.getParameter("memberId");
		//localhost:9090/mvc/member/memberView?memberId=abcde
		
		//사용자 검사
		if(memberLoggedIn.getMemberId().equals("admin")) {
			chain.doFilter(request, response);
			return;
		}
		
		if(memberLoggedIn == null || 
			reqmemberId == null ||
		   !reqmemberId.equals(memberLoggedIn.getMemberId())) {
			//부정요청시 처리
			request.setAttribute("msg", "잘못된 경로로 접근하셨습니다.");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
				   .forward(request, response);
			//더이상 servlet 또는 filterChain으로 진행시키지 않기 위해서
			return;
			
			
		}
		
		
		
		
		
		
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
