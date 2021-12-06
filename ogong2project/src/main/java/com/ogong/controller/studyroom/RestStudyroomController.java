package com.ogong.controller.studyroom;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ogong.service.banana.BananaService;
import com.ogong.service.domain.Banana;
import com.ogong.service.domain.Calendar;
import com.ogong.service.domain.GroupStudyMember;
import com.ogong.service.domain.Study;
import com.ogong.service.domain.User;
import com.ogong.service.study.StudyService;
import com.ogong.service.studyroom.StudyroomService;
import com.ogong.service.user.UserService;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/studyroom/*")
public class RestStudyroomController {
	
	@Autowired
	private StudyroomService studyroomService;
	
	@Autowired
	private StudyService studyService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private BananaService bananaService;
	
	
	public RestStudyroomController(){
		System.out.println(this.getClass());
	}
	

	//신청
	@GetMapping("json/applyParticipation/{email}/{studyNo}")
	public String updateApproval( @PathVariable String email,
									@PathVariable int studyNo) throws Exception{

		
		studyroomService.applyParticipation(email);
		studyroomService.updateMember(studyNo);
		
		return "성공";
	}
	
	//거절
	@GetMapping("json/rejectParticipation/{email}")
	public String rejectApproval ( @PathVariable String email) throws Exception{
		
		studyroomService.rejectParticipation(email);
		
		return "성공";
	}
	
	//출석체크
	//경고를 무시하는 어노테이션
	@SuppressWarnings("unused")
	@GetMapping("json/addAttendance/{studyNo}")
	public List<Map<String, Object>> addAttendance (  @PathVariable int studyNo,
									HttpSession session) throws Exception {
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", ((User)session.getAttribute("user")).getEmail());
		map.put("studyNo", studyNo);
		
		String result = studyroomService.checkAttendance(map);
		System.out.println(result);
		if(result == null) {
			studyroomService.addAttendance(map);
			
			//바나나를 줘 봅시다~
			User user = (User)session.getAttribute("user");
			User bananaUser = new User();
			Banana banana = new Banana();
			banana.setBananaEmail(user);
			banana.setBananaAmount(5);
			banana.setBananaHistory("출석체크로 인한 바나나 적립");
			banana.setBananaCategory("1");
			bananaService.addBanana(banana);
			
			list = studyroomService.getAttendanceList(map);
			
		} else if (result == null ) {
			return null;
		}
		return list;
	}
	
	
	@PostMapping("json/checkDuplication")
	public boolean checkDuplication ( @RequestBody Study study,
										GroupStudyMember gsm,
										HttpSession session) throws Exception{
		
		gsm.setStudy(study);
		gsm.setMember((User)session.getAttribute("user"));
			
		boolean result = studyroomService.getGSMember(gsm) != null ? true : false;
		//System.out.println("여기까지 잘 왔니??");
		return result;
	}
	
	
	@GetMapping("json/getCalendarList/{studyNo}")
	public List<Calendar> getCalendarList ( @PathVariable int studyNo) throws Exception{

	
		return studyroomService.getCalendarList(studyNo);
	}
	
	@PostMapping("json/updateCalendar")
	public Boolean updateCalendar (@RequestBody Calendar cal)throws Exception{
		Boolean result = false;
		cal.setCalendarStartDate(cal.getCalendarStartDate().replaceAll("T", " "));
		cal.setCalendarStartDate(cal.getCalendarStartDate().replaceAll("Z", "").substring(0, 16));
		cal.setCalendarEndDate(cal.getCalendarEndDate().replaceAll("T", " "));
		cal.setCalendarEndDate(cal.getCalendarEndDate().replaceAll("Z", "").substring(0, 16));
		
		if(cal !=null) {
			studyroomService.updateCalendar(cal);
			result = true;
		}
		return result;
	}
	
	@GetMapping("json/deleteCalendar/{calendarNo}")
	public Boolean deleteCalendar (@PathVariable("calendarNo") int calendarNo)throws Exception{
		Boolean result = false;
		
		if(calendarNo != 0) {
			studyroomService.deleteCalendar(calendarNo);
			result = true;
		}
		
		
		return result;
	}
	
	@PostMapping("json/addCalendar")
	public Boolean addCalendar(@RequestBody List<Map<String,String>> list,
								Calendar calendar, Study study) throws Exception{
		Boolean result = false;
		
		System.out.println(list);
		ObjectMapper objectMapper = new ObjectMapper();
		
		String jasonCalendar = objectMapper.writeValueAsString(list.get(0));
		String jsonStudy = objectMapper.writeValueAsString(list.get(1));
		
		calendar = objectMapper.readValue(jasonCalendar, Calendar.class);
		
		calendar.setStudy(objectMapper.readValue(jsonStudy, Study.class));
		System.out.println("calendar : : :"+calendar);
		
		  if(calendar != null) { 
			  studyroomService.addCalendar(calendar); result = true;
		  }
		 
		
		return result;
	}
	
	@GetMapping("json/getUser/{email}")
	public User getUser(@PathVariable String email, HttpServletResponse response) throws Exception {
		
		User user = userService.getProfile(email);
		
		return user;
	}
	
	@PostMapping("json/updateNotice")
	public String updateNotice(@RequestBody Study study) throws Exception{
		
		studyService.updateNotice(study);
		
		return study.getGroupStudyNotice();
	}
	
}
