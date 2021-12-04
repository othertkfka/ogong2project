package com.ogong.controller.integration;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ogong.common.Page;
import com.ogong.common.Search;
import com.ogong.service.admin.AdminService;
import com.ogong.service.banana.BananaService;
import com.ogong.service.domain.Answer;
import com.ogong.service.domain.Banana;
import com.ogong.service.domain.LearningHistory;
import com.ogong.service.domain.Message;
import com.ogong.service.domain.Notice;
import com.ogong.service.domain.Study;
import com.ogong.service.domain.User;
import com.ogong.service.integration.IntegrationService;
import com.ogong.service.learningHistory.LearningHistoryService;
import com.ogong.service.study.StudyService;
import com.ogong.service.user.UserService;

@Configuration 
@EnableScheduling
@Controller
@RequestMapping("/integration/*")
public class IntegrationController {
	
	@Autowired
	private IntegrationService integrationService;
	@Autowired
	private AdminService adminService;
	@Autowired
	private LearningHistoryService learningHistoryService;
	@Autowired
	private UserService userService;
	@Autowired
	private StudyService studyService;
	@Autowired
	private BananaService bananaService;	
	
	public IntegrationController() {
		System.out.println(this.getClass());
	}
	
	/*@GetMapping("addSendMessage")
	public String addSendMessage(Model model) throws Exception{
		
		System.out.println("/integration/addSendMessage : GET");
		
		User sender = new User();
		Message message = new Message();
		
		sender.setEmail("user06");
		message.setSender(sender);
		
		model.addAttribute(message);
		
		System.out.println(message+"여기는 message");
		
		return "/integrationView/addSendMessage";
		
	}*/
	
	//쪽지 전송을 위한 메소드
	@PostMapping("addSendMessage")
	public String addSendMessage( @ModelAttribute("message") Message message,
								  HttpSession session, 
								  Notice notice) throws Exception{
		
		System.out.println("message 시작");
		
		User user = (User)session.getAttribute("user"); 
		message.setSender(user);
		
		System.out.println("message 확인 ::: " +message);
		System.out.println("session user 확인 :::"+session.getAttribute("user"));
		
		// 알림 처리를 위해 알림 insert부터 해 볼까요
		notice.setNoticeUser(message.getReceiver());
		notice.setSender(user);
		notice.setNoticeCategory("7");
		notice.setNoticeCondition("2");
		
		
		
		integrationService.addNotice(notice);
		
		
		// 이제 쪽지 전송처리를 합시다.
		System.out.println("message : : : "+message);
		integrationService.addSendMessage(message);
		integrationService.addSendMessage2(message);
		System.out.println(message.getSender().getEmail());
		
		return "redirect:/integration/listSendMessage?sender.email="+message.getSender().getEmail();
	}
	
	//받은 쪽지 목록
	@RequestMapping(value="listSendMessage")
	public String listSendMessage(@ModelAttribute("search") Search search, HttpSession session,
									@ModelAttribute("message") Message message, Model model)throws Exception {

		int pageSize = 30;
		int pageUnit = 20;
	
		System.out.println("/integration/listSendMessage : GET");
		
		User email = (User)session.getAttribute("user");
		message.setSender(email);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("message", message);
		
		System.out.println("message는 이거 :::::"+message);
		
		Map<String,Object> result = integrationService.getlistSendMessage(map);
		List<Object> list = (List<Object>)result.get("list");
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)result.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("여기는 resultPage " + resultPage);
				
		model.addAttribute("list", result.get("list"));
		model.addAttribute("search", search);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("message", message);
		
		return "/integrationView/listSendMessage";
	}
	
	//보낸 쪽지 목록
	@RequestMapping(value="listReceiveMessage")
	public String listReceiveMessage(@ModelAttribute("search") Search search, Model model, HttpSession session, Message message  )throws Exception {
		
		int pageSize = 30;
		int pageUnit = 20;
		
		System.out.println("/integration/listReceiveMessage : GET");
		
		User email = (User)session.getAttribute("user");
		message.setReceiver(email);
		message.setSender(email);
		
		
		//쪽지 전송으로 session END....		
		
		System.out.println("/integration/listReceiveMessage : GET");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("message", message);
		
		Map<String,Object> result = integrationService.getlistReceiveMessage(map);
		List<Object> list = (List<Object>)result.get("list");
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)result.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("여기는 resultPage " + resultPage);
				
		model.addAttribute("list", result.get("list"));
		model.addAttribute("search", search);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("message", message);
		
		return "/integrationView/listReceiveMessage";
	}
	
	//쪽지 선택삭제
	@PostMapping("deleteTest")
	public void deleteTest(@RequestParam(value = "messageNo[]") List<String> messageArr, 
						  Message message) throws Exception{
			
		System.out.println("테스트 삭제 실행");
			
			
			User user = new User();
			
			message.setReceiver(user);
			
			int result = 0;
			int messageNo = 0;
			
			if(user != null) {
				message.setReceiver(user);
				
				  for(String i : messageArr) {   
					  messageNo = Integer.parseInt(i);
					   message.setMessageNo(messageNo);
					   integrationService.deleteMessage(message.getMessageNo());
				  }
				  
				  result = 1;
					
			}
		
		
		
	}

	
	//메인페이지의 필요한 모든 것
	@GetMapping("mainPage")
	public String mainPage(Model model, Answer answer, HttpSession session) throws Exception{
		
		System.out.println("mainPage 메소드가 실행되는지 확인합시다."); 
		
		User user = (User)session.getAttribute("user");
		String email = user.getEmail();
		
		User Newuser = userService.getProfile(email);
		session.setAttribute("user", Newuser);
		
		///////공부시간 및 목표시간
		int targetTime = Newuser.getUserTargetTime();
		String todayLearningTime = learningHistoryService.getTodayLearningTime(email);
		String splitTime[] = todayLearningTime.split(":");
		String gage = "";
		//////목표시간 달성률
		if(targetTime != 0) {
			Float rate = ((Float.parseFloat(splitTime[0]) * 60) + Float.parseFloat(splitTime[1])) / ((float)targetTime*60) * 100;
			if(rate > 100) {
				gage = "100";
			}else {
				gage = String.format("%.1f", rate);
			}
		}else {
			gage = "0";
		}
		
		model.addAttribute("targetTime", targetTime);
		model.addAttribute("todayHour", splitTime[0]);
		model.addAttribute("todayMinute", splitTime[1]);
		model.addAttribute("gage", gage);
		
		
		//진행중인 자율스터디
		List<Study> mySelfStudyList = studyService.getMySelfStudy(email);
		//진행중인 그룹스터디
		List<Study> myGroupStudyList = studyService.getMyStudy(email, "1", "1");
		
		model.addAttribute("mySelfStudyList", mySelfStudyList);
		model.addAttribute("myGroupStudyList", myGroupStudyList);
		
		//////랭킹
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<User> banana = integrationService.listBananaRanking(map);
		List<Answer> choose = integrationService.listChooseCountRanking(map);
		List<LearningHistory> learningTime = integrationService.listLearningTimeRanking(map);

		map.put("banana", banana);
		map.put("choose", choose);
		map.put("learningTime", learningTime);
		
		model.addAttribute("user", session.getAttribute("user"));
		model.addAttribute("list3", map.get("learningTime"));
		model.addAttribute("list2", map.get("banana"));
		model.addAttribute("list", map.get("choose"));
		
		return "/index";
	}
	
	//매 주 월요일 자정에 매소드 실행
	@Scheduled(cron = "0 0 12 ? * MON") 
	public void bananaAdd() throws Exception{
		
		System.out.println("바나나 수 랭킹 일정시간 포인트 지급을 확인합시다.");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<User> bananaRank = integrationService.listBananaRanking(map);
		
		User user = new User();
		Banana banana1 = new Banana();
		Banana banana2 = new Banana();
		Banana banana3 = new Banana();
		
		//바나나 랭킹 1위
		banana1.setBananaEmail(bananaRank.get(0));
		banana1.setBananaAmount(100);
		banana1.setBananaHistory("바나나 랭킹 1위로 인한 포인트 지급");
		banana1.setBananaCategory("1");
		bananaService.addBanana(banana1);
		user.setEmail(bananaRank.get(0).getEmail());
		user.setBananaCount(100);
		bananaService.updateAcquireBanana(user);
		//바나나 랭킹 2위
		banana2.setBananaEmail(bananaRank.get(1));
		banana2.setBananaAmount(50);
		banana2.setBananaHistory("바나나 랭킹 2위로 인한 포인트 지급");
		banana2.setBananaCategory("1");
		bananaService.addBanana(banana2);
		user.setEmail(bananaRank.get(1).getEmail());
		user.setBananaCount(50);
		bananaService.updateAcquireBanana(user);
		//바나나 랭킹 3위
		banana3.setBananaEmail(bananaRank.get(0));
		banana3.setBananaAmount(30);
		banana3.setBananaHistory("바나나 랭킹 3위로 인한 포인트 지급");
		banana3.setBananaCategory("1");
		bananaService.addBanana(banana3);
		user.setEmail(bananaRank.get(2).getEmail());
		user.setBananaCount(30);
		bananaService.updateAcquireBanana(user);
	
	}
	
	//채택수 랭킹 1위~3위 일주일에 한 번 바나나 지급
	//매 주 월요일 자정에 매소드 실행
	@Scheduled(cron = "0 0 12 ? * MON")
	public void chooseAdd() throws Exception{
		
		System.out.println("바나나 수 랭킹 일정시간 포인트 지급을 확인합시다.");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<Answer> chooseRank = integrationService.listChooseCountRanking(map);
		
		User user = new User();
		Banana choose1 = new Banana();
		Banana choose2 = new Banana();
		Banana choose3 = new Banana();
		
		//채택랭킹 1위
		user.setEmail(chooseRank.get(0).getEmail());
		choose1.setBananaEmail(user);
		choose1.setBananaAmount(100);
		choose1.setBananaHistory("채택수 랭킹 1위로 인한 포인트 지급");
		choose1.setBananaCategory("1");
		bananaService.addBanana(choose1);
		user.setEmail(chooseRank.get(0).getEmail());
		user.setBananaCount(100);
		bananaService.updateAcquireBanana(user);
		//채택랭킹 2위
		user.setEmail(chooseRank.get(1).getEmail());
		choose2.setBananaEmail(user);
		choose2.setBananaAmount(50);
		choose2.setBananaHistory("채택수 랭킹 2위로 인한 포인트 지급");
		choose2.setBananaCategory("1");
		bananaService.addBanana(choose2);
		user.setEmail(chooseRank.get(1).getEmail());
		user.setBananaCount(50);
		bananaService.updateAcquireBanana(user);
		//채택랭킹 3위
		user.setEmail(chooseRank.get(2).getEmail());
		choose2.setBananaEmail(user);
		choose2.setBananaAmount(30);
		choose2.setBananaHistory("채택수 랭킹 3위로 인한 포인트 지급");
		choose2.setBananaCategory("1");
		bananaService.addBanana(choose3);
		user.setEmail(chooseRank.get(2).getEmail());
		user.setBananaCount(30);
		bananaService.updateAcquireBanana(user);
		
		
		

	}
	
	// 정지 회원 자동 복구
	// 매일 정오 12시에 해당 매소드 실행
	@Scheduled(cron =  "0 0 12 * * ?" )
	public void updateSuspendUser() throws Exception{
		
		Search search = new Search();
		int pageSize = 15;
		int pageUnit = 15;
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("listType", 4);
		map.put("search", search);
		
		Map<String,Object> result = adminService.getlistTotalUser(map);
		List<User> list = (List<User>)result.get("list");
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
		String today = sdf.format(date);
		
		for(int i = 0; i <= list.size(); i++) {
			if(list.get(i).getSuspendEndDate().equals(today)){
				try {
					System.out.println("여기 이제 업데이트 시작");
					adminService.updateUserRestore(list.get(i).getEmail());
				} catch (IndexOutOfBoundsException e){
					
				}
			}else {
				
			}
		}
		
	}
	
	@ResponseBody
	@PostMapping("setTargetTime")
	public String setTargetTime(@RequestBody User user) throws Exception {
		integrationService.setTargetTime(user);
		
		return "success";
	}
	
}












