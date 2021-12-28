<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name ="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JY 전적 검색 웹사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");		
		}

	%>
	<nav class ="navbar navbar-default">
		<div class ="navbar-header">
			<button type="button" class ="navbar-toggle collapsed"
				data-toggle ="collapse" data-target ="#bs-example-collapse-1"
				aria-expanded="false">
				<span class= "icon-bar"></span>
				<span class= "icon-bar"></span>
				<span class= "icon-bar"></span>
			</button>
			<a class ="navbar-brand" href="main.jsp">메인</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"> <a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null){
			%>	
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class ="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
				
			<%	
				}
				else{
			%>	
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class ="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%	
				}
			
			%>

		</div>
	</nav>
	
	<div class ="container">
		<div class="jumbotron">
			<div class="container">
				<h1>전적 검색 및 게시판 활용 연습</h1>
				<p>롤 전적 검색 가능 API활용</p>
				<p><a class="btn btn-primary btn-pull" href="http://google.co.kr">자세히 알아보기</a></p>
			</div>
			<div>
				<input id="searchbox-box" class="recent-pop" type="text" name="lolName" placeholder="소환사명을 입력하세요" autocomplete="off" required="true" />
				<a class="btn btn-primary btn-pull" onclick='updateList()'>검색</a>
			<!-- 	<a class="btn btn-primary btn-pull" href="searchAction.jsp">검색</a> -->
			<div><table id ="summonerInfo" border = "1"></table></div>
			<div><table id ="summonerStat" border = "1"></table></div>
			</div>
				<div id="recent-users" class="recent-pop"></div>
				<div id="recent-container"></div>
			</div>
		</div>
    <div class="container">
        <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="0"></li>
                <li data-target="#myCarousel" data-slide-to="0"></li>
            </ol>
            <div class="carousel-inner">
                <div class="item active">
                    <img src="images/111.jpg">
                </div>
                <div class="item">
                    <img src="images/222.jpg">
                </div>
                <div class="item">
                    <img src="images/333.jpg">
                </div>
            </div>
            <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left"></span>
            </a>
            <a class="right carousel-control" href="#myCarousel" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
            </a>
        </div>
    </div>

     <script>
    function updateList(){
    	var summonerN = document.getElementById('searchbox-box').value;
    	$.ajax({
    		type:"GET",
    		url: 'https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/'+summonerN+'?api_key=RGAPI-81731e05-e456-4c8d-9abc-8eef2e100639',
    		dataType: 'json',
    		async: true,
    		data:{},
    		success: function(res){
    			console.log(res);
    			var tblresult = res;
    			var str = "";
    				str += "<TR>";
    				str += '<TD>' + tblresult.id + '</TD><TD>' + tblresult.accountId + '</TD><TD>' + tblresult.puuid + '</TD><TD>' +tblresult.name + '</TD><TD>' + tblresult.profileIconId + '</TD><TD>' + tblresult.revisionDate + '</TD><TD>' + tblresult.summonerLevel + '</TD>';
    				str += '</TR>';
    			$("#summonerInfo").append(str);
    			updateStat(tblresult.id);
       		},
    		error: function(req, stat, err){
    			console.log(err);
    		}
       	})
    }
    
    function updateStat(summoner){
           	$.ajax({
    		type:"GET",
    		url: 'https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/'+summoner+'?api_key=RGAPI-81731e05-e456-4c8d-9abc-8eef2e100639',
    		dataType: 'json',
    		async: true,
    		data:{},
    		success: function(stat){
    			console.log(stat);
    			var statresult = stat;
    			var str = "";
    			$.each(statresult, function(i){
    				str += "<TR>";
    				str += '<TD>' + statresult[i].summonerName+ '</TD><TD>'statresult[i].tier + '</TD><TD>' + statresult[i].rank + '</TD><TD>' + statresult[i].leaguePoints + '</TD><TD>' +statresult[i].wins + '</TD><TD>' + statresult[i].losses + '</TD>';
    				str += '</TR>';
    		});
    			$("#summonerStat").append(str);
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