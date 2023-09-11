<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="CafeLove.*"%>
<%@ page import="Common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.Mground{
width:1400px;
height:720px;
background-color: orange;
}
.Ming{
width:1390px;
height:710px;
background-color: white;
}
.Muser{
width:600px;
height:300px;
}
.Mlike{
width:600px;
height:30px;
background-color: orange;
}
.Mlikethis{
width:600px;
height:30px;
background-color: #EBEBEB;
}
.m1{
background-color: orange;
}
.m2{
background-color: #EBEBEB;
}

</style>
<title>마이 페이지</title>
</head>
<body>
	<%
	JDBConnect jdbc = new JDBConnect();

	String query = "SELECT * FROM usermember";

	Statement stmt = jdbc.con.createStatement();
	ResultSet rs = stmt.executeQuery(query);

	String loggedInUserId = (String) session.getAttribute("UserId");
	String userName = "";
	String userGender = "";
	String userTel = "";

	while (rs.next()) {
		if (rs.getString("id").equals(loggedInUserId)) {
			userName = rs.getString("name");
			userGender = rs.getString("gender");
			userTel = rs.getString("Tel");
			break;
		}
	}
	%>
	<center>
	<table border=0 class="Mground"><td>
	<center>
	<table border=0 class="Ming">
	<tr>
	<td><center>
	<img src="img/MP3.jpg" style="width:690px; height:100px;">
	</center></td>
	<td>
	<center>
	<img src="img/MP2.jpg" style="width:690px; height:100px;">
	</center>
	</td></tr>
	<tr>
	<td><center>
	<table border=0 class="Muser"><center>
	<tr><td class = "m1"><h4><center>이 름</center></h4></td><td class="m2"><center><%=userName%></center></td></tr>
	<tr><td class = 'm1'><h4><center>성 별</center></h4></td><td class = 'm2'><center><%=userGender%></center></td></tr>
	<tr><td class = 'm1'><h4><center>전 화 번 호</center></h4></td><td class = 'm2'><center><%=userTel%></center></td></tr>
	<tr><td class = 'm1'><h4><center><a href="AccountUpdate.jsp" style="text-decoration : none;">회원정보 수정</a></h4></center></td>
	<td class = 'm1'><center><a href="AccountDelete.jsp" style="text-decoration : none;">회원 탈퇴</a></center></td></tr>
	
	<%if(loggedInUserId.equals("admin")) {//추가된 항목%> 
        
      
	<tr>
    <td class='m1' colspan='2' style='height: 60px;'>
        <center>
            <a href="AccountUpdateBlackList.jsp" style="text-decoration: none;">블랙 리스트</a>
        </center>
    </td>
</tr>
  <%
       }
        %>
	</center></td></table>
	</center></td>
	<td>
	<center>
	<table border="0" class="Mlike"><td><h3><center>좋아요 목록</center></h3></td></table>
	<%
	CafeLoveDAO ldao = new CafeLoveDAO(application);
	
	// 좋아요한 게시글 목록을 가져옴
	List<CafeLoveDTO> likesList = ldao.selectlikesList(loggedInUserId); //좋아요 취소 기능 필요함

	for (CafeLoveDTO likes : likesList) {
	%>
	<table border="0" class="Mlikethis"><tr><td><center>
	<a style="text-decoration : none;" href="BoardView.jsp?num=<%=likes.getNum()%>"><%=likes.getTitle()%></a>
	</center></td></tr></table>
	<%
	}
	%>
	</center>
	<br>
	<center>
	<table border="0" style="background-color:orange;"><td>
	<a href="MainPage.jsp" style="font-size:35px;text-decoration : none;">메인 페이지</a></center></td>
	</td></table>
	</center>
	</tr>
	<td><center>
	<img src="img/MP4.jpg" style="width:690px; height:100px;">
	<td><center>
	<img src="img/MP1.jpg" style="width:690px; height:100px;">
	</center></td>
	</center>
	</td></table>
	</center>
	</td></table>
	</center>
</body>
</html>