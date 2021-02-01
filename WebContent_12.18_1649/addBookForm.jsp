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
<title>���� �߰� ������</title>
</head>
<body>
	<h2>���� �߰�</h2>

	<div style="line-height: 300%; font-size: 15px; font-weight: bold;">
		<form method="post" action="addBookPro.jsp?id=<%=id%>">
			ISBN : <input type="text" name="isbn" pattern="[0-9]{13}" required ><br /> 
			���� : <input type="text" name="title" maxlength="30" required ><br /> 
			���� : <input type="text" name="author" maxlength="30" required ><br /> 
			���ǻ� : <input type="text" name="publisher" maxlength="30" required ><br />
			�Ǽ� : <input type="number" name="count" min="1" maxlength="10" required ><br />
			<input type="submit" value="�߰�" /> 
			<input type="button" onclick="location.href='AdministratorPage.jsp?id=<%=id%>'" value="���" />
		</form>
	</div>
</body>
</html>