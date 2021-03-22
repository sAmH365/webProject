<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="users.UsersDAO"%>
<%@ page import="users.UsersDTO"%>
<%@ page import="util.SHA256"%>
<%@page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("utf-8");
	String userName = null;
	String userID = null;
	String userPwd = null;
	String userEmail = null;
	
	if(request.getParameter("userName")!=null){
		userName = request.getParameter("userName");
	}
	if(request.getParameter("userID")!=null){
		userID = request.getParameter("userID");
	}
	if(request.getParameter("userPwd")!=null){
		userPwd = request.getParameter("userPwd");
	}
	if(request.getParameter("userEmail")!=null){
		userEmail = request.getParameter("userEmail");
	}
	if(userName==null || userID==null || userPwd==null||userEmail==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력 안된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}else{
		UsersDAO userDao = new UsersDAO();
		int result = userDao.join(new UsersDTO(userName, userID, userPwd, userEmail, SHA256.getSHA256(userEmail), 0));
		if(result==-1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 등록된 회원 입니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		}else{
			session.setAttribute("userID", userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='emailSendAction.jsp';");
			script.println("</script>");
			script.close();
		}
	}
%>
