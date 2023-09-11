<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.Wground{
width:1400px;
height:720px;
background-color: orange;
}
.Win{
width:900px;
height:300px;
background-color:orange;
}
.WinB{
width:1390px;
height:710px;
background-color: white;
}
.Wtext{
width: 750px;
height: 400px;
}
.Wside{
width: 190px;
height:520px;
}
.Winin{
width:900px;
height:310px;

}
</style>
<title>글쓰기</title>
</head>
<script type="text/javascript">
</script>
<body>
<center>
<table border=0 class="Wground"><td>
	<center>
	<table border=0 class="WinB">
	<tr>
	<td><center><img src="img/only.jpg" style="width: 200px; height:70px;"></center></td>
	<td style="height:100px"><h1 style="color:orange; font-size : 37px;"><center>게시글 작성</center></h1></td>
	<td></td>
	</tr>
	<tr>
	<td style="width:200px"><center>
	<img src="img/BW2.jpg" style="width: 190px; height:510px;">
	</center></td>
	<td><center>
	<form name="WrteFrm" enctype="multipart/form-data" method="post" action="BoardWriteProcess.jsp"onsubmit="return validateForm(this);"
		onsubmit="return validateForm(this);">
		<table border="0" class="Win">
			<tr>
			<td><center><table border=0 class="Winin">
				<td style="background-color:white;"><center>제목</center></td>
				<td style="height:40px; background-color:white;"><center>
				<input type="text" name="title" size = 100 "></center></td>
			</tr>
			<tr>
				<td style="background-color:white;"><center>내용</center></td>
				<td style="background-color:white;"><center>
				<textarea name="content" class="Wtext"></textarea>
				</center></td>
			</tr>
			<tr>
				<td style="background-color:white;"><center>분류</center></td>
				<td style="background-color:white;"><center>
				<input type="radio" name="category" value="하의" />하의
				<input type="radio" name="category" value="상의" />상의
				<input type="radio" name="category" value="장신구" />장신구</center></td>
			</tr>
				<tr>
  <td colspan="2" style="background-color:white;">
    <center>
      <input type="file" name="fileName">
    </center>
  </td>
</tr>
                <tr>
			<tr>
				<td colspan="2" align="" style="background-color:white;">
				
					<center><button type="submit">작성 완료</button>
					<button type="reset">다시 입력</button>
					<button type="button" onclick="location.href='MainPage.jsp'">목록보기</button></center>
					</table></center>
				</td>
			</tr>
		</table>
	</form>
	</center>
	</td>
	<td style="width:200px"><center><img src="img/BW1.jpg" style="width: 190px; height:510px;"></center></td>
	</tr>
	<td></td>
	<td style="height:50px"><center><h4 style="color:red;">부적절한 게시물은 관리자에 의거하여 삭제처리 될 수 있습니다.</h4></center></td>
	<td></td>
	</table>
	</center>
	</td>
	</table>
	</center>
</body>
</html>