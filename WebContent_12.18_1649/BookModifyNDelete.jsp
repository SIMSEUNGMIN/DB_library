<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import = "java.sql.*" %>
    
<% request.setCharacterEncoding("euc-kr"); %>

<%
	String id = request.getParameter("id");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ����/����</title>
</head>
<body>
	<h2>���� ���</h2>
	<table width = "100%" border = "0" style = "text-align:center;">
	<tr>
		<td>���� ISBN</td>
		<td>���� ����</td>
		<td>���� ����</td>
		<td>���� ���ǻ�</td>
		<td>���� �Ǽ�</td>
		<td>���� �뿩 ���� �Ǽ�</td>
		<td>����</td>
		<td>����</td>
	</tr>
		
	<%
	
	Connection conn = null;

	try{
		
		String jdbcUrl = "jdbc:mysql://localhost:3306/db_Library";
		String dbId = "root";
		String dbPass = "qwerty";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		//������, ���̺��� �����͸� �ҷ���
		String returnRequestQ = "select * from book";
		
		//�ڹ� statement ����
		Statement st = conn.createStatement();
		
		// ���� ����, ��ü ����
		ResultSet returnRList = st.executeQuery(returnRequestQ);
		
		
		while(returnRList.next()){
			String isbn = returnRList.getString("isbn");
			String title = returnRList.getString("title");
			String author = returnRList.getString("author");
			String publisher = returnRList.getString("publisher");
			String count = returnRList.getString("count");
			String canBorrowCount = returnRList.getString("canBorrowCount");
					
	%>
			<tr>
				<td><%= isbn %></td>
				<td><%= title %></td>
				<td><%= author %></td>
				<td><%= publisher %></td>
				<td><%= count %></td>
				<td><%= canBorrowCount %></td>
				<!-- ǥ �� �ȿ��� ��ư �����-->
				<td><button onclick="location='BookModify.jsp?isbn=<%= isbn%>'">����</button></td>
				<td><button onclick="location='BookDelete.jsp?isbn=<%= isbn%>'">����</button></td>
			</tr>
	<%	
		}
		
		st.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	%>
	
	</table>
	
	<hr />
	
	<button onclick ="location='AdministratorPage.jsp?id=<%=id%>'" style="float:right;">�ڷΰ���</button>
</body>
</html>