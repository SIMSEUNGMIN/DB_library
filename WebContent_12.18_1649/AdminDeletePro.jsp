<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("euc-kr");
%>

<%
	//파라미터 값을 얻어내는 부분
	String id = request.getParameter("id");
	String password = request.getParameter("password");

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

		String sql = "select password from user where id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();

		if (rs.next()) {
			String rPassword = rs.getString("password");
			if (password.equals(rPassword)) { // 성공
				rs.close();
				pstmt.close();
				sql = "delete from user where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
				out.println("<script>alert('탈퇴되었습니다.');location.href='loginForm.jsp'</script>");
			} else { // 패스워드가 일치하지 않는 경우 
				out.println("<script>alert('비밀번호가 일치하지 않습니다.');location.href='AdministratorPage.jsp?id=" + id
						+ "'</script>");
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