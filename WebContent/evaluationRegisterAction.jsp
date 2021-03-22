<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
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
	int postNum;
	String area = null;
	String address=null;
	String selectStore = null; //선택한 지점
	String storeTitle= null; //제목
	String storeEvaluation= null; //평가내용
	String purpose = null;
	Double taste = null;
	Double mood = null;
	Double kind = null;
	Double facility = null;
	Double totalScore = null;
	
	if(request.getParameter("selectStore")!=null){//선택한 지점
		selectStore = request.getParameter("selectStore");
	}
	if(request.getParameter("storeTitle")!=null){ //제목
		storeTitle = request.getParameter("storeTitle");
	}
	if(request.getParameter("storeEvaluation")!=null){//평가내용
		storeEvaluation = request.getParameter("storeEvaluation");
	}
	if(request.getParameter("purpose")!=null){
		purpose = request.getParameter("purpose");
	}
	if(request.getParameter("taste")!=null){
		taste = Double.parseDouble(request.getParameter("taste"));
	}
	if(request.getParameter("mood")!=null){
		mood = Double.parseDouble(request.getParameter("mood"));
	}
	if(request.getParameter("kind")!=null){
		kind = Double.parseDouble(request.getParameter("kind"));
	}
	if(request.getParameter("facility")!=null){
		facility = Double.parseDouble(request.getParameter("facility"));
	}
	if(request.getParameter("totalScore")!=null){
		totalScore = Double.parseDouble(request.getParameter("totalScore"));
	}
	if(request.getParameter("area")!=null){
		area = request.getParameter("area");
	}
	
	if(selectStore=="" || storeTitle==""|| storeEvaluation==""||storeEvaluation==""){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력 안된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}else{
		EvaluationDAO evaluationDao = new EvaluationDAO();
		
		int result = evaluationDao.registerEvaluation(new EvaluationDTO(0, evaluationDao.getArea(selectStore), evaluationDao.getAddress(selectStore),
				selectStore,storeTitle, userID, storeEvaluation, purpose, taste, mood, kind, facility, totalScore,0));
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류입니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		}else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = './index.jsp?pageNum=1';");
			script.println("</script>");
			script.close();
		}
	}
	
	
%>