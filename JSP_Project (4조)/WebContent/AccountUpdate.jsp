<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.Uground{
width:1400px;
height:720px;
background-color: orange;
}
.Uing{
width:1390px;
height:710px;
background-color: white;
}
.Up1{
background-color: orange;
}
.Up2{
background-color: #EBEBEB;
}
.Myname{
width:600px;
height:300px;
}
</style>
<title>회원정보 수정</title>
</head>
<body>
<script>  // 전화번호 입력시 '-' 가 자동으로 입력되는 스크립트 코드
function oninputPhone(target) {
    target.value = target.value
        .replace(/[^0-9]/g, '')
        .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3");
}
</script>
	<form action = "AccountUpdateProcess.jsp" method = "post">
	<center>
	<table border="0" class="Uground">
	<td><center>
	<table border="0" class="Uing">
	
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
	<h2 style="color:orange">정보 수정</h2>
	<h4>
	<table border="0" class="Myname">
		<tr><td class="Up1"><center>아이디</center></td> <td class="Up2"><center><input type = "text" name = "user_id" /></center></td></tr>
		<tr><td class="Up1"><center>패스워드</center></td> <td class="Up2"><center><input type = "password" name = "user_pass" /></center></td></tr>
		<tr><td class="Up1"><center>이름</center></td> <td class="Up2"><center><input type = "text" name = "user_name" /></center></td></tr>
		<tr><td class="Up1"><center>성별</center></td>
		<td class="Up2"><center>
		<input type='radio' name='user_gender' value='남성' />남성
		<input type='radio' name='user_gender' value='여성' />여성
		</center></td></tr>
		<tr><td class="Up1"><center>전화번호</center></td>
		<td class="Up2"><center><input type="text" class="form-control" oninput="oninputPhone(this)" name="user_tel" maxlength="13"></center></td>
		</tr>
		<tr>
		<td><center><a href="MyPage.jsp">뒤로가기</a></center></td>
		<td><center><input type = "submit" value = "회원정보 수정" ></center></td></tr>
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