<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@page import="users.UsersDAO" %>
	<%@page import="users.UsersDAO" %>
	<%@page import="java.io.PrintWriter" %>
<%
String userID = null;
String id = null;
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
request.setCharacterEncoding("UTF-8");
id = request.getParameter("id");


UsersDAO usersDao = new UsersDAO();
usersDao.deleteUser(id);
PrintWriter script = response.getWriter();
script.println("<script>");
script.println("alert('유저가 삭제되었습니다.');");
script.println("location.href = 'management.jsp'");
script.println("</script>");
script.close();

%>
