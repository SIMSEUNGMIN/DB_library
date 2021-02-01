<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import = "java.sql.*" %>
    
<% request.setCharacterEncoding("euc-kr"); %>

<%
	String id = request.getParameter("id");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>도서 대출 내역</title>
</head>
<body>
	<h2>도서 대출 내역</h2>
	<br />
	<h3>대출 내역을 알고 싶은 기간을 입력하시오(YYYY-MM-DD 형태로 입력하시오)</h3>
	
	<form method="post" action="ReturnBookRankingList.jsp">
	시작 날짜
	<input type='date' name='startDate' id='startDate'>
	~ 종료 날짜
	<input type='date' name='endDate' id='endDate'>
	<input type='submit' style="float:right;" value='검색'>
	</form>
	
	<script>
		document.getElementById('startDate').value = new Date().toISOString().substring(0,10);
		document.getElementById('endDate').value = new Date().toISOString().substring(0,10);
	</script>
	
	<hr />
	<button onclick ="location='AdministratorPage.jsp?id=<%=id%>'" style="float:right;">뒤로가기</button>
</body>
</html>