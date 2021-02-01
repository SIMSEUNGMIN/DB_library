<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

<%
   request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대출 목록 페이지</title>
<script>
   
</script>
<style>
table {
   border: "1";
   border-collapse: collapse;
}

table, td, th {
   border: 3px solid black;
   text-align: center;
}

td, th {
   padding: 8px;
}
</style>
</head>
<body>
   <%
      String id = request.getParameter("id");
   %>
   <button onclick="location='userForm.jsp?id=<%=id%>'">뒤로가기</button>
   <br />
   <table>
      <tr>
         <th>ISBN</th>
         <th>제목</th>
         <th>작가</th>
         <th>출판사</th>
         <th>예약일</th>
         <th>예상 대출 가능일</th>
         <th>예약 취소</th>
      </tr>
   
   <%
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      try {
         String jdbcUrl = "jdbc:mysql://localhost:3306/db_library";
         String dbId = "root";
         String dbPass = "qwerty";

         Class.forName("com.mysql.jdbc.Driver");
         conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
         String search = "select * from reservation where id =?";
         pstmt = conn.prepareStatement(search);
         pstmt.setString(1, id);
         rs = pstmt.executeQuery();
         while(rs.next()){
            String sql = "select rank from " + "(select id, @rownum := @rownum+1 rank from"
               + " ( select * from reservation where isbn = ? order by reserveDate ) b, (select @rownum:=0) r ) getRank where id=?";
            PreparedStatement getRankStmt = conn.prepareStatement(sql);
            getRankStmt.setString(1, rs.getString("isbn"));
            getRankStmt.setString(2, id);
            ResultSet rankSet = getRankStmt.executeQuery();
            rankSet.next();
            int rank = rankSet.getInt("rank");
            String sql2 = "select * from (select @rownum := @rownum+1 rank, b.returnDate, b.id, b.isbn from"+
                  "( select * from borrow where isbn =? and returnState='N' order by returnDate ) b, (select @rownum:=0) r) ra inner join book bo on ra.isbn=bo.isbn where ra.rank =?";
            PreparedStatement returnDateStmt = conn.prepareStatement(sql2);
            returnDateStmt.setString(1, rs.getString("isbn"));
            returnDateStmt.setInt(2, rank);
            ResultSet rd = returnDateStmt.executeQuery();
         
            if(rd.next()){
               String isbn = rd.getString("isbn");
               String title = rd.getString("title");
               String author = rd.getString("author");
               String publisher = rd.getString("publisher");
               java.sql.Date reserveDate = rs.getDate("reserveDate");
               java.sql.Date returnDate = rd.getDate("returnDate");
            %>
            <tr>
         <td><%=isbn%></td>
         <td><%=title%></td>
         <td><%=author%></td>
         <td><%=publisher%></td>
         <td><%=reserveDate.toString()%></td>
         <td><%=returnDate.toString()%></td>
         <td><button
               onclick="location='cancelReservation.jsp?id=<%=id%>&isbn=<%=isbn%>'">예약 취소</button></td>
         </tr>
            <% 
            }
         }
         
   %>
   </table>
   <%
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
</body>
</html>