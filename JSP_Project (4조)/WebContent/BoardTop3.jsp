<%@ page import="java.sql.*"%>
<%@ page import="CafeBoard.*"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
CafeBoardDAO dao = new CafeBoardDAO(application);

// 좋아요가 가장 많은 3개의 게시물 조회
List<CafeBoardDTO> top3List = dao.getTop3ByLikes();
%>
<html>
<head>
<meta charset="UTF-8">
<style>
.Top3{
color : black;
}
.Top3:hover{
color : orange;
font-size : 25px;
}
</style>
<title>좋아요가 가장 많은 게시물</title>
</head>
<body><center>
	<%
	for (CafeBoardDTO dto : top3List) {
		String num = dto.getNum();
		String title = dto.getTitle();
	%>
	<a href="BoardView.jsp?num=<%=num%>" style="text-decoration : none;"><h3 class="Top3"><%=title%></h3></a>
	<%
	}
	%>
</center>
</body>
</html>
<%
// DB 연결 해제
dao.close();
%>