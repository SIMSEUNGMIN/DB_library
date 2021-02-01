<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import = "java.sql.*" %>
    
<% request.setCharacterEncoding("euc-kr"); %>

<%
	String id = request.getParameter("id");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>도서 수정/삭제</title>
</head>
<body>
	<h2>도서 목록</h2>
	<table width = "100%" border = "0" style = "text-align:center;">
	<tr>
		<td>도서 ISBN</td>
		<td>도서 제목</td>
		<td>도서 저자</td>
		<td>도서 출판사</td>
		<td>도서 권수</td>
		<td>도서 대여 가능 권수</td>
		<td>수정</td>
		<td>삭제</td>
	</tr>
		
	<%
	
	Connection conn = null;

	try{
		
		String jdbcUrl = "jdbc:mysql://localhost:3306/db_Library";
		String dbId = "root";
		String dbPass = "qwerty";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		//쿼리문, 테이블의 데이터를 불러옴
		String returnRequestQ = "select * from book";
		
		//자바 statement 생성
		Statement st = conn.createStatement();
		
		// 쿼리 실행, 객체 생성
		ResultSet returnRList = st.executeQuery(returnRequestQ);
		
		
		while(returnRList.next()){
			String isbn = returnRList.getString("isbn");
			String title = returnRList.getString("title");
			String author = returnRList.getString("author");
			String publisher = returnRList.getString("publisher");
			String count = returnRList.getString("count");
			String canBorrowCount = returnRList.getString("canBorrowCount");
					
	%>
			<tr>
				<td><%= isbn %></td>
				<td><%= title %></td>
				<td><%= author %></td>
				<td><%= publisher %></td>
				<td><%= count %></td>
				<td><%= canBorrowCount %></td>
				<!-- 표 셀 안에다 버튼 만들기-->
				<td><button onclick="location='BookModify.jsp?isbn=<%= isbn%>'">수정</button></td>
				<td><button onclick="location='BookDelete.jsp?isbn=<%= isbn%>'">삭제</button></td>
			</tr>
	<%	
		}
		
		st.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	%>
	
	</table>
	
	<hr />
	
	<button onclick ="location='AdministratorPage.jsp?id=<%=id%>'" style="float:right;">뒤로가기</button>
</body>
</html>