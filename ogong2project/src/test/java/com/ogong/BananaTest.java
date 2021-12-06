package com.ogong;

import org.junit.jupiter.api.DisplayName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.ogong.service.banana.BananaService;
import com.ogong.service.domain.Banana;
import com.ogong.service.domain.User;
import com.ogong.service.user.UserService;

@SpringBootTest
public class BananaTest {

	@Autowired
	private BananaService bananaService;
	
	@Autowired
	private UserService userService;
		
	//@Test
	@DisplayName("바나나 인서트")
	void testaddBanana() throws Exception{
		
		System.out.println("이거 출력 안되면");
		
		User user = new User();
		Banana banana = new Banana();
		
		user.setEmail("user01");
		
		banana.setBananaEmail(user);
		banana.setBananaHistory("정보공유 게시글 등록으로 인한 포인트 적립");
		banana.setBananaAmount(+5);
		banana.setBananaCategory("1");
		System.out.println("1");
		bananaService.addBanana(banana);
		
	}
	
	//@Test
	@DisplayName("바나나 인서트")
	void testaddBanana2() throws Exception{
		
		System.out.println("이거 출력 안되면");
		
		User user = new User();
		Banana banana = new Banana();
		
		user.setEmail("user01");
		banana.setBananaEmail(user);
		banana.setBananaHistory("프리미엄 방 등급 개설로 인한 바나나 소모");
		banana.setBananaAmount(-20);
		banana.setBananaCategory("2");
		
		bananaService.addBanana(banana);
		
	}	
	
	/*@Test
	@DisplayName("바나나 획득처")
	void testlistBanana1() throws Exception{
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		
		User user = new User();
		Banana banana = new Banana();
		user.setEmail("user01");
		banana.setBananaEmail(user);
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("banana", banana);
		
		Map<String,Object> result = bananaService.getlistAcquireBanana(map);
		List<Object> list = (List<Object>)map.get("list");
		
		Integer totalCount = (Integer)map.get("totalCount");
		
		System.out.println("list 값 : "+list);
		System.out.println("list size : "+list.size());
		System.out.println("total Count : "+totalCount);
		
		System.out.println("================================");		
		
	}*/
	
	/*@Test
	@DisplayName("바나나 사용처")
	void testlistBanana2() throws Exception{
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		
		User user = new User();
		Banana banana = new Banana();
		user.setEmail("user01");
		banana.setBananaEmail(user);
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("banana", banana);
		
		Map<String,Object> result = bananaService.getlistUseBanana(map);
		List<Object> list = (List<Object>)map.get("list");
		
		Integer totalCount = (Integer)map.get("totalCount");
		
		System.out.println("list 값 : "+list);
		System.out.println("list size : "+list.size());
		System.out.println("total Count : "+totalCount);
		
		System.out.println("================================");		
		
	}*/
	
}