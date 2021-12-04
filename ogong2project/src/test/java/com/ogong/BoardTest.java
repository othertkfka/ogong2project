package com.ogong;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.sql.Date;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.ogong.common.Search;
import com.ogong.service.board.BoardService;
import com.ogong.service.domain.Answer;
import com.ogong.service.domain.Board;
import com.ogong.service.domain.Comment;
import com.ogong.service.domain.User;

@SpringBootTest
class BoardTest {

	@Autowired
	private BoardService boardService;


	//@Test
	@Test
	@DisplayName("게시글 등록")
	void addBoard() throws Exception {

		User user = new User();
		user.setEmail("user05");
		user.setNickname("권세은");

		Board board = new Board();


		//board.setBoardNo(1);

		board.setWriter(user);
		board.setBoardCategory("2");
		board.setBoardTitle("Q&A게시판 글 등록");
		board.setBoardContents("성공성공~~");
		board.setBoardInterest("3");

		board.setViewCount(0);
		board.setCommentCount(0);
		// board.setFileFlag(false);

		//board.setBoardRegDate(Date.valueOf("2021-07-13"));
		//board.setViewCount(0);
		//board.setCommentCount(0);
		board.setFileFlag("2");

	//	boardService.addBoard(board);

		System.out.println(board);

	}

	 @Test
	@DisplayName("게시글 조회")
	void getBoard() throws Exception {

		Board board = new Board();
		board.setBoardNo(10021);
		Map<String, Object> map = (Map<String, Object>) boardService.getBoard(board);

		System.out.println(map);

	}

	// @Test
	@DisplayName("게시글 수정")
	void updateBoard() throws Exception {

		Board board = new Board();
		board.setBoardNo(10001);
		board.setBoardTitle("제목수정");
		board.setBoardContents("내용수정");

		boardService.updateBoard(board);

	}

	// @Test
	@DisplayName("게시글 삭제")
	void deleteBoard() throws Exception {

		Board board = new Board();
		board.setBoardNo(10001);

		boardService.deleteBoard(10021);

	}

	 //@Test
	@DisplayName("게시글 목록")
	void listBoard() throws Exception {

		Board board = new Board();
		Search search = new Search();
		board.setBoardCategory("1");
		search.setCurrentPage(1);
		search.setPageSize(2);
		search.setSearchKeyword("안녕");
		search.setSearchCondition("1");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board", board);
		map.put("search", search);
		Map<String, Object> listBoard = boardService.listBoard(map);

		Integer totalCount = (Integer) map.get("totalCount");

	}

	// @Test
	@DisplayName("댓글 등록")
	void addComent() throws Exception {

		Board board = new Board();
		User user = new User();
		Comment comment = new Comment();
		board.setBoardNo(10003);
		user.setEmail("user07");
		user.setNickname("꼬미");
		//comment.setCommentBoard(board);
		comment.setCommentWriter(user);
		comment.setCommentRegDate("2021-07-22");
		comment.setCommentContents("뽀글아 안녕~");

		boardService.addComment(comment);

	}

	// @Test
	@DisplayName("댓글 수정")
	void updateComment() throws Exception {

		Board board = new Board();
		Comment comment = new Comment();
		board.setBoardNo(10004);
		//comment.setCommentBoard(board);
		comment.setCommentContents("댓글수정 완료");

		boardService.updateComment(comment);

	}

	// @Test
	@DisplayName("댓글 삭제")
	void deleteComment() throws Exception {

	//	boardService.deleteComment(comment);

	}

	// @Test

	@DisplayName("댓글 목록")
	void listComment() throws Exception {

		Map<String, Object> map = boardService.listComment(10004, null);

		System.out.println(map.get("list"));
		System.out.println(map.get("totalCount"));

	}

	// @Test
	@DisplayName("Q&A 답변 등록")
	void addAnswer() throws Exception {

		User user = new User();
		Board board = new Board();
		Answer answer = new Answer();
		board.setBoardNo(10002);
		user.setEmail("user09");
		user.setNickname("비트캠프");
		//answer.setAnswerContents("답변 등록 성공");
		//answer.setBoard(board);
		answer.setEmail(user.getEmail());
		answer.setAdoptionFlag("2");

		boardService.addAnswer(answer);
	}

	// @Test
	@DisplayName("Q&A 답변 수정")
	void updateAnswer() throws Exception {

		Answer answer = new Answer();
		answer.setAnswerContents("답변 수정이 될까?");
		answer.setAnswerNo(10020);

		boardService.updateAnswer(answer);

	}

	// @Test
	/*
	 * @DisplayName("Q&A 답변 삭제") deleteAnswer() throws Exception {
	 * 
	 * boardService.deleteAnswer(null);
	 * 
	 * }
	 */
}
