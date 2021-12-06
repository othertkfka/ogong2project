package com.ogong.controller.board;
 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ogong.common.Search;
import com.ogong.service.banana.BananaService;
import com.ogong.service.board.BoardService;
import com.ogong.service.domain.Answer;
import com.ogong.service.domain.Banana;
import com.ogong.service.domain.Board;
import com.ogong.service.domain.Comment;
import com.ogong.service.domain.File;
import com.ogong.service.domain.Notice;
import com.ogong.service.domain.User;
import com.ogong.service.integration.IntegrationService;

//@Controller
@RestController
@RequestMapping("/board/*")
public class RestBoardController {
    
    @Autowired
    private BoardService boardService;

    @Autowired
    private IntegrationService integrationService;
    
    @Autowired
    private BananaService bananaService;
    
	@PostMapping("/json/addBoard")
	public int addBoard(MultipartHttpServletRequest request, @ModelAttribute("board") Board board) throws Exception {
		List<MultipartFile> fileList = request.getFiles("file");
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		board.setWriter(user);
		
		System.err.println("@@@@@@@@@@@@@@");

		int result = boardService.addBoard(board, fileList);
		return result;  
	}
    
    
    @PostMapping("updateRecommend")
	public int updateRecommend(HttpServletRequest request, @RequestParam("boardNo") int boardNo) throws Exception {
		Board board = new Board();
		board.setBoardNo(boardNo);		
		HttpSession session = request.getSession(true);
		User user = (User)session.getAttribute("user");
		board.setWriter(user);	
		int result = boardService.recommend(board);
		
		return result;
		
	}
    
    @GetMapping("/json/updateAdoption/{answerNo}/{boardNo}/{boardRegBanana}")
	public void updateAdoption(@PathVariable("answerNo") int answerNo, @PathVariable("boardNo") int boardNo,
													@PathVariable("boardRegBanana") int boardRegBanana) throws Exception {
		Answer answer = new Answer();
		answer.setAnswerNo(answerNo);		
		answer = boardService.getAnswer(answer);
		Banana banana = new Banana();
		User user = new User();
		user.setEmail(answer.getEmail());
		
		Board board = new Board();
		board.setBoardNo(boardNo);
		Map<String, Object> map = boardService.getBoard(board);
		
		
		banana.setBananaEmail(user);
		banana.setBananaAmount(boardRegBanana);
		banana.setBananaHistory("Q&A 게시글 채택으로 인한 바나나 적립");
		banana.setBananaCategory("1");
		bananaService.addBanana(banana);

		boardService.updateAdoption(answerNo);
		boardService.updateBoardAdoption(boardNo);
		
		Notice notice = new Notice();
		//확인
		System.out.println("확인 ::: "+map.get("board"));
		notice.setNoticeUser(user);
		notice.setNoticeBoard((Board)map.get("board"));
		notice.setNoticeCategory("3");
		notice.setNoticeCondition("2");
		integrationService.addNotice(notice);
		
	}
    
    
    @GetMapping("listComment")
	public Map<String, Object> listComment(@RequestParam("boardNo") int boardNo, Search search) throws Exception {		
    	Map<String, Object> map = boardService.listComment(boardNo, search);
    		
    	return map;
	}  
    
    @PostMapping("addComment")
	public Boolean addComment(HttpServletRequest request, HttpSession session, @RequestBody Comment comment, Notice notice) throws Exception {
    	User user = (User)session.getAttribute("user");
    	
    	// 알림 처리를 위한 인서트~
    	Board board = boardService.getNoticeBoard(comment.getBoardNo());
    	notice.setNoticeUser(board.getWriter());
    	notice.setNoticeBoard(board);
    	notice.setNoticeCategory("1");
    	notice.setNoticeCondition("2");
    	integrationService.addNotice(notice);

		comment.setCommentWriter(user);
		
		return boardService.addComment(comment);
    }
    
    @PostMapping("updateComment")
	public Boolean updateComment(HttpServletRequest request, @RequestBody Comment comment) throws Exception {	
    	HttpSession session = request.getSession();
    	User user = (User)session.getAttribute("user");
    	comment.setCommentWriter(user);
    	
    	boardService.updateComment(comment);
    	
		return true;
    }
    
    @PostMapping("deleteComment")
	public Boolean deleteComment(HttpServletRequest request, @RequestBody Comment comment) throws Exception {	
    	HttpSession session = request.getSession();
    	User user = (User)session.getAttribute("user");
    	comment.setCommentWriter(user);
		
		return boardService.deleteComment(comment);
    }
    
    @GetMapping("listAnswer/{boardNo}")
	public List<Answer> listAnswer(@PathVariable int boardNo) throws Exception {		
    	List<Answer> list = boardService.listAnswer(boardNo);
    	
    	return list;
	}  
    
    @PostMapping("addAnswer")
    public String addAnswer(@RequestBody Answer answer) throws Exception {
    	
    	// 알림 처리를 위한 인서트~
		Notice notice = new Notice();
		Board board = boardService.getNoticeBoard(answer.getBoardNo());
    	notice.setNoticeUser(board.getWriter());
    	notice.setNoticeBoard(board);
    	notice.setNoticeCategory("2");
    	notice.setNoticeCondition("2");
    	integrationService.addNotice(notice);		
		
		boardService.addAnswer(answer);
    	
    	return "success";
    }
    
    @PostMapping("updateAnswer")
   	public String updateAnswer(HttpServletRequest request, @RequestBody Answer answer) throws Exception {	
       	HttpSession session = request.getSession();
       	User user = (User)session.getAttribute("user");
       	answer.setEmail(user.getEmail());

       		
   		boardService.updateAnswer(answer);
   		return "/board/getBoard";

       }
       
       
      @PostMapping("deleteAnswer")
   	public Boolean deleteAnswer(HttpServletRequest request, @RequestBody Answer answer) throws Exception {	
       	HttpSession session = request.getSession();
       	User user = (User)session.getAttribute("user");
       	answer.setEmail(user.getEmail());
   		
       	return boardService.deleteAnswer(answer);

       }
       
   	@PostMapping("/json/listStudyBoard/")
   	public Map<String, Object> listStudyBoard(HttpServletRequest request, @RequestBody Search search, 
   			Model model, Board board)throws Exception {
   		
    	//HttpSession session = request.getSession();
    	//User user = (User)session.getAttribute("user");
   		
   		board.setBoardCategory("5");
   		search.setPageSize(4);
   		HashMap<String, Object> map = new HashMap<String, Object>();
   		map.put("search", search);
   		map.put("board", board);
   		
   		
   		System.out.println("오류 확인");
   		
   		Map<String, Object> result = boardService.listBoard(map);
   		
   		return result;
   	}
    
    @GetMapping("fileDown")
   	public void fileDown(HttpServletResponse response, @RequestParam("fileNo") int fileNo) throws Exception {		
    	File file = new File();
    	file.setFileNo(fileNo);
    	boardService.fileDown(response, file);
   	}  
}