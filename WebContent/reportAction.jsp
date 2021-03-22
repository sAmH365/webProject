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
	String reportTitle = null;
	String reportContent = null;
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
	if(request.getParameter("reportTitle")!=null){
		reportTitle = request.getParameter("reportTitle");
	}
	if(request.getParameter("reportContent")!=null){
		reportContent = request.getParameter("reportContent");
	}
	 
	// 사용자에게 보낼 메시지를 기입합니다.
		String host = "http://localhost:8080/evaluation/";
		String from = "kwonsaehim";
		String to = "kwonsaehim@gmail.com";
		String subject = "StarEvalue에서 접수된 신고 메일입니다.";
		String content = "신고자: " + userID + "<br>제목: " + reportTitle +	 "<br>내용: " + reportContent;
		
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
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('정상적으로 신고되었습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	
%>
