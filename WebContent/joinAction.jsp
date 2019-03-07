<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MOTTIP JSP 게시판 포트폴리오</title>
</head>
<body>
	<%
		if(user.getUserID() == null || user.getUserPassword() == null  || user.getUserName() == null
			|| user.getUserGender() == null  || user.getUserEmail() == null ){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 정보가 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
		
			if(result== -1){
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('이미 가입되어 있는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			} 
		}
	%>
</body>
</html>