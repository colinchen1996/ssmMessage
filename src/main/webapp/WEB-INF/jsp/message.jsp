<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="org.lanqiao.entity.*"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>留言板</title>
<script src="js/jquery-3.1.0.min.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
div {
	margin: 0;
	padding: 0;
	font-size: 12px;
	margin: 0 auto;
}

h3 {
	text-align: center
}

#container {
	width: 500px;
}

.article {
	border: 1px solid #a6cbe7;
	margin-top: 5px;
}

.author {
	background-color: #0099FF;
	width: 100%;
	height: 24px;
	line-height: 24px;
}

.content {
	height: 40px;
	padding: 10px;
}

.author span {
	float: right;
	padding-right: 10px;
}

.time {
	border-top: solid 1px #a6cbe7;
	text-align: right;
	height: 30px;
	line-height: 30px;
	padding-right: 10px;
}

.page {
	text-align: right;
	height: 30px;
	line-height: 30px;
	padding-right: 10px;
}
</style>

</head>

<body>
	<div id="container">
		<div>
			请输入帖子内容：<input type="text" name="title"><br> 开始时间：<input
				type="date" name="startDate"> 结束时间：<input type="date"
				name="endDate"> <input type="button" value="搜索" name="搜索">
		</div>
		<div>
			<c:forEach items="${msgList}" var="list">
				<div class="article">
					<div class="author">
						${list.author}<span>${list.floor}</span>
					</div>
					<div class="content">${list.message}</div>
					<div class="time">
						发表于:
						<fmt:formatDate value="${list.time}" pattern="yyyy-MM-dd HH:mm:ss" />
					</div>
				</div>
			</c:forEach>
		</div>
		<div class="page">
			<input class="btn1" type="button" value="上一页"> <input
				class="btn1" type="button" value="下一页" onClick="">
		</div>
		<br>
		<div>
			<form action="insert" method="post">
				<input type="hidden" name="time" value="">
				<div>
					用户: <input type="text" name="author" value="" />
				</div>
				<br>
				<div>
					留言:
					<textarea name="message" rows="5" cols="72"></textarea>
				</div>
				<div align="center">
					<input type="reset" value="清除" /> <input type="submit" value="发表" />
				</div>
			</form>
		</div>
	</div>
</body>
<script>
	$(function() {
		var currPage = "${currPage}"; //接收当前页数
		var lastPage = "${lastPage}"; //接收最大页数
		var searchLastPage;  //符合条件搜索的记录页数
		//按钮上一页的点击事件
		$("input[value='上一页']").click(function() {
			currPage = currPage == 1 ? 1 : currPage - 1; //判断
			myClick(currPage);
		});

		//按钮下一页的点击事件
		$("input[value='下一页']")
				.click(
						function() {
							currPage = parseInt(currPage) == parseInt(searchLastPage) ? parseInt(searchLastPage)
									: parseInt(currPage) + 1;//判断
							myClick(currPage);
						});
		$("input[name='搜索']").click(function() {
			currPage=1;
			myClick(currPage);
		});
		
		function myClick(page) {  //ajax封装数据并进行条件搜索
			$("div.page").prev().children().remove();
			$.post("search", {
				"currPage" : page,
				"title" : $("input[name='title']").val(),
				"startDate" : $("input[name='startDate']").val(),
				"endDate" : $("input[name='endDate']").val()
			}, function(msg) {
				searchLastPage=msg.searchLastPage;
					$.each(msg.msgList,function(j,list){
						var myDate = new Date(list.time);
						var year = myDate.getFullYear();//获取当前年
						var month = myDate.getMonth() + 1;//获取当前月
						var date = myDate.getDate();//获取当前日
						var h = myDate.getHours(); //获取当前小时数(0-23)
						var m = myDate.getMinutes(); //获取当前分钟数(0-59)
						var s = myDate.getSeconds();
						var now = year + "-" + month + "-" + date + " " + h + ':'
								+ m + ":" + s;
						$("div.page").prev().append(
								'<div class="article">' + '<div class="author">'
										+ list.author + '<span>' + list.floor
										+ '</span></div>' + '<div class="content">'
										+ list.message + '</div>'
										+ '<div class="time">发表于:' + now
										+ '</div></div>');
				});
			}, "json");
		}

		//点击发送按钮时
		$("input[type='submit'][value='发表']").click(
				function(e) {
					e.preventDefault(); //先阻止submit事件提交表单
					var myDate = new Date();
					var year = myDate.getFullYear();//获取当前年
					var month = myDate.getMonth() + 1;//获取当前月
					var date = myDate.getDate();//获取当前日
					var h = myDate.getHours(); //获取当前小时数(0-23)
					var m = myDate.getMinutes(); //获取当前分钟数(0-59)
					var s = myDate.getSeconds();
					var now = year + "-" + month + "-" + date + " " + h + ':'
							+ m + ":" + s;
					$("input[name='time']").val(now); //把事件写入表单
					$("form").submit(); //提交表单
				});
	})
</script>
</html>
