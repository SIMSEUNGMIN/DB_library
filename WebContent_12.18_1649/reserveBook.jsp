<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("utf-8");
%>
<%
	//예약자
	String id = request.getParameter("id");
	String isbn = request.getParameter("isbn");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String position = "";
	String borrowId = "";

	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/db_library";
		String dbId = "root";
		String dbPass = "qwerty";
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		String sql = "select * from book natural join borrow natural join user where isbn=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, isbn);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			if (rs.getInt("canBorrowCount") == 0) {
				// 예상 대출 가능날짜 계산
				position = rs.getString("position");
				borrowId = rs.getString("id");
				String sql3 = "insert into reservation values (?,?,NOW())";
				PreparedStatement pstmt3 = conn.prepareStatement(sql3);
				pstmt3.setString(1, id);
				pstmt3.setString(2, isbn);
				pstmt3.executeUpdate();
				out.println(
						"<script>alert('예약 신청되었습니다.');location.href='findBookForm.jsp?id=" + id + "'</script>");
			} else {
				out.println(
						"<script>alert('예약 실패하였습니다.');location.href='findBookForm.jsp?id=" + id + "'</script>");
			}
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