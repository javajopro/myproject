package com.kh.admin.model.service;

import java.sql.Connection;
import java.util.List;

import com.kh.admin.model.dao.AdminDao;
import com.kh.board.model.vo.Board;
import com.kh.member.model.vo.Member;
import static com.kh.common.JDBCTemplate.*;

public class AdminService {
	
	public List<Member> selectMemberList(){
		List<Member> list = null;
		Connection conn = getConnection();
		list = new AdminDao().selectMemberList(conn);
		
		close(conn);
		
		return list;
	}

	
	public List<Member> selectMemberByMemberId(String searchKeyword, int cPage, int numPerPage) {
		List<Member> list = null;
		
		Connection conn = getConnection();
		list = new AdminDao().selectMemberByMemberId(conn, searchKeyword, cPage, numPerPage);
		
		
		
		close(conn);
		
		return list;
	}

	/**
	 * 페이징처리용 회원조회
	 * @param cPage
	 * @param numPerPage
	 * @return
	 */
	public List<Member> selectMemberList(int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<Member> list = new AdminDao().selectMemberList(conn, cPage, numPerPage);
		
		close(conn);
		
		return list;
	}


	public int selectMemberCount() {
		Connection conn = getConnection();
		int totalContent = new AdminDao().selectMemberCount(conn);
		close(conn);
		
		
		
		
		return totalContent;
	}


	public List<Member> selectMemberByMemberName(String searchKeyword, int cPage, int numPerPage) {
		List<Member> list = null;
		
		Connection conn = getConnection();
		list = new AdminDao().selectMemberByMemberName(conn, searchKeyword, cPage, numPerPage);
		
		
		
		close(conn);
		
		return list;
		
	}


	public List<Member> selectMemberByGender(String searchKeyword, int cPage, int numPerPage) {
		List<Member> list = null;
		
		Connection conn = getConnection();
		list = new AdminDao().selectMemberByGender(conn, searchKeyword, cPage, numPerPage);
		
		
		
		close(conn);
		
		return list;
	}


	public int selectMemberIdCount(String searchKeyword) {
		Connection conn = getConnection();
		int totalContent = new AdminDao().selectChoiceMemberCount(conn, searchKeyword);
		close(conn);
		
		
		
		
		return totalContent;
	}


	public int selectMemberNameCount(String searchKeyword) {
		Connection conn = getConnection();
		int totalContent = new AdminDao().selectMemberNameCount(conn, searchKeyword);
		close(conn);
		
		
		
		
		return totalContent;
	}


	public int selectMembergenderCount(String searchKeyword) {
		Connection conn = getConnection();
		int totalContent = new AdminDao().selectMembergenderCount(conn, searchKeyword);
		close(conn);
		
		
		
		
		return totalContent;
	}

}
