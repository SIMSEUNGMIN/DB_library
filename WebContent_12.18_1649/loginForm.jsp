<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α��� ������</title>
</head>
<body>
	<h2>���� ���� �� ���� �ý���</h2>

	<div style="line-height: 300%; font-size: 15px; font-weight: bold;">
		<form method="post" action="loginPro.jsp">
			���̵� : <input type="text" name="id" maxlength="10" required><br />
			��й�ȣ : <input type="password" name="password" maxlength="30" required>
			<input type="submit" value="�α���" />
		</form>
		<input type="button" onclick="location.href='signUpForm.jsp'"
			value="ȸ������" />
	</div>
</body>
</html>