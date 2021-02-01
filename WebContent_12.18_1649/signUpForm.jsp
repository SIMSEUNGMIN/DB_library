<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입 페이지</title>
</head>
<body>
	<h2>회원가입</h2>

	<div style="line-height: 300%; font-size: 15px; font-weight: bold;">
		<form method="post" action="signUpPro.jsp">
			아이디 : <input type="text" name="id" maxlength="10" required><br />
			비밀번호 : <input type="password" name="password" maxlength="30" required><br />
			이름 : <input type="text" name="name" maxlength="10" required><br />
			이메일 주소 : <input type="email" name="email" maxlength="30" required><br />
			전화번호 : <input type="tel" name="phoneNumber" pattern="[0-9]{11}" placeholder="(-) 를 빼고 입력" required><br />
			구분 <select name="position" required>
				<option value="학부">학부</option>
				<option value="대학원">대학원</option>
				<option value="교직원">교직원</option>
			</select><br /> <input type="submit" value="가입" /> <input type="button"
				onclick="location.href='loginForm.jsp'" value="취소" />
		</form>
	</div>
</body>
</html>