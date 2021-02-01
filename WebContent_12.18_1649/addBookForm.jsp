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
<title>도서 추가 페이지</title>
</head>
<body>
	<h2>도서 추가</h2>

	<div style="line-height: 300%; font-size: 15px; font-weight: bold;">
		<form method="post" action="addBookPro.jsp?id=<%=id%>">
			ISBN : <input type="text" name="isbn" pattern="[0-9]{13}" required ><br /> 
			제목 : <input type="text" name="title" maxlength="30" required ><br /> 
			저자 : <input type="text" name="author" maxlength="30" required ><br /> 
			출판사 : <input type="text" name="publisher" maxlength="30" required ><br />
			권수 : <input type="number" name="count" min="1" maxlength="10" required ><br />
			<input type="submit" value="추가" /> 
			<input type="button" onclick="location.href='AdministratorPage.jsp?id=<%=id%>'" value="취소" />
		</form>
	</div>
</body>
</html>