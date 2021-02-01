<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.*"%>

<% request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>도서 삭제</title>
</head>
<body>

<%
	String isbn = request.getParameter("isbn");

	Connection con = null;
	Statement st = null;
	String jdbcUrl = "jdbc:mysql://localhost:3306/DB_Library";
	String dbId = "root";
	String dbPass = "qwerty";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		//isbn과 같은 값을 가진 행 추출
		String findForBookQ = "select * from book where isbn = '" + isbn + "'";
		
		st = con.createStatement();
		
		ResultSet returnList = st.executeQuery(findForBookQ);
		
		int count = 0;
		int canBorrowCount = 0;
		
		while(returnList.next()){
			count = Integer.parseInt(returnList.getString("count"));
			canBorrowCount = Integer.parseInt(returnList.getString("canBorrowCount"));
		}
		
		//책 권수와 빌릴 수 있는 책의 권수만 같을 수 있을 때만 테이블에서 삭제 가능
		if(count == canBorrowCount){
			
			//book에서 값 삭제
			String deleteForBookQ = "delete from book where isbn = '" + isbn + "'";
			
			st = con.createStatement();
			
			st.executeUpdate(deleteForBookQ);
			
%>
			<script type="text/javascript">
			alert("삭제 완료");
			</script>
<%		
		}
		else{
%>
			<script type="text/javascript">
			alert("이 책은 대출 중이라 삭제가 불가능합니다");
			</script>
<%		
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>


<script type="text/javascript">
	location.href = "BookModifyNDelete.jsp";	
</script>

</body>
</html>