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

		String sql = "select id, password, position from user where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();

		if (rs.next()) {
			String rId = rs.getString("id");
			String rPassword = rs.getString("password");
			if (id.equals(rId) && password.equals(rPassword)) { // 성공
				if (rs.getString("position").equals("A")) { // 관리자
					out.println("<script>location.href='AdministratorPage.jsp?id=" + id + "'</script>");
				} else { // 일반회원
					out.println("<script>location.href='userForm.jsp?id=" + id + "'</script>");
				}
			} else { // 패스워드가 일치하지 않는 경우 
				out.println("<script>alert('비밀번호가 일치하지 않습니다.');location.href='loginForm.jsp'</script>");
			}
		} else { // 존재하지 않는 아이디인 경우
			out.println("<script>alert('존재하지 않는 아이디 입니다.');location.href='loginForm.jsp'</script>");
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