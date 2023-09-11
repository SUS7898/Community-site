<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.Dground{
width:1400px;
height:720px;
background-color: orange;
}
.Ding{
width:1390px;
height:710px;
background-color: white;
}
.Dp1{
background-color: orange;
}
.Dp2{
background-color: #EBEBEB;
}
.DMyname{
width:600px;
height:300px;
}
</style>
<title>회원 탈퇴</title>
</head>
<body>
	<form action = "AccountDeleteProcess.jsp" method = "post">
	<center>
	<table border="0" class="Dground">
	<td><center>
	<table border="0" class="Ding">
	
	<tr>
	<td><center><img src="img/0000.jpg" style="width:270px; height:100px;"></center></td>
	<td><center>
	<img src="img/1111.jpg" style="width:270px; height:100px;">
	<img src="img/9999.jpg" style="width:270px; height:100px;">
	<img src="img/2222.jpg" style="width:270px; height:100px;">
	</center></td>
	<td><center><img src="img/8888.jpg" style="width:270px; height:100px;"></center></td>
	</tr>
	
	<tr>
	<td><center><img src="img/BW2.jpg" style="width: 160px; height:450px;"></center></td>
	<td><center>
	<h2 style="color:orange">탈퇴</h2>
	<h4>
	<table border="0" class="DMyname">
		<tr><td class="Dp1"><center>아이디</center></td> <td class="Dp2"><center><input type = "text" name = "user_id" /></center></td></tr>
		<tr><td class="Dp1"><center>패스워드</center></td> <td class="Dp2"><center><input type = "password" name = "user_pass" /></center></td></tr>
		<tr>
		<td><center><a href="MyPage.jsp">뒤로가기</a></center></td>
		<td><center><input type = "submit" value = "탈퇴" ></center></td></tr>
	</table>
	</h4>
	</center></td>
	<td><center><img src="img/BW1.jpg" style="width: 160px; height:450px;"></center></td>
	<tr>
	
	<tr>
	<td><center><img src="img/3333.jpg" style="width:270px; height:100px;"></center></td>
	<td><center>
	<img src="img/7777.jpg" style="width:270px; height:100px;">
	<img src="img/4444.jpg" style="width:270px; height:100px;">
	<img src="img/6666.jpg" style="width:270px; height:100px;">
	</center></td>
	<td><center><img src="img/5555.jpg" style="width:270px; height:100px;"></center></td>
	</tr>
	
	</table>
	</center></td>
	</table>
	</center>
	</form>
</body>
</html>