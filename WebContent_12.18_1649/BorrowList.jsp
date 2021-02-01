<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대출 목록 페이지</title>
<script>
</script>
<style>
table {
	border: "1";
	border-collapse: collapse;
}

table, td, th {
	border: 3px solid black;
	text-align:center;
}
td, th{
	padding:8px;
}
</style>
</head>
<body>
<%String id = request.getParameter("id"); %>
<button onclick="location='userForm.jsp?id=<%= id%>'">뒤로가기</button><br />
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	

	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/db_library";
		String dbId = "root";
		String dbPass = "qwerty";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		String sql = "select b.isbn, b.title,  b.author, b.publisher,l.borrowDate, l.returnRequest, l.returnDate"
				+ " from borrow l inner join book b on b.isbn = l.isbn"
				+ " where l.id=? and l.returnState='N'";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);

		rs = pstmt.executeQuery();
		%>
		<br />
		<table>
		<tr><th>ISBN</th><th>제목</th><th>작가</th><th>출판사</th><th>대출일</th><th>반납예정일</th><th>반납신청</th></tr>
		
		
		<%
		while (rs.next()) {
			String isbn = rs.getString("isbn");
			String title = rs.getString("title");
			String author = rs.getString("author");
			String publisher = rs.getString("publisher");
			java.sql.Date borrowDate = rs.getDate("borrowDate");
			java.sql.Date returnDate = rs.getDate("returnDate");
			String returnRequest = rs.getString("returnRequest");
			%>
			<tr>
				<td><%= isbn %></td>
				<td><%= title %></td>
				<td><%= author %></td>
				<td><%= publisher %></td>
				<td><%= borrowDate.toString() %></td>				
				<td><%= returnDate.toString() %></td>
			<%
			if(rs.getString("returnRequest").equals("Y")){
			%>
				<td>반납 신청 중</td>
			<%
			}else{
			%>
				<td><button onclick="location='requestReturn.jsp?id=<%= id%>&isbn=<%= isbn%>'">반납신청</button></td>
			<% 	
			}
			%>
			</tr>
	<%
		}
		%>
		</table>
		<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException sqle) {
			}
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException sqle) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException sqle) {
			}
	}
%>
</body>
</html>