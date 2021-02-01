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

		// DB와 연동을 위한 Connection 객체를 얻어내는 부분
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		// 정보 불러오기
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
<title>도서 수정 페이지</title>
<style>
.p {
	font-size: 10px;
}
</style>
</head>
<body>
	<h2>도서 수정</h2>
	<p class="p">ISBN은 수정이 불가능 합니다.</p>

	<div style="line-height: 300%; font-size: 15px; font-weight: bold;">
		<form method="post" action="BookModifyPro.jsp">
			ISBN : <input type="text" name="isbn" pattern="[0-9]{13}" readonly value=<%=isbn%>><br /> 
			제목 : <input type="text" name="title" maxlength="30" required value=<%=title%>><br /> 
			저자 : <input type="text" name="author" maxlength="30" required value=<%=author%>><br /> 
			출판사 : <input type="text" name="publisher" maxlength="30" required value=<%=publisher%>><br />
			권수 : <input type="number" name="count" min="1" maxlength="10" required value=<%=count%>><br />
			<input type="submit" value="수정" /> 
			<input type="button" onclick="location.href='BookModifyNDelete.jsp'" value="취소" />
		</form>
	</div>
</body>
</html>