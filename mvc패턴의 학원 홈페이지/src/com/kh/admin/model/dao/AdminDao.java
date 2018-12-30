package com.kh.admin.model.dao;

import java.io.FileNotFoundException;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import static com.kh.common.JDBCTemplate.*;

import com.kh.member.model.vo.Member;


public class AdminDao {
	private Properties prop = new Properties();
	
	public AdminDao() {
		String fileName = AdminDao.class
								  .getResource("/sql/admin/admin-query.properties")
								  .getPath();
		try {
			prop.load(new FileReader(fileName));
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

	public List<Member> selectMemberList(Connection conn) {
		List<Member> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = prop.getProperty("selectMemberList");
		
		try {
			//1. 쿼리객체 준비
			pstmt = conn.prepareStatement(query);
			
			//2.쿼리객체 실행
			rset = pstmt.executeQuery();
			
			//3.실행결과 list에 담기
			list = new ArrayList<>();
			
			while(rset.next()) {
				Member m = new Member();
				m.setMemberId(rset.getString("memberid"));
				m.setPassword(rset.getString("password"));
				m.setMemberName(rset.getString("membername"));
				m.setGender(rset.getString("gender"));
				m.setAge(rset.getInt("age"));
				m.setEmail(rset.getString("email"));
				m.setPhone(rset.getString("phone"));
				m.setAddress(rset.getString("address"));
				m.setHobby(rset.getString("hobby"));
				m.setEnrollDate(rset.getDate("enrolldate"));
				
				list.add(m);
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		return list;
	}


	public List<Member> selectMemberByMemberId(Connection conn, String searchKeyword, int cPage, int numPerPage) {
		ArrayList<Member> list =  new ArrayList<Member>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = prop.getProperty("selectMemberIdList");
		
		try {
			//1.statement객체 생성 및 미완성쿼리문 완성
			pstmt = conn.prepareStatement(query);
			
			System.out.println("searchKeyword : " + searchKeyword);
			pstmt.setString(1, "%"+searchKeyword+"%");
			pstmt.setInt(2, (cPage-1)*numPerPage+1);
			pstmt.setInt(3, cPage*numPerPage);
			
			//2.쿼리실행
			rset = pstmt.executeQuery();
			
			
			//3.결과 변수 result에 담기
			while(rset.next()) {
				Member m = new Member();
				
				m.setMemberId(rset.getString("memberid"));
				m.setPassword(rset.getString("password"));
				m.setMemberName(rset.getString("membername"));
				m.setGender(rset.getString("gender"));
				m.setAge(rset.getInt("age"));
				m.setEmail(rset.getString("email"));
				m.setPhone(rset.getString("phone"));
				m.setAddress(rset.getString("address"));
				m.setHobby(rset.getString("hobby"));
				m.setEnrollDate(rset.getDate("enrolldate"));
				
				list.add(m);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		
		
		return list;

	}


	public List<Member> selectMemberList(Connection conn, int cPage, int numPerPage) {
		ArrayList<Member> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = prop.getProperty("selectMemberListByPaging");
		
		
		try {
			//1.statement객체 생성 및 미완성쿼리문 완성
			pstmt = conn.prepareStatement(query);
			//startRnum, endRnum
			//numPerPage=5 cPage = 1인경우=> 1~5
			//numPerPage=5 cPage = 2인경우=> 6~10
			//numPerPage=5 cPage = 3인경우=> 11~15
			
			
			int startRnum = (cPage-1)*numPerPage+1;
			int endRnum = cPage*numPerPage;
			
			
			
			
			
			pstmt.setInt(1, startRnum);		
			pstmt.setInt(2, endRnum);		
			
			
			//2.쿼리실행
			rset = pstmt.executeQuery();
			
			list = new ArrayList<Member>();
			//3.결과 변수 result에 담기
			while(rset.next()) {
				Member m = new Member();
				
				m.setMemberId(rset.getString("memberid"));
				m.setPassword(rset.getString("password"));
				m.setMemberName(rset.getString("membername"));
				m.setGender(rset.getString("gender"));
				m.setAge(rset.getInt("age"));
				m.setEmail(rset.getString("email"));
				m.setPhone(rset.getString("phone"));
				m.setAddress(rset.getString("address"));
				m.setHobby(rset.getString("hobby"));
				m.setEnrollDate(rset.getDate("enrolldate"));
				
				list.add(m);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		
		
		return list;
	}


	public int selectMemberCount(Connection conn) {
		PreparedStatement pstmt = null;
		int totalContent = 0;
		ResultSet rset = null;
		String query = prop.getProperty("selectMemberCount");
		
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				totalContent = rset.getInt("cnt");
			}
			
		} catch(SQLException e){
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		
		
		
		return totalContent;
	}


	public List<Member> selectMemberByMemberName(Connection conn, String searchKeyword, int cPage, int numPerPage) {
	      List<Member> list = new ArrayList<>();
	      PreparedStatement pstmt = null;
	      ResultSet rset = null;
	      
	      String query = prop.getProperty("selectMemberByMemberName");
	      
	      try{
	         //미완성쿼리문을 가지고 객체생성. 
	         pstmt = conn.prepareStatement(query);
	         pstmt.setString(1, "%"+searchKeyword+"%");
	         pstmt.setInt(2, (cPage-1)*numPerPage+1);
			 pstmt.setInt(3, cPage*numPerPage);
	         
	         //쿼리문실행
	         //완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
	         rset = pstmt.executeQuery();
	         
	         while(rset.next()){
	            Member m = new Member();
	            //컬럼명은 대소문자 구분이 없다.
	            m.setMemberId(rset.getString("MEMBERID"));
	            m.setPassword(rset.getString("PASSWORD"));
	            m.setMemberName(rset.getString("MEMBERNAME"));
	            m.setGender(rset.getString("GENDER"));
	            m.setAge(rset.getInt("AGE"));
	            m.setEmail(rset.getString("EMAIL"));
	            m.setPhone(rset.getString("PHONE"));
	            m.setAddress(rset.getString("ADDRESS"));
	            m.setHobby(rset.getString("HOBBY"));
	            m.setEnrollDate(rset.getDate("ENROLLDATE"));
	            
	            list.add(m);
	         }
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally{
	         close(rset);
	         close(pstmt);
	      }
	      
	      
	      return list;
	   }


	public List<Member> selectMemberByGender(Connection conn, String searchKeyword, int cPage, int numPerPage) {
	      List<Member> list = new ArrayList<>();
	      PreparedStatement pstmt = null;
	      ResultSet rset = null;
	      
	      String query = prop.getProperty("selectMemberByGender");
	      
	      try{
	         //미완성쿼리문을 가지고 객체생성. 
	         pstmt = conn.prepareStatement(query);
	         pstmt.setString(1, "%"+searchKeyword+"%");
	         pstmt.setInt(2, (cPage-1)*numPerPage+1);
			 pstmt.setInt(3, cPage*numPerPage);
	         
	         //쿼리문실행
	         //완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
	         rset = pstmt.executeQuery();
	         
	         while(rset.next()){
	            Member m = new Member();
	            //컬럼명은 대소문자 구분이 없다.
	            m.setMemberId(rset.getString("MEMBERID"));
	            m.setPassword(rset.getString("PASSWORD"));
	            m.setMemberName(rset.getString("MEMBERNAME"));
	            m.setGender(rset.getString("GENDER"));
	            m.setAge(rset.getInt("AGE"));
	            m.setEmail(rset.getString("EMAIL"));
	            m.setPhone(rset.getString("PHONE"));
	            m.setAddress(rset.getString("ADDRESS"));
	            m.setHobby(rset.getString("HOBBY"));
	            m.setEnrollDate(rset.getDate("ENROLLDATE"));
	            
	            list.add(m);
	         }
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally{
	         close(rset);
	         close(pstmt);
	      }
	      
	      return list;
	   }


	public int selectChoiceMemberCount(Connection conn, String searchKeyword) {
		PreparedStatement pstmt = null;
		int totalContent = 0;
		ResultSet rset = null;
		String query = prop.getProperty("selectMemberIdCount");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, "%"+searchKeyword+"%");
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				totalContent = rset.getInt("cnt");
			}
			
		} catch(SQLException e){
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		
		
		
		return totalContent;
	}


	public int selectMemberNameCount(Connection conn, String searchKeyword) {
		PreparedStatement pstmt = null;
		int totalContent = 0;
		ResultSet rset = null;
		String query = prop.getProperty("selectMemberNameCount");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, "%"+searchKeyword+"%");
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				totalContent = rset.getInt("cnt");
			}
			
		} catch(SQLException e){
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		
		
		
		return totalContent;
	}


	public int selectMembergenderCount(Connection conn, String searchKeyword) {
		PreparedStatement pstmt = null;
		int totalContent = 0;
		ResultSet rset = null;
		String query = prop.getProperty("selectMembergenderCount");
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, "%"+searchKeyword+"%");
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				totalContent = rset.getInt("cnt");
			}
			
		} catch(SQLException e){
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		
		
		
		return totalContent;
	}
}
