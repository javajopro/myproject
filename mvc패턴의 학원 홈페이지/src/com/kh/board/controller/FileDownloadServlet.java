package com.kh.board.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FileDownloadServlet
 */
@WebServlet("/board/fileDownload")
public class FileDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.파라미터 핸들링
		String rName = request.getParameter("rName");
		String oName = request.getParameter("oName");
		System.out.printf("[rName=%s, oName=%s]\n", rName, oName);
		
		
		
		
		
		//2.파일입출력준비
		String saveDirectory = getServletContext().getRealPath("/");
		System.out.println("saveDirectory = "+saveDirectory);
		
		//입력스트림
		File f = new File(saveDirectory+"upload/board/"+rName);
		FileInputStream fis = new FileInputStream(f);
		BufferedInputStream bis = new BufferedInputStream(fis);
		//출력스트림
		ServletOutputStream sos = response.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(sos);
		
		//전송할 파일명 작성
		String resFileName = "";
		//요청브라우져에 따른 분기 : IE
		boolean isMSIE = request.getHeader("user-agent").indexOf("MSIE") != -1
						|| request.getHeader("user-agent").indexOf("Trident") != -1;
		if(isMSIE) {
			//utf-8인코딩처리를 명시적으로 해줌.
			resFileName = URLEncoder.encode(oName, "UTF-8");
			//+로 처리된 공백을 다시 한번 %20로 치환
			resFileName = resFileName.replaceAll("\\+", "%20");
		}
		else {
			resFileName = new String(oName.getBytes("UTF-8"), "ISO-8859-1");
		}
		
		
		
		System.out.println("resFileName="+resFileName);
		
		
		
		//3.파일전송
		//이진데이터 전송을 위한 MIME타입설정.
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", 
						  "attachment;filename="+resFileName);
		
		
		//파일쓰기
		int read = -1;
		while((read=bis.read()) != -1) {
			bos.write(read);
		}
		bos.close();
		bis.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
