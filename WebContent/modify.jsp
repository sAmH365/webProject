<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="evaluation.EvaluationDAO" %>
	<%@page import="evaluation.EvaluationDTO" %>
	<%@page import="java.io.PrintWriter" %>
	<%@page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>StarEvalue</title>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.css" rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
	rel='stylesheet' type='text/css'>

<!-- Custom styles for this template -->
<link href="css/clean-blog.css" rel="stylesheet">
</head>
<body>
<%
String userID = null;
String writer = null;
String postNum = null;
String purpose = null;
Double taste = 0.0;
Double mood = 0.0;
Double kind = 0.0;
Double facility = 0.0;
Double totalScore = 0.0;

if(session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
}
if(request.getParameter("writer") != null){
	writer = request.getParameter("writer");
}
if(userID == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 해주세요.');");
	script.println("location.href = 'login.jsp'");
	script.println("</script>");
	script.close();	
}
if(!userID.equals(writer) && !userID.equals("admin")){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('작성자만 수정할 수 있습니다.');");
	script.println("location.href = 'index.jsp'");
	script.println("</script>");
	script.close();	
}
if(request.getParameter("postNum") != null){
	postNum = request.getParameter("postNum");
}

if(request.getParameter("purpose") != null){
	purpose = request.getParameter("purpose");
}
taste = Double.parseDouble(request.getParameter("taste"));
mood = Double.parseDouble(request.getParameter("mood"));
kind = Double.parseDouble(request.getParameter("kind"));
facility = Double.parseDouble(request.getParameter("facility"));
totalScore = Double.parseDouble(request.getParameter("totalScore"));
%>
	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-red fixed-top" id="mainNav">
		<div class="container">
			<a class="navbar-brand" href="./index.jsp">StarEvalue</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link" href="./index.jsp"
						style="font-size: 12pt;">홈으로</a></li>
					<li class="nav-item"><a class="nav-link" href="./logout.jsp"
						style="font-size: 12pt;">로그아웃</a></li>
					<li class="nav-item">
						<form action="#" method="get" class="form-inline ">
							<input type="text" name="search" class="form-control mr-sm-2"
								placeholder="내용을 입력하세요.">
							<button class="btn btn-outline-default" type="submit"
								style="border: 3;">검색</button>
						</form>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Page Header -->
	<header class="masthead"
		style="background-image: url('img/home-bg.jpg')">
		<div class="overlay"></div>
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-md-10 mx-auto">
					<div class="site-heading">
						<h1>StarEvalue</h1>
						<span class="subheading">Evaluate your Starbucks</span>
					</div>
				</div>
			</div>
		</div>
	</header>

	<!-- Main Content -->
	<div class="container">
		<div class="row">
			<div class="col-lg-8 col-md-10 mx-auto">
			  <form action="./modifyAction.jsp" method="get">
				<table class="table">
					<tr>

		                   
		                 <%
		                   request.setCharacterEncoding("utf-8");
		                   PrintWriter script = response.getWriter();
		                   EvaluationDAO evaluationDao = new EvaluationDAO();
		                   ArrayList<EvaluationDTO> ar = new ArrayList<EvaluationDTO>();
		                   ar = evaluationDao.getModifyList(Integer.parseInt(postNum));		                  
		                 %>		                   

					</tr>
					<tr>
						<td style="text-align:center;">제목</td>
						<td><input type="text" name="storeTitle" class="form-control col-lg-9" value="<%=ar.get(0).getTitle() %>" ></td>
					</tr>
					<tr>
						<td style="text-align:center;">내용</td>
						<td>
						  <textarea  name="storeEvaluation" class="form-control" maxlength="2048" style="height: 180px;" ><%=ar.get(0).getContent() %></textarea>
						</td>
					</tr>
				</table>
			  
				<div class="row text-center col-lg-12">
                <div class="form-group col-sm-2">
                  <label>방문목적</label>
                  <select name="purpose" class="form-control">
                  <%
                  	if(purpose.equals("공부")){
                  %>
                  	<option value="공부" selected>공부</option>
                    <option value="독서">독서</option>
                    <option value="포장">포장</option>
                    <option value="얘기">얘기</option>
                    <option value="기타" >기타</option>
                  <%
                  	}else if(purpose.equals("독서")){
                  %>
                  	<option value="공부" >공부</option>
                    <option value="독서" selected>독서</option>
                    <option value="포장">포장</option>
                    <option value="얘기">얘기</option>
                    <option value="기타" >기타</option>
                  <% 
                  	}else if(purpose.equals("포장")){
                  %>
                      	<option value="공부" >공부</option>
                        <option value="독서" >독서</option>
                        <option value="포장" selected>포장</option>
                        <option value="얘기">얘기</option>
                        <option value="기타" >기타</option>
                  <% 
                     }else if(purpose.equals("얘기")){
                  %>
                          	<option value="공부" >공부</option>
                            <option value="독서" >독서</option>
                            <option value="포장">포장</option>
                            <option value="얘기" selected>얘기</option>
                            <option value="기타" >기타</option>
                  <%
                     } else if(purpose.equals("기타")){
                  %> 	                    
                    <option value="공부" >공부</option>
                    <option value="독서">독서</option>
                    <option value="포장">포장</option>
                    <option value="얘기">얘기</option>
                    <option value="기타" selected>기타</option>
                  <%
                     }
                  %>
                  </select>
                </div>
				 <div class="form-group col-sm-2">
                  <label>커피맛</label>
                  <select name="taste" class="form-control">
                  <%
                  	if(taste==5.0){
                  %>
                    <option value="5" selected>5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5">3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(taste==4.5){
                   %>
                   <option value="5" >5</option>
                    <option value="4.5"selected>4.5</option>
                    <option value="4">4</option>
                    <option value="3.5">3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(taste==4.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4"selected>4</option>
                    <option value="3.5">3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(taste==3.5){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" selected>3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(taste==3.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3"selected>3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(taste==2.5){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5"selected>2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(taste == 2.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" selected>2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(taste == 1.5){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" >2</option>
                    <option value="1.5"selected>1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(taste == 1.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" >2</option>
                    <option value="1.5">1.5</option>
                    <option value="1"selected>1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(taste == 0.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" >2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0"selected>0</option>
                   <%
                  	}
                   %>
                  </select>
                </div>
                <div class="form-group col-sm-2">
                  <label>분위기</label>
                  <select name="mood" class="form-control">
                     <%
                  	if(mood==5.0){
                 	 %>
                    <option value="5" selected>5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5">3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(mood==4.5){
                   %>
                   <option value="5" >5</option>
                    <option value="4.5"selected>4.5</option>
                    <option value="4">4</option>
                    <option value="3.5">3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(mood==4.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4"selected>4</option>
                    <option value="3.5">3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(mood==3.5){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" selected>3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(mood==3.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3"selected>3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(mood==2.5){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5"selected>2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(mood == 2.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" selected>2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(mood == 1.5){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" >2</option>
                    <option value="1.5"selected>1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(mood == 1.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" >2</option>
                    <option value="1.5">1.5</option>
                    <option value="1"selected>1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(mood == 0.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" >2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0"selected>0</option>
                   <%
                  	}
                   %>
                  </select>
                </div>
                <div class="form-group col-sm-2">
                  <label>친절도</label>
                  <select name="kind" class="form-control">
                    <%
                  	if(kind==5.0){
                 	 %>
                    <option value="5" selected>5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5">3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(kind==4.5){
                   %>
                   <option value="5" >5</option>
                    <option value="4.5"selected>4.5</option>
                    <option value="4">4</option>
                    <option value="3.5">3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(kind==4.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4"selected>4</option>
                    <option value="3.5">3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(kind==3.5){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" selected>3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(kind==3.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3"selected>3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(kind==2.5){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5"selected>2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(kind == 2.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" selected>2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(kind == 1.5){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" >2</option>
                    <option value="1.5"selected>1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(kind == 1.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" >2</option>
                    <option value="1.5">1.5</option>
                    <option value="1"selected>1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(kind == 0.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" >2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0"selected>0</option>
                   <%
                  	}
                   %>
                  </select>
                </div>
                <div class="form-group col-sm-2">
                  <label>시설</label>
                  <select name="facility" class="form-control">
                     <%
                  	if(facility==5.0){
                 	 %>
                    <option value="5" selected>5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5">3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(facility==4.5){
                   %>
                   <option value="5" >5</option>
                    <option value="4.5"selected>4.5</option>
                    <option value="4">4</option>
                    <option value="3.5">3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(facility==4.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4"selected>4</option>
                    <option value="3.5">3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(facility==3.5){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" selected>3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(facility==3.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3"selected>3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(facility==2.5){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5"selected>2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(facility == 2.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" selected>2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(facility == 1.5){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" >2</option>
                    <option value="1.5"selected>1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(facility == 1.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" >2</option>
                    <option value="1.5">1.5</option>
                    <option value="1"selected>1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(facility == 0.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" >2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0"selected>0</option>
                   <%
                  	}
                   %>
                  </select>
                </div>
                 <div class="form-group col-sm-2">
                  <label>종합</label>
                  <select name="totalScore" class="form-control">
                    <%
                  	if(totalScore==5.0){
                 	 %>
                    <option value="5" selected>5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5">3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(totalScore==4.5){
                   %>
                   <option value="5" >5</option>
                    <option value="4.5"selected>4.5</option>
                    <option value="4">4</option>
                    <option value="3.5">3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(totalScore==4.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4"selected>4</option>
                    <option value="3.5">3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(totalScore==3.5){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" selected>3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(totalScore==3.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3"selected>3</option>
                    <option value="2.5">2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(totalScore==2.5){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5"selected>2.5</option>
                    <option value="2">2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(totalScore == 2.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" selected>2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(totalScore == 1.5){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" >2</option>
                    <option value="1.5"selected>1.5</option>
                    <option value="1">1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(totalScore == 1.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" >2</option>
                    <option value="1.5">1.5</option>
                    <option value="1"selected>1</option>
                    <option value="0">0</option>
                   <%
                  	}else if(totalScore == 0.0){
                   %>
                   	<option value="5" >5</option>
                    <option value="4.5">4.5</option>
                    <option value="4">4</option>
                    <option value="3.5" >3.5</option>
                    <option value="3">3</option>
                    <option value="2.5">2.5</option>
                    <option value="2" >2</option>
                    <option value="1.5">1.5</option>
                    <option value="1">1</option>
                    <option value="0"selected>0</option>
                   <%
                  	}
                   %>
                  </select>
                </div>
                
               </div>
              
               <div class="text-center">
                <button type="submit" class="btn btn-primary">수정하기</button>
                <a class="btn btn-danger" href="./index.jsp">되돌아가기</a>
                <input type="hidden" name = "postNum" value ="<%=ar.get(0).getPostNum()%>">
               </div>
               
			  </form>
			</div>
		</div>
	</div>
	
	<footer></footer>

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="js/clean-blog.min.js"></script>

</body>
</html>