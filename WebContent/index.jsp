<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="users.UsersDAO" %>
	<%@page import="evaluation.EvaluationDTO" %>
	<%@page import="evaluation.EvaluationDAO" %>
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
		request.setCharacterEncoding("utf-8");
		EvaluationDAO evaluationDao = new EvaluationDAO();
		String q = "";
		int pageNum = 1;//현재 보고있는 페이지
		int num = 1; //페이지
		if(request.getParameter("pageNum")==null){
			pageNum = 1;
		}else{
		pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		if(request.getParameter("q") != null) {
			q = request.getParameter("q");
		}
	
		if((pageNum%5>0) && (pageNum/5>0)){
			num = 1+(pageNum/5);
		}
		if((pageNum%5==0)){
			num = (pageNum/5);
		}
		int displayPage = 5;
		int endPage = num * displayPage;
		int beginPage = endPage - 4;
		int totalCount = evaluationDao.getTotalList(q);
		int totalPage = totalCount/displayPage;
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.');");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
			script.close();	
		}
	int emailChecked = new UsersDAO().getUserEmailChecked(userID);
	if(emailChecked == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp'");
		script.println("</script>");
		script.close();		
		return;
	}
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
					<%
						if(userID.equals("admin")){
					%>
						<li class="nav-item"><a class="nav-link" href="./management.jsp"
						style="font-size: 12pt;">회원관리</a></li>
					<%
						}
					%>
					<li class="nav-item"><a class="nav-link" href="./logout.jsp"
						style="font-size: 12pt;">로그아웃</a></li>
					<li class="nav-item">
						<form action="./index.jsp"  method="get" class="form-inline ">
							<input type="text" name="q" class="form-control mr-sm-2" value="<%=q%>"
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
				<div class="text-center">
				<%
					if(userID.equals("visitor")){
				%>
					<a class="btn btn-danger mt-2" data-toggle="modal" href="#reportModal">신고하기</a>
				<%
					}else{
				%>
					<a class="btn btn-primary  mt-2" data-toggle="modal"
						href="#selectArea">등록하기</a> <a class="btn btn-danger  mt-2"
						data-toggle="modal" href="#reportModal">신고하기</a>
				<%
					}
				%>
				</div>
				<div class="card bg-light mt-3">
					<%					
						EvaluationDTO evaluation = new EvaluationDTO();
						ArrayList<EvaluationDTO> ar = new ArrayList<EvaluationDTO>();
						ar = evaluationDao.getList(pageNum,q);
						for(int i=0;i<ar.size();i++){
					%>
					<div class="card-header bg-dark">
						<div class="row">
							<div class="col-8 text-left" style="color: white;">
								<%=ar.get(i).getStoreTitle()%>&nbsp;<small style="font-size: 4pt;"><%=ar.get(i).getAddress()%>
									</small>
							</div>
							<div class="col-4 text-right" style="color: white;">
								종합 <span style="color: red;"><%=ar.get(i).getTotalScore()%></span>
							</div>
						</div>
					</div>
					<div class="card-body" >
						<div class="row">
							<div class="col-9" style="font-size:20pt;font-weight:bold; ">
								<%=ar.get(i).getTitle()%> &nbsp;<span style="font-size:8pt; font-weight:normal;">by&nbsp;<%=ar.get(i).getUserID()%></span>
							</div>
							<div class="col-3" style="font-weight:bold; text-align:right; font-size:8pt">
							<%if((ar.get(i).getPurpose()).equals("기타")) { %>
								for &nbsp;<%=ar.get(i).getPurpose()%>
							<%}else{ %>
								for &nbsp;<%=ar.get(i).getPurpose()%>하러
							<% } %>
							</div>
						</div>						
						<p class="card-text"><%=ar.get(i).getContent()%></p>
						<div class="row">
							<div class="col-7 text-left">
								커피맛 <span style="color: red;"><%=ar.get(i).getTaste()%></span> 분위기 <span
									style="color: red;"><%=ar.get(i).getMood()%></span> 친절도 <span style="color: red;"><%=ar.get(i).getKind()%></span>
									시설 <span style="color: red;"><%=ar.get(i).getFacility()%></span>
							</div>
							<div class="col-5 text-right">
								<span style="color: green; font-size: 10pt">(추천: <%=ar.get(i).getRecoCount()%>)</span> <a
									onclick="return confirm('추천하시겠습니까?')"
									href="./recoAction.jsp?postNum=<%=ar.get(i).getPostNum() %>"
									style="color: green; font-weight: bold;">추천</a> <a
									onclick="return confirm('삭제하시겠습니까?')"
									href="./deleteAction.jsp?postNum=<%=ar.get(i).getPostNum()%>"
									style="color: red; font-weight: bold;">삭제</a>
									<a onclick="return confirm('수정하시겠습니까?')"
									href="./modify.jsp?postNum=<%=ar.get(i).getPostNum()%>&purpose=<%=ar.get(i).getPurpose()%>
									&taste=<%=ar.get(i).getTaste()%>&mood=<%=ar.get(i).getMood()%>&kind=<%=ar.get(i).getKind()%>
									&facility=<%=ar.get(i).getFacility()%>&totalScore=<%=ar.get(i).getTotalScore()%>&writer=<%=ar.get(i).getUserID()%>"
									style="color: black; font-size:8pt">수정</a>
							</div>
						</div>
					</div>
					<%
						}
					%>
				</div>
				
				<!-- Pager -->
				<div class="paginate">
				<% 					
					if(totalCount% displayPage > 0){
						totalPage++;
					}
					if(beginPage==1){//이전페이지 비활성화
				%>	
				<%
					}else{
				%>
					<a href="index.jsp?pageNum=<%=beginPage-5%>&q=<%=q%>" class="prev">이전페이지</a> 
				<%
					}
					for(int i=beginPage;i<=endPage;i++){
						if(totalPage<i) break;
						
				%>			
						<a href="?pageNum=<%=i%>&q=<%=q%>"><%=i %></a>						
				<%
				
				//<strong>5</strong>
					}
					if(totalPage<endPage){//다음페이지 비활성화
				%>				
				<%
					}else{
				%> 
					<a href="index.jsp?pageNum=<%=endPage+1 %>&q=<%=q%>" class="next">다음페이지</a>
				<% 	
					}
				%>
				</div>
				<!-- -----------------------modal------------------------------- -->

				<div class="modal fade" id="selectArea" tabindex="-1" role="dialog"
					aria-labelledby="modal" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="modal">지역을 선택해주세요</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form action="./evaluationRegister.jsp" method="get">
									<label class="radio-inline"> <input type="radio"
										name="area" value="서울"> 서울
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="경기"> 경기
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="광주"> 광주
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="대구"> 대구
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="대전"> 대전
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="부산"> 부산
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="울산"> 울산
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="인천"> 인천
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="강원"> 강원
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="경남"> 경남
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="경북"> 경북
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="전남"> 전남
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="전북"> 전북
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="충남"> 충남
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="충북"> 충북
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="제주"> 제주
									</label>&nbsp;&nbsp;&nbsp; <label class="radio-inline"> <input
										type="radio" name="area" value="세종"> 세종
									</label><br> <br>
									<div class="modal-footer">
										<button type="submit" class="btn btn-primary">선택</button>
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">취소</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
					aria-labelledby="modal" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="modal">신고하기</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form method="post" action="./reportAction.jsp">
									<div class="form-group">
										<label>신고 제목</label> <input type="text" name="reportTitle"
											class="form-control" maxlength="20">
									</div>
									<div class="form-group">
										<label>신고 내용</label>
										<textarea name="reportContent" class="form-control"
											maxlength="2048" style="height: 180px;"></textarea>
									</div>
									<div class="modal-footer">
										<button type="submit" class="btn btn-danger">신고하기</button>
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">취소</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>

				<!-- <ul class="pagination pagenation-sm justify-content-center mt-3">
					<li class="page-item">
						<a class="page-link" href="#" style="font-size:10pt; color:black;">이전</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#" style="font-size:10pt; color:black;">다음</a>
					</li>
				</ul> -->
			</div>
		</div>
	</div>



	<!-- Footer -->
	<footer>
		<p class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">Copyright
			&copy; 권새힘 2021</p>
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="js/clean-blog.min.js"></script>

</body>
</html>