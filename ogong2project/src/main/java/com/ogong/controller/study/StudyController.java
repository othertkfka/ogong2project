package com.ogong.controller.study;

import java.io.File;
import java.io.IOException;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ogong.common.Search;
import com.ogong.service.banana.BananaService;
import com.ogong.service.domain.Banana;
import com.ogong.service.domain.CamStudyMember;
import com.ogong.service.domain.GroupStudyMember;
import com.ogong.service.domain.LearningHistory;
import com.ogong.service.domain.Notice;
import com.ogong.service.domain.Study;
import com.ogong.service.domain.User;
import com.ogong.service.integration.IntegrationService;
import com.ogong.service.learningHistory.LearningHistoryService;
import com.ogong.service.study.CamStudyService;
import com.ogong.service.study.StudyService;
import com.ogong.service.studyroom.StudyroomService;

@CrossOrigin(origins = "*", maxAge = 3600)
@Controller
@RequestMapping("/study/*")
public class StudyController {
	
	@Autowired
	private StudyService studyService;
	
	@Autowired
	private StudyroomService studyroomService;
	
	@Autowired
	private CamStudyService camStudyService;
	
	@Autowired
	private LearningHistoryService learningHistoryService;
	
	@Autowired
	private BananaService bananaService;
	
	@Autowired
	private IntegrationService integrationService;


	
	@Value("8")
	int pageSize;
	
	public StudyController(){
		System.out.println(this.getClass());
	}
	
	@GetMapping("addStudy")
	public String addStudy(@RequestParam("studyType") String studyType, Model model) throws Exception{
		
		System.out.println("/studyController/addStudy : GET");
		
		model.addAttribute("studyType", studyType);
		
		return "/studyView/addStudy";
	}
	
	@Transactional
	@PostMapping("addStudy")
	public String addStudy(@ModelAttribute("study") Study study, @RequestParam("file") MultipartFile file,
										GroupStudyMember gsm, HttpServletRequest request, Model model,
										com.ogong.service.domain.Calendar calendar, HttpSession session) throws Exception{
			
		System.out.println("/studyController/addStudy : POST");
		User user = (User)session.getAttribute("user");
		study.setStudyMaker(user);
		
		//바나나
		User bananaUser = new User();
		Banana banana = new Banana();
		if(study.getStudyRoomGrade().equals("basic")) {
			banana.setBananaEmail(user);
			banana.setBananaAmount(-20);
			banana.setBananaHistory("Basic 등급 스터디 개설로 인한 바나나 소모 ");
			banana.setBananaCategory("2");
			bananaService.addBanana(banana);
			bananaUser.setEmail(user.getEmail());
			bananaUser.setBananaCount(20);
			bananaService.updateUseBanana(bananaUser);
			user.setBananaCount(user.getBananaCount()-20);
		}else if(study.getStudyRoomGrade().equals("premium")) {
			banana.setBananaEmail(user);
			banana.setBananaAmount(-50);
			banana.setBananaHistory("Premium 등급 스터디 개설로 인한 바나나 소모 ");
			banana.setBananaCategory("2");
			bananaService.addBanana(banana);
			bananaUser.setEmail(user.getEmail());
			bananaUser.setBananaCount(50);
			bananaService.updateUseBanana(bananaUser);
			user.setBananaCount(user.getBananaCount()-50);
		}
		//파일 업로드
		if(file.getOriginalFilename().equals("")) {    //파일 선택안했을때
			study.setStudyThumbnail("ogong2.jpg");
		}else {
			String root_path = request.getSession().getServletContext().getRealPath("/");  
			String attach_path = "resources/upload_files/study/";
			
			String temDir = root_path+attach_path;
			String fileName = file.getOriginalFilename();
			File uploadFile = new File(temDir, fileName);
			try {
				file.transferTo(uploadFile);
			}catch (IOException e) {
				e.printStackTrace();
			}
			System.out.println(uploadFile.getPath());
			study.setStudyThumbnail(fileName);
		}

		if(study.getStudyType().equals("group")) {		
			study.setCurrentMember(1);
			studyService.addStudy(study);
			
			gsm.setStudy(study);
			gsm.setMember(user);
			gsm.setApprovalFlag("1");
			studyService.addParticipation(gsm);
			
			calendar.setStudy(study);
			calendar.setCalendarTitle("스터디 진행 기간");
			calendar.setCalendarStartDate(study.getStudyStartDate());
			calendar.setCalendarEndDate(study.getStudyEndDate());
			
			studyroomService.addCalendar(calendar);
			
			return "redirect:/study/getStudy?studyNo="+study.getStudyNo();
		}
		
		//자율스터디일 경우
		studyService.addStudy(study);
		
		model.addAttribute("study", study);
		
		return "/studyView/entranceSelfStudy";
	}
	
	@GetMapping("getStudy")
	public String getStudy(@RequestParam("studyNo") int studyNo, Model model) throws Exception{
		
		System.out.println("studyController/getStudy : GET");
		
		Study study = new Study();
		study = studyService.getStudy(studyNo);
		
		model.addAttribute("study", study);
		System.out.println(study.getStudyType());
		if(study.getStudyType().equals("self")) {
			return "/studyView/entranceSelfStudy";
		}else {
			return "/studyView/getStudy";
		}	
	}
	
	@Transactional
	@GetMapping("entranceStudy/{studyNo}")
	@ResponseBody
	public String entranceStudy(@PathVariable int studyNo, HttpSession session) throws Exception{
				
		CamStudyMember csm = new CamStudyMember();
		User user = ((User)session.getAttribute("user"));
				
		if(camStudyService.getCamStudyMember(studyNo, user.getEmail()) == null) {
			csm.setEmail(user.getEmail());
			csm.setNickname(user.getNickname());
			csm.setStudyNo(studyNo);
			
			studyService.entranceStudy(studyNo);
			camStudyService.addCamStudyMember(csm);
			
			return "success";
		}
		
		return "fail";
	}
	
	@RequestMapping("listStudy")
	public String listStudy(@ModelAttribute("search") Search search, Model model) throws Exception{
		
		System.out.println("/studyController/listStudy");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setStudyEndFlag(1);		
		Map<String, Object> map = studyService.getStudyList(search);
		System.out.println("map : "+map);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("totalCount", map.get("totalCount"));
		model.addAttribute("studyType", search.getStudyType());
		model.addAttribute("search", search);
		
		return "/studyView/listStudy";
	}
	
	@Transactional
	@PostMapping("leaveStudy")
	@ResponseBody
	public void leaveStudy(@RequestBody LearningHistory learningHistory) throws Exception{
		String learningTime = (camStudyService.getCamStudyMember(learningHistory.getStudyNo(), learningHistory.getEmail())).getLearningTime();
		if(!learningTime.equals("00:00:00")) {
			int userTargetTime = (camStudyService.getUser(learningHistory.getEmail())).getUserTargetTime();
			String todayLearningTime = (learningHistoryService.getTodayLearningTime(learningHistory.getEmail())).substring(1, 2);
			if(Integer.parseInt(todayLearningTime) < userTargetTime) {
				learningHistoryService.addLearningHistory(learningHistory);
				String todayLearningTimePlus = (learningHistoryService.getTodayLearningTime(learningHistory.getEmail())).substring(1, 2);
				
				if(Integer.parseInt(todayLearningTimePlus) >= userTargetTime) {
					//바나나 10개 update, 바나나기록 insert
					Banana banana = new Banana();
					User user = camStudyService.getUser(learningHistory.getEmail());
					Notice notice = new Notice();
					//바나나 기록 저장
					banana.setBananaEmail(camStudyService.getUser(learningHistory.getEmail()));
					banana.setBananaAmount(10);
					banana.setBananaHistory("목표시간 완료로 인한 바나나 적립");
					banana.setBananaCategory("1");
					bananaService.addBanana(banana);
					//회원 바나나 업데이트
					user.setBananaCount(10);
					bananaService.updateAcquireBanana(user);
					//목표시간 완료 알림처리
					notice.setNoticeUser(user);
					notice.setNoticeCategory("6");
					notice.setNoticeCondition("2");
					integrationService.addNotice(notice);
				}
			} else {
				learningHistoryService.addLearningHistory(learningHistory);
			}
		}
		
		camStudyService.deleteCamStudyMember(learningHistory);
		studyService.leaveStudy(learningHistory.getStudyNo());
	}
	
	@PostMapping("addParticipation")
	public String addParticipation ( @ModelAttribute("study") Study study,
										@ModelAttribute("GSMember") GroupStudyMember gsm,
										User user,
										HttpSession session) throws Exception {
		
		user = (User)session.getAttribute("user");
		gsm.setMember(user);
		gsm.setStudy(study);
		
		studyService.addParticipation(gsm);
		
		return "redirect:/study/getStudy?studyNo="+study.getStudyNo();
	}
	
	@GetMapping("getMyStudy")
	public String getMyStudy(HttpSession session, Model model) throws Exception {
		
		User user = (User)session.getAttribute("user");
		String email = user.getEmail();

		//진행중인 자율스터디
		List<Study> mySelfStudyList = studyService.getMySelfStudy(email);
		//진행중인 그룹스터디
		List<Study> myGroupStudyList = studyService.getMyStudy(email, "1", "1");
		//참가신청중인 그룹스터디
		List<Study> myApprovalGroupStudyList = studyService.getMyStudy(email, "1", "0");
		//종료된 그룹스터디
		List<Study> myEndGroupStudyList = studyService.getMyStudy(email, "2", "1");
		
		model.addAttribute("mySelfStudyList",mySelfStudyList);
		model.addAttribute("myGroupStudyList",myGroupStudyList);
		model.addAttribute("myApprovalGroupStudyList",myApprovalGroupStudyList);
		model.addAttribute("myEndGroupStudyList",myEndGroupStudyList);
		
		return "/studyView/listMyStudy";
	}
	
}