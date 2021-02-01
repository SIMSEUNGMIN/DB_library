<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
    
<% request.setCharacterEncoding("euc-kr"); %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�ݳ� ���� ó��</title>
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
		
		//borrow ���� �� ����, �ݳ� ���¸� �Ϸ��Ŵ
		String returnStateForBorrowQ = "update borrow set returnState = 'Y' " + 
			"where id = '" + id + "' and isbn = '" + isbn + "'";
		
		st.executeUpdate(returnStateForBorrowQ);
		
		//�̶� �����ڰ� �ִ� å�� ���� ���� �����ڿ��Է� �ѱ��
		//�����ڰ� ���� å�� �׳� å �Ǽ��� �߰��Ѵ�.
		
		//�ش� isbn�� ���� ������ �� Ȯ��
		String checkReservationNumQ = "select count(*) count from reservation" + "\n"
										+ "where isbn = '" + isbn + "';";
										
		ResultSet resultR = st.executeQuery(checkReservationNumQ);
		
		int reservationCount = 0;
										
		while(resultR.next()){
			reservationCount = Integer.parseInt(resultR.getString("count"));
		}
		
		if(reservationCount != 0){
			//reservation���� ���� ���� �����ڸ� ã�´�.
			
			//������ ���̵� ã��
			String nextReservationQ = "select id from reservation" + "\n"
										+ "where isbn = '" + isbn + "'" + "\n"
										+ "order by reserveDate limit 1;";
			
			ResultSet nextRId = st.executeQuery(nextReservationQ);
			
			String idString = "";
											
			while(nextRId.next()){
				idString = nextRId.getString("id");
			}
			
			//������ ���̵� ã������ ���� ���̺��� �׺κ��� ���� ���� (isbn && id)
			String deleteReservationQ = "delete from reservation" + "\n"
										+ "where isbn = '" + isbn + "' and id = '" + idString + "';";
										

			st.executeUpdate(deleteReservationQ);
			
			//���� ������ ���̵� ���� �������� ã��, �����Ǹ��� �ٸ� �ݳ���¥�� �ο��� ���̱� ����
			String checkPositionQ = "select position from user where id = '" + idString + "';";
			
			ResultSet positionSet = st.executeQuery(checkPositionQ);
			
			String position = "";
			
			while(positionSet.next()){
				position = positionSet.getString("position");
			}
			
			System.out.println(position);
			
			String addBorrowQ = "";
			
			//�������� ã������ �����ǿ� ���� ���� ���̺� ���� å�� ���� ������ �߰�
			// B�� ��� 10��, C�� ��� 30��, D�� ��� 60��
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
			//book ���� �� ����
			String canBorrowForBookQ = "update book set canBorrowCount = canBorrowCount + 1" +  
					" where isbn = '" + isbn + "'";
		
			st.executeUpdate(canBorrowForBookQ);
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>

<script type="text/javascript">
	alert("�ݳ� ���� �Ϸ�");
	location.href = "ReturnRequestList.jsp";	
</script>

</body>
</html>