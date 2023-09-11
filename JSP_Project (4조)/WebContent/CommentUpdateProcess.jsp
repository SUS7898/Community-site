<%@ page import="Comment.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 1. 로그인여부 체크 IsLoggedIn.jsp -->
<%@ include file="IsLoggedIn.jsp"%>
<%
// 일련번호 해당하는 게시물 얻어오기 : CommentDTO
String num = request.getParameter("num");
String content = request.getParameter("content");
String commentNum = request.getParameter("commentNum");

CommentDTO dto = new CommentDTO();
CommentDAO dao = new CommentDAO(application);

// 작성자가 본인인지 확인 후 삭제 - 삭제 성공시 '삭제되었습니다' 메시지 출력 후 게시글 상세 페이지로 이동, 삭제 실패시 '삭제 실패' 메시지 출력 후 이전페이지로 이동 
// 작성자가 본인이 아니면 메세지 출력후 이전페이지로 이동
if (!session.getAttribute("UserId").toString().equals(dto.getId())) {
	dto.setNum(num);
	dto.setContent(content);
	dto.setCommentNum(commentNum);
	
	int result = dao.updateComment(dto);
	
	dao.close();

	if (result == 1) {
		JSFunction.alertLocation("댓글이 수정되었습니다.", "BoardView.jsp?num=" + dto.getNum(), out);
	
	} else {
		JSFunction.alertBack("수정 실패", out);
	}
} else {
	JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
}
%>