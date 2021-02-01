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
	String position = request.getParameter("position");

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
		String sql = "select email from user where id != '" + id + "'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		boolean check = true;

		while (rs.next()) {
			if (rs.getString("email").equals(email)) {
				out.println("<script>alert('�̹� �����ϴ� �̸��� �Դϴ�.');location.href='updateUserForm.jsp?id=" + id
						+ "'</script>");
				check = false;
			}
		}

		// ����
		if (check) {
			rs.close();
			pstmt.close();

			sql = "update user set password = ?, name = ?, email = ?, phoneNumber = ?, position = ? where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, password);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			pstmt.setString(4, phoneNumber);
			if (position.equals("�к�")) {
				position = "B";
			} else if (position.equals("���п�")) {
				position = "C";
			} else {
				position = "D";
			}
			pstmt.setString(5, position);
			pstmt.setString(6, id);
			pstmt.executeUpdate();
			
			// �����ǿ� ���� ���� ��¥�� �ٽ� ���� �ؾ���
			String borrowForIdQ = "select count(*) from borrow where id = '" + id + "';";
			
			ResultSet resultB = pstmt.executeQuery(borrowForIdQ);
			
			// borrow���� id�� ���� ���� ���� ������ ����
			int bCount = 0;
			
			while(resultB.next()){
				bCount = Integer.parseInt(resultB.getString("count(*)"));
			}
			
			System.out.print("id = " + id + ", bCount = " + bCount + ", position = " + position);
			
			// 0���� �ƴ� �ÿ��� �ش� �����ǿ� ���� ���� ���� ����
			// ����� ���� borrowDate���� �� returnDate�� �����ؼ� ����
			if(bCount != 0){
				String modifyReturnDQ = "";
				
				if(position.equals("B")){ //B�� ��쿡 10�� �ø�
					modifyReturnDQ = "update borrow set returnDate = date_add(borrowDate, interval 10 day) where id = '" + id + "';";
				}
				else if(position.equals("C")){ // C�� ��쿡�� 30�� �ø�
					modifyReturnDQ = "update borrow set returnDate = date_add(borrowDate, interval 30 day) where id = '" + id + "';";
				}
				else{
					// D�� ��쿡�� 60�� �ø�
					modifyReturnDQ = "update borrow set returnDate = date_add(borrowDate, interval 60 day) where id = '" + id + "';";
				}
				pstmt.executeUpdate(modifyReturnDQ);
			}
			
			out.println("<script>alert('����Ǿ����ϴ�.');location.href='userForm.jsp?id=" + id + "'</script>");
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

