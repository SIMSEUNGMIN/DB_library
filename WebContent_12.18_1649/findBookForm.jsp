<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	String id = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>도서 검색 페이지</title>
<style>
table {
	border: "1";
	border-collapse: collapse;
}

table, td, th {
	border: 3px solid black;
	text-align: center;
}

td, th {
	padding: 8px;
}
</style>
</head>
<body>
	<input type="button" onclick="location.href='userForm.jsp?id=<%=id%>'"
		value="뒤로가기" />
	<br />
	<br />
	<form method="post" action="findBookPro.jsp?id=<%=id%>">
		<input type="radio" name="typeOfSearch" value="bookName" checked>
		제목으로 검색 <br /> <input type="radio" name="typeOfSearch" value="isbn">ISBN으로
		검색 <br /> <input type="text" name="search"> <input
			type="submit" value="검색">
	</form>
	<br />
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
			String sql = "select * from book";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
	%>
	<table>
		<tr>
			<th>ISBN</th>
			<th>제목</th>
			<th>작가</th>
			<th>출판사</th>
			<th>예약 대기 인원</th>
			<th>대출/예약</th>
		</tr>
		<%
			while (rs.next()) {
					String isbn = rs.getString("isbn");
					String title = rs.getString("title");
					String author = rs.getString("author");
					String publisher = rs.getString("publisher");
		%>

		<tr>
			<td><%=isbn%></td>
			<td><%=title%></td>
			<td><%=author%></td>
			<td><%=publisher%></td>
			<%
				String sqlCount = "select count(*) as cnt from reservation where isbn=?";
						PreparedStatement prestmt = conn.prepareStatement(sqlCount);
						prestmt.setString(1, rs.getString("isbn"));
						ResultSet rset = prestmt.executeQuery();
						rset.next();
			%>
			<td><%=rset.getInt("cnt")%></td>
			<%
				if (rs.getInt("count") == 0) {
			%>
			<td>대출 불가</td>
			<%
				} else {
							String sql2 = "select count(*) as cnt from borrow where isbn=? and id=? and returnState='N'";
							PreparedStatement ptemp = null;
							ptemp = conn.prepareStatement(sql2);
							ptemp.setString(1, rs.getString("isbn"));
							ptemp.setString(2, id);
							ResultSet temp = ptemp.executeQuery();
							temp.next();
							if (temp.getInt("cnt") != 0) {
			%>
			<td>대출 중</td>
			<%
				} else if (rs.getInt("canBorrowCount") > 0) {
			%>
			<td><button
					onclick="location='loanBook.jsp?id=<%=id%>&isbn=<%=isbn%>'">대출</button></td>
			<%
				} else {
								String isReserve = "select count(*) as cnt from reservation where isbn=? and id=?";
								PreparedStatement isReserveStmt = null;
								isReserveStmt = conn.prepareStatement(isReserve);
								isReserveStmt.setString(1, isbn);
								isReserveStmt.setString(2, id);
								ResultSet reserveState = isReserveStmt.executeQuery();
								reserveState.next();
								if (reserveState.getInt("cnt") > 0) {
			%>
			<td>예약 중</td>
			<%
				} else {//예약 가능한 지 봐야함
									String canReserve = "select count(*) as cnt from reservation where isbn=?";
									PreparedStatement canReserveStmt = null;
									canReserveStmt = conn.prepareStatement(canReserve);
									canReserveStmt.setString(1, rs.getString("isbn"));
									ResultSet canReserveState = canReserveStmt.executeQuery();
									canReserveState.next();
									if (canReserveState.getInt("cnt") >= rs.getInt("count")) {
			%>
			<td>예약 불가</td>
			<%
				} else {
			%>
			<td><button
					onclick="location='reserveBook.jsp?id=<%=id%>&isbn=<%=isbn%>'">예약</button></td>

			<%
				}
								}
							}
						}
			%>
		</tr>
		<%
			}

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

	</table>


</body>
</html>