package com.kh.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Board;
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
@WebServlet("/board/boardList")
public class BoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Member memberLoggedIn = (Member)request.getSession()
				   .getAttribute("logm");
		
		
		//1.파라미터핸들링
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
		
		System.out.printf("[cPage=%s, numPerPage=%s]\n", cPage, numPerPage);
		
		
		
		
		//2. 업무로직 컨텐츠 영역
		//보드 리스트 서비스단
		List<Board> list = new BoardService().selectBoardList(cPage, numPerPage);
		
		//2.2.페이지바영역
		//전체컨텐츠수(전체회원수)를 구하기
		int totalContent = new BoardService().selectBoardCount();
		System.out.printf("[totalContent=%s]\n", totalContent);
		
		//(공식2) 전체페이지수구하기
		//totalContent, numPerPage
		//예) numPerPage = 10, totalContent = 103
		
		int totalPage = (int)Math.ceil((double)(totalContent/numPerPage))+1;
		System.out.printf("[totalPage=%s]\n", totalPage);
		
		
		
		
		//페이지바 html
		String pageBar = "";
		//페이지바 길이
		int pageBarSize = 5;
		//(공식3) 시작페이지startPage 번호세팅
		//cPage=5, pageBarSize=5 -> 1
		//cPage=6, pageBarSize=5 -> 6
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
								"/board/boardList?" +
								"cPage="+(pageNo-1)+
								"&numPerPage="+numPerPage+"'>[이전]</a>";
		}
		
		//[페이지]section
		while(pageNo<=endPage && pageNo<=totalPage) {
			if(cPage == pageNo) {
				pageBar += "<span class='cPage'>"+pageNo+"</span>";
			}
			else {
				
				pageBar += "<a href='"+request.getContextPath()+
									"/board/boardList?" +
									"cPage="+pageNo+
									"&numPerPage="+numPerPage+"'>"+
									pageNo+"</a>";
				
			}
			pageNo++;
		}
		
		//[다음]section
		if(pageNo > totalPage) {
			
		}
		else {
			pageBar += "<a href='"+request.getContextPath()+
					"/board/boardList?" +
					"cPage="+pageNo+
					"&numPerPage="+numPerPage+"'>[다음]</a>";
		}
		
		
		//3. 뷰단
		
		
		request.setAttribute("memberLoggedIn", memberLoggedIn);
		request.setAttribute("list", list);
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("cPage", cPage);
		request.setAttribute("numPerPage", numPerPage);
		request.getRequestDispatcher("/WEB-INF/views/board/boardList.jsp")
			   .forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
