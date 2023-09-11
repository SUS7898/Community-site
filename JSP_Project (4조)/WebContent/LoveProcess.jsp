<%@ page import="CafeBoard.*"%>
<%@ page import="CafeLove.*"%>
<%@ page import="Utils.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 로그인여부 체크 IsLoggedIn.jsp -->
<%@ include file="IsLoggedIn.jsp"%>
<%
// 일련번호 해당하는 게시물 얻어오기: CafeBoardDTO
String num = request.getParameter("num");
String title = request.getParameter("title");
String id = (String) session.getAttribute("UserId");

CafeBoardDTO dto = new CafeBoardDTO();
CafeBoardDAO dao = new CafeBoardDAO(application);
CafeLoveDTO ldto = new CafeLoveDTO();
CafeLoveDAO ldao = new CafeLoveDAO(application);

// 작성자가 본인인지 확인 후 삭제 - 삭제 성공시 '삭제되었습니다' 메시지 출력 후 목록보기 페이지로 이동, 삭제 실패시 '삭제 실패' 메시지 출력 후 이전페이지로 이동
// 작성자가 본인이 아니면 메세지 출력후 이전페이지로 이동
// 작성자가 본인인지 확인 후 좋아요 추가
if (session.getAttribute("UserId") != null) {
	String userId = (String) session.getAttribute("UserId");
	ldto.setId(id);
	ldto.setNum(num);
	ldto.setTitle(title);

	int result = 0;

	result = ldao.insertLoveRecord(ldto); // 좋아요 테이블에 추가

	if (result == 1) {
		dto.setId(id);
		dto.setNum(num);
		dao.updateLove(dto); // 좋아요 +1

		JSFunction.alertBack("좋아요!", out);
	} else if (result == 0) {
		JSFunction.alertBack("좋아요가 이미 있음", out);
	}
	dao.close();
	ldao.close();
} else {
	JSFunction.alertBack("회원만 좋아요를 누를 수 있습니다.", out);
}
%>