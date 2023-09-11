<%@ page import="CafeBoard.*"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 사용자가 입력한 검색 조건을 가져옵니다.
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");

// DAO를 생성해 DB에 연결합니다.
CafeBoardDAO dao = new CafeBoardDAO(application);

// 사용자의 검색 조건에 따라 게시물을 검색합니다.
List<CafeBoardDTO> searchResults = dao.searchBoard(searchField, searchWord);
dao.close(); // DB 연결 닫기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.Sground{
width:1400px;
height:720px;
background-color: orange;
}
.Sing{
width:1390px;
height:710px;
background-color: white;
}
.SBoard{
width:800px;
height:300px;
background-color: silver;
}
.S1{
background-color: orange;
}
.S2{
background-color: white;
}
</style>
<title>게시글 검색 결과</title>
</head>
<body>
	<center>
	<table border="0" class="Sground">
	<td><center>
	<table border="0" class="Sing">
	
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
	<h1 style="color:orange">검색 결과</h1>
	<table border="0" class="SBoard">
		<!-- 각 칼럼의 이름 -->
		<tr>
			<th width="10%" class="S1">번호</th>
			<th width="10%" class="S1">카테고리</th>
			<th width="35%" class="S1">제목</th>
			<th width="10%" class="S1">작성자</th>
			<th width="10%" class="S1">조회수</th>
			<th width="10%" class="S1">좋아요</th>
			<th width="15%" class="S1">작성일</th>
		</tr>
		<!-- 검색 결과 목록 -->
		<%
		if (searchResults.isEmpty()) { // 검색 결과가 없을 때
		%>
		<tr>
			<td colspan="5" align="center">검색된 게시물이 없습니다.</td>
		</tr>
		<%
		} else { // 검색 결과가 있을 때
		int virtualNum = 0; // 화면상에서의 게시물 번호
		
		for (CafeBoardDTO dto : searchResults) {
			virtualNum++;
		%>
		<tr align="center">
			<td class="S2"><%=virtualNum%></td> <!-- 게시물 번호 -->
			<td class="S2"><%=dto.getCategory()%></td>
			<td align="center" class="S2"> <!-- 제목(+ 하이퍼링크) -->
			<a style="text-decoration : none;" href="BoardView.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle()%></a> </td>
			<td class="S2" align="center"><%=dto.getId()%></td> <!-- 작성자 아이디 -->
			<td class="S2" align="center"><%=dto.getVisitcount()%></td> <!-- 조회수 -->
			<td class="S2" align="center"><%=dto.getLove()%></td> <!-- 좋아요 -->
			<td class="S2" align="center"><%=dto.getPostdate()%></td> <!-- 작성일 -->
		</tr>
		<%
		}
		}
		%>
	</table>
	<br>
	<button type="button" onclick="location.href='MainPage.jsp';" style="background-color:orange">돌아가기</button>
	</center></td>
	<td><center><img src="img/BW1.jpg" style="width: 160px; height:450px;"></center></td>
	</tr>
	
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
</body>
</html>