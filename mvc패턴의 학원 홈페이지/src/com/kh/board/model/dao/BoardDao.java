package com.kh.board.model.dao;

import static com.kh.common.JDBCTemplate.close;


import static com.kh.common.JDBCTemplate.commit;
import static com.kh.common.JDBCTemplate.rollback;

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

import com.kh.admin.model.dao.AdminDao;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.BoardComment;

public class BoardDao {
	
	
private Properties prop = new Properties();
	
	public BoardDao() {
		String fileName = AdminDao.class
								  .getResource("/sql/board/board-query.properties")
								  .getPath();
		try {
			prop.load(new FileReader(fileName));
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	

	public List<Board> selectBoardList(Connection conn,int cPage, int numPerPage) {
		List<Board> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = prop.getProperty("selectBoardList");
		
		try {
			//1. 쿼리객체 준비
			pstmt = conn.prepareStatement(query);
			
			int startRnum = (cPage-1)*numPerPage+1;
			int endRnum = cPage*numPerPage;
			
			
			
			
			
			pstmt.setInt(1, startRnum);		
			pstmt.setInt(2, endRnum);	
			
			//2.쿼리객체 실행
			rset = pstmt.executeQuery();
			
			//3.실행결과 list에 담기
			list = new ArrayList<>();
			
			while(rset.next()) {
				Board b = new Board();
				b.setBoardNo(rset.getInt("board_no"));
				b.setBoardTitle(rset.getString("board_title"));
				b.setBoardWriter(rset.getString("board_writer"));
				b.setBoardDate(rset.getDate("board_date"));
				b.setOrginalFileName(rset.getString("board_original_filename"));
				b.setRenamedFileName(rset.getString("board_renamed_filename"));
				b.setReadCount(rset.getInt("board_readcount"));
				b.setBoardCommentCnt(rset.getInt("board_comment_cnt"));
				
				list.add(b);
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		return list;
	}



	public int selectBoardCount(Connection conn) {
		PreparedStatement pstmt = null;
		int totalContent = 0;
		ResultSet rset = null;
		String query = prop.getProperty("selectBoardCount");
		
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



	public int BoardUpLoad(Connection conn, Board b) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = prop.getProperty("boardUpLoad");
		
		
		try {
			
			//1. 미완성쿼리문을 가지고 PreparedStatement객체생성
			pstmt = conn.prepareStatement(query);
			
			//객체생성후 ? 부분 값대입.
			
			pstmt.setString(1, b.getBoardTitle());
			pstmt.setString(2, b.getBoardWriter());
			pstmt.setString(3, b.getBoardContent());
			pstmt.setString(4, b.getOrginalFileName());
			pstmt.setString(5, b.getRenamedFileName());
			
			//2. 쿼리문 실행, 실행결과 받기
			
			result = pstmt.executeUpdate();
			
			if(result>0) conn.commit();
			else conn.rollback();
				
			
		} catch(SQLException e){
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		
		
		
		return result;
	}



	public Board selectBoardNoList(Connection conn, int boardNo) {
		Board b = new Board();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = prop.getProperty("selectBoardNoList");
		
		try {
			//1. 쿼리객체 준비
			pstmt = conn.prepareStatement(query);
			
			
			pstmt.setInt(1, boardNo);
			
			
			
			//2.쿼리객체 실행
			rset = pstmt.executeQuery();
			
			//3.실행결과 list에 담기
			
			
			while(rset.next()) {
				
				b.setBoardNo(rset.getInt("board_no"));
				b.setBoardTitle(rset.getString("board_title"));
				b.setBoardWriter(rset.getString("board_writer"));
				b.setBoardDate(rset.getDate("board_date"));
				b.setBoardContent(rset.getString("board_content"));
				b.setOrginalFileName(rset.getString("board_original_filename"));
				b.setRenamedFileName(rset.getString("board_renamed_filename"));
				b.setReadCount(rset.getInt("board_readcount"));
				
				
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		return b;
	}



	public int increaseReadCount(Connection conn, int boardNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("increaseReadCount");
		
		try {	
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, boardNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		
		
		
		
		
		
		
		
		return result;
	}



	public int BoardLastNoSelect(Connection conn) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("BoardLastNoSelect");
		ResultSet rset = null;
		
		try {	
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			
			while(rset.next()) {
			result = rset.getInt("last_number");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		
		
		
		
		
		
		
		
		return result;
	}



	public int deleteBoard(Connection conn, int boardNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = prop.getProperty("deleteBoard");
		
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, boardNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		
		
		
		
		
		
		
		return result;
	}



	public int updateBoard(Connection conn, Board b) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = prop.getProperty("updateBoard");
		try {
			
			//1. 미완성쿼리문을 가지고 PreparedStatement객체생성
			pstmt = conn.prepareStatement(query);
			//객체생성후 ? 부분 값대입.
			
			pstmt.setString(1, b.getBoardTitle());
			pstmt.setString(2, b.getBoardContent());
			pstmt.setString(3, b.getOrginalFileName());
			pstmt.setString(4, b.getRenamedFileName());
			pstmt.setInt(5, b.getBoardNo());
			
			
			
		
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
		} finally {
			close(pstmt);
		}
		
		return result;
	}



	public int boardCommentInsert(Connection conn, BoardComment c) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = prop.getProperty("boardCommentInsert");
		try {
			
			//1. 미완성쿼리문을 가지고 PreparedStatement객체생성
			pstmt = conn.prepareStatement(query);
			//객체생성후 ? 부분 값대입.
			
			pstmt.setInt(1, c.getBoardCommentLevel());
			pstmt.setString(2, c.getBoardCommentWriter());
			pstmt.setString(3, c.getBoardCommentContent());
			pstmt.setInt(4, c.getBoardRef());
			pstmt.setObject(5, c.getBoardCommentRef()==0?null:c.getBoardCommentRef());
			
			
		
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
		} finally {
			close(pstmt);
		}
		
		return result;
	}



	public List<BoardComment> selectCommentList(Connection conn, int boardNo) {
		List<BoardComment> commentList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = prop.getProperty("selectCommentList");
		
		
		try {
			//1. statement객체 생성
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, boardNo);
			
			//2.실행
			rset = pstmt.executeQuery();
			
			//3.list객체 담기
			commentList = new ArrayList<>();
			while(rset.next()) {
				BoardComment bc = new BoardComment();
				
				bc.setBoardCommentNo(rset.getInt("board_comment_no"));
				bc.setBoardCommentLevel(rset.getInt("board_comment_level"));
				bc.setBoardCommentWriter(rset.getString("board_comment_writer"));
				bc.setBoardCommentContent(rset.getString("board_comment_content"));
				bc.setBoardRef(rset.getInt("board_ref"));
				bc.setBoardCommentRef(rset.getInt("board_comment_ref"));
				bc.setBoardCommentDate(rset.getDate("board_comment_date"));
				
				
				
				commentList.add(bc);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		
		
		
		
		
		
		return commentList;
	}



	public int deleteBoardComment(Connection conn, int boardCommentNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("deleteBoardComment"); 
		
		try {
			//미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(query);
			//쿼리문미완성
			pstmt.setInt(1, boardCommentNo);
			
			//쿼리문실행 : 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			//DML은 executeUpdate()
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

}
