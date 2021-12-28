<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="user.UserDAO" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 문장사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 파일을 UTF-8로 -->
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />

<%@ const riotkey = 'api_key=RGAPI-3ddf4f37-9539-4763-b0df-61f271c1ef51' %>;

 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JY 전적 검색 웹사이트</title>
</head>
<body>
    <script>
    function updateList (lolName){
    	$.ajax({
    		type:"GET",
    		url: 'https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/pz%20zzang',
    		dataType: 'json',
    		data: {id = lolName()},
    		success: function(res){
    			console.log(res);
    		},
    		error: function(req, stat, err){
    			console.log(err);
    		}
       	})
    }
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html> 
