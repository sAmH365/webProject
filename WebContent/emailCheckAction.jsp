<%@page import="java.io.PrintWriter"%>
<%@page import="util.SHA256"%>
<%@page import="users.UsersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String code = request.getParameter("code");
	UsersDAO usersDao = new UsersDAO();
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
	String userEmail = usersDao.getUserEmail(userID);
	boolean rightCode = (new SHA256().getSHA256(userEmail).equals(code)) ? true : false;
	if(rightCode == true) {
		usersDao.setUserEmailChecked(userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('인증에 성공했습니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();		
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 코드입니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();		
	}
%>