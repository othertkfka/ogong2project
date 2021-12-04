package com.ogong.controller.integration;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ogong.common.Search;
import com.ogong.service.banana.BananaService;
import com.ogong.service.domain.Notice;
import com.ogong.service.domain.User;
import com.ogong.service.integration.IntegrationService;

@RestController
@RequestMapping("/integration/*")
public class IntegrationRestController {
	
	@Autowired
	private IntegrationService integrationService;
	
	@Autowired
	private BananaService bananaService;	
	
	public IntegrationRestController() {
		System.out.println(this.getClass());
	}
	
	//알림이 온 수를 보기위한 메소드
	@GetMapping(value="json/getNoticeCount/{email}")
	public int getNoticeCount(@PathVariable("email") String email) throws Exception {
		
		System.out.println("/getNoticeCount : GET");
		
		return integrationService.getNoticeCount(email);
	}
	
	
	//알림 목록을 볼 수 있는 메소드
	@GetMapping(value="json/getlistNotice/{email}")
	public List<Notice> getlistNotice(@PathVariable("email") String email) throws Exception{
		
		System.out.println("/getListNotice : GET");
		Search search = new Search();
		search.setStartRowNum(1);
		search.setEndRowNum(5);
		
		return integrationService.getlistNotice(email);
	}
	
	
	//
	@GetMapping(value="json/updateNotice/{email}")
	public void updateNotice(@PathVariable("email") String email) throws Exception {
		
		System.out.println("updateNotice : GET");
		integrationService.updateNotice(email);
	}
	
	
	@GetMapping(value="json/deleteNotice/{noticeNo}")
	public void deleteNotice(@PathVariable("noticeNo")int noticeNo) throws Exception {
		
		System.out.println("deleteNotice : GET");

		integrationService.deleteNotice(noticeNo);
	}
	
	@GetMapping(value="json/deleteNoticeAll/{email}")
	public void deleteAllNotice(@PathVariable("email")String email) throws Exception {
		
		System.out.println("deleteAllNotice : GET");
		
		integrationService.deleteAllNotice(email);
	}
	
	@GetMapping(value="json/deleteMessage/{messageNo}")
	public void deleteMessage(@PathVariable("messageNo") int messageNo) throws Exception{
		
		integrationService.deleteMessage(messageNo);
	}
	
	@GetMapping(value="json/getMyProfile/{email}")
	public User	getMyProfile(@PathVariable("email") String email) throws Exception{
		
		
		
		return bananaService.adminGetUser(email);
	}
	
	
	
	
	/* @PostMapping(value="json/deleteMessage/{email}") */
}









