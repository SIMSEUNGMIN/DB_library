<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ������ ������</title>
</head>
<body>
	<h2>ȸ������</h2>

	<div style="line-height: 300%; font-size: 15px; font-weight: bold;">
		<form method="post" action="signUpPro.jsp">
			���̵� : <input type="text" name="id" maxlength="10" required><br />
			��й�ȣ : <input type="password" name="password" maxlength="30" required><br />
			�̸� : <input type="text" name="name" maxlength="10" required><br />
			�̸��� �ּ� : <input type="email" name="email" maxlength="30" required><br />
			��ȭ��ȣ : <input type="tel" name="phoneNumber" pattern="[0-9]{11}" placeholder="(-) �� ���� �Է�" required><br />
			���� <select name="position" required>
				<option value="�к�">�к�</option>
				<option value="���п�">���п�</option>
				<option value="������">������</option>
			</select><br /> <input type="submit" value="����" /> <input type="button"
				onclick="location.href='loginForm.jsp'" value="���" />
		</form>
	</div>
</body>
</html>