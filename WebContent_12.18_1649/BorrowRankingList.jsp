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
<title>���� ���� ����</title>
</head>
<body>
	<h2>���� ���� ����</h2>
	<br />
	<h3>���� ������ �˰� ���� �Ⱓ�� �Է��Ͻÿ�(YYYY-MM-DD ���·� �Է��Ͻÿ�)</h3>
	
	<form method="post" action="ReturnBookRankingList.jsp">
	���� ��¥
	<input type='date' name='startDate' id='startDate'>
	~ ���� ��¥
	<input type='date' name='endDate' id='endDate'>
	<input type='submit' style="float:right;" value='�˻�'>
	</form>
	
	<script>
		document.getElementById('startDate').value = new Date().toISOString().substring(0,10);
		document.getElementById('endDate').value = new Date().toISOString().substring(0,10);
	</script>
	
	<hr />
	<button onclick ="location='AdministratorPage.jsp?id=<%=id%>'" style="float:right;">�ڷΰ���</button>
</body>
</html>