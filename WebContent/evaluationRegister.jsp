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
			  <form action="./evaluationRegisterAction.jsp" method="get">
				<table class="table">
					<tr>
						<td style="text-align:center;">
							지점선택&nbsp;
						</td>
						<td>
						   <select name="selectStore" class="form-control col-lg-9">
		                   
		                 <%
		                   request.setCharacterEncoding("utf-8");
		                   PrintWriter script = response.getWriter();
		                   EvaluationDTO evaluationDto = new EvaluationDTO();
		                   EvaluationDAO evaluationDao = new EvaluationDAO();
		                   ArrayList<String> ar = new ArrayList<String>();
		                   String area = request.getParameter("area");
		                   ar = evaluationDao.setStoreList(area);
		                   int storeCount = evaluationDao.setStoreList(area).size();
		                   for(int i=0;i<storeCount;i++){
		                 %>
		                    <option value=<%=ar.get(i) %>><%=ar.get(i) %></option>
		                 <% 
		                   } 
		                 %>
		                   </select>
						</td>
					</tr>
					<tr>
						<td style="text-align:center;">제목</td>
						<td><input type="text" name="storeTitle" class="form-control col-lg-9"></td>
					</tr>
					<tr>
						<td style="text-align:center;">내용</td>
						<td>
						  <textarea  name="storeEvaluation" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
						</td>
					</tr>
				</table>
			  
				<div class="row text-center col-lg-12">
                <div class="form-group col-sm-2">
                  <label>방문목적</label>
                  <select name="purpose" class="form-control">
                    <option value="공부" >공부</option>
                    <option value="독서">독서</option>
                    <option value="포장">포장</option>
                    <option value="얘기">얘기</option>
                    <option value="기타" selected>기타</option>
                  </select>
                </div>
				 <div class="form-group col-sm-2">
                  <label>커피맛</label>
                  <select name="taste" class="form-control">
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
                  </select>
                </div>
                <div class="form-group col-sm-2">
                  <label>분위기</label>
                  <select name="mood" class="form-control">
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
                  </select>
                </div>
                <div class="form-group col-sm-2">
                  <label>친절도</label>
                  <select name="kind" class="form-control">
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
                  </select>
                </div>
                <div class="form-group col-sm-2">
                  <label>시설</label>
                  <select name="facility" class="form-control">
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
                  </select>
                </div>
                 <div class="form-group col-sm-2">
                  <label>종합</label>
                  <select name="totalScore" class="form-control">
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
                  </select>
                </div>
                
               </div>
              
               <div class="text-center">
                <button type="submit" class="btn btn-primary">등록하기</button>
                <a class="btn btn-danger" href="./index.jsp">되돌아가기</a>
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