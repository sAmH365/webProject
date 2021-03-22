<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="recommend.RecommendDAO"%>
<%@page import="evaluation.EvaluationDAO"%>
<%@page import="evaluation.EvaluationDTO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%
String userID = null;
String postNum = null;
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
if(userID.equals("visitor")){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('비회원은 회원가입 후 추천 가능 합니다.');");
	script.println("location.href = 'index.jsp'");
	script.println("</script>");
	script.close();
}
if(request.getParameter("postNum") != null) {
	postNum = request.getParameter("postNum");
}


RecommendDAO dao = new RecommendDAO();
EvaluationDAO evaluationDao = new EvaluationDAO();
int result = dao.addReco(Integer.parseInt(postNum), userID);
if(userID.equals("visitor")) result = 0;
if(result==1){
	result = evaluationDao.recommend(Integer.parseInt(postNum));
	if(result==1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('추천했습니다.');");
		script.println("location.href= 'index.jsp'");
		script.println("</script>");
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.');");
		script.println("history.back();");
		script.println("</script>");
	}
}else if(result==0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('비회원은 회원가입 후 추천 가능 합니다.');");
	script.println("location.href = 'index.jsp'");
	script.println("</script>");
	script.close();
}else{
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 추천 했습니다.');");
	script.println("history.back();");
	script.println("</script>");
}

%>
