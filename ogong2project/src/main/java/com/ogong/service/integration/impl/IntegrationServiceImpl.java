package com.ogong.service.integration.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ogong.common.Search;
import com.ogong.service.domain.Answer;
import com.ogong.service.domain.LearningHistory;
import com.ogong.service.domain.Message;
import com.ogong.service.domain.Notice;
import com.ogong.service.domain.User;
import com.ogong.service.integration.IntegrationMapper;
import com.ogong.service.integration.IntegrationService;

@Service
public class IntegrationServiceImpl implements IntegrationService {
	
	@Autowired
	IntegrationMapper integrationMapper;

	@Override
	public Map<String, Object> getlistReceiveMessage(HashMap<String, Object> map) throws Exception {
		
		List<Message> list = integrationMapper.getlistReceiveMessage(map);
		int totalCount = integrationMapper.getTotalCount(map);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		result.put("totalCount", new Integer(totalCount));
		
		return result;
	}

	@Override
	public Map<String, Object> getlistSendMessage(HashMap<String, Object> map) throws Exception {
		List<Message> list = integrationMapper.getlistSendMessage(map);
		int totalCount = integrationMapper.getTotalCount2(map);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		result.put("totalCount", new Integer(totalCount));
		
		return result;
	}

	@Override
	public void addSendMessage(Message message) throws Exception {

		integrationMapper.addSendMessage(message);
	}
	
	@Override
	public void addSendMessage2(Message message) throws Exception {

		integrationMapper.addSendMessage2(message);
	}

	@Override
	public void deleteMessage(int messageNo) throws Exception {

		integrationMapper.deleteMessage(messageNo);
	}

	@Override
	public void addNotice(Notice notice) throws Exception {
		// TODO Auto-generated method stub
		integrationMapper.addNotice(notice);
	}
	
	@Override
	public List<User> listBananaRanking(HashMap<String, Object> map) throws Exception {
		
		List<User> list = integrationMapper.listBananaRanking(map);
		

		return list;
	}

	@Override
	public List<Answer> listChooseCountRanking(HashMap<String, Object> map) throws Exception {
		
		List<Answer> list = integrationMapper.listChooseCountRanking(map);
		
		return list;
	}

	@Override
	public List<LearningHistory> listLearningTimeRanking(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		List<LearningHistory> list = integrationMapper.listLearningTimeRanking(map);
		
		return list;
	}

	@Override
	public List<Notice> getlistNotice(String email) throws Exception {

		return integrationMapper.getlistNotice(email);
	}
	
	@Override
	public Notice getNotice(int noticeNo) throws Exception{
		
		return integrationMapper.getNotice(noticeNo);
	}

	@Override
	public void deleteNotice(int noticeNo) throws Exception {

		integrationMapper.deleteNotice(noticeNo);
	}

	@Override
	public void deleteAllNotice(String email) throws Exception {

		integrationMapper.deleteAllNotice(email);
	}
	
	@Override
	public int getNoticeCount(String email) {
		
		return integrationMapper.getNoticeCount(email);
	}
	
	@Override
	public void updateNotice(String email) throws Exception{
		
		integrationMapper.updateNotice(email);
	}
	
	@Override
	public void deleteTest(Message message) throws Exception{
		integrationMapper.deleteTest(message);
	}

	@Override
	public void setTargetTime(User user) throws Exception {
		// TODO Auto-generated method stub
		integrationMapper.setTargetTime(user);
	}

}
