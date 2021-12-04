package com.ogong.controller.banana;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ogong.common.Search;
import com.ogong.service.banana.BananaService;
import com.ogong.service.domain.Banana;
import com.ogong.service.domain.User;

@RestController
@RequestMapping("/banana/*")
public class bananaRestController {
	
	@Autowired
	private BananaService bananaService;

	public bananaRestController() {
		System.out.println(this.getClass());
	}
	
	@GetMapping(value="json/deleteBanana/{bananaNo}")
	public void deleteBanana(@PathVariable("bananaNo")int bananaNo) throws Exception{
		
		System.out.println("deleteBanana : GET");
		
		bananaService.deleteBanana(bananaNo);
		
	}
	
	@PostMapping("/json/getlistBanana/")
	public Map<String, Object> getlistBanana(@RequestBody Search search, 
			HttpSession session, Model model, Banana banana)throws Exception {
		
		User user = (User)session.getAttribute("user");
		
		banana.setBananaEmail(user);
		
		search.setPageSize(4);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("banana", banana);
		
		System.out.println("search 확인 ::: "+search);
		
		Map<String, Object> result = bananaService.getlistBanana(map);
		
		return result;
	}
	
}
