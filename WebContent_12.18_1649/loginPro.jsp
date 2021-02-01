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

		String sql = "select id, password, position from user where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();

		if (rs.next()) {
			String rId = rs.getString("id");
			String rPassword = rs.getString("password");
			if (id.equals(rId) && password.equals(rPassword)) { // ����
				if (rs.getString("position").equals("A")) { // ������
					out.println("<script>location.href='AdministratorPage.jsp?id=" + id + "'</script>");
				} else { // �Ϲ�ȸ��
					out.println("<script>location.href='userForm.jsp?id=" + id + "'</script>");
				}
			} else { // �н����尡 ��ġ���� �ʴ� ��� 
				out.println("<script>alert('��й�ȣ�� ��ġ���� �ʽ��ϴ�.');location.href='loginForm.jsp'</script>");
			}
		} else { // �������� �ʴ� ���̵��� ���
			out.println("<script>alert('�������� �ʴ� ���̵� �Դϴ�.');location.href='loginForm.jsp'</script>");
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