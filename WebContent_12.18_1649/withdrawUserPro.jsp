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

		String sql = "select password from user where id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		boolean check = false;

		if (rs.next()) {
			String rPassword = rs.getString("password");
			if (password.equals(rPassword)) { // ����
				check = true;
			} else { // �н����尡 ��ġ���� �ʴ� ��� 
				out.println("<script>alert('��й�ȣ�� ��ġ���� �ʽ��ϴ�.');location.href='userForm.jsp?id=" + id
						+ "'</script>");
			}
		}

		if (check) {
			rs.close();
			pstmt.close();

			sql = "select returnState from borrow where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (rs.getString("returnState").equals("N")) { // �ݳ� �ȵ� å �ִ� ���
					check = false;
				}
			}

			if (check) {
				sql = "delete from user where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
				out.println("<script>alert('Ż��Ǿ����ϴ�.');location.href='loginForm.jsp'</script>");
			} else {
				out.println(
						"<script>alert('���� �� �ݳ��� �Ϸ���� ���� å�� �ֽ��ϴ�. Ż���� �� �����ϴ�.');location.href='userForm.jsp?id="
								+ id + "'</script>");
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