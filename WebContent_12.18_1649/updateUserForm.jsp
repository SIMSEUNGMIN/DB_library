<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	String id = request.getParameter("id");
	String name = "";
	String email = "";
	String phoneNumber = "";
	String position = "";
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

		// ���� �ҷ�����
		String sql = "select * from user where id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();

		if (rs.next()) {
			name = rs.getString("name");
			email = rs.getString("email");
			phoneNumber = rs.getString("phoneNumber");
			if(rs.getString("position").equals("B")){
				position = "<option value='�к�' selected='selected'>�к�</option><option value='���п�'>���п�</option><option value='������'>������</option>";
			}else if(rs.getString("position").equals("C")){
				position = "<option value='�к�'>�к�</option><option value='���п�' selected='selected'>���п�</option><option value='������'>������</option>";
			}else{
				position = "<option value='�к�'>�к�</option><option value='���п�'>���п�</option><option value='������' selected='selected'>������</option>";
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
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ�� ���� ���� ������</title>
<style>
.p {
	font-size: 10px;
}
</style>
</head>
<body>
	<h2>ȸ�� ���� ����</h2>
	<p class="p">���̵�� ������ �Ұ��� �մϴ�.</p>

	<div style="line-height: 300%; font-size: 15px; font-weight: bold;">
		<form method="post" action="updateUserPro.jsp">
			���̵� : <input type="text" name="id" maxlength="10" readonly value=<%=id%>><br /> 
			��й�ȣ : <input type="password" name="password" maxlength="30" required> <br /> 
			�̸� : <input type="text" name="name" maxlength="10" required value=<%=name%>><br />
			�̸��� �ּ� : <input type="text" name="email" maxlength="30" required value=<%=email%>><br /> 
			��ȭ��ȣ : <input type="tel" name="phoneNumber" pattern="[0-9]{11}" required value=<%=phoneNumber%>><br />
			���� <select name="position" required><%=position%></select>
			<br /> <input type="submit" value="����" /> 
			<input type="button" onclick="location.href='userForm.jsp?id=<%=id%>'" value="���" /><br />
			<input type="button" onclick="location.href='withdrawUserForm.jsp?id=<%=id%>'" value="Ż��" />
		</form>
	</div>
</body>
</html>