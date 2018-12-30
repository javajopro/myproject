package com.kh.member.model.dao;

import java.io.FileNotFoundException;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import com.kh.member.model.vo.Member;


import static com.kh.common.JDBCTemplate.*;

public class MemberDao {
	Properties prop = new Properties();
	
	public MemberDao() {
		String fileName = MemberDao.class.getResource("/sql/member/member-query.properties")
										 .getPath();
		try {
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public int loginCheck(Connection conn, Member m) {
		int result = -1;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = prop.getProperty("loginCheck");
		
		try {
			//1.statement객체 생성 및 미완성쿼리문 완성
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, m.getMemberId());
			pstmt.setString(2, m.getPassword());
			pstmt.setString(3, m.getMemberId());
			
			
			//2.쿼리실행
			rset = pstmt.executeQuery();
			
			//3.결과 변수 result에 담기
			while(rset.next()) {
				result = rset.getInt("login_check");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		//2.쿼리실행
		
		
		
		return result;
		
	}

	public Member selectOne(Connection conn, String memberId) {
		Member m = new Member();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = prop.getProperty("selectOne");
		
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, memberId);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
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
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return m;
	}

	public int loginInsert(Connection conn, String memberId, int status, String ip) {
		int result = 0;

		PreparedStatement pstmt = null;
		
		String query = prop.getProperty("loginInsert");
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, memberId);
			pstmt.setInt(2, status);
			pstmt.setString(3, ip);
			
			//2. 쿼리문 실행, 실행결과 받기
			result = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(pstmt);
		}
		
		
		
		
		
		
		
		return result;
	}

	public int logoutInsert(Connection conn, String memberId, int status, String ip) {
		int result = 0;

		PreparedStatement pstmt = null;
		
		String query = prop.getProperty("loginInsert");
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, memberId);
			pstmt.setInt(2, status);
			pstmt.setString(3, ip);
			
			//2. 쿼리문 실행, 실행결과 받기
			result = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(conn);
		}
		
		
		
		
		
		
		
		return result;
	}

	public int join(Connection conn, Member m) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = prop.getProperty("insertjoin");
		try {
			
			//1. 미완성쿼리문을 가지고 PreparedStatement객체생성
			pstmt = conn.prepareStatement(query);
			//객체생성후 ? 부분 값대입.
			pstmt.setString(1, m.getMemberId());
			pstmt.setString(2, m.getPassword());
			pstmt.setString(3, m.getMemberName());
			pstmt.setString(4, m.getGender());
			pstmt.setInt(5, m.getAge());
			pstmt.setString(6, m.getEmail());
			pstmt.setString(7, m.getPhone());
			pstmt.setString(8, m.getAddress());
			pstmt.setString(9, m.getHobby());
			
			
			//2. 쿼리문 실행, 실행결과 받기
			result = pstmt.executeUpdate();
			
			if(result > 0) {
				commit(conn);
			}
			else {
				rollback(conn);
			}
			
		} catch (Exception e) {
			e.printStackTrace();//콘솔로깅용으로 남겨둠
			//사용자 정의 예외 던짐.
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int updateEnd(Connection conn, Member m) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = prop.getProperty("updateEnd");
		try {
			
			//1. 미완성쿼리문을 가지고 PreparedStatement객체생성
			pstmt = conn.prepareStatement(query);
			//객체생성후 ? 부분 값대입.
			pstmt.setString(1, m.getMemberName());
			pstmt.setString(2, m.getGender());
			pstmt.setInt(3, m.getAge());
			pstmt.setString(4, m.getEmail());
			pstmt.setString(5, m.getPhone());
			pstmt.setString(6, m.getAddress());
			pstmt.setString(7, m.getHobby());
			pstmt.setString(8, m.getMemberId());
			
			
			//2. 쿼리문 실행, 실행결과 받기
			result = pstmt.executeUpdate();
			
			if(result > 0) {
				commit(conn);
			}
			else {
				rollback(conn);
			}
			
		} catch (Exception e) {
			e.printStackTrace();//콘솔로깅용으로 남겨둠
			//사용자 정의 예외 던짐.
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int memberDelete(Connection conn, String memberId) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = prop.getProperty("memberDelete");
		try {
			
			//1. 미완성쿼리문을 가지고 PreparedStatement객체생성
			pstmt = conn.prepareStatement(query);
			//객체생성후 ? 부분 값대입.
			pstmt.setString(1, memberId);
			
			
			
			//2. 쿼리문 실행, 실행결과 받기
			result = pstmt.executeUpdate();
			
			if(result > 0) {
				commit(conn);
			}
			else {
				rollback(conn);
			}
			
		} catch (Exception e) {
			e.printStackTrace();//콘솔로깅용으로 남겨둠
			//사용자 정의 예외 던짐.
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int updatePassword(Connection conn, Member m) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("updatePassword");
		
		try {
			//1.쿼리객체 준비 끝
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, m.getPassword());
			pstmt.setString(2, m.getMemberId());
			
			//2.실행
			result = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		
		
		return result;
	}

	
}
