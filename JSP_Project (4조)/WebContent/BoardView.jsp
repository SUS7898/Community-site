<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="Common.JDBConnect"%>
<%@ page import="CafeBoard.*"%>
<%@ page import="Comment.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String num = request.getParameter("num");
String commentNum = request.getParameter("commentNum");

//DAO를 생성해 DB에 연결
CafeBoardDAO dao = new CafeBoardDAO(application);
CommentDAO comdao = new CommentDAO(application);

//목록 페이지(BoardView.jsp)로 부터 얻은 일련번호(num)에 해당하는 게시물의 방문횟수 업데이트하기 
dao.updateVisitCount(num);
//목록 페이지(BoardView.jsp)로 부터 얻은 일련번호(num)에 해당하는 게시물 조회하기 -BoardDTO
CafeBoardDTO dto = dao.selectView(num);
//게시물 수 조회
int totalCount = dao.selectCount();

//댓글 수 조회
int commentCount = comdao.commentCount();
//댓글 목록 조회
List<CommentDTO> commentLists = comdao.commentList();

//로그인한 유저 아이디 받아오기
String userId = (String) session.getAttribute("UserId");
// 관리자인지 확인
boolean isAdmin = (userId != null && userId.equals("admin"));

//DB 연결 해제
dao.close();
comdao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.Look1{
width : 1390px;
background-color : white;
}
.Nreaple{
width : 1390px;
background-color : white;
}
.BVground{
width : 1400px;
height:720px;
background-color : orange;
}
.BVgroundin{
width : 1400px;
height:720px;
background-color : white;
}

.Reaple{
width : 1095px;
background-color : white;
}
.ReName{
background-color : white;
}
.Rday{
background-color : white;
}
.ReRe{
background-color : white;
}
.ReapleBox{
width : 1390px;
}
.RRRR{
width : 1390px;
background-color : #EBEBEB;
}
.Rtext{
width : 1100px;
background-color : white;
}
.RTground{
width : 1390px;
background-color : white;
}
.BVins{
width : 1300px;
background-color : gray;
}
.BVinspls{
width : 600px;
background-color : #EBEBEB;
}
</style>
<title>회원제 게시판</title>
<script type="text/javascript">
	function deletePost() {  // 삭제 시 삭제 할지 말지 한번 더 물어봄
		var confirmed = confirm("정말로 삭제하시겠습니까?");

		if (confirmed) {  // 확인 누를 경우 게시글 삭제 프로세스 실행
			var form = document.writeFrm;
			form.method = "post";
			form.action = "BoardDeleteProcess.jsp";
			form.submit();
		}
	}

	function toggleCommentForm(commentNum) {  // 댓글 수정 버튼을 눌렀을 시에만 댓글 수정 폼이 보이게함
		var formId = "commentForm_" + commentNum;
		var form = document.getElementById(formId);
		var buttonId = "commentEditButton_" + commentNum;
		var button = document.getElementById(buttonId);

		if (form.style.display === "none") {  // 댓글 수정 눌렀을 시 댓글 취소로 변경
			form.style.display = "block";
			button.innerText = "댓글 취소";
		} else {  // 댓글 취소 누르면 댓글 수정으로 버튼이 변경
			form.style.display = "none";
			button.innerText = "댓글 수정";
		}
	}
</script>
</head>
<body>
	<!-- 공통 링크 "../Common/Link.jsp"  -->
	<center>
	<table border="0" class="BVground">
	<td>
	<center>
	<table border="0" class="BVgroundin">
	<td>
	<center>
	<img src="img/MP4.jpg" style="width:690px; height:100px;">
	<img src="img/MP3.jpg" style="width:690px; height:100px;">
	</center>
	</td>
	<tr>
	<td>
	<center>
	<table border="0" class="Look1"><td>
	<form name="writeFrm">
		<!-- hidden 속성 -->
		<input type="hidden" name="num" value="<%=num%>" />
		<!-- 공통 링크 -->
		<h4>
		<center>
		<table border='0' class="BVinspls">
			<td style="width:200px"><center><%=num%> 번 게시물</center></td>
			<td style="width:200px"><center>카테고리 : <%=dto.getCategory()%></center></td>
			<td style="width:200px"><center>작성자 : <%=dto.getId()%></center></td>
		</table>
		</center>
		<center>
<table border="0" class="BVins">
    <tr>
        <td style=" background-color:white;"><center><%=dto.getTitle()%></center></td>
    </tr>
   <tr>
    <td style="height:200px; background-color:white;">
        <center>
            <% if (dto.getFileName() != null) { %>
            <img src="Uploads/<%=dto.getFileName()%>">
            <% } %>
            <br/>
            <%=dto.getContent().replace("\r\n", "<br/>")%>
        </center>
    </td>
</tr>
   
</table>
</center>

		<center>
		<table border='0' class="BVinspls">
			<td style="width:200px"><center>작성일 <%=dto.getPostdate()%></center></td>
			<td style="width:200px"><center>좋아요 <%=dto.getLove()%></center></td>
			<td style="width:200px"><center>조회수 <%=dto.getVisitcount()%></center></td>
		</table>
		</center>
		</h4>
		
		<center>
		<table border="0"><td>
		<button type="button" onClick="location.href='LoveProcess.jsp?num=<%=dto.getNum()%>&title=<%=dto.getTitle()%>&id=<%=userId%>';">좋아요</button>
		<%
		// 로그인 여부와 게시물의 작성자 동일인이 경우 [수정하기][삭제하기][목록보기] 버튼 보여주기
		if (isAdmin || (userId != null && userId.equals(dto.getId()))) { // 관리자이거나 본인이 작성한 경우
		%>
		<button type="button" onClick="location.href='BoardEdit.jsp?num=<%=dto.getNum()%>';">수정하기</button>
		<button type="button" onClick="location.href='BoardDeleteProcess.jsp?num=<%=dto.getNum()%>';">삭제하기</button>
		<%
		}
		%>
		<!-- 동일인이 아닌경우, [목록보기]버튼만 보여준다. -->
		<button type="button" onClick="location.href='MainPage.jsp';">목록보기</button>
		</td></table>
		</center>
	</form>
	</td>
	</table>
	</center>
	<h2>댓글</h2>
   <tr>
  <td>
    <center>
      <table border="0" class="RTground">
        <tr>
          <td style="width:100px;background-color:#EBEBEB"><center>댓글 입력</center></td>
          <td class="Rtext">
            <center>
              <div class="comment-form">
                <form name="comment" method="post" action="CommentInsertProcess.jsp" onsubmit="return validateForm(this);">
                  <input type="hidden" name="num" value="<%=num%>">
                  <div style="display: flex; align-items: center;">
                    <textarea name="content" placeholder="댓글 입력" style="flex-grow: 1; margin-right: 10px;" required></textarea>
                    <button type="submit">작성 완료</button>
                  </div>
                </form>
              </div>
            </center>
          </td>
        </tr>
      </table>
    </center>
  </td>
</tr>

	<%
	if (commentLists.isEmpty()) { // 댓글이 하나도 없을 때
	%>
	<tr><td>
	<center>
	<table border="0" class="RRRR"><td><center>댓글창</center></td></table>
	</center>
	</td></tr>
	
	<center>
	<table border="0">
	<tr><td colspan="5" align="center" class="Nreaple">등록된 댓글이 없습니다.</td></tr>
	</table>
	</center>
	
	<form name="comment" method="post" action="CommentInsertProcess.jsp" onsubmit="return validateForm(this);">
	<input type="hidden" name="num" value="<%=num%>" /> <!-- 현재 게시물 번호를 넘기기위해 작성 -->
	
	<table border="0" class="RTground">
	<tr>
	<td style="width:100px;background-color:#EBEBEB"><center>댓글 입력</center></td>
	<td class="Rtext"><center><textarea name="content" style="width: 1190px; height: 100%"></textarea></center></td>
	<td style="width:100px;background-color:#EBEBEB"><center><button type="submit">작성 완료</button></center></td>
	</tr>
	
	<td></td>
	
	<td></td>
	
	</table>
	</form>
	</td>
	<tr>
	
	<%
	}else { // 댓글이 있을 때
	int virtualNum = 0; // 화면상에서의 댓글 번호
	for (CommentDTO comdto : commentLists) {
		if (comdto.getNum().equals(num)) { // 현재 게시글 번호와 일치하는 댓글만 출력
			virtualNum = commentCount--; // 전체 댓글 수에서 시작해 1씩 감소
	%>
	<center>
	<table border="0" class="RRRR"><td><center>댓글창</center></td></table>
	</center>
	
	<center>
	<table border="0" class="ReapleBox">
	<td class="ReName"><%=comdto.getName()%>:</td> <!-- 댓글 작성자 이름 출력 -->
	<td class="Reaple";><%=comdto.getContent()%></td><!-- 댓글 출력 -->
	<td class="Rday"><%=comdto.getPostdate()%></td><!-- 댓글 작성일 출력 -->
	<td class="ReRe">
	<button type="button" id="commentEditButton_<%=comdto.getCommentNum()%>" onClick="toggleCommentForm(<%=comdto.getCommentNum()%>)">댓글수정</button>
	<button type="button" onClick="location.href='CommentDeleteProcess.jsp?commentNum=<%=comdto.getCommentNum()%>&num=<%=num%>';">댓글삭제</button>
	<form id="commentForm_<%=comdto.getCommentNum()%>" name="comment" method="post" action="CommentUpdateProcess.jsp"
		onsubmit="return validateForm(this);" style="display: none;">
	<input type="hidden" name="num" value="<%=num%>" /> <!-- 현재 게시물 번호를 넘기기위해 작성 -->
	<input type="hidden" name="commentNum" value="<%=comdto.getCommentNum()%>" /> <!-- 현재 댓글 번호를 넘기기위해 작성 -->
	</td>
	</table>
	</center>
	
	<center>
	<table border="0" class="RTground">
	<tr>
	<td style="width:100px;background-color:#EBEBEB"><center>댓글 입력</center></td>
	<td class="Rtext"><center><textarea name="content" style="width: 1190px; height: 100%"><%=comdto.getContent()%></textarea></center></td>
	<td style="width:100px;background-color:#EBEBEB"><center><button type="submit">수정 완료</button></center></td>
	</tr>
	</center>
	
	<td></td>
	
	
	
	<td></td>
	
	</table>
	</form>
	</td>
	</tr>
	<%
	}
	}
	}
	%>
	
	
	</td>
	</table>
	</center>
	</td>
	</table>
	</center>
	<td><center>
	<% // 이전 게시물 번호, 다음 게시물 번호를 얻어온다.
	int prevNum = Integer.parseInt(dto.getNum()) - 1;  // 현재 게시판에 -1을 하여 이전 게시물 번호를 얻어옴
	String prev = "BoardView.jsp?num=" + prevNum;  // 이전 게시물 링크를 prev함수에 저장
	if (prevNum >= 1) { %>
	<a href="<%= prev %>">[이전 게시물]</a> <!-- 이전 게시글로 넘어감 -->
	<% } %> <!-- 이전 게시글 번호가 1보다 크거나 같으면 페이지에 출력 -->
	
	<%
	
	int nextNum = Integer.parseInt(dto.getNum()) + 1;  // 현재 게시판에 +1을 하여 다음 게시물 번호를 얻어옴
	String next = "BoardView.jsp?num=" + nextNum;  // 다음 게시물 링크를 next함수에 저장
	 { %>
	<a href="<%= next %>">[다음 게시물]</a> <!-- 다음 게시글로 넘어감 -->
	<% } %>  <!-- 다음 게시글 번호가 총 게시글 수 보다 작거나 같으면 페이지에 출력 -->
	</center></td>
</body>
</html>