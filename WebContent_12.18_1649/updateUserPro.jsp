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

		// DB와 연동을 위한 Connection 객체를 얻어내는 부분
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

		// 이메일 중복 검사
		String sql = "select email from user where id != '" + id + "'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		boolean check = true;

		while (rs.next()) {
			if (rs.getString("email").equals(email)) {
				out.println("<script>alert('이미 존재하는 이메일 입니다.');location.href='updateUserForm.jsp?id=" + id
						+ "'</script>");
				check = false;
			}
		}

		// 수정
		if (check) {
			rs.close();
			pstmt.close();

			sql = "update user set password = ?, name = ?, email = ?, phoneNumber = ?, position = ? where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, password);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			pstmt.setString(4, phoneNumber);
			if (position.equals("학부")) {
				position = "B";
			} else if (position.equals("대학원")) {
				position = "C";
			} else {
				position = "D";
			}
			pstmt.setString(5, position);
			pstmt.setString(6, id);
			pstmt.executeUpdate();
			
			// 포지션에 따른 대출 날짜를 다시 설정 해야함
			String borrowForIdQ = "select count(*) from borrow where id = '" + id + "';";
			
			ResultSet resultB = pstmt.executeQuery(borrowForIdQ);
			
			// borrow에서 id에 대한 대출 내역 개수를 구함
			int bCount = 0;
			
			while(resultB.next()){
				bCount = Integer.parseInt(resultB.getString("count(*)"));
			}
			
			System.out.print("id = " + id + ", bCount = " + bCount + ", position = " + position);
			
			// 0개가 아닐 시에는 해당 포지션에 대한 대출 내역 변경
			// 변경시 원래 borrowDate에서 새 returnDate를 세팅해서 수정
			if(bCount != 0){
				String modifyReturnDQ = "";
				
				if(position.equals("B")){ //B일 경우에 10일 늘림
					modifyReturnDQ = "update borrow set returnDate = date_add(borrowDate, interval 10 day) where id = '" + id + "';";
				}
				else if(position.equals("C")){ // C일 경우에는 30일 늘림
					modifyReturnDQ = "update borrow set returnDate = date_add(borrowDate, interval 30 day) where id = '" + id + "';";
				}
				else{
					// D일 경우에는 60일 늘림
					modifyReturnDQ = "update borrow set returnDate = date_add(borrowDate, interval 60 day) where id = '" + id + "';";
				}
				pstmt.executeUpdate(modifyReturnDQ);
			}
			
			out.println("<script>alert('변경되었습니다.');location.href='userForm.jsp?id=" + id + "'</script>");
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

