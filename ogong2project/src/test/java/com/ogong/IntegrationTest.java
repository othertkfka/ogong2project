package com.ogong;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.ogong.common.Search;
import com.ogong.service.domain.Message;
import com.ogong.service.domain.Notice;
import com.ogong.service.domain.User;
import com.ogong.service.integration.IntegrationService;

@SpringBootTest
public class IntegrationTest {

	@Autowired
	private IntegrationService integrationService;

	//@Test
	@DisplayName("쪽지 보내기")
	void addSendMessage() throws Exception{
		
		User receiver = new User();
		User sender = new User();
		Message message = new Message();
		receiver.setEmail("user02");
		message.setReceiver(receiver);
		sender.setEmail("user01");
		message.setSender(sender);
		message.setMessageContents("쪽지 보내기 이거 맞나 모르겠다.");
		
		System.out.println(message);
		
		integrationService.addSendMessage(message);
		integrationService.addSendMessage2(message);
		
	}
	
	@Test
	@DisplayName("받은 쪽지 목록")
	void testlistReceiveMessage() throws Exception{
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
//		search.setSearchCondition("1");
//		search.setSearchKeyword("");		
		
		User receiver = new User();
		Message message = new Message();
		receiver.setEmail("user01");
		message.setReceiver(receiver);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("message", message);
		
		
		Map<String, Object> result = integrationService.getlistReceiveMessage(map);
		List<Object> list = (List<Object>)map.get("list");
		
		
		Integer totalCount = (Integer)map.get("totalCount");
		
		System.out.println("map의 값 : "+map);
		System.out.println("list 값 : "+list);
		System.out.println("list size : "+list.size());
		System.out.println("total Count : "+totalCount);
		
		System.out.println("================================");
	}
	
	//@Test
	@DisplayName("받은 쪽지 목록")
	void testlistSendMessage() throws Exception{
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
//		search.setSearchCondition("1");
//		search.setSearchKeyword("");		
		
		User receiver = new User();
		Message message = new Message();
		receiver.setEmail("user01");
		message.setSender(receiver);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("message", message);
		
		
		Map<String, Object> result = integrationService.getlistSendMessage(map);
		List<Object> list = (List<Object>)map.get("list");
		
		
		Integer totalCount = (Integer)map.get("totalCount");
		
		System.out.println("map의 값 : "+map);
		System.out.println("list 값 : "+list);
		System.out.println("list size : "+list.size());
		System.out.println("total Count : "+totalCount);
		
		System.out.println("================================");
	}	
	
	//@Test
	@DisplayName("쪽지 삭제")
	void testDeleteMessage() throws Exception{
		
		Message message = new Message();
		int messageNo = 10032;
		
		
		
				
		integrationService.deleteMessage(messageNo);
	}
	
	//@Test
	@DisplayName("쪽지 삭제 테스트")
	void testDeleteTest() throws Exception{
		
		Message message = new Message();
		User user = new User();
		
		user.setEmail("user01");
		message.setReceiver(user);
		message.setMessageNo(10033);
		
		integrationService.deleteTest(message);
	}
	
	//@Test
	@DisplayName("바나나 랭킹")
	void testlistBananaRanking() throws Exception{
		

		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//Map<String, Object> result = integrationService.listBananaRanking(map);
		List<Object> list = (List<Object>)map.get("list");
		
		
		
		System.out.println("map의 값 : "+map);
		System.out.println("list 값 : "+list);
		System.out.println("list size : "+list.size());
		
	}
	
	//@Test
	@DisplayName("채택수 랭킹")
	void testlistChooseCountRanking() throws Exception{
		

		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		Map<String, Object> result = (Map<String, Object>) integrationService.listChooseCountRanking(map);
		List<Object> list = (List<Object>)map.get("list");
		
		
		
		System.out.println("map의 값 : "+map);
		System.out.println("list 값 : "+list);
		System.out.println("list size : "+list.size());
		System.out.println("map : "+ map);
	}
	
	//@Test
	@DisplayName("알림")
	void testaddNotice() throws Exception{
			
		User email = new User();
		User senderEmail = new User();
		Notice notice = new Notice();
		senderEmail.setEmail("user05");
		email.setEmail("user01");
		notice.setNoticeUser(email);
		notice.setSender(senderEmail);
		notice.setNoticeCategory("7");
		
		System.out.println("여기는 Notice : "+ notice);
		
		integrationService.addNotice(notice);
		
	}
	
	//@Test
	@DisplayName("알림 목록 조회")
	void testlistNotice() throws Exception{
		
		integrationService.getlistNotice("user01");
		
		
	}
	
	//@Test
	@DisplayName("알림 삭제")
	void testdeleteNotice()	 throws Exception{
		
		integrationService.deleteNotice(10000);
		
	}
	
	//@Test
	@DisplayName("알림 전체 삭제")
	void testdeleteAllNotice() throws Exception{
		
		integrationService.deleteAllNotice("user01");
		
	}
	
	//@Test
	@DisplayName("알림 카운트 확인")
	void testgetNoticeCount() throws Exception{
		
		User user = new User();
		user.setEmail("user01");
		Notice notice = new Notice();
		notice.setNoticeUser(user);
		
		integrationService.getNoticeCount("user01");
	}
}








