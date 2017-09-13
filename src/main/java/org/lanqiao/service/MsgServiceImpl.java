package org.lanqiao.service;

import java.util.List;
import java.util.Map;

import org.lanqiao.dao.UserMessageDao;
import org.lanqiao.entity.UserMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class MsgServiceImpl implements MsgService {
	@Autowired  //注入
	UserMessageDao userMessageDao;
	
	@Override
	public int queryLastPage(int pageSize) {
		int maxFloor = userMessageDao.selectTotalFloor(); //从数据库查询出最大条数
		int lastPage= maxFloor%pageSize==0?maxFloor/pageSize:maxFloor/pageSize+1; //根据最大条数计算出最后一页的页数
		return lastPage;
	}

	@Override
	public List<UserMessage> queryUserByPage(int pageNum, int pageSize) {
		int startNum = pageSize*(pageNum-1);
		return userMessageDao.selectUserByPage(startNum, pageSize); //查询指定的页面的信息
	}

	@Override
	public List<UserMessage> queryMessageByCondition(Map map) {
		return userMessageDao.selectMessageByCondition(map);
	}

	@Override
	public int queryContitionLastPage(Map map,int pageSize) {
		int maxFloor = userMessageDao.selectConditionCount(map);
		int lastPage= maxFloor%pageSize==0?maxFloor/pageSize:maxFloor/pageSize+1; //根据最大条数计算出最后一页的页数
		return lastPage;
	}

}
