package com.collection.list.board.model.dao;

import java.io.EOFException;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;

import com.collection.list.board.model.vo.Board;

public class BoardDao {

	private ArrayList<Board> list = new ArrayList<Board>();

	public BoardDao() {
		try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream("board_list.dat"))) {

			// 불러오는 방법 다양함
			// 1번, 2번 방법은 아래의 저장하기 메소드(saveListFile)에서 for문을 이용하여 Board객체 하나씩 넣는 경우 사용
			// 3번 방법은 저장하기 메소드(saveListFile)에서 ArrayList 통으로 저장하는 경우 사용

			// 1번.
			/*
			 * Board b; 
			 * while((b=(Board)ois.readObject()) != null) { list.add(b); }
			 */

			// 2번.
			// 무한루프로 돌지만 끝을 만나게 되면 EOFException이 발생
			// 그래서 그 예외처리의 catch에서 return을 해줌으로써 끝냄
			/*
			 * while(true) { list.add((Board)(ois.readObject())); }
			 */

			// 3번. 
			// addAll메소드를 통해  list를 통으로 추가
			list.addAll((ArrayList<Board>) ois.readObject());

		} catch (EOFException e) {
			return;
		} catch (FileNotFoundException e) {
			System.out.println("파일을 찾을수 없습니다. ");
		} catch (ClassNotFoundException e) {

		} catch (IOException e) {

		}
	}

	// 게시물의 마지막 번호 얻어오기
	public int getLastBoardNo() {
		return list.get(list.size() - 1).getBoardNo();
	}

	// 1. 게시글 쓰기
	public void writeBoard(Board board) {
		list.add(board);
	}

	// 2. 게시글 전체 보기
	public ArrayList<Board> displayAllList() {
		return list;
	}

	// 3_1. 게시글 한개 보기
	public Board displayBoard(int no) {
		Board board = null;
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getBoardNo() == no) // 단지 index가 아니라 실제 게시물 번호와 비교하기 위해..
				board = list.get(i);
		}
		return board;
	}

	// 3_2. 조회수 올리기
	public void upReadCount(int no) {
		
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getBoardNo() == no) {
				list.get(i).setReadCount(list.get(i).getReadCount() + 1);
				break;
			}
		}
		// 흠.. 조회수올리는건 무조건 바로 파일에 저장해야될거같은데.. 고민중
	}

	// 4. 게시글 제목 수정
	public void modifyTitle(int no, String title) {
		
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getBoardNo() == no) {
				list.get(i).setBoardTitle(title);
				break;
			}
		}
	}

	// 5. 게시글 내용 수정
	public void modifyContent(int no, String content) {
		
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getBoardNo() == no) {
				list.get(i).setBoardContent(content);
				break;
			}
		}
	}

	// 6. 게시글 삭제
	public void deleteBoard(int no) {
		
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getBoardNo() == no) {
				list.remove(i);
				break;
			}
		}
	}

	// 7. 게시글 검색
	public ArrayList<Board> searchBoard(String title) {

		ArrayList<Board> searchList = new ArrayList<Board>();

		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getBoardTitle().contains(title)) {
				searchList.add(list.get(i));
				
				// 조회수 올리기
				list.get(i).setReadCount(list.get(i).getReadCount() + 1);
			}
		}

		return searchList;
	}

	// 8. 파일에 저장하기 
	public void saveListFile() {

		try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("board_list.dat"))) {
			
			// 리스트로 저장해도 되고 for문을 이용해 Board를 저장해도 되고
			oos.writeObject(list);

			System.out.println("board_list.dat에 성공적으로 저장되었습니다. ");

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
