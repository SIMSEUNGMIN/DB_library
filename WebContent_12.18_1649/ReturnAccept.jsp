<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
    
<% request.setCharacterEncoding("euc-kr"); %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>반납 승인 처리</title>
</head>
<body>

<%
	String id = request.getParameter("id");
	String isbn = request.getParameter("isbn");
	
	Connection con = null;
	Statement st = null;
	String jdbcUrl = "jdbc:mysql://localhost:3306/DB_Library";
	String dbId = "root";
	String dbPass = "qwerty";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		st = con.createStatement();
		
		//borrow 에서 값 변경, 반납 상태를 완료시킴
		String returnStateForBorrowQ = "update borrow set returnState = 'Y' " + 
			"where id = '" + id + "' and isbn = '" + isbn + "'";
		
		st.executeUpdate(returnStateForBorrowQ);
		
		//이때 예약자가 있는 책은 가장 빠른 예약자에게로 넘기고
		//예약자가 없는 책은 그냥 책 권수를 추가한다.
		
		//해당 isbn에 대한 예약자 수 확인
		String checkReservationNumQ = "select count(*) count from reservation" + "\n"
										+ "where isbn = '" + isbn + "';";
										
		ResultSet resultR = st.executeQuery(checkReservationNumQ);
		
		int reservationCount = 0;
										
		while(resultR.next()){
			reservationCount = Integer.parseInt(resultR.getString("count"));
		}
		
		if(reservationCount != 0){
			//reservation에서 가장 빠른 예약자를 찾는다.
			
			//예약자 아이디 찾음
			String nextReservationQ = "select id from reservation" + "\n"
										+ "where isbn = '" + isbn + "'" + "\n"
										+ "order by reserveDate limit 1;";
			
			ResultSet nextRId = st.executeQuery(nextReservationQ);
			
			String idString = "";
											
			while(nextRId.next()){
				idString = nextRId.getString("id");
			}
			
			//예약자 아이디를 찾았으면 예약 테이블에서 그부분의 행을 삭제 (isbn && id)
			String deleteReservationQ = "delete from reservation" + "\n"
										+ "where isbn = '" + isbn + "' and id = '" + idString + "';";
										

			st.executeUpdate(deleteReservationQ);
			
			//현재 예약자 아이디에 대한 포지션을 찾음, 포지션마다 다른 반납날짜를 부여할 것이기 때문
			String checkPositionQ = "select position from user where id = '" + idString + "';";
			
			ResultSet positionSet = st.executeQuery(checkPositionQ);
			
			String position = "";
			
			while(positionSet.next()){
				position = positionSet.getString("position");
			}
			
			System.out.println(position);
			
			String addBorrowQ = "";
			
			//포지션을 찾았으면 포지션에 따른 대출 테이블에 현재 책에 대한 대출행 추가
			// B일 경우 10일, C일 경우 30일, D일 경우 60일
			if(position.equals("B")){
				addBorrowQ = "insert into borrow values ('" + idString + "', '" + isbn + "', now(), DATE_ADD(now(),interval 10 day), 'N', 'N');"; 
			}
			else if(position.equals("C")){
				addBorrowQ = "insert into borrow values ('" + idString + "', '" + isbn + "', now(), DATE_ADD(now(),interval 30 day), 'N', 'N');"; 
			}
			else{
				addBorrowQ = "insert into borrow values ('" + idString + "', '" + isbn + "', now(), DATE_ADD(now(),interval 60 day), 'N', 'N');"; 
			}
			
			st = con.createStatement();
			st.executeUpdate(addBorrowQ);	
		}
		else{
			//book 에서 값 변경
			String canBorrowForBookQ = "update book set canBorrowCount = canBorrowCount + 1" +  
					" where isbn = '" + isbn + "'";
		
			st.executeUpdate(canBorrowForBookQ);
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>

<script type="text/javascript">
	alert("반납 승인 완료");
	location.href = "ReturnRequestList.jsp";	
</script>

</body>
</html>