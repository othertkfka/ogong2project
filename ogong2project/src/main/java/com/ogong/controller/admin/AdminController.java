package com.ogong.controller.admin;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ogong.common.Page;
import com.ogong.common.Search;
import com.ogong.service.admin.AdminService;
import com.ogong.service.domain.Report;
import com.ogong.service.domain.User;


@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	//Filed
	@Autowired
	private AdminService adminService;
	
	public AdminController() {
		System.out.println(this.getClass());
	}
	
	@GetMapping("addReport")
	public String addReport() throws Exception{
		
		System.out.println("/admin/addReport : GET");
		
		
		return "/adminView/addReport";
	}
	
	
	@PostMapping("addReport")
	public String addReport( @ModelAttribute("report") Report report,
							 HttpServletRequest request,
							 HttpSession session,
							 Model model) throws Exception{
		
		//session에서 receiverRepoter 꺼낸 유저가 들어가고 sendeReporter는 ModelAttribute로 넘어온 값을 줌
		
		System.out.println("addReport/Post 시작");
		
		User user = (User)session.getAttribute("user");		
		report.setSendReporter(user);
		
		System.out.println("report 확인 :::: "+report);

		String referer = request.getHeader("Referer");

		
		adminService.addReport(report);
		
		
		return "redirect:"+ referer;
		
	}
	
	@RequestMapping(value="listReport")
	public String listReport(@ModelAttribute("search") Search search, Model model,
							 @RequestParam("reportType") String reportType,
													   HttpServletRequest request) throws Exception{
		int pageSize = 15;
		int pageUnit = 15;
		
		System.out.println("/listReport 시작");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		/* search.setPageSize(pageSize); */
	
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("reportType", reportType);
		
		Map<String,Object> result = adminService.getlistReport(map);
		List<Object> list = (List<Object>)result.get("list");
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)result.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("여기는 resultType " + reportType);
		System.out.println("여기는 resultPage " + resultPage);
		
		model.addAttribute("list", result.get("list"));
		System.out.println("유저를 확인합시다."+map);
		model.addAttribute("search", search);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("reportType", reportType);
		
		return "/adminView/listReport";
	}
	
	@RequestMapping(value="listUserReport")
	public String listUserReport(@ModelAttribute("search") Search search, Model model,
			   HttpServletRequest request) throws Exception{
		
		int pageSize = 15;
		int pageUnit = 15;
		
		HttpSession session = request.getSession();
		
		System.out.println("/listUserReport 시작");
		
		System.out.println(search.getSearchCondition()+"확인합시당");
		System.out.println(search.getSearchKeyword()+"확인합시당");	
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		
		Map<String,Object> result = adminService.getlistUserReport(map);
		List<Object> list = (List<Object>)result.get("list");
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)result.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("여기는 resultPage " + resultPage);
		model.addAttribute("list", result.get("list"));
		model.addAttribute("search", search);
		model.addAttribute("resultPage", resultPage);
		
		
		return "/adminView/listUserReport";
	}
	
	
	@RequestMapping(value="listTotalUser")
	public String listTotalUser(@ModelAttribute("search") Search search, Model model,
								@RequestParam("listType") String listType,
								HttpServletRequest request) throws Exception{
		int pageSize = 15;
		int pageUnit = 15;
		
		System.out.println("/listTotalUser 시작");

		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		System.out.println(search.getSearchCondition()+"확인합시당");
		System.out.println(search.getSearchKeyword()+"확인합시당");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("listType", listType);
		
		Map<String,Object> result = adminService.getlistTotalUser(map);
		List<Object> list = (List<Object>)result.get("list");
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)result.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("여기는 listType " + listType);
		System.out.println("여기는 resultPage " + resultPage);
		
		model.addAttribute("list", result.get("list"));
		model.addAttribute("search", search);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("listType", listType);
		
		return "/adminView/listTotalUser";
	}
	
	
	@PostMapping("updateSuspendUser")
	public String updateSuspendUser(@ModelAttribute("report") Report report, Model model,
									@RequestParam("email") String email,
									@RequestParam("suspendType") String suspendType) throws Exception {
		
		System.out.println("/updateSuspendUser/POST");
		
		
		User receiveReport = new User();
		
		receiveReport.setEmail(email);
		
		report.setReceiveReporter(receiveReport);
		

		report.setSuspendType(suspendType);
		
		System.out.println(receiveReport+"여기는...");
		System.out.println(suspendType+"여기는...");
		
		model.addAttribute("receiveReport", receiveReport);
		model.addAttribute("report", report);
		
		adminService.updateUserSuspend(report);
		
		return "redirect:/admin/listUserReport";
		
	}
	
	
	@GetMapping("updateSuspendUser")
	public String updateSuspendUser(@RequestParam("receiveReporter") String email,
									Model model) throws Exception {
		System.out.println("/updateSuspendUser/GET");
		
		System.out.println(email);
		
		model.addAttribute("receiveReporter", email);
		
		return "/adminView/updateSuspendUser";
		
	}
	
	
	/*@PostMapping("updateRestoreUser")
	public String updateRestoreUser(@ModelAttribute("report")Report report,Model model,
									@RequestParam("receiveReporter")String email,
								    @RequestParam("suspendType") String suspendType) throws Exception {
		
		System.out.println("/updateRestoreUser/POST");
		System.out.println(email);
		User user = new User();
		user.setEmail(email);
		
		report.setReceiveReporter(user);
		
		adminService.updateUserRestore(report);
		
		return "redirect:/admin/listUserReport";
	}*/
	
	
	@GetMapping("reportModal")
	public String reportModal() {
		
		return "/adminView/addReport";
	}
	
	
}













