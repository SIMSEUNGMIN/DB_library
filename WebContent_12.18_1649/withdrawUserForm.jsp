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
<title>회원 탈퇴 페이지</title>
</head>
<body>
	<h2>탈퇴 전 정보 확인</h2>

	<div style="line-height: 300%; font-size: 15px; font-weight: bold;">
		<form method="post" action="withdrawUserPro.jsp">
			아이디 : <input type="text" name="id" maxlength="10" readonly value=<%=id%> ><br /> 
			비밀번호 : <input type="password" name="password" maxlength="30" required><br /> 
			<input type="submit" value="확인" /> 
			<input type="button" onclick="location.href='userForm.jsp?id=<%=id%>'" value="취소" /><br />
		</form>
	</div>
</body>
</html>