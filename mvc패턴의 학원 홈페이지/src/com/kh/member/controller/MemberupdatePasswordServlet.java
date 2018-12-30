package com.kh.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.member.model.service.MemberService;
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class MemberPasswordUpdateEndServlet
 */
@WebServlet("/member/updatePasswordEnd")
public class MemberupdatePasswordServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;

   /**
    * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      //1.parameterHandling
      String memberId = request.getParameter("memberId");
      String password = request.getParameter("password");
      String password_new = request.getParameter("password_new");
      
      System.out.printf("[%s %s %s\n", memberId, password, password_new);
      
      //2.businessLogic
      //기존비밀번호확인
      //logincheck : memberId, password
      
      //1,0
      Member m = new Member();
      m.setMemberId(memberId);
      m.setPassword(password);
      
      System.out.println(m);
      
      int result = new MemberService().loginCheck(m);
      
      System.out.println("기존비밀번호 체크 : "+result);
      String msg = "";
      String loc = "";
      
      if(result == MemberService.LOGIN_OK) { //로그인OK가 1값이니까!! 
         //새비밀번호 변경
         m.setPassword(password_new); //변경할 비밀번호로 Member 객체 갱신
         result = new MemberService().updatePassword(m);
         
         if(result > 0) {
            msg = "패스워드 변경 성공!";
         }
         else {
            msg = "패스워드 변경에 실패했습니다.";
            loc = "/member/updatePassword?memberid="+memberId;
         }
               
               
      }
      else {
         msg = "기존 패스워드를 잘못 입력하셨습니다.";
         loc = "/member/updatePassword?memberid="+memberId;
         
      }
      
      //3.view
      request.setAttribute("msg", msg);
      request.setAttribute("loc", loc);
      request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
   }

   /**
    * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // TODO Auto-generated method stub
      doGet(request, response);
   }

}