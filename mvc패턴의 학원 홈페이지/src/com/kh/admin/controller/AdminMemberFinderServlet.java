package com.kh.admin.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.admin.model.service.AdminService;
import com.kh.member.model.vo.Member;

/**
 * 페이징 recipe
 * 1. 주요공식
 *  - 시작 rownum/끝rownum을 구하는 공식 : adminDao.selectMemberList(cPage, numPerPage)
 *  - 전체페이지수totalPage를 구하는 공식 : 올림처리. 모든 게시물을 담아야함.
 *  - 페이지바에서 시작번호 pageStart를 구하는 공식 : 
 *  
 *  2. 사용할 변수
 *  (컨텐츠영역)
 *  - 현재페이지 cPage
 *  - 페이지당컨텐츠수 numPerPage
 *  
 *  (페이지바영역)
 *  - 총컨텐츠수 totalContent
 *  - 전체페이지수 totalPage
 *  - 페이지바에표시할 페이지 수 pageBarSize
 *  - 페이지바시작startPage, 페이지바끝 endPage
 *  - 페이지바에서 사용할 증감변수 pageNo
 *
 */
@WebServlet("/admin/memberFinder")
public class AdminMemberFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//0. 관리자가 아닌 경우
		Member memberLoggedIn = (Member)request.getSession()
									   .getAttribute("logm");
		if(memberLoggedIn == null || 
		   !"admin".equals(memberLoggedIn.getMemberId())) {
			request.setAttribute("msg", "잘못된 경로로 접근하셨습니다.");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
				   .forward(request, response);
			
			return;
		}
		//1. 파라미터
		String searchType = request.getParameter("searchType");
		String searchKeyword = request.getParameter("searchKeyword");
		
		//cPage, numPerPage에 대한 파라미터처리.
		int cPage;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException e) {
			cPage = 1;
		}
		
		int numPerPage;
		try {
			numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
		} catch(NumberFormatException e) {
			numPerPage = 5;
		}
		System.out.println(searchType);
		
		
		
		
		//2. 업무 로직 요청
		//2.1. 컨텐츠영역
		int totalContent = 0;
		
		List<Member> list = new ArrayList<Member>();
		System.out.println("searchKeyword"+searchType+":"+searchKeyword);
		switch(searchType) {
		case "memberId": 
			list = new AdminService().selectMemberByMemberId(searchKeyword, cPage, numPerPage);
			totalContent = new AdminService().selectMemberIdCount(searchKeyword);
			System.out.printf("[totalContent=%s]\n", totalContent);
			break;
		case "memberName": 
			list = new AdminService().selectMemberByMemberName(searchKeyword, cPage, numPerPage);
			totalContent = new AdminService().selectMemberNameCount(searchKeyword);
			System.out.printf("[totalContent=%s]\n", totalContent);
			break;
		case "gender":  
			list = new AdminService().selectMemberByGender(searchKeyword, cPage, numPerPage);
			totalContent = new AdminService().selectMembergenderCount(searchKeyword);
			System.out.printf("[totalContent=%s]\n", totalContent);
			break;
		}
		
		//2.2.페이지바영역.
		//검색된 전체회원수
		
		
		//memberId, memberName, gender별로 각각 구하기
		
		
		//페이지바 html
		String pageBar = "";
		//페이지바 길이
		int pageBarSize = 5;
		int totalPage = (int)Math.ceil((double)(totalContent/numPerPage))+1;
		System.out.printf("[totalPage=%s]\n", totalPage);
		
		int startPage = ((cPage-1)/pageBarSize)*pageBarSize+1;
		int endPage = startPage + pageBarSize - 1;
		System.out.printf("[start=%s, end=%s]", startPage, endPage);
		//페이지증감변수
		int pageNo = startPage;
		
		//[이전]section
		if(pageNo == 1) {
			
		}
		else {
			pageBar += "<a href='"+request.getContextPath()+
								"/admin/memberFinder?" +"cPage="+(pageNo-1)+"&numPerPage="+numPerPage+"&searchType="+searchType+"&searchKeyword="+searchKeyword+"'>[이전]</a>";
		}
		
		//[페이지]section
		while(pageNo<=endPage && pageNo<=totalPage) {
			if(cPage == pageNo) {
				pageBar += "<span class='cPage'>"+pageNo+"</span>";
			}
			else {
				
				pageBar += "<a href='"+request.getContextPath()+
									"/admin/memberFinder?" +
									"cPage="+pageNo+"&searchType="+searchType+"&searchKeyword="+searchKeyword+"&numPerPage="+numPerPage+"'>"+
									pageNo+"</a>";
				
			}
			pageNo++;
		}
		
		//[다음]section
		if(pageNo > totalPage) {
			
		}
		else {
			pageBar += "<a href='"+request.getContextPath()+
					"/admin/memberFinder?" +
					"cPage="+pageNo+
					"&numPerPage="+numPerPage+"&searchType="+searchType+"&searchKeyword="+searchKeyword+"'>[다음]</a>";
		}
		
		
		
		//3. 뷰
		request.setAttribute("list", list);
		request.setAttribute("searchType", searchType);
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("cPage", cPage);
		request.setAttribute("numPerPage", numPerPage);
		request.getRequestDispatcher("/WEB-INF/views/admin/memberFinder.jsp")
			   .forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
