<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("euc-kr");
%>

<%
	//�Ķ���� ���� ���� �κ�
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

		// DB�� ������ ���� Connection ��ü�� ���� �κ�
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		String sql = "select count, canBorrowCount from db_library.book where isbn = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, isbn);
		rs = pstmt.executeQuery();
		int BorrowedCount = 0;
		if (rs.next()) {
			int rCount = rs.getInt("count");
			int rCanBorrowCount = rs.getInt("canBorrowCount");
			BorrowedCount = rCount - rCanBorrowCount;
			pstmt.close();

			if (count < 0) {
				out.println("<script>alert('�Ǽ��� ������ �� �����ϴ�.');location.href='BookModifyNDelete.jsp'</script>");

			} else if (rCount - rCanBorrowCount > count) {
				out.println(
						"<script>alert('�������� å�� �����Ƿ� �Ǽ��� �� �۰� ������ �� �����ϴ�.');location.href='BookModifyNDelete.jsp'</script>");
			} else { // ����
				sql = "update db_library.book set title = ?, author = ?, publisher = ?, count = ?, canBorrowCount = ? where isbn = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, title);
				pstmt.setString(2, author);
				pstmt.setString(3, publisher);
				pstmt.setInt(4, count);
				pstmt.setInt(5, count - BorrowedCount);
				pstmt.setString(6, isbn);
				pstmt.executeUpdate();
				out.println("<script>alert('�����Ǿ����ϴ�.');location.href='BookModifyNDelete.jsp'</script>");
			}
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

