package com.ogong.controller.study;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ogong.service.domain.CamStudyMember;
import com.ogong.service.domain.LearningHistory;
import com.ogong.service.domain.Study;
import com.ogong.service.domain.User;
import com.ogong.service.learningHistory.LearningHistoryService;
import com.ogong.service.study.CamStudyService;


@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/cam/*")
public class CamStudyRestController {
	
	@Autowired
	private CamStudyService camStudyService;
	
	@Autowired
	private LearningHistoryService learningHistoryService;
	
	
	@GetMapping("/getUser/{email}")
	public User getUser(@PathVariable String email, HttpServletResponse response) throws Exception {
		
		User user = camStudyService.getUser(email);
		
		return user;
	}
	
	@GetMapping("/getStudy/{studyNo}")
	public Study getStudy(@PathVariable int studyNo, HttpServletResponse response) throws Exception {
		
		Study study = camStudyService.getStudy(studyNo);
		
		return study;
	}
	
	@GetMapping("/getCamStudyMemberList/{studyNo}")
	public List<CamStudyMember> getCamStudyMemberList(@PathVariable int studyNo) throws Exception{
		
		return camStudyService.getCamStudyMemberList(studyNo);
	}
	
	@PostMapping("/addCamStudyMember")
	public void addCamStudyMember(@ModelAttribute("camStudyMember") CamStudyMember csm) throws Exception{
		
		camStudyService.addCamStudyMember(csm);
	}
	
	@PostMapping("/updateCamStudyMember")
	public void updateCamStudyMember(@RequestBody CamStudyMember csm) throws Exception{
		
		camStudyService.updateCamStudyMember(csm);
	}
	
	@PostMapping("/updateCamStudyMemberZero")
	public void updateCamStudyMemberZero(@RequestBody CamStudyMember csm) throws Exception{
		
		camStudyService.updateCamStudyMemberZero(csm);
	}
	
	@PostMapping("/addLearningHistory")
	public void addLearningHistory(@RequestBody LearningHistory learningHistory) throws Exception{

		learningHistoryService.addLearningHistory(learningHistory);
	}
	
	
}