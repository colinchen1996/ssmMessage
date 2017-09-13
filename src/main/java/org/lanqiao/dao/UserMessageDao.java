package org.lanqiao.dao;

import java.util.List;
import java.util.Map;

import org.lanqiao.entity.UserMessage;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

public interface UserMessageDao {
    int deleteByPrimaryKey(Integer floor);

    int insert(UserMessage record);

    int insertSelective(UserMessage record);

    UserMessage selectByPrimaryKey(Integer floor);

    int updateByPrimaryKeySelective(UserMessage record);

    int updateByPrimaryKey(UserMessage record);
    
    
    List<UserMessage> selectAllUserMessage(); //自定义查询方法，并修改mapper配置文件，相当于接口的实现类
    
    int selectTotalFloor();//查询出表中的记录条数
    
    List<UserMessage> selectUserByPage(int startNum,int pageSize);//自定义分页查询方法
    
    List<UserMessage> selectMessageByCondition(Map map);
    
    int selectConditionCount(Map map);//查询符合条件的记录条数
}