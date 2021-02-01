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
<title>회원 기능 선택 페이지</title>
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
		회원님
	</p>
	<input type="button"
		onclick="location.href='updateUserForm.jsp?id=<%=id%>'" value="정보수정"
		class="btn">
	<br />
	<input type="button"
		onclick="location.href='BorrowList.jsp?id=<%=id%>'" value="대출목록"
		class="btn">
	<br />
	<input type="button"
		onclick="location.href='reservationList.jsp?id=<%=id%>'" value="예약목록"
		class="btn">
	<br />
	<input type="button"
		onclick="location.href='findBookForm.jsp?id=<%=id%>'" value="도서검색"
		class="btn">
	<br />
	<input type="button" onclick="location.href='loginForm.jsp'"
		value="로그아웃" class="btn">
	<br />
</body>
</html>