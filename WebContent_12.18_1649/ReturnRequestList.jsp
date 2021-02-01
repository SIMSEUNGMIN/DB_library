<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String aid = request.getParameter("id");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>반납 요청 목록</title>
</head>
<body>
	<h2>반납 요청 목록</h2>
	
	<table width = "100%" border = "0" style = "text-align:center;">
	<tr>
		<td>회원 아이디</td>
		<td>도서 ISBN</td>
		<td>대출 일자</td>
		<td>반납 요청 상태</td>
	</tr>
	
	<%
	
	Connection conn = null;

	try{
		
		String jdbcUrl = "jdbc:mysql://localhost:3306/DB_Library";
		String dbId = "root";
		String dbPass = "qwerty";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		//쿼리문, 테이블의 데이터를 불러옴
		String returnRequestQ = "select * from borrow where returnRequest = 'Y' and returnState = 'N'";
		
		//자바 statement 생성
		Statement st = conn.createStatement();
		
		// 쿼리 실행, 객체 생성
		ResultSet returnRList = st.executeQuery(returnRequestQ);
		
		
		while(returnRList.next()){
			String id = returnRList.getString("id");
			String isbn = returnRList.getString("isbn");
			String borrowDate = returnRList.getString("borrowDate");
					
	%>
			<tr>
				<td><%= id %></td>
				<td><%= isbn %></td>
				<td><%= borrowDate%></td>
				<!-- 표 셀 안에다 버튼 만들기-->
				<td><button onclick="location='ReturnAccept.jsp?id=<%= id%>&isbn=<%= isbn%>'">승인</button></td>
			</tr>
	<%	
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	%>
	
	</table>
	
	<hr />
	
	<button onclick ="location='AdministratorPage.jsp?id=<%= aid%>'" style="float:right;">돌아가기</button>
</body>
</html>