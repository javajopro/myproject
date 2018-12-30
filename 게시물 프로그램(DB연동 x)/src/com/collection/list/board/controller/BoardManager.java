package com.collection.list.board.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.Scanner;

import com.collection.list.board.model.comparator.AscBoardDate;
import com.collection.list.board.model.comparator.AscBoardNo;
import com.collection.list.board.model.comparator.AscBoardTitle;
import com.collection.list.board.model.comparator.DescBoardDate;
import com.collection.list.board.model.comparator.DescBoardNo;
import com.collection.list.board.model.comparator.DescBoardTitle;
import com.collection.list.board.model.dao.BoardDao;
import com.collection.list.board.model.vo.Board;

public class BoardManager {

	private BoardDao bDao = new BoardDao();
	private Scanner sc = new Scanner(System.in);

	public BoardManager() {

	}

	public void writeBoard() {

		System.out.println("새 게시글 쓰기 입니다.");

		System.out.print("글제목 : ");
		String title = sc.nextLine();
		System.out.print("작성자 : ");
		String ss = sc.nextLine();

		// 문제의도상 공백제거를 위해 다음과 같은 과정 거치기
		String writer = "";
		for (int i = 0; i < ss.length(); i++) {
			if (ss.charAt(i) != ' ') {
				writer += ss.charAt(i);
			}
		}

		Date date = new Date();

		String content = "";
		String str = "";
		System.out.print("글내용(exit 입력 시 종료) : ");

		while (true) {
			str = sc.nextLine();

			if (str.equals("exit"))
				break;
			content += str + " ";
		}

		// 파일이 없었을 경우, 즉 첫 글 등록일 경우 IndexOutofBoundsException 발생
		// 다음의 try catch문을 이용하여 첫 글 등록시 게시물 번호 1로 등록
		// 첫 글이 아닐경우 getLastBoardNo메소드를 통해 기존에 있는 게시물의 제일 마지막번호를 불러와 +1 처리
		try {
			bDao.writeBoard(new Board(bDao.getLastBoardNo() + 1, title, writer, date, content));
		} catch (IndexOutOfBoundsException e) {
			bDao.writeBoard(new Board(1, title, writer, date, content));
		}
	}

	public void displayAllList() {
		Iterator it = bDao.displayAllList().iterator();
		while (it.hasNext()) {
			System.out.println(it.next());
		}
	}

	public void displayBoard() {
		System.out.print("조회할 글번호 : ");
		int no = sc.nextInt();
		sc.nextLine();

		Board board = bDao.displayBoard(no);
		if (board == null) {
			System.out.println("조회된 글이 없습니다.");
		} else {
			System.out.println(board);
			
			// 조회수 올리기
			bDao.upReadCount(no);
		}

		
	}

	public void modifyTitle() {
		System.out.print("수정할 글번호 : ");
		int no = sc.nextInt();
		sc.nextLine();

		Board board = bDao.displayBoard(no);
		if (board == null) {
			System.out.println("조회된 글이 없습니다.");
		} else {
			System.out.println(board);
			
			System.out.print("변경할 제목 : ");
			String title = sc.nextLine();
			bDao.modifyTitle(no, title);
		}

		
	}

	public void modifyContent() {
		System.out.print("수정할 글번호 : ");
		int no = sc.nextInt();
		sc.nextLine();

		Board board = bDao.displayBoard(no);
		if (board == null) {
			System.out.println("조회된 글이 없습니다.");
		} else {
			System.out.println(board);
			
			System.out.print("변경할 내용 : ");
			String content = sc.nextLine();
			bDao.modifyContent(no, content);
		}
		

	}

	public void deleteBoard() {
		System.out.print("삭제할 글번호 : ");
		int no = sc.nextInt();
		sc.nextLine();

		Board board = bDao.displayBoard(no);
		if (board == null) {
			System.out.println("조회된 글이 없습니다.");
		} else {
			System.out.println(board);

			System.out.print("정말로 삭제하시겠습니까? (y/n) : ");
			char ch = sc.nextLine().toUpperCase().charAt(0);
			if (ch == 'Y') {
				bDao.deleteBoard(no);
				System.out.println(no + "번 글이 삭제되었습니다.");
			}
		}

	}

	public void searchBoard() {

		System.out.print("검색할 제목 : ");
		String title = sc.nextLine();

		// 검색 결과가 다중일 수도 있으니깐 ArrayList로 결과값 받기
		ArrayList<Board> searchList = bDao.searchBoard(title);

		if (searchList.isEmpty()) {
			System.out.println("검색 결과가 없습니다.");
		} else {
			for (int i = 0; i < searchList.size(); i++) {
				System.out.println(searchList.get(i));
			}
		}

	}

	public void saveListFile() {
		bDao.saveListFile();
	}

	public void sortList(int item, boolean isDesc) {

		ArrayList<Board> list = bDao.displayAllList();
		switch (item) {
		case 1:
			if (isDesc)
				list.sort(new DescBoardNo());
			else
				list.sort(new AscBoardNo());
			break;
		case 2:
			if (isDesc)
				list.sort(new DescBoardDate());
			else
				list.sort(new AscBoardDate());
			break;
		case 3:
			if (isDesc)
				list.sort(new DescBoardTitle());
			else
				list.sort(new AscBoardTitle());
			break;
		}

		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}

	}

}
