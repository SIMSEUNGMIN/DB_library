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

      // 아이디, 이메일 중복 검사
      String sql = "select id, email from user";
      pstmt = conn.prepareStatement(sql);
      rs = pstmt.executeQuery();
      boolean check = true;

      while (rs.next()) {
         String rId = rs.getString("id");
         String rEmail = rs.getString("email");
         if (id.equals(rId)) { // 아이디 중복
            out.println("<script>alert('아이디가 중복되었습니다.');location.href='signUpForm.jsp'</script>");
            check = false;
         }
         if (email.equals(rEmail)) { // 이메일 중복
            out.println("<script>alert('이메일이 중복되었습니다.');location.href='signUpForm.jsp'</script>");
            check = false;
         }
      }
      if (check) { // 회원가입 성공
         rs.close();
         pstmt.close();

         sql = "insert into user values(?, ?, ?, ?, ?, ?)";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         pstmt.setString(2, password);
         pstmt.setString(3, name);
         pstmt.setString(4, email);
         pstmt.setString(5, phoneNumber);
         if (position.equals("학부")) {
            position = "B";
         } else if (position.equals("대학원")) {
            position = "C";
         } else if(position.equals("교직원")){
            position = "D";
         }
         pstmt.setString(6, position);
         pstmt.executeUpdate();
         out.println("<script>alert('회원 가입되었습니다.');location.href='loginForm.jsp'</script>");
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
