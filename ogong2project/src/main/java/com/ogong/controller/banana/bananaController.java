package com.ogong.controller.banana;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ogong.common.Page;
import com.ogong.common.Search;
import com.ogong.service.banana.BananaService;
import com.ogong.service.domain.Banana;
import com.ogong.service.domain.Message;
import com.ogong.service.domain.User;
import com.ogong.service.user.UserService;

@Controller
@RequestMapping("/banana/*")
public class bananaController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private BananaService bananaService;	
	
	public bananaController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="listBanana")
	public String listBanana(@ModelAttribute("search") Search search, 
							HttpSession session, Model model, Banana banana)throws Exception {
		System.out.println("/bananaController/listBanana : GET");
		
		int pageSize = 4;
		int pageUnit = 5;
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		
		User user = (User)session.getAttribute("user");
		
		bananaService.adminGetUser(user.getEmail());
		
		banana.setBananaEmail(user);
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("banana", banana);
		
	
		
		Map<String,Object> result = bananaService.getlistBanana(map);
		List<Object> list = (List<Object>)result.get("list");
		System.out.println("list1의 값을 확인 ::: "+list);
		

		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)result.get("totalCount")).intValue(), pageUnit, pageSize);
		
		System.out.println("search 확인 ::: "+search);
		
		model.addAttribute("list", result.get("list"));
		model.addAttribute("search", search);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("banana", banana);
		model.addAttribute("user", user);
		
		return "/userView/listBanana";
	}	
	
}














