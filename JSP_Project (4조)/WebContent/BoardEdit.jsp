<%@ page import="CafeBoard.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 로그인여부 체크 IsLoggedIn.jsp -->
<%@ include file="IsLoggedIn.jsp"%>
<%
// 상세보기페이지(View.jsp)로 부터 얻은 일련번호(num)에 해당하는 게시물 조회하기 -BoardDTO
// 작성자 본인인지 확인- 본인 아닐시, 이전 페이지로 이동
String num = request.getParameter("num");

CafeBoardDAO dao = new CafeBoardDAO(application);
CafeBoardDTO dto = dao.selectView(num);

String userId = (String) session.getAttribute("UserId"); // 로그인한 유저 id 받아오기
boolean isAdmin = (userId != null && userId.equals("admin")); // 관리자인지 확인

if (!session.getAttribute("UserId").toString().equals(dto.getId())) {
	if (!isAdmin || userId.equals(dto.getId())) {
		JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
	}
}
// DB 연결 해제
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.Eground{
width:1400px;
height:720px;
background-color: orange;
}
.Ein{
width:900px;
height:300px;
background-color:orange;
}
.EinB{
width:1390px;
height:710px;
background-color: white;
}
.Etext{
width: 750px;
height: 400px;
}
.Eside{
width: 190px;
height:520px;
}
.Einin{
width:900px;
height:310px;

}
</style>
<title>회원제 게시판</title>
</head>
<body>
<center>
<table border=0 class="Eground"><td>
	<center>
	<table border=0 class="EinB">

	<tr>
	<td><center><img src="img/only.jpg" style="width: 200px; height:70px;"></center></td>
	<td style="height:100px"><h1 style="color:orange; font-size : 37px;"><center>게시글 수정</center></h1></td>
	<td></td>
	</tr>

	<tr>
	<td style="width:200px"><center>
	<img src="img/BW2.jpg" style="width: 190px; height:510px;">
	</center></td>
	<td><center>
	<form name="WrteFrm" enctype="multipart/form-data" method="post" action="BoardEditProcess.jsp">
	
	<input type="hidden" name="num" value="<%=num%>" />
		<table border="0" class="Ein">
			<tr>
			<td><center><table border=0 class="Einin">
				<td style="background-color:white;"><center>제목</center></td>
				<td style="height:40px; background-color:white;"><center>
				<input type="text" name="title" size = 100 value="<%=dto.getTitle()%>"></center></td>
			</tr>
			<tr>
				<td style="background-color:white;"><center>내용</center></td>
				<td style="background-color:white;"><center>
				<textarea name="content" class="Etext"><%=dto.getContent()%></textarea>
				</center></td>
			</tr>
			<tr>
				<td style="background-color:white;"><center>분류</center></td>
				<td style="background-color:white;"><center>

				<select name="category">
				<option value="상의" <%if (dto.getCategory().equals("상의")) {%> selected <%}%>>상의</option>
				<option value="하의" <%if (dto.getCategory().equals("하의")) {%> selected <%}%>>하의</option>
				<option value="장신구" <%if (dto.getCategory().equals("장신구")) {%> selected <%}%>>장신구</option>
				</select>

				</center></td>
<tr>
  <td style="background-color:white;"><center>파일</center></td>
  <td colspan="2" style="background-color:white;">
    <center>
      <input type="file" name="fileName">
      <% if (dto.getFileName() != null) { %>
        <br>
        <img src="Uploads/<%=dto.getFileName()%>">
      <% } %>
    </center>
  </td>
</tr>	<tr>
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