package com.collection.list.board.model.comparator;

import java.util.Comparator;

import com.collection.list.board.model.vo.Board;

public class AscBoardNo implements Comparator/*<Board>*/ {
	
	public AscBoardNo() {
		
	}

	@Override
	public int compare(Object arg0, Object arg1) {
		if(arg0 instanceof Board && arg1 instanceof Board) {
			Board b1 = (Board) arg0;
			Board b2 = (Board) arg1;
			
			return b1.getBoardNo()- b2.getBoardNo();
		}
		
		return 0;
	}

	/*@Override
	public int compare(Board b1, Board b2) {
		return b1.getBoardNo()- b2.getBoardNo();
	}*/

}
