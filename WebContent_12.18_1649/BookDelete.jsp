<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.*"%>

<% request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ����</title>
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
		
		//isbn�� ���� ���� ���� �� ����
		String findForBookQ = "select * from book where isbn = '" + isbn + "'";
		
		st = con.createStatement();
		
		ResultSet returnList = st.executeQuery(findForBookQ);
		
		int count = 0;
		int canBorrowCount = 0;
		
		while(returnList.next()){
			count = Integer.parseInt(returnList.getString("count"));
			canBorrowCount = Integer.parseInt(returnList.getString("canBorrowCount"));
		}
		
		//å �Ǽ��� ���� �� �ִ� å�� �Ǽ��� ���� �� ���� ���� ���̺��� ���� ����
		if(count == canBorrowCount){
			
			//book���� �� ����
			String deleteForBookQ = "delete from book where isbn = '" + isbn + "'";
			
			st = con.createStatement();
			
			st.executeUpdate(deleteForBookQ);
			
%>
			<script type="text/javascript">
			alert("���� �Ϸ�");
			</script>
<%		
		}
		else{
%>
			<script type="text/javascript">
			alert("�� å�� ���� ���̶� ������ �Ұ����մϴ�");
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