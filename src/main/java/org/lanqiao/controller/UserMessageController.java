package org.lanqiao.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.lanqiao.dao.UserMessageDao;
import org.lanqiao.entity.UserMessage;
import org.lanqiao.service.MsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserMessageController {
	int pageSize = 3;
	
	@Autowired
	UserMessageDao userMessageDao;

//	@RequestMapping("message")
//	public String message(){
//		return "message";
//	}
	
	@RequestMapping("insert")
	public String insert(String author,String message,String time) {
		SimpleDateFormat smf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			date = smf.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		int maxFloor = userMessageDao.selectTotalFloor(); // 从数据库查询出最大条数
		UserMessage user = new UserMessage();
		user.setAuthor(author);
		user.setMessage(message);
		user.setFloor(maxFloor + 1);
		user.setTime(date);
		userMessageDao.insert(user); // 插入数据库
		return "forward:show";// 转发到显示的servlet，显示最后一页的数据
	}

	@Autowired
	MsgService msgServiceImpl; //注入MsgService
	
	@RequestMapping("show")
	public String show(String currPage,Model model) {
		int pageNum = currPage != null && currPage != "" ? Integer.parseInt(currPage) : 1;
		int lastPage = msgServiceImpl.queryLastPage(pageSize);
		List<UserMessage> list = new ArrayList<UserMessage>();
		list = msgServiceImpl.queryUserByPage(pageNum, pageSize);
		model.addAttribute("msgList", list);// 回传信息
		model.addAttribute("currPage", pageNum);// 回传当前页
		model.addAttribute("lastPage", lastPage);// 回传最大页数
		return "message";
	}

	@ResponseBody
	@RequestMapping("search")
	public Object search(String currPage,String title,String startDate,String endDate) {
		// 条件查询表单
		if (title!=null && !"".equals(title)) {
			title = "%" + title + "%";
		} else {
			title = null;
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date sDate = null;
		Date eDate = null;
		try {
			if (startDate!=null && !"".equals(startDate)) {
				sDate = sdf.parse(startDate);
			}
			if (endDate!=null && !"".equals(endDate)) {
				eDate = sdf.parse(endDate);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		int startNum = pageSize*(Integer.parseInt(currPage)-1);
		// 条件查询
		map.put("title", title);
		map.put("startDate", sDate);
		map.put("endDate", eDate);
		map.put("startNum", startNum);
		map.put("pageSize", pageSize);
		List<UserMessage> msgList = msgServiceImpl.queryMessageByCondition(map);
		int searchLastPage = msgServiceImpl.queryContitionLastPage(map,pageSize);
		Map<String,Object> searchMap = new HashMap<String, Object>();
		searchMap.put("msgList", msgList);
		searchMap.put("searchLastPage", searchLastPage);
		return searchMap;
	}
}
