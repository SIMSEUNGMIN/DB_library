<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import = "java.sql.*" %>
    
<% request.setCharacterEncoding("euc-kr"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>도서 대출 순위 결과</title>
</head>
<body>
	<h2>도서 대출 순위 목록 TOP10</h2>
	<table width = "100%" border = "0" style = "text-align:center;">
	<tr>
		<td>순서</td>
		<td>순위</td>
		<td>id</td>
		<td>빌린 권수</td>
	</tr>
	
	<%
	
	String start = request.getParameter("startDate");
	String end = request.getParameter("endDate");
	
	Connection conn = null;

	try{
		
		String jdbcUrl = "jdbc:mysql://localhost:3306/db_Library";
		String dbId = "root";
		String dbPass = "qwerty";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		//쿼리문, 테이블의 데이터를 불러옴
		String borrowBookListQ = "select id, count(*) from borrow" + "\n"
							+ "where borrowDate between '" + start + " 00:00:00' and '" + end + " 23:59:59'" + "\n"
							+ "group by id" + "\n"
							+ "order by count(*) desc";
		
		//자바 statement 생성
		Statement st = conn.createStatement();
		
		// 쿼리 실행, 객체 생성
		ResultSet returnRList = st.executeQuery(borrowBookListQ);
		
		int preBookNum = 0;
		int count = 1;
		int realRank = 0;
		int preRank = 1;
		int sameRankNum = 1;
		
		while(returnRList.next() && (count <= 10)){
			String id = returnRList.getString("id");
			int curBookNum = Integer.parseInt(returnRList.getString("count(*)"));
			
			if(preBookNum == curBookNum){ //같을 경우
				sameRankNum++;
			}
			else{
				realRank += sameRankNum;
				sameRankNum = 1;
			}
					
	%>
			<tr>
				<td><%= count %></td>
				<td><%= realRank %></td>
				<td><%= id %></td>
				<td><%= curBookNum %></td>
			</tr>
	<%	
	
			preBookNum = curBookNum;		
			count++;
		}
		
		st.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	%>
	
	</table>
	
	<hr />
	
	<button onclick ="location='BorrowBookList.jsp'" style="float:right;">뒤로가기</button>
</body>
</html>