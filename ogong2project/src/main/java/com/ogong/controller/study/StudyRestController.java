package com.ogong.controller.study;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ogong.common.Search;
import com.ogong.service.study.StudyService;

@RestController
@RequestMapping("/study/*")
public class StudyRestController {

	@Autowired
	private StudyService studyService;
	
	public StudyRestController() {
		System.out.println(this.getClass());
	}
	
	@PostMapping("/listStudy")
	public Map<String, Object> listStudy(@RequestBody Search search) throws Exception{
		
		search.setPageSize(8);
		search.setStudyEndFlag(1);
		
		Map<String, Object> result = studyService.getStudyList(search);
		
		return result;
	}
}