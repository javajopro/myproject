package com.kh.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.BoardComment;

/**
 * Servlet implementation class BoardViewServlet
 */
@WebServlet("/board/boardView")
public class BoardViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		
		BoardService boardService = new BoardService();
		
		//boardCookie 확인
		Cookie[] cookies = request.getCookies();
		System.out.println("cookies값 : "+cookies);
		String boardCookieVal = "";
		boolean hasRead = false;
		
		//Cookie객체는 반드시 null여부 검사후 진행
		if(cookies != null) {
			for(Cookie c : cookies) {
				String name = c.getName();
				String value = c.getValue();
				
				//boardCookie인 경우
				if("boardCookie".equals(name)) {
					boardCookieVal = value;
					if(value.contains("|"+boardNo+"|")) {
						hasRead = true;
						break;
					}
				}
				
				
			}
		}
		
		//boardCookie에서 읽음여부에 따라 분기
		if(!hasRead) {
			int result = boardService.increaseReadCount(boardNo);
			
			//쿠키를 새로새성 : 현재 게시물 번호 추가
			Cookie boardCookie = new Cookie("boardCookie", boardCookieVal+"|"+boardNo+"|");
//			boardCookie.setMaxAge(); //영속 설정
//			boardCookie.setPath("/mvc/board"); // 현재 디렉토리 기준으로 설정
			response.addCookie(boardCookie);
			
		}
		
		//게시글
		Board b = boardService.selectBoardNoList(boardNo);
		//게시글에 대한 댓글
		List<BoardComment> commentList = 
				boardService.selectCommentList(boardNo);
		
		
		
		
		
		
		
		
		
		request.setAttribute("board", b);
		request.setAttribute("commentList", commentList);
		
		String view = "WEB-INF/views/board/boardView.jsp";
		
		
		request.setAttribute("b", b);
		request.getRequestDispatcher("/WEB-INF/views/board/boardView.jsp")
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
