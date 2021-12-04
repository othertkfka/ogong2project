package com.ogong.service.board;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.ogong.common.Search;
import com.ogong.service.domain.Answer;
import com.ogong.service.domain.Board;
import com.ogong.service.domain.Comment;
import com.ogong.service.domain.File;
import com.ogong.service.domain.Recommend;


	@Repository
	@Mapper
	public interface BoardMapper {
		
		//게시글 등록
		int addBoard(Board board);
		
		//게시글 조회
		Board getBoard(Board board);
		
		//게시글 수정
		void updateBoard(Board board);
		
		//게시글 삭제
		void deleteBoard(int boardNo);
		
		//게시글 목록
		List<Board> listBoard(Map<String, Object> map) ;
		
		//댓글 등록
		int addComment (Comment comment);
		
		//댓글 수정
		int updateComment (Comment comment);
		
		//댓글 삭제
		int deleteComment (Comment comment);
		
		//댓글 목록
		List<Comment> listComment(Map<String, Object> map) ;
		
		int listCommentCount(Map<String, Object> map);
		
		//답변 목록
		List<Answer> listAnswer(int boardNo) ;
		
		
		int getTotalCount(Map<String, Object> map);
		
		//Q&A 답변 등록
		void addAnswer(Answer answer);
		
		//Q&A 답변 수정
		int updateAnswer (Answer answer);
		
		//Q&A 답변 삭제
		int deleteAnswer (Answer answer);
		
		//Q&A 답변 조회
		Answer getAnswer (Answer answer);
		
		//조회수
		void updateViewcnt(int boardNo);
		
		//추천수
		void addRecommend(Board board);
		
		//추천수
		void deleteRecommend(int recommendNo);
		
		//추천수
		int recommendCount(Board board);
		
		//추천수
		Recommend getRecommendNo(Board board);
		

		//알림 게시글 상세보기
		Board getNoticeBoard(int boardNo);

		//채택수
		void updateAdoption(int answerNo);
		
		//채택수
		void updateBoardAdoption(int boardNo);
			
		//채택수
		void deleteAdoption(int answerNo);
		
		//채택수
		int adoptionCount(Board board);
		
		//채택수
		Answer getAdoptionNo(Board board);

		
		//파일업로드
		int addFile (File file);	
		
		//파일업로드
		List<File> getFileList (Board board);	
		
		//파일 다운로드
		File getFile (File file);	
		
		// insert, delete, update는 반환값이 무조건 int 
		// select는 바뀌기때문에 x 
		// DAO메소드의 매개변수는 무조건 하나다 
	}