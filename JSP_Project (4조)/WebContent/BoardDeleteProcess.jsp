<%@ page import="CafeBoard.*"%>
<%@ page import="CafeLove.*"%>
<%@ page import="Utils.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 1. 로그인여부 체크 IsLoggedIn.jsp -->
<%@ include file="IsLoggedIn.jsp"%>
<%
// 일련번호 해당하는 게시물 얻어오기 : CafeBoardDTO 
String num = request.getParameter("num");
String id = request.getParameter("id");

CafeBoardDTO dto = new CafeBoardDTO();
CafeBoardDAO dao = new CafeBoardDAO(application);

CafeLoveDTO ldto = new CafeLoveDTO();
CafeLoveDAO ldao = new CafeLoveDAO(application);

// 작성자가 본인인지 확인 후 삭제 - 삭제 성공시 '삭제되었습니다' 메시지 출력 후 목록보기 페이지로 이동, 삭제 실패시 '삭제 실패' 메시지 출력 후 이전페이지로 이동 
// 작성자가 본인이 아니면 메세지 출력후 이전페이지로 이동
String userId = (String) session.getAttribute("UserId"); // 로그인한 유저 id 받아오기
boolean isAdmin = (userId != null && userId.equals("admin")); // 관리자인지 확인
boolean isUser = (userId != id);

if (isAdmin || isUser) {
	dto.setNum(num);
	ldto.setNum(num);

	int result = dao.deletePost(dto); //게시글 삭제
	int lresult = ldao.deleteLoveRecord(ldto); //게시글 번호가 같은 좋아요 데이터 삭제

	dao.close();
	ldao.close();
	
	if (result == 1 || lresult == 1) {
		JSFunction.alertLocation("삭제되었습니다.", "MainPage.jsp", out);
	} else {
		JSFunction.alertBack("삭제 실패", out);
	}
} else {
	JSFunction.alertBack("작성자 본인만 삭제할 수 있습니다.", out);
}
%>