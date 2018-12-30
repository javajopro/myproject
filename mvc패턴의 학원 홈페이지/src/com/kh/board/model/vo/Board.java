package com.kh.board.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Board implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private int boardNo;
	private String boardTitle;
	private String boardWriter;
	private String boardContent;
	private String originalFileName;
	private String renamedFileName;
	private Date boardDate;
	private int readCount;
	private int boardCommentCnt;
	
	
	public Board() {
		
	}
		
	public Board(int boardNo, String boardTitle, String boardWriter, String boardContent, String originalFileName,
			String renamedFileName, Date boardDate, int readCount, int boardCommentCnt) {
		super();
		this.boardNo = boardNo;
		this.boardTitle = boardTitle;
		this.boardWriter = boardWriter;
		this.boardContent = boardContent;
		this.originalFileName = originalFileName;
		this.renamedFileName = renamedFileName;
		this.boardDate = boardDate;
		this.readCount = readCount;
		this.boardCommentCnt = boardCommentCnt;
	}

	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public String getOrginalFileName() {
		return originalFileName;
	}
	public void setOrginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	
	public String getRenamedFileName() {
		return renamedFileName;
	}

	public void setRenamedFileName(String renamedFileName) {
		this.renamedFileName = renamedFileName;
	}

	public Date getBoardDate() {
		return boardDate;
	}
	public void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getBoardCommentCnt() {
		return boardCommentCnt;
	}

	public void setBoardCommentCnt(int boardCommentCnt) {
		this.boardCommentCnt = boardCommentCnt;
	}

	@Override
	public String toString() {
		return "Board [boardNo=" + boardNo + ", boardTitle=" + boardTitle + ", boardWriter=" + boardWriter
				+ ", boardContent=" + boardContent + ", originalFileName=" + originalFileName + ", renamedFileName="
				+ renamedFileName + ", boardDate=" + boardDate + ", readCount=" + readCount + ", boardCommentCnt="
				+ boardCommentCnt + "]";
	}

	
	
	
	
	
	
}
