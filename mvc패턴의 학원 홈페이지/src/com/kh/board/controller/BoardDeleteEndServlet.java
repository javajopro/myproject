package com.kh.board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BoardService;

/**
 * Servlet implementation class BoardDeleteEndServlet
 */
@WebServlet("/board/boardDelete")
public class BoardDeleteEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 파라미터 핸들링
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		String rName = request.getParameter("rName");
		//파일이 있는 경우 : rName=저장된 파일명, 파일이 없는 경우 : rName=""
		
		//2. 업무로직
		//db의 게시글삭제
		int result = new BoardService().deleteBoard(boardNo);
		
		//첨부파일 삭제
		if(result>0 && !"".equals(rName)) {
			String saveDirectory = getServletContext().getRealPath("/upload/board/");
			File delFile = new File(saveDirectory+rName);
			System.out.println("delFile="+delFile); //toString 오버라이딩되어서 파일경로 출력
			//파일삭제
			//System.out.println("파일삭제여부 : "+delFile.delete());
			
			//파일이동
			String delDirectory = getServletContext().getRealPath("/deleteFiles/board/");
			File delFile_ = new File(delDirectory+rName);
			delFile.renameTo(delFile_);
			
			
			
		}
		
		
		
		
		//3. 뷰단
		
		String view = "/WEB-INF/views/common/msg.jsp";
		
		String msg = "";
		String loc = "/board/boardList";
		
		if(result>0) {
			msg = "게시글 삭제 성공 했습니다.";
		}
		else {
			msg = "게시글 삭제 실패 했습니다.";
		}
		
		
		
		
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
