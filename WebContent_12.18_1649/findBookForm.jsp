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
<title>���� �˻� ������</title>
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
		value="�ڷΰ���" />
	<br />
	<br />
	<form method="post" action="findBookPro.jsp?id=<%=id%>">
		<input type="radio" name="typeOfSearch" value="bookName" checked>
		�������� �˻� <br /> <input type="radio" name="typeOfSearch" value="isbn">ISBN����
		�˻� <br /> <input type="text" name="search"> <input
			type="submit" value="�˻�">
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
			<th>����</th>
			<th>�۰�</th>
			<th>���ǻ�</th>
			<th>���� ��� �ο�</th>
			<th>����/����</th>
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
			<td>���� �Ұ�</td>
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
			<td>���� ��</td>
			<%
				} else if (rs.getInt("canBorrowCount") > 0) {
			%>
			<td><button
					onclick="location='loanBook.jsp?id=<%=id%>&isbn=<%=isbn%>'">����</button></td>
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
			<td>���� ��</td>
			<%
				} else {//���� ������ �� ������
									String canReserve = "select count(*) as cnt from reservation where isbn=?";
									PreparedStatement canReserveStmt = null;
									canReserveStmt = conn.prepareStatement(canReserve);
									canReserveStmt.setString(1, rs.getString("isbn"));
									ResultSet canReserveState = canReserveStmt.executeQuery();
									canReserveState.next();
									if (canReserveState.getInt("cnt") >= rs.getInt("count")) {
			%>
			<td>���� �Ұ�</td>
			<%
				} else {
			%>
			<td><button
					onclick="location='reserveBook.jsp?id=<%=id%>&isbn=<%=isbn%>'">����</button></td>

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