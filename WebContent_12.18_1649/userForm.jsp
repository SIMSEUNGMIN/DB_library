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
<title>ȸ�� ��� ���� ������</title>
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
	<p id="userid" class="btn">
		<%=id%>
		ȸ����
	</p>
	<input type="button"
		onclick="location.href='updateUserForm.jsp?id=<%=id%>'" value="��������"
		class="btn">
	<br />
	<input type="button"
		onclick="location.href='BorrowList.jsp?id=<%=id%>'" value="������"
		class="btn">
	<br />
	<input type="button"
		onclick="location.href='reservationList.jsp?id=<%=id%>'" value="������"
		class="btn">
	<br />
	<input type="button"
		onclick="location.href='findBookForm.jsp?id=<%=id%>'" value="�����˻�"
		class="btn">
	<br />
	<input type="button" onclick="location.href='loginForm.jsp'"
		value="�α׾ƿ�" class="btn">
	<br />
</body>
</html>