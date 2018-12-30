package com.kh.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.BoardComment;

/**
 * Servlet implementation class BoardCommentInsertServlet
 */
@WebServlet("/board/boardCommentInsert")
public class BoardCommentInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String boardCommentWriter = request.getParameter("boardCommentWriter");
		int boardRef = Integer.parseInt(request.getParameter("boardRef"));
		int boardCommentLevel = Integer.parseInt(request.getParameter("boardCommentLevel"));
		int boardCommentRef = Integer.parseInt(request.getParameter("boardCommentRef"));
		String boardCommentContent = request.getParameter("boardCommentContent");
		
		
		int result = 0;
		
		BoardComment c = new BoardComment();
		c.setBoardCommentLevel(boardCommentLevel);
		c.setBoardCommentWriter(boardCommentWriter);
		c.setBoardCommentContent(boardCommentContent);
		c.setBoardRef(boardRef);
		c.setBoardCommentRef(boardCommentRef);
		
		
		result = new BoardService().boardCommentInsert(c);
		
		String view = "/WEB-INF/views/common/msg.jsp";
		String msg = "";
		String loc = "/board/boardView?boardNo="+boardRef;
		
		if(result > 0) msg = "댓글 등록 성공!";
		else msg = "댓글 등록 실패!";
		
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
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
