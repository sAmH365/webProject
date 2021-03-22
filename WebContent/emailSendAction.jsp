<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="users.UsersDAO"%>
<%@page import="util.SHA256"%>
<%@page import="util.Gmail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	UsersDAO usersDao = new UsersDAO();
	request.setCharacterEncoding("utf-8");
	String userID = null;	
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(session.getAttribute("userID")==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요');");
		script.println("location.href='login.jsp'");
		script.println("</script>");
		script.close();
	}
	
	int emailChecked = usersDao.getUserEmailChecked(userID);
	if(emailChecked == 1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 인증 된 회원입니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();		
	}
	 
	// 사용자에게 보낼 메시지를 기입합니다.
		String host = "http://localhost:8080/evaluation/";
		String from = "kwonsaehim";
		String to = usersDao.getUserEmail(userID);
		String subject = "StarEvalue에서 보낸 확인 메일 입니다.";
		String content = "다음 링크에 접속하여 이메일 확인을 진행하세요.<br>" +
			"<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>이메일 인증하기</a>";
		
		// SMTP에 접속하기 위한 정보를 기입합니다.
		Properties p = new Properties();
		p.put("mail.smtp.user", from);
		p.put("mail.smtp.host", "smtp.googlemail.com"); //이메일 발송을 처리해줄 SMTP 서버
		p.put("mail.smtp.port", "465"); //tls의 포트번호는 587  이며 ssl의 포트번호는 465이다.
		p.put("mail.smtp.starttls.enable", "true");//로그인시 TLS를 사용할 것인지 설정
		p.put("mail.smtp.auth", "true"); //SMTP서버의 인증을 사용한다는 의미
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465"); 
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		 
		try{
		    Authenticator auth = new Gmail(); //MailAuth.java 에서 Authenticator를 상속받아 생성한 Gmail 클래스를 받아 
		    Session ses = Session.getInstance(p, auth);//세션을 생성한다.
		    ses.setDebug(true);
		    MimeMessage msg = new MimeMessage(ses); //MimeMessage는 Message 클래스를 상속받은 인터넷 메일을 휘나 클래스이다. 위에서 생성한 세션을 담아 msg객체를 생성한다.
		    msg.setSubject(subject);
		    Address fromAddr = new InternetAddress(from);
		    msg.setFrom(fromAddr);//발송자를 지정한다
		    Address toAddr = new InternetAddress(to); //수신자의 메일을 생성한다.
		    msg.addRecipient(Message.RecipientType.TO, toAddr);//Message 클래스의 setREcipient()메소드를 사용하여 수신자를 설정한다.
		    msg.setContent(content, "text/html;charset=UTF-8");
		    Transport.send(msg);//메일을 보내는 부분
		} catch(Exception e){
		    e.printStackTrace();
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('오류가 발생했습니다..');");
			script.println("history.back();");
			script.println("</script>");
			script.close();		
		}
	
%>

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
					<li class="nav-item"><a class="nav-link" href="./login.jsp"
						style="font-size: 12pt;">홈으로</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						style="font-size: 12pt;">회원정보</a></li>
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
	<div class="container">
	    <div class="alert alert-success mt-4" role="alert">
		  인증 메일이 전송되었습니다. 이메일에 들어가셔서 인증해주세요.
		</div>
    </div>
    <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
      Copyright &copy; 2021 권새힘 All Rights Reserved.
    </footer>
    <!-- 제이쿼리 자바스크립트 추가하기 -->
    <script src="./js/jquery.min.js"></script>
    <!-- Popper 자바스크립트 추가하기 -->
    <script src="./js/popper.min.js"></script>
    <!-- 부트스트랩 자바스크립트 추가하기 -->
    <script src="./js/bootstrap.min.js"></script>
  </body>
</html>