<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>MOTTIP JSP 게시판 포트폴리오</title>
<style type ="text/css">
	a, a:hover{
		color : #000000;
		text-decoration: none;
		}|
</style>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse=-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
	        	<li class="dropdown">
	          		 <a href="#" class="dropdown-toggle" 
	          			data-toggle="dropdown" role="button" aria-haspopup="true" 
	        			aria-expanded="false">접속하기 <span class="caret"></span></a>
	        		<ul class="dropdown-menu">
	             		<li><a href="login.jsp">로그인</a></li>
	              		<li><a href="join.jsp">회원가입</a></li>
	           		</ul>    
	        	</li>
	       	</ul>
			<%
				} else{
			%>
			<ul class="nav navbar-nav navbar-right">
	        	<li class="dropdown">
	          		 <a href="#" class="dropdown-toggle" 
	          			data-toggle="dropdown" role="button" aria-haspopup="true" 
	        			aria-expanded="false">회원관리 <span class="caret"></span></a>
	        		<ul class="dropdown-menu">
	             		<li><a href="logoutAction.jsp">로그아웃</a></li>
	           		</ul>    
	        	</li>
	       	</ul>
			<%
				}
			%>

		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th style="background-color:#eeeeee; text-align:center;">번호</th>
						<th style="background-color:#eeeeee; text-align:center;">제목</th>
						<th style="background-color:#eeeeee; text-align:center;">작성자</th>
						<th style="background-color:#eeeeee; text-align:center;">작성일</th>
					</tr>
				</thead>
				<tbody>
				<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					for(int i=0;i<list.size();i++){
				%>	
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11, 13) + "시 " + list.get(i).getBbsDate().substring(14, 16) + "분"%></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
			<nav style="inline;">
				<ul class="pagination" style="margin : 0; auto;">
				    <li>
				    <%
				    	int lastPage = bbsDAO.pageCount();
						int blockPage = 5;
				
						if(pageNumber == 1 ){
					%>
						<a href="#" aria-label="Previous" style="background-color:#eeeeee; cursor: default;">
							<span aria-hidden="true">&laquo;</span>
						</a>
					<%
						} else {
					%>
					  <a href="bbs.jsp?pageNumber=<%=pageNumber - 1 %>" aria-label="Previous">
						    <span aria-hidden="true">&laquo;</span>
						</a>
					<%
					}
					%> 
					</li>
					<%
						int startPage = (pageNumber-1)/blockPage*blockPage+1;
						int endPage = startPage + 5 -1; 
						for(int i=startPage;i<=endPage;i++) {
							if(pageNumber == i){
					%>
								<li><a href="bbs.jsp?pageNumber=<%=i%>" style="color:red;"><%=i%></a></li>
					<%	
							} else if(lastPage < i){
					%>
						   		<li><a href="#" style="background-color:#eeeeee; cursor: default;"><%=i%></a></li>
					<%			
							}		
							else {
					%>
						   		<li><a href="bbs.jsp?pageNumber=<%=i%>"><%=i%></a></li>
					<%
							}
						}
					%>
				    <%
				   		if(bbsDAO.nextPage(pageNumber+1)){
					%>
				    	<li>
						    <a href="bbs.jsp?pageNumber=<%=pageNumber + 1 %>" aria-label="Next">
							    <span aria-hidden="true">&raquo;</span>
						    </a>
				   		</li>
					<%
						} else {
					%>
						<li>
						    <a href="#" aria-label="Next" style="background-color:#eeeeee; cursor: default;">
							    <span aria-hidden="true">&raquo;</span>
						    </a>
				   		</li>
					<%
						}
					%>
			  	</ul>
					<a href="write.jsp" class="btn btn-primary pull-right" style="float:right; margin:0 auto">글쓰기</a>
			</nav>
		</div>
	</div>
	
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>