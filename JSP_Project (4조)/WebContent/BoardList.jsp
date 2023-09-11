<%@ page import="CafeBoard.*"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//DAO를 생성해 DB에 연결
CafeBoardDAO dao = new CafeBoardDAO(application);

//게시물 수 확인
int totalCount = dao.selectCount()-1;
int totalCountDisplay = 0;
//페이지당 게시글 수 수정
int postsPerPage = 10;
//전체 페이지 수 계산 수정
int totalPage = (int)Math.ceil((double)totalCount / postsPerPage);
int displayTotalCount = totalCount; // 화면에 표시될 총 게시물 수
int displayTotalPage; // 화면에 표시될 총 페이지 수 (선언 추가)
//현재 페이지 번호 설정 (URL 매개변수로 받거나 기본값으로 1 설정)
int pageNum = request.getParameter("pageNum") == null ? 1 : Integer.parseInt(request.getParameter("pageNum"));
//게시물 목록 받아오기
List<CafeBoardDTO> boardLists;
//카테고리를 받아오기
String category = request.getParameter("category");
int totalCount2 = 0;
if (category != null) {
//카테고리별 게시물 수 확인
totalCount2 = dao.selectCountByCategory(category);
displayTotalCount = totalCount2; // 선택된 카테고리의 게시물 수 사용
//카테고리별 게시물 목록 받기
boardLists = dao.selectListByCategory(category, pageNum, postsPerPage);

} else {
//전체 게시물 목록 받기
boardLists = dao.selectList(pageNum, postsPerPage);
}
displayTotalPage = (int)Math.ceil((double)displayTotalCount / postsPerPage); // 화면에 표시될 총 페이지 수 계산
//DB 연결 해제
dao.close();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.Bground{
background-color : orange;
width : 1400px;
}
.Bside{
background-color : white;
width : 380px;
height : 460px;
}
.Bsearch{
width : 350px;
height : 100px;
background-color : orange;
}
.Btop{
width : 350px;
height : 250px;
background-color : silver;
color : black;
}
.Bbottom{
background-color : white;
width : 1005px;
height : 460px;
color : white;
}
.Binside{
background-color : silver;
color : black;
border-color : black;
border-style : solid;
}
.Bdeco{
text-decoration : none;
}
.b3{
background-color : orange;
color : black;
}
.b3:hover{
font-size : 20px;
background-color : gold;
}
.hothot{
font-size : 15px;
color : white;
}
.hothot:hover{
color : red;
}


  .shopping-mall {
    font-size: 24px;
    color:#FFA500;
    margin: 50px auto; 
    text-align: center;
  }
  .link-list {
    list-style-type: none;
    padding: 0;
    margin: 40px auto;
    text-align: center; 
  }
  .link-list li {
    margin-bottom: 10px;
    display: inline-block; 
    margin-right: 10px; 
  }
  .link-list li a {
    color: #000;
    text-decoration: none;
    font-size: 18px;
    padding: 5px 10px; 
    background-color: #f5f5f5;
    border-radius: 5px; 
  }
  .link-list li a:hover {
    color: #FF4500;
    font-weight: bold;
    background-color: #ddd; 
  }
</style>
<title>게시글 목록</title>
</head>
<!--  공통링크 추가 -->

<body>
<center>
<table border=0 class="Bground">
<td>
	<table border=0 class="Bside"><tr><td>
	<center>
	<table border=0 class="Bsearch"><td><center>
	<!-- 검색폼 -->
	<form method="get" action="BoardSearchProcess.jsp">
		<select name="searchField">
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="category">카테고리</option>
		</select> <input type="text" name="searchWord" /> <input type="submit"
			value="검색하기" />
	</form><br>
	<!-- 카테고리 선택 폼 -->
	<form method="get">
		<select name="category">
			<option value="">전체글 보기</option>
			<option value="상의">상의</option>
			<option value="하의">하의</option>
			<option value="장신구">장신구</option>

			<!-- 원하는 카테고리 옵션 추가 -->
		</select> <input type="submit" value="카테고리별 보기" />
	</form>
	</center>
	</td>
	</table>
	</center>
	</td></tr>
	
	<td>
	<center><table border=0 class="Btop">
	<tr><td style="background-color : orange">
	<center class = "hothot" ><h1>인기글 TOP 3</h1></center>
	</td></tr>
	<td style="background-color : white"><jsp:include page="BoardTop3.jsp" /></td>
	</table></center>
	</table></td>
	
	<td>
	<table border="0" class="Bbottom"><td>
	<center><top>
	<table border="0" width="990px" class="Binside">
		<!-- 각 칼럼의 이름 -->
		<tr style = "background-color : orange">
			<th width="10%">번호</th>
			<th width="10%">카테고리</th>
			<th width="35%">제목</th>
			<th width="10%">작성자</th>
			<th width="10%">조회수</th>
			<th width="10%">좋아요</th>
			<th width="15%">작성일</th>
		</tr>
		<!-- 목록의 내용 -->
		<%
		if (boardLists.isEmpty()) { // 게시물이 하나도 없을 때
		%>
		<tr>
			<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
		</tr>
		<%
		} else { // 게시물이 있을 때
			if(totalCount2 == 0){
			totalCountDisplay =  totalCount - (pageNum - 1) * postsPerPage+1 ; //수정
			} else{
				totalCountDisplay =  totalCount2 - (pageNum - 1) * postsPerPage ; //수정
			}
			for (CafeBoardDTO dto : boardLists) { %>
			
		<tr align="center" style = "background-color : white"; >
			<td><%=totalCountDisplay--%></td> <!--게시물 번호-->
			<td><%=dto.getCategory()%></td>  <!--카테고리 종류-->
			<td align="left"><center> <!--제목(+ 하이퍼링크)-->
			<a class="Bdeco" href="BoardView.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle()%></a></center>
			</td>

			<td align="center"><%=dto.getId()%></td> <!--작성자 아이디-->
			<td align="center"><%=dto.getVisitcount()%></td> <!--조회수-->
			<td align="center"><%=dto.getLove()%></td> <!--좋아요-->
			<td align="center"><%=dto.getPostdate()%></td> <!--작성일-->
		</tr>
		<%
		}
		}
		%>
		
	</table></top></center>
	
<div class="pagination">
<% for (int i = 0; i < displayTotalPage; i++) {
    if (category != null) { // 카테고리가 선택된 경우
        if (i+1 == pageNum) { %>
            <span class="current"><%= i+1 %></span>
        <% } else { %>
            <a href="?pageNum=<%= i+1 %>&category=<%= category %>"><%= i+1 %></a>
        <% }
    } else { // 카테고리가 선택되지 않은 경우
        if (i+1 == pageNum) { %>
            <span class="current"><%= i+1 %></span>
        <% } else { %>
            <a href="?pageNum=<%= i+1 %>"><%= i+1 %></a>
        <% }
    }
} %>
</div>


	
	
	<center><button type="button" onclick="location.href='BoardWrite.jsp';" class="b3">글쓰기</button></center>
<center>
<h2 class="shopping-mall">쇼핑몰</h2>
<ul class="link-list">
    <li><a href="https://lakickz.com/?_sta1=MUwwTDEwMDJMU0wzMjY0TDBMMEwwTE5MMDAw">LAKICKZ</a></li>
    <li><a href="https://okkane.co.kr/?_sta1=MUwwTDEwMDJMU0wyNTZMMEwwTDBMTkww">OKKANE</a></li>
    <li><a href="https://www.gopeople.co.kr/?_sta1=MUwwTDEwMDJMU0wyOTU3TDBMMEwwTE5MMDAw">GOPEOPLE</a></li>
</ul></center>
	</td>
	</table>
	</center>
	</td></table>
	<!-- <a href = 'MainPage.jsp'>[메인 페이지]</a> -->

</body>
</html>