<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("euc-kr");
%>

<%
	//�Ķ���� ���� ���� �κ�
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phoneNumber = request.getParameter("phoneNumber");

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

		// �̸��� �ߺ� �˻�
		String sql = "select email from user where not id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		boolean check = true;

		while (rs.next()) {
			if (rs.getString("email").equals(email)) {
				out.println("<script>alert('�̹� �����ϴ� �̸��� �Դϴ�.');location.href='AdminInfoForm.jsp?id=" + id
						+ "'</script>");
				check = false;
			}
		}

		// ����
		if (check) {
			rs.close();
			pstmt.close();

			sql = "update user set password = ?, name = ?, email = ?, phoneNumber = ? where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, password);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			pstmt.setString(4, phoneNumber);
			pstmt.setString(5, id);
			pstmt.executeUpdate();
			out.println("<script>alert('����Ǿ����ϴ�.');location.href='AdministratorPage.jsp?id=" + id + "'</script>");
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

