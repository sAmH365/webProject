<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="users.UsersDAO" %>
	<%@page import="users.UsersDTO" %>
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
if(session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
}
if(!userID.equals("admin")){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('관리자 페이지입니다.');");
	script.println("location.href = 'index.jsp'");
	script.println("</script>");
	script.close();
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
			  <%
			  	UsersDAO userDao = new UsersDAO();
			  	ArrayList<UsersDTO> ar = userDao.getUsers();
			  	String check;
			  %>
				<table class="table">
				<tr class="text-center">
					<th>이름</th>
					<th>아이디</th>
					<th>이메일</th>
					<th>이메일확인여부</th>
					<th>삭제</th>
				</tr>
			<%
				for(int i=0;i<ar.size();i++){ if((ar.get(i).getName()).equals("비회원") ||(ar.get(i).getName()).equals("관리자")) continue;
			%>
				<tr >
					<td><%=ar.get(i).getName() %></td>
					<td><%=ar.get(i).getUserID() %></td>
					<td><%=ar.get(i).getUserEmail() %></td>
					<%
						check = ar.get(i).getUserEmailChecked()+"";
						if(check.equals("0")){
							check="X";
						}else{
							check="O";
						}
					%>
					<td class="text-center"><%=check%></td>
					<td><a href="./managementAction.jsp?id=<%=ar.get(i).getUserID()%>" type="button" class="btn btn-danger">삭제</a></td>
				</tr>
			<%
				}
			%>
				</table>
         
               <div class="text-center">
                <a class="btn btn-primary" href="./index.jsp">되돌아가기</a>
               </div>
               
			  </form>
			</div>
		</div>
	</div>





	<!-- Footer -->
	<footer>
		<p class="bg-light mt-4 p-5 text-center" style="color: black;">Copyright
			&copy; 권새힘 2021</p>
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="js/clean-blog.min.js"></script>

</body>
</html>