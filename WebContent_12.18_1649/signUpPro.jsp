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

      // ���̵�, �̸��� �ߺ� �˻�
      String sql = "select id, email from user";
      pstmt = conn.prepareStatement(sql);
      rs = pstmt.executeQuery();
      boolean check = true;

      while (rs.next()) {
         String rId = rs.getString("id");
         String rEmail = rs.getString("email");
         if (id.equals(rId)) { // ���̵� �ߺ�
            out.println("<script>alert('���̵� �ߺ��Ǿ����ϴ�.');location.href='signUpForm.jsp'</script>");
            check = false;
         }
         if (email.equals(rEmail)) { // �̸��� �ߺ�
            out.println("<script>alert('�̸����� �ߺ��Ǿ����ϴ�.');location.href='signUpForm.jsp'</script>");
            check = false;
         }
      }
      if (check) { // ȸ������ ����
         rs.close();
         pstmt.close();

         sql = "insert into user values(?, ?, ?, ?, ?, ?)";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         pstmt.setString(2, password);
         pstmt.setString(3, name);
         pstmt.setString(4, email);
         pstmt.setString(5, phoneNumber);
         if (position.equals("�к�")) {
            position = "B";
         } else if (position.equals("���п�")) {
            position = "C";
         } else if(position.equals("������")){
            position = "D";
         }
         pstmt.setString(6, position);
         pstmt.executeUpdate();
         out.println("<script>alert('ȸ�� ���ԵǾ����ϴ�.');location.href='loginForm.jsp'</script>");
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
