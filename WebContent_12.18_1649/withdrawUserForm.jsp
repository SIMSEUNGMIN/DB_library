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
<title>ȸ�� Ż�� ������</title>
</head>
<body>
	<h2>Ż�� �� ���� Ȯ��</h2>

	<div style="line-height: 300%; font-size: 15px; font-weight: bold;">
		<form method="post" action="withdrawUserPro.jsp">
			���̵� : <input type="text" name="id" maxlength="10" readonly value=<%=id%> ><br /> 
			��й�ȣ : <input type="password" name="password" maxlength="30" required><br /> 
			<input type="submit" value="Ȯ��" /> 
			<input type="button" onclick="location.href='userForm.jsp?id=<%=id%>'" value="���" /><br />
		</form>
	</div>
</body>
</html>