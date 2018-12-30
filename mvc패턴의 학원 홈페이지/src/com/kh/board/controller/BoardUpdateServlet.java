package com.kh.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Board;

/**
 * Servlet implementation class BoardUpdateSeervlet
 */
@WebServlet("/board/boardUpdate")

public class BoardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 파라미터
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		
		
		
		
		//2. 업무로직
		Board b = new BoardService().selectBoardNoList(boardNo);
		
		
		
		
		//3. 뷰단 처리
		String view = "/WEB-INF/views/board/boardUpdate.jsp";
		request.setAttribute("board", b);
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
