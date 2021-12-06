package com.ogong.controller.board;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.ogong.common.Page;
import com.ogong.common.Search;
import com.ogong.service.banana.BananaService;
import com.ogong.service.board.BoardService;
import com.ogong.service.domain.Answer;
import com.ogong.service.domain.Banana;
import com.ogong.service.domain.Board;
import com.ogong.service.domain.User;
import com.ogong.service.integration.IntegrationService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Value("5")
	int pageUnit;

	@Value("5")
	int pageSize;

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private BananaService bananaService;	
	
	@Autowired
	private IntegrationService integrationService;	

	@GetMapping("addBoard")
	public String addBoard(@RequestParam("boardCategory") String boardCategory, Model model) throws Exception {
		model.addAttribute("boardCategory", boardCategory);

		if (boardCategory.equals("2")) {
			return "boardView/addQaBoard";
		}
		if (boardCategory.equals("6") || boardCategory.equals("1")) {
			return "boardView/addFile";
		}
		if (boardCategory.equals("5")) {
			return "boardView/addStudyBoard";
		}
		return "/boardView/addBoard";
	}

	@PostMapping("addBoard")
	public String addBoard(HttpSession session, @ModelAttribute("board") Board board) throws Exception {
		User user = new User();
		user = (User)session.getAttribute("user");
		board.setWriter(user);

		List<MultipartFile> fileList = new ArrayList<MultipartFile>();
		
		int result = boardService.addBoard(board,fileList);
		
		//===========바나나 적립 및 소모 Start==================
		Banana banana = new Banana();
		if (board.getBoardCategory().equals("1")) {
			banana.setBananaEmail(user);
			banana.setBananaAmount(5);
			banana.setBananaHistory("정보공유게시판 게시글 등록으로 인한 바나나 적립");
			banana.setBananaCategory("1");
			bananaService.addBanana(banana);
		} else if (board.getBoardCategory().equals("2")) {
			int regBanana = board.getBoardRegBanana();
			banana.setBananaEmail(user);
			banana.setBananaAmount(-regBanana);
			banana.setBananaHistory("Q&A 게시글 등록으로 바나나 소모");
			banana.setBananaCategory("2");
			bananaService.addBanana(banana);
		} else if (board.getBoardCategory().equals("3")) {
			banana.setBananaEmail(user);
			banana.setBananaAmount(3);
			banana.setBananaHistory("합격후기게시판 게시글 등록으로 인한 바나나 적립");
			banana.setBananaCategory("1");
			bananaService.addBanana(banana);
		}
		// ===========바나나 적립 및 소모 END==================
		
		return "redirect:/board/getBoard?boardNo=" +result;

	}
	
	@GetMapping("updateAnswer")
	public String updateAnswer(HttpSession session, @RequestParam("answerNo") int answerNo, Model model) throws Exception {

		User user = (User) session.getAttribute("user");
		
		Answer answer = new Answer();
		answer.setAnswerNo(answerNo);	
		answer.setEmail(user.getEmail());
		
		Answer result = boardService.getAnswer(answer);
		
		model.addAttribute("answer", result);

		return "/boardView/updateAnswerBoard";
	}


	@GetMapping("getBoard")
	public String getBoard(@RequestParam("boardNo") int boardNo, HttpSession session, Model model, Search search) throws Exception {
		// , @RequestParam("boardCategory") String boardCategory
		System.out.println("boardNo" + boardNo);

		User user = (User) session.getAttribute("user");
		
		boardService.updateViewcnt(boardNo);
		/* Comment comment = (Comment)boardService.listComment(boardNo, search); */
		
		
		
		Board board = new Board();
		board.setBoardNo(boardNo);
		// board.setBoardCategory(null);

		Map<String, Object> result = boardService.getBoard(board);
		board = (Board) result.get("board");
		List<File> fileList = (List<File>)result.get("fileList");
		
		model.addAttribute("board", board);
		/* model.addAttribute("comment", comment); */
		model.addAttribute("fileList", fileList);
		model.addAttribute("user", session.getAttribute("user"));

		if (board.getBoardCategory().equals("2")) {

			return "/boardView/getQaBoard";
		}
		
		if (board.getBoardCategory().equals("5")) {

			return "/boardView/getStudyBoard";
		}
		return "/boardView/getBoard";
	}

	
	@RequestMapping(value = "deleteBoard")
	public String deleteProduct(@RequestParam("boardNo") int boardNo, Model model,
			@RequestParam("boardCategory") String boardCategory) throws Exception {

		boardService.deleteBoard(boardNo);

		model.addAttribute("boardCategory", boardCategory);

		return "forward:/board/listBoard";
	}

	@GetMapping("updateBoard")
	public String updateBoard(@RequestParam("boardNo") int boardNo, Model model) throws Exception {

		Board board = new Board();
		board.setBoardNo(boardNo);

		Map<String, Object> result =  boardService.getBoard(board);
		board = (Board) result.get("board");
		
		model.addAttribute("board", board);
		
		return "/boardView/updateBoard";
	}

	@PostMapping("updateBoard")
	public String updateBoard(@ModelAttribute("board") Board board, Model model) throws Exception {

		boardService.updateBoard(board);

		return "redirect:/board/getBoard?boardNo=" + board.getBoardNo();
	}

	@RequestMapping("listBoard")
	public String listBoard(@ModelAttribute("search") Search search,
			@RequestParam("boardCategory") String boardCategory, Model model, HttpServletRequest request)
			throws Exception {

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Board board = new Board();
		board.setBoardCategory(boardCategory);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("board", board);

		Map<String, Object> resultMap = boardService.listBoard(map);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) resultMap.get("totalCount")).intValue(),
				pageUnit, pageSize);

		System.out.println(resultPage);

		model.addAttribute("list", resultMap.get("list"));
		model.addAttribute("search", search);
		model.addAttribute("boardCategory", boardCategory);
		model.addAttribute("resultPage", resultPage);

		if (boardCategory.equals("2")) {

			return "/boardView/listQaBoard";
		}
		if (boardCategory.equals("5")) {
			
			return "/boardView/listStudyBoard";
		}

		return "/boardView/listBoard";
	}

	// 파일 업로드
	@PostMapping(value = "/uploadSummernoteImageFile", produces = "application/json")
	@ResponseBody
	public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {

		JsonObject jsonObject = new JsonObject();

		String fileRoot = "C:\\summernote_image\\"; // 저장될 외부 파일 경로
		String originalFileName = multipartFile.getOriginalFilename(); // 오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자

		// UUID 확장자로 저장될 savedFileName
		String savedFileName = UUID.randomUUID() + extension; // 저장될 파일 명

		File targetFile = new File(fileRoot + savedFileName);

		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
			jsonObject.addProperty("url", "/summernoteImage/" + savedFileName);
			jsonObject.addProperty("responseCode", "success");

		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile); // 실패시 저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}

		return jsonObject;
	}
}