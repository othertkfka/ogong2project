package com.ogong.service.board.impl;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.ogong.common.Search;
import com.ogong.service.board.BoardMapper;
import com.ogong.service.board.BoardService;
import com.ogong.service.domain.Answer;
import com.ogong.service.domain.Board;
import com.ogong.service.domain.Comment;
import com.ogong.service.domain.File;
import com.ogong.service.domain.Recommend;

@Service
public class BoardServiceImpl implements BoardService {

	private static final int NUM_OF_MESSAGE_PER_PAGE = 5;
	private static final int NUM_OF_NAVI_PAGE = 3;

	private static final String UPLOAD_PATH = "C:/summernote_image";

	@Autowired
	BoardMapper boardMapper;

	// 게시글 등록
	@Override
	public int addBoard(Board board, List<MultipartFile> fileList) throws Exception {
		if (fileList == null) {
			board.setFileFlag("2");
		} else {
			board.setFileFlag("1");
		}
		
		makDir(UPLOAD_PATH);
		boardMapper.addBoard(board);

		for (MultipartFile f : fileList) {
			String fileName = f.getOriginalFilename();

			File file = new File();
			file.setFileName(fileName);
			file.setFileBoard(board);
			boardMapper.addFile(file);

			java.io.File target = new java.io.File(UPLOAD_PATH, fileName);
			try {
				FileCopyUtils.copy(f.getBytes(), target);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return board.getBoardNo();

	}

	// 게시글+댓글 조회
	public Map<String, Object> getBoard(Board board) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("board", boardMapper.getBoard(board));
		result.put("fileList", boardMapper.getFileList(board));

		return result;

	}

	// 게시글 수정
	public void updateBoard(Board board) throws Exception {

		boardMapper.updateBoard(board);

	}

	// 게시글 삭제
	public void deleteBoard(int boardNo) throws Exception {

		boardMapper.deleteBoard(boardNo);

	}

	// 게시글 목록
	public Map<String, Object> listBoard(Map<String, Object> map) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("list", boardMapper.listBoard(map));
		resultMap.put("totalCount", boardMapper.getTotalCount(map));

		return resultMap;
	}

	// 댓글 등록
	public Boolean addComment(Comment comment) throws Exception {
		int cnt = boardMapper.addComment(comment);
		if (cnt > 0) {
			return true;
		}
		return false;
	}

	// 댓글 수정
	public Boolean updateComment(Comment comment) throws Exception {
		boardMapper.updateComment(comment);
		return null;
	}

	// 댓글 삭제
	public Boolean deleteComment(Comment comment) throws Exception {
		int cnt = boardMapper.deleteComment(comment);
		if (cnt > 0) {
			return true;
		}
		return false;
	}

	// 댓글 목록
	public Map<String, Object> listComment(int boardNo, Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardNo", boardNo);
		map.put("startRowNum", search.getStartRowNum());
		map.put("endRowNum", search.getEndRowNum());

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", boardMapper.listComment(map));
		result.put("listComment", boardMapper.listCommentCount(map));

		return result;
	}

//	Q&A 답변 등록
	public void addAnswer(Answer answer) throws Exception {
		boardMapper.addAnswer(answer);
	}
	
//	Q&A 답변 조회
	public Answer getAnswer(Answer answer) throws Exception {
		return boardMapper.getAnswer(answer);
	}

	// Q&A 답변 수정
	public Boolean updateAnswer(Answer answer) throws Exception {
		int cnt = boardMapper.updateAnswer(answer);
		if (cnt > 0) {
			return true;
		}
		return false;
	}

	// Q&A 답변 삭제
	public Boolean deleteAnswer(Answer answer) throws Exception {
		int cnt = boardMapper.deleteAnswer(answer);
		if (cnt > 0) {
			return true;
		}
		return false;
	}

	// 조회수
	public void updateViewcnt(int boardNo) throws Exception {

		boardMapper.updateViewcnt(boardNo);
	}

	// 추천수
	public int recommend(Board board) throws Exception {
		Recommend recommend = boardMapper.getRecommendNo(board);
		if (recommend != null) {
			boardMapper.deleteRecommend(recommend.getRecommendNo());
		} else {
			boardMapper.addRecommend(board);
		}

		int recommendCount = boardMapper.recommendCount(board);
		return recommendCount;
	}
	
	// 채택수
	public void updateAdoption(int answerNo) throws Exception {
		
		boardMapper.updateAdoption(answerNo);
	}
	
	// 채택수
	public void updateBoardAdoption(int boardNo) throws Exception {
		
		boardMapper.updateBoardAdoption(boardNo);
	}

	// 답변 목록
	public List<Answer> listAnswer(int boardNo) throws Exception {

		return boardMapper.listAnswer(boardNo);
	}

	// 파일 다운로드
	public void fileDown(HttpServletResponse response, File file) throws Exception {
		File fileInfo = boardMapper.getFile(file);
		String fileName = fileInfo.getFileName();
		String storePath = UPLOAD_PATH + "\\" + fileName;

		try {
			fileName = URLEncoder.encode(fileName, "UTF-8");
			response.setContentType("application/download;charset=utf-8");
			response.setHeader("Content-Disposition", "attachment;fileName=\"" + fileName + "\";");

			OutputStream out = response.getOutputStream();
			FileInputStream fis = new FileInputStream(new java.io.File(storePath));
			FileCopyUtils.copy(fis, out);
			fis.close();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 파일 업로드
	private void makDir(String path) {
		java.io.File folder = new java.io.File(path);
		if (!folder.exists()) // 폴더 존재여부 확인 (존재: true)
		{
			try {
				folder.mkdir(); // 폴더 생성
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
	}

	//알림 게시글 상세보기
	public Board getNoticeBoard(int boardNo) throws Exception{
		
		return boardMapper.getNoticeBoard(boardNo);
	}
}
