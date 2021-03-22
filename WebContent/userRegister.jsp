<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
			<a class="navbar-brand" href="./login.jsp">StarEvalue</a>
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
				<div class="container mt-3" style="max-width: 560px;">
			      <form method="post" action="./userRegisterAction.jsp">
			      <div class="form-group">
			          <label>이름</label>
			          <input type="text" name="userName" class="form-control">
			        </div>
			        <div class="form-group">
			          <label>아이디</label>
			          <input type="text" name="userID" class="form-control">
			        </div>
			        <div class="form-group">
			          <label>비밀번호</label>
			          <input type="password" name="userPwd" class="form-control">
			        </div>
			        <div class="form-group">
			          <label>이메일</label>
			          <input type="email" name="userEmail" class="form-control">
			        </div>
			        <div class="text-center">
			        <button type="submit" class="btn btn-primary">회원가입</button>
			        <a type="button" class="btn btn-primary" href="./login.jsp">돌아가기</a>
			        </div>
			      </form>
			    </div>
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