<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	String id = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������ ���� ������</title>
<style>
.btn {
	line-height: 200%;
	font-size: 20px;
	font-weight: bold;
	margin-top: 30px;
	margin-left: 100px;
}
</style>
</head>
<body>
	<h2 class="btn"><%=id%> �����ڴ�</h2>
	<button class="btn" onclick="location='AdminInfoForm.jsp?id=<%=id%>'">���� ����</button><br />
	<button class="btn" onclick="location='addBookForm.jsp?id=<%=id%>'">���� ���</button><br />
	<button class="btn" onclick="location='BookModifyNDelete.jsp?id=<%=id%>'">���� ����/����</button><br />
	<button class="btn" onclick="location='BorrowRankingList.jsp?id=<%=id%>'">���� ���� ���� ����</button><br />
	<button class="btn" onclick="location='ReturnRequestList.jsp?id=<%=id%>'">���� �ݳ� ��û ���</button><br />
	<button class="btn" onclick="location='loginForm.jsp'">�α׾ƿ�</button>
</body>
</html>