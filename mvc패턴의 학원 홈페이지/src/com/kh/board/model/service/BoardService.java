package com.kh.board.model.service;

import static com.kh.common.JDBCTemplate.*;

import static com.kh.common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.List;

import com.kh.board.model.dao.BoardDao;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.BoardComment;

public class BoardService {
	public List<Board> selectBoardList(int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<Board> list = new BoardDao().selectBoardList(conn, cPage, numPerPage);
		
		close(conn);
		
		return list;
	}

	public int selectBoardCount() {
		Connection conn = getConnection();
		int totalContent = new BoardDao().selectBoardCount(conn);
		close(conn);
		
		
		
		
		return totalContent;
	}

	public int BoardUpLoad(Board b) {
		int result = 0;
		
		
		Connection conn = getConnection();
		result = new BoardDao().BoardUpLoad(conn, b);
		
		if(result>0) {
			commit(conn);
			
			result = new BoardDao().BoardLastNoSelect(conn) - 1;
		}
		else {
			rollback(conn);
		}
		
		
		
		
		return result;
	}

	public Board selectBoardNoList(int boardNo) {
		Board b = new Board();
		Connection conn = getConnection();
		b = new BoardDao().selectBoardNoList(conn, boardNo);
		
		close(conn);
		
		return b;
	}

	public int increaseReadCount(int boardNo) {
		Connection conn = getConnection();
		int result = new BoardDao().increaseReadCount(conn, boardNo);
		
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		close(conn);
		
		return 0;
	}

	public int deleteBoard(int boardNo) {
		int result = 0 ;
		Connection conn = getConnection();
		result = new BoardDao().deleteBoard(conn, boardNo);
		
		//트랜잭션 처리 : dml
		
		if(result > 0)
			commit(conn);
		else
			rollback(conn);
		
		close(conn);
		
		
		
		
		return result;
	}

	public int updateBoard(Board b) {
		int result = 0;
		Connection conn = getConnection();
		result = new BoardDao().updateBoard(conn, b);
		
		
		
		close(conn);
		
		
		return result;
	}

	public int boardCommentInsert(BoardComment c) {
		int result = 0;
		Connection conn = getConnection();
		result = new BoardDao().boardCommentInsert(conn, c);
		
		
		
		close(conn);
		
		
		return result;
	}

	public List<BoardComment> selectCommentList(int boardNo) {
		List<BoardComment> commentList = null;
		Connection conn = getConnection();
		commentList = new BoardDao().selectCommentList(conn, boardNo);
		
		close(conn);
		
		
		return commentList;
	}

	public int deleteBoardComment(int boardCommentNo) {
		Connection conn = getConnection();
		int result = new BoardDao().deleteBoardComment(conn, boardCommentNo);
		if(result>0)
			commit(conn);
		else 
			rollback(conn);
		close(conn);
		
		return result;
	}
	
	
}







