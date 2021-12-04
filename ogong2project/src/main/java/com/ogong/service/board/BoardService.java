package com.ogong.service.board;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.ogong.common.Search;
import com.ogong.service.domain.Answer;
import com.ogong.service.domain.Board;
import com.ogong.service.domain.Comment;
import com.ogong.service.domain.File;

public interface BoardService {

		//게시글 등록
		public int addBoard(Board board, List<MultipartFile> fileList) throws Exception;
		
		//게시글 조회
		public Map<String, Object> getBoard(Board board) throws Exception;
		
		//게시글 수정
		public void updateBoard(Board board) throws Exception;
		
		//게시글 삭제
		public void deleteBoard(int boardNo) throws Exception; 
		
		//게시글 목록
		public Map<String, Object> listBoard(Map<String, Object> map) throws Exception;
		
		//댓글 등록
		public Boolean addComment(Comment comment) throws Exception;
		
		//댓글 수정
		public Boolean updateComment(Comment comment) throws Exception;
		
		//댓글 삭제
		public Boolean deleteComment(Comment comment) throws Exception;
		
		//댓글 목록
		public Map<String, Object> listComment(int boardNo, Search search) throws Exception;
		
		//Q&A 답변 등록
		public void addAnswer(Answer answer) throws Exception;
			
		//Q&A 답변 등록
		public Answer getAnswer(Answer answer) throws Exception;
		
		//Q&A 답변 목록
		public List<Answer> listAnswer(int boardNo) throws Exception;
		
		//Q&A 답변 수정
		public Boolean updateAnswer(Answer answer) throws Exception;
			
		//Q&A 답변 삭제
		public Boolean deleteAnswer(Answer answer) throws Exception;
		
		//조회수
		public void updateViewcnt(int boardNo) throws Exception;
		
		//추천수
		public int recommend(Board board) throws Exception;
		
		//채택수
		public void updateAdoption(int answerNo) throws Exception;
		
		//채택수
		public void updateBoardAdoption(int boardNo) throws Exception;
		
		//파일 다운
		public void fileDown(HttpServletResponse response, File file) throws Exception;
		
		//알림 게시글 상세보기
		public Board getNoticeBoard(int boardNo) throws Exception;

		
}