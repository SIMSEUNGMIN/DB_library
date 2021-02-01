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
<title>관리자 시작 페이지</title>
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
	<h2 class="btn"><%=id%> 관리자님</h2>
	<button class="btn" onclick="location='AdminInfoForm.jsp?id=<%=id%>'">정보 수정</button><br />
	<button class="btn" onclick="location='addBookForm.jsp?id=<%=id%>'">도서 등록</button><br />
	<button class="btn" onclick="location='BookModifyNDelete.jsp?id=<%=id%>'">도서 수정/삭제</button><br />
	<button class="btn" onclick="location='BorrowRankingList.jsp?id=<%=id%>'">도서 대출 내역 순위</button><br />
	<button class="btn" onclick="location='ReturnRequestList.jsp?id=<%=id%>'">도서 반납 요청 목록</button><br />
	<button class="btn" onclick="location='loginForm.jsp'">로그아웃</button>
</body>
</html>