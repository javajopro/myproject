package com.kh.board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.josephoconnell.html.HTMLInputFilter;
import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Board;
import com.kh.common.MyFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class BoardFormEnd
 */
@WebServlet("/board/boardFormEnd")
public class BoardFormEnd extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//-1.유효성검사
		if(!ServletFileUpload.isMultipartContent(request)) {
			request.setAttribute("msg", "게시판작성오류![form:enctype]");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
				   .forward(request, response);
			return;
		}
		
		
		//0. 파일업로드처리 => MultipartRequest객체 사용
		//a.saveDirectory : /upload/board/
		//파일업로드 디렉토리의 절대경로 가져오기
		String root = getServletContext().getRealPath("/");
		String saveDirectory = root + "upload"+File.separator+"board";
		System.out.printf("[saveDirectory = %s]\n", saveDirectory);
		
		//b.maxPostSize : 파일최대크기 10MB
		//1kb*1kb*10
		int maxPostSize = 1024 * 1024 * 10;
		
		//c.파일Rename정책객체 : DefaultRenamePolicy를 상속한 사용자 정의객체
		
		//MultipartRequest객체 생성
		MultipartRequest multiReq = new MultipartRequest(request,
														 saveDirectory, 
														 maxPostSize, 
														 "UTF-8", 
														 new MyFileRenamePolicy());
		
		
		
				
		
		//1. 파라미터
		//(중요)MultipartRequest객체를 생성하면, 
		//기존 request객체로부터 파라미터값을 가져올 수 없다.
		String boardTitle = multiReq.getParameter("title");
		String boardWriter = multiReq.getParameter("writer");
		String boardContent = multiReq.getParameter("content");
		
		//xss(Cross-Site Scripting)공격 대비 코드
//		boardContent = boardContent.replaceAll("<", "&lt;")
//								   .replaceAll(">",  "&gt;");
		//html_filter라이브러리	사용
		boardContent = new HTMLInputFilter().filter(boardContent);
		
		
		
		
		String originalFileName = multiReq.getOriginalFileName("up_file");//곽경국.jpg
		String renamedFileName = multiReq.getFilesystemName("up_file");//20181220_164845333_234.jpg
		
		Board b = new Board();
		b.setBoardTitle(boardTitle);
		b.setBoardWriter(boardWriter);
		b.setBoardContent(boardContent);
		b.setOrginalFileName(originalFileName);
		b.setRenamedFileName(renamedFileName);
		
		int boardNo = new BoardService().BoardUpLoad(b);
		
		String view = "/WEB-INF/views/common/msg.jsp";
		String msg = "";
		String loc = "/board/boardView?boardNo="+boardNo;
		
		if(boardNo > 0) {
			msg = "게시판 등록 성공!";
		}
		else {
			msg = "게시판 등록 실패!";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher(view)
			   .forward(request, response);
		
//		String title = request.getParameter("title");
//		String up_file = request.getParameter("up_file");
//		String content = request.getParameter("content");
//		String writer = request.getParameter("writer");
		
		
		//2. 업무 로직
//		int result = new BoardService().BoardUpLoad(title, up_file, content, writer);
		
		
		//3. 뷰단
//		String msg = "";
//		String loc = "/";
		
		
		
//		if(result>0) {
//			System.out.println("게시글 등록 성공~");
//			msg = "게시글 등록 성공~";
//		}
//		else {
//			System.out.println("게시글 등록 실패~");
//			msg = "게시글 등록 실패~";
//		}
//		
//		request.setAttribute("msg", msg);
//		request.setAttribute("loc", loc);
//		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
//			   .forward(request, response);
	
	
	
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
