package com.kh.member.model.service;

import static com.kh.common.JDBCTemplate.close;

import static com.kh.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.Properties;

import com.kh.member.model.dao.MemberDao;
import com.kh.member.model.vo.Member;

public class MemberService {
	//로그인 관련 상수
	public static final int LOGIN_OK = 1;
	public static final int WRONG_PASSWORD = 0;
	public static final int ID_NOT_EXIST = -1;
	
	
	public int loginCheck(Member m) {
		
		int result = -1;
		Connection conn = getConnection();
		
		result = new MemberDao().loginCheck(conn, m);
		
		close(conn);
		
		return result;
	}


	public Member selectOne(String memberId) {
		Member m = new Member();
		
		Connection conn = getConnection();
		
		m = new MemberDao().selectOne(conn, memberId);
		
		close(conn);
		
		return m;
	}


	public int loginInsert(String memberId, int status, String ip) {
		int result = 0;
		
		Connection conn = getConnection();
		
		result = new MemberDao().loginInsert(conn, memberId, status, ip);
		
		if(result>0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}


	public int logoutInsert(String memberId, int status, String ip) {
		int result = 0;
		
		Connection conn = getConnection();
		
		result = new MemberDao().logoutInsert(conn, memberId, status, ip);
		
		close(conn);
		
		return result;
	}


	public int join(Member m) {
		int result = 0;
		
		Connection conn = getConnection();
		
		result = new MemberDao().join(conn, m);
		
		close(conn);
		
		return result;
	}


	public int updateEnd(Member m) {
		int result = 0;
		
		Connection conn = getConnection();
		
		result = new MemberDao().updateEnd(conn, m);
		
		close(conn);
		
		return result;
	}


	public int memberDelete(String memberId) {
		int result = 0;
		
		Connection conn = getConnection();
		
		result = new MemberDao().memberDelete(conn, memberId);
		
		close(conn);
		
		return result;
	}


	public int updatePassword(Member m) {
		Connection conn = getConnection();
		
		int result = new MemberDao().updatePassword(conn, m);
		//dml문 실행시 반드시 트랜잭션처리
		
		if(result > 0 )
			commit(conn);
		else
			rollback(conn);
		
		//자원반납
		close(conn);
		
		return result;
	}


	
}
