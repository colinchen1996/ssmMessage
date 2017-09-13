package org.lanqiao.service;

import java.util.List;
import java.util.Map;

import org.lanqiao.entity.UserMessage;
import org.springframework.stereotype.Service;

public interface MsgService {
	int queryLastPage(int pageSize);
	
	List<UserMessage> queryUserByPage(int pageNum,int pageSize);
	
	List<UserMessage> queryMessageByCondition(Map map);
	
	int queryContitionLastPage(Map map,int pageSize);
}
