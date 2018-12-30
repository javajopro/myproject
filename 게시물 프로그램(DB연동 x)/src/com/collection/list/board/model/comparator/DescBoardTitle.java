package com.collection.list.board.model.comparator;

import java.util.Comparator;

import com.collection.list.board.model.vo.Board;

public class DescBoardTitle implements Comparator/*<Board>*/{
	
	public DescBoardTitle() {
		
	}

	@Override
	public int compare(Object arg0, Object arg1) {
		if(arg0 instanceof Board && arg1 instanceof Board) {
			Board b1 = (Board) arg0;
			Board b2 = (Board) arg1;
			
			return b2.getBoardTitle().compareTo(b1.getBoardTitle());
		}
		
		return 0;
	}

	/*@Override
	public int compare(Board o1, Board o2) {
		// TODO Auto-generated method stub
		return b2.getBoardTitle().compareTo(b1.getBoardTitle());
	}*/
}
