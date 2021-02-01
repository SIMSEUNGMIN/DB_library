<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	String isbn = request.getParameter("isbn");
	String title = "";
	String author = "";
	String publisher = "";
	int count = 0;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {

		String jdbcUrl = "jdbc:mysql://localhost:3306/db_library";
		String dbId = "root";
		String dbPass = "qwerty";

		// DB�� ������ ���� Connection ��ü�� ���� �κ�
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		// ���� �ҷ�����
		String sql = "select * from book where isbn = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, isbn);
		rs = pstmt.executeQuery();

		if (rs.next()) {
			title = rs.getString("title");
			author = rs.getString("author");
			publisher = rs.getString("publisher");
			count = rs.getInt("count");
		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException sqle) {
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException sqle) {
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException sqle) {

			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���� ������</title>
<style>
.p {
	font-size: 10px;
}
</style>
</head>
<body>
	<h2>���� ����</h2>
	<p class="p">ISBN�� ������ �Ұ��� �մϴ�.</p>

	<div style="line-height: 300%; font-size: 15px; font-weight: bold;">
		<form method="post" action="BookModifyPro.jsp">
			ISBN : <input type="text" name="isbn" pattern="[0-9]{13}" readonly value=<%=isbn%>><br /> 
			���� : <input type="text" name="title" maxlength="30" required value=<%=title%>><br /> 
			���� : <input type="text" name="author" maxlength="30" required value=<%=author%>><br /> 
			���ǻ� : <input type="text" name="publisher" maxlength="30" required value=<%=publisher%>><br />
			�Ǽ� : <input type="number" name="count" min="1" maxlength="10" required value=<%=count%>><br />
			<input type="submit" value="����" /> 
			<input type="button" onclick="location.href='BookModifyNDelete.jsp'" value="���" />
		</form>
	</div>
</body>
</html>