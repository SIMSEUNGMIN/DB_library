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

		// 정보 불러오기
		String sql = "select * from user where id = ? and position = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, "A");
		rs = pstmt.executeQuery();

		if (rs.next()) {
			name = rs.getString("name");
			email = rs.getString("email");
			phoneNumber = rs.getString("phoneNumber");
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
<title>관리자 정보 수정 페이지</title>
<style>
.p {
	font-size: 10px;
}
</style>
</head>
<body>
	<h2>관리자 정보 수정</h2>

	<p class="p">아이디는 수정이 불가능 합니다.</p>
	<div style="line-height: 300%; font-size: 15px; font-weight: bold;">
		<form method="post" action="AdminInfoPro.jsp">
			아이디 : <input type="text" name="id" maxlength="10" readonly value=<%=id%> ><br /> 
			비밀번호 : <input type="password" name="password" maxlength="30" required><br /> 
			이름 : <input type="text" name="name" maxlength="10" required value=<%=name%>><br />
			이메일 주소 : <input type="email" name="email" maxlength="30" required value=<%=email%>><br /> 
			전화번호 : <input type="tel" name="phoneNumber" pattern="[0-9]{11}" placeholder="(-) 를 빼고 입력" required value=<%=phoneNumber%>><br />
			<input type="submit" value="확인" /> 
			<input type="button" onclick="location.href='AdministratorPage.jsp?id=<%=id%>'" value="취소" /><br />
			<input type="button" onclick="location.href='AdminDelete.jsp?id=<%=id%>'" value="탈퇴" />
		</form>
	</div>
</body>
</html>