<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<% request.setCharacterEncoding("euc-kr"); %>

<%
	String aid = request.getParameter("id");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�ݳ� ��û ���</title>
</head>
<body>
	<h2>�ݳ� ��û ���</h2>
	
	<table width = "100%" border = "0" style = "text-align:center;">
	<tr>
		<td>ȸ�� ���̵�</td>
		<td>���� ISBN</td>
		<td>���� ����</td>
		<td>�ݳ� ��û ����</td>
	</tr>
	
	<%
	
	Connection conn = null;

	try{
		
		String jdbcUrl = "jdbc:mysql://localhost:3306/DB_Library";
		String dbId = "root";
		String dbPass = "qwerty";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		//������, ���̺��� �����͸� �ҷ���
		String returnRequestQ = "select * from borrow where returnRequest = 'Y' and returnState = 'N'";
		
		//�ڹ� statement ����
		Statement st = conn.createStatement();
		
		// ���� ����, ��ü ����
		ResultSet returnRList = st.executeQuery(returnRequestQ);
		
		
		while(returnRList.next()){
			String id = returnRList.getString("id");
			String isbn = returnRList.getString("isbn");
			String borrowDate = returnRList.getString("borrowDate");
					
	%>
			<tr>
				<td><%= id %></td>
				<td><%= isbn %></td>
				<td><%= borrowDate%></td>
				<!-- ǥ �� �ȿ��� ��ư �����-->
				<td><button onclick="location='ReturnAccept.jsp?id=<%= id%>&isbn=<%= isbn%>'">����</button></td>
			</tr>
	<%	
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	%>
	
	</table>
	
	<hr />
	
	<button onclick ="location='AdministratorPage.jsp?id=<%= aid%>'" style="float:right;">���ư���</button>
</body>
</html>