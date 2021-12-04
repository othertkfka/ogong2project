package com.ogong.service.studyroom;

import java.util.List;
import java.util.Map;

import com.ogong.service.domain.Calendar;
import com.ogong.service.domain.GroupStudyMember;
import com.ogong.service.domain.Study;

public interface StudyroomService {
	
	public Map<String, Object> getParticipationList(int studyNo) throws Exception;
	
	public void applyParticipation(String email) throws Exception;
	
	public void rejectParticipation(String email) throws Exception;
	
	public List<GroupStudyMember> getGSMemberList (int studyNo) throws Exception;
	
	public void updateStudy(Study study) throws Exception;
	
	public void addAttendance(Map<String, Object> map) throws Exception;
	
	public void addCalendar(Calendar calendar) throws Exception;
	
	public Calendar getCalendar(int calendarNo) throws Exception;
	
	public List<Calendar> getCalendarList(int studyNo) throws Exception;
	
	public void updateCalendar(Calendar calendar) throws Exception;
	
	public void deleteCalendar(int calendarNo) throws Exception;
	
	public String checkAttendance(Map<String, Object> map ) throws Exception;
	
	public GroupStudyMember getGSMember(GroupStudyMember gsm) throws Exception;
	
	public void updateMember(int studyNo) throws Exception;
	
	public List<Map<String, Object>> getAttendanceList(Map<String, Object> map) throws Exception;
	
}
