<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table width="800" border="1">
		<tr>
			<td>사원번호</td>
			<td>사원명</td>
			<td>직급</td>
			<td>상관번호</td>
			<td>입사일자</td>
			<td>급여</td>
			<td>커미션</td>
			<td>부서번호</td>
		</tr>
	<%!
		Connection conn=null;
		DataSource ds = null;
		Statement stmt = null;
		ResultSet rs = null;
	%>
	<%
		try{
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
			conn = ds.getConnection();
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select * from emp");
			while (rs.next()) {
				%>
				<tr>
					<td><%= rs.getInt("empno") %></td>
					<td><%= rs.getString("ename") %></td>
					<td><%= rs.getString("job") %></td>
					<td><%= rs.getInt("mgr") %></td>
					<td><%= rs.getDate("hiredate") %></td>
					<td><%= rs.getInt("sal") %></td>
					<td><%= rs.getInt("comm") %></td>
					<td><%= rs.getInt("deptno") %></td>
				</tr>
				<%
			}
		}catch(NamingException ne){
			ne.printStackTrace();
		}finally{
			try{
				if(conn != null)conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
</body>
</html>