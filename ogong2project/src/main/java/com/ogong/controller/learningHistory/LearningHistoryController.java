package com.ogong.controller.learningHistory;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ogong.service.domain.LearningHistory;
import com.ogong.service.domain.User;
import com.ogong.service.learningHistory.LearningHistoryService;

@Controller
@RequestMapping("/learningHistory/*")
public class LearningHistoryController {

	@Autowired
	private LearningHistoryService learningHistoryService;
	
	public LearningHistoryController() {
		System.out.println(this.getClass());
	}
	
	@GetMapping("learningHistoryPage")
	public String learningHistoryPage(HttpSession session, Model model) throws Exception {
		
		String email = ((User)session.getAttribute("user")).getEmail();
		model.addAttribute("email", email);
		
		String todayLearningTime = learningHistoryService.getTodayLearningTime(email);
		String averageLearningTime = learningHistoryService.getAverageLearningTime(email);
		String totalLearningTime = learningHistoryService.getTotalLearningTime(email);
		
		model.addAttribute("todayLearningTime", todayLearningTime);
		model.addAttribute("averageLearningTime", averageLearningTime);
		model.addAttribute("totalLearningTime", totalLearningTime);
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
		String month = format.format(System.currentTimeMillis());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		map.put("month", month);
		
		List<LearningHistory> list = learningHistoryService.getLearningHistoryList(map);
		List<LearningHistory> lineChart = learningHistoryService.getlineChartTime(map);
		List<LearningHistory> pieChart = learningHistoryService.getPieChartTime(map);
		
		model.addAttribute("list", list);
		model.addAttribute("lineChart", lineChart);
		model.addAttribute("pieChart", pieChart);
		
		return "learningHistoryView/learningHistory";
	}
	
	@ResponseBody
	@PostMapping("getLearningHistoryList")
	public List<LearningHistory> getLearningHistoryList(@RequestBody LearningHistory learningHistory) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", learningHistory.getEmail());
		map.put("month", learningHistory.getLearningDate());
		
		return learningHistoryService.getLearningHistoryList(map);
	}
	
	@ResponseBody
	@PostMapping("getLineChartTime")
	public List<LearningHistory> getLineChartTime(@RequestBody LearningHistory learningHistory) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", learningHistory.getEmail());
		map.put("month", learningHistory.getLearningDate());
		
		return learningHistoryService.getlineChartTime(map);
	}
	
	@ResponseBody
	@PostMapping("getPieChartTime")
	public List<LearningHistory> getPieChartTime(@RequestBody LearningHistory learningHistory) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", learningHistory.getEmail());
		map.put("month", learningHistory.getLearningDate());
		
		return learningHistoryService.getPieChartTime(map);
	}
	
}
