<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
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
<meta charset="utf-8">
<title>책 찾기</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
	%>
	<button onclick="location='findBookForm.jsp?id=<%=id%>'">뒤로가기</button>

	<%
		String typeOfSearch = request.getParameter("typeOfSearch");
		String search = request.getParameter("search");
		search = "%" + search + "%";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String jdbcUrl = "jdbc:mysql://localhost:3306/db_library";
			String dbId = "root";
			String dbPass = "qwerty";

			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			if (typeOfSearch.equals("bookName")) {
				String sql = "select * from book where title like ?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, search);
				rs = pstmt.executeQuery();
			} else {
				String sql = "select * from book where isbn like ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, search);
				rs = pstmt.executeQuery();
			}
	%>
	<table>
		<tr>
			<td>isbn</td>
			<td>제목</td>
			<td>작가</td>
			<td>출판사</td>
			<td>예약 대기 인원</td>
			<td>대출/예약</td>
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
								ResultSet reserveState = ptemp.executeQuery();
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

			}%>



	</table>
</body>
</html>