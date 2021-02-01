<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	String id = request.getParameter("id");
	String isbn = request.getParameter("isbn");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/db_library";
		String dbId = "root";
		String dbPass = "qwerty";
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		String sql = "update borrow set returnRequest = 'Y' where isbn = ? and id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, isbn);
		pstmt.setString(2, id);
		pstmt.executeUpdate();
		out.println("<script>alert('반납신청 되었습니다.');location.href='BorrowList.jsp?id=" + id + "'</script>");
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