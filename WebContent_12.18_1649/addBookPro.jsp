<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("euc-kr");
%>

<%
	//파라미터 값을 얻어내는 부분
	String id = request.getParameter("id");

	String isbn = request.getParameter("isbn");
	String title = request.getParameter("title");
	String author = request.getParameter("author");
	String publisher = request.getParameter("publisher");
	int count = Integer.parseInt(request.getParameter("count"));

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

		String sql = "select isbn from db_library.book where isbn = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, isbn);
		rs = pstmt.executeQuery();

		if (rs.next()) {
			out.println("<script>alert('이미 존재하는 책입니다. 도서 수정을 이용해주세요.');location.href='AdministratorPage.jsp?id="
					+ id + "'</script>");
		}
		pstmt.close();

		if (count < 0) {
			out.println(
					"<script>alert('권수는 음수일 수 없습니다.');location.href='addBookForm.jsp?id=" + id + "'</script>");
		} else {
			sql = "insert into db_library.book values(?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, isbn);
			pstmt.setString(2, title);
			pstmt.setString(3, author);
			pstmt.setString(4, publisher);
			pstmt.setInt(5, count);
			pstmt.setInt(6, count);
			pstmt.executeUpdate();
			out.println(
					"<script>alert('추가되었습니다.');location.href='AdministratorPage.jsp?id=" + id + "'</script>");
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

