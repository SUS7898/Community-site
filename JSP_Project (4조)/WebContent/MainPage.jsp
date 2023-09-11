<%@ page import="java.sql.*"%>
<%@ page import="Common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	body {
	background-color : white;
	color : black;
	}
	a {
	color : black;
	}
	.login1 {
	width : 200px;
	height : 235px;
	background-color : white;
	color : black;
	}
	.home {
	width : 1400px;
	background-color : orange;
	}
	.logo1{
	width : 380px;
	height : 235px;
	background-color : white;
	color:silver;
	}
	.Only{
	font-size : 40px;
	color : orange;
	}
	.Only:hover{
	font-size : 50px;
	color : gold;
	}
	.uid{
	background-color : silver;
	color : black;
	}
	.upw{
	background-color : silver;
	color : black;
	}
	.ub1{
	background-color : orange;
	color : black;
	}
	.ub1:hover{
	font-size : 20px;
	background-color : gold;
	}
	.ub2{
	background-color : orange;
	color : black;
	}
	.ub2:hover{
	font-size : 20px;
	background-color : gold;
	}
	.ub3:hover{
	font-size : 20px;
	color : yellow;
	}
	.ub4:hover{
	font-size : 20px;
	color : yellow;
	}
</style>
<title>메인 페이지</title>
</head>
<body>
	<%
	JDBConnect jdbc = new JDBConnect();

	String query = "SELECT * FROM usermember";

	Statement stmt = jdbc.con.createStatement();
	ResultSet rs = stmt.executeQuery(query);

	String loggedInUserId = (String) session.getAttribute("UserId");
	String userName = "";

	while (rs.next()) {
		if (rs.getString("id").equals(loggedInUserId)) {
			userName = rs.getString("name");
			break;
		}
	}
	
	if (session.getAttribute("UserId") == null) {
	%>
	<center>
	<table border=0 class="home">
	<td><table border=0 class="logo1"><td><center><h1 class="Only">Only!패션</h1><br>
	<h3>로그인 후 글쓰기가 가능합니다.</h3></center></td></table></td>
	<td><table border=0><td><center><img src="img/only.jpg"></center></td></table></td>
	<td>
	<table border=0 class="login1"><td>
	<form action="LoginProcess.jsp" method="post">
		<center>아이디 : <input type="text" name="user_id" class="uid"/></center><br>
		<center>패스워드 : <input type="password" name="user_pass" class="upw"/></center><br>
	<center><input type="submit" value="로그인" class="ub1"></center><br>
	</form><form action="AccountCreate.jsp">
	<center><input type="submit" value="회원가입" class="ub2"></center>
	</form>
	</td>
	</table>
	</td>
	<%
	} else {
	%>
	<center>
	<table border=0 class="home">
	<td><table border=0 class="logo1"><td><center><h1 class="Only">Only!패션</h1><br>
	<h3><%=userName%> 회원님 환영합니다.</h3></center></td></table></td>
	<td><table border=0><td><center><img src="img/only.jpg"></center></td></table></td>
	<td>
	<table border=0 class="login1"><td>
	<center><%=userName%></center>
	<center><a href='MyPage.jsp'><h4 class = "ub3">마이 페이지</h4></a></center>
	<center><a href="Logout.jsp"><h4 class = "ub4">로그아웃</h4></a></center>
	</table>
	</td>
	<%
	}
	%>
	<tr><td>
	</table></center>
	
	<%@ include file="BoardList.jsp"%>
</body>
</html>