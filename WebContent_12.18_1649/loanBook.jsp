<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%
   request.setCharacterEncoding("utf-8");
%>
<%
   String id = request.getParameter("id");
   String isbn = request.getParameter("isbn");
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   String str = "";
   try {
      String jdbcUrl = "jdbc:mysql://localhost:3306/db_library";
      String dbId = "root";
      String dbPass = "qwerty";
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
      String sql = "select canBorrowCount from book where isbn=?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, isbn);
      rs = pstmt.executeQuery();
      if (rs.next()) {
         if (rs.getInt("canBorrowCount") > 0) {
            String sql1 = "select case when u.position='B' then 10 when u.position = 'C' then 30 else 60 end borrowDay from user u where u.id=?";
            PreparedStatement pstmt1 = conn.prepareStatement(sql1);
            pstmt1.setString(1, id);
            ResultSet rs1 = pstmt1.executeQuery();
            rs1.next();
            int day = rs1.getInt("borrowDay");
            
            String sql2 = "update book set canBorrowCount=? where isbn=?";
            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            pstmt2.setInt(1, rs.getInt("canBorrowCount") - 1);
            pstmt2.setString(2, isbn);
            pstmt2.executeUpdate();
            
            String sql3 = "insert into borrow values(?,?,?,DATE_ADD(?,interval ? day),'N','N')";
            PreparedStatement pstmt3 = conn.prepareStatement(sql3);
            Timestamp tp = new Timestamp(System.currentTimeMillis());
            pstmt3.setString(1, id);
            pstmt3.setTimestamp(3, tp);
            pstmt3.setString(2, isbn);
            pstmt3.setTimestamp(4, tp);
            pstmt3.setInt(5, day);
            
            pstmt3.executeUpdate();
            
            out.println(
                  "<script>alert('대출신청 되었습니다.');location.href='findBookForm.jsp?id=" + id + "'</script>");
         } else {
            out.println(
                  "<script>alert('대출실패 하였습니다.');location.href='findBookForm.jsp?id=" + id + "'</script>");
         }
      } else {
         out.println("<script>alert('대출실패 하였습니다.');location.href='findBookForm.jsp?id=" + id + "'</script>");
      }
      out.println(str);
   } catch (Exception e) {
      e.printStackTrace();
   } finally {
      if (rs != null)
         try {
            rs.close();
         } catch (SQLException sqle) {
         }
      if (pstmt != null)
         try {
            pstmt.close();
         } catch (SQLException sqle) {
         }
      if (conn != null)
         try {
            conn.close();
         } catch (SQLException sqle) {
         }
   }
%>