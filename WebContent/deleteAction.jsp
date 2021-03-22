<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@page import="evaluation.EvaluationDAO" %>
	<%@page import="evaluation.EvaluationDTO" %>
	<%@page import="java.io.PrintWriter" %>
<%
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
request.setCharacterEncoding("UTF-8");
String postNum = null;
if(request.getParameter("postNum") != null) {
	postNum = (String) request.getParameter("postNum");
}

EvaluationDAO evaluationDAO = new EvaluationDAO();
//System.out.println(evaluationDAO.getUserID(postNum));
//System.out.println("userID : "+ userID);
if(userID.equals(evaluationDAO.getUserID(postNum))|| userID.equals("admin")) {
	int result = new EvaluationDAO().deleteEvaluation(postNum);
	if (result == 1 ) {
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('삭제가 완료되었습니다.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();		
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		
	}
} else {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('자신이 쓴 글만 삭제 가능합니다.');");
	script.println("history.back();");
	script.println("</script>");
	script.close();
	
}
%>
