<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인 페이지</title>
</head>
<body>
	<h2>도서 예약 및 관리 시스템</h2>

	<div style="line-height: 300%; font-size: 15px; font-weight: bold;">
		<form method="post" action="loginPro.jsp">
			아이디 : <input type="text" name="id" maxlength="10" required><br />
			비밀번호 : <input type="password" name="password" maxlength="30" required>
			<input type="submit" value="로그인" />
		</form>
		<input type="button" onclick="location.href='signUpForm.jsp'"
			value="회원가입" />
	</div>
</body>
</html>