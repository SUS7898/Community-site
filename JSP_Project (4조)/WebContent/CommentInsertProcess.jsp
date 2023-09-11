<%@ page import="Comment.*"%>
<%@ page import="Utils.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int result = 0;
String id = (String)session.getAttribute("UserId");
// 폼값 받기
if(id!=null){
String content = request.getParameter("content");
String num = request.getParameter("num");
String BlackList = (String)session.getAttribute("BlackList");
// 폼값을 DTO 객체에 저장
CommentDTO dto = new CommentDTO();

dto.setContent(content);
dto.setNum(num);
dto.setId(session.getAttribute("UserId").toString());
dto.setName(session.getAttribute("UserName").toString());

// DAO 객체를 통해 DB에 DTO 저장
CommentDAO dao = new CommentDAO(application);
if(BlackList.equals("false")){
 result = dao.insertComment(dto);
 dao.close();

if (result == 1) {
	JSFunction.alertLocation("댓글이 생성되었습니다.", "BoardView.jsp?num=" + dto.getNum(), out);

}
}else{
	JSFunction.alertLocation("블랙리스트에 등록된 유저입니다..", "BoardView.jsp?num=" + dto.getNum(), out);
}
} else{
	JSFunction.alertBack("미등록된 유저입니다.", out);
}

%>