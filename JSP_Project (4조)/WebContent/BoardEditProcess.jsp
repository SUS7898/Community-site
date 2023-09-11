<%@ page import="CafeBoard.*"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 로그인여부 체크 IsLoggedIn.jsp -->
<%@ include file="IsLoggedIn.jsp"%>
<%
String saveDirectory = application.getRealPath("/Uploads");
int maxSize = 5 * 1024 * 1024;
String encoding = "UTF-8";

MultipartRequest multi = new MultipartRequest(request, saveDirectory, maxSize, encoding);

// 수정페이지(Edit.jsp) 페이지로부터 받아온 내용을 DB에 반영
String num = multi.getParameter("num");
String title = multi.getParameter("title");
String content = multi.getParameter("content");
String category = multi.getParameter("category"); // 추가된 부분: 카테고리 값 받아오기
String fileName = multi.getFilesystemName("fileName");  // 이미지 파일명 가져오기

CafeBoardDTO dto = new CafeBoardDTO();

dto.setNum(num);
dto.setTitle(title);
dto.setContent(content);
dto.setCategory(category); // 추가된 부분: 카테고리 값 설정
dto.setFileName(fileName);

CafeBoardDAO dao = new CafeBoardDAO(application);

int result = dao.updateEdit(dto);

dao.close();

// 수정 성공/실패 처리 
// 성공시 상세 보기 페이지로 이동
if (result == 1) {
	JSFunction.alertLocation("게시글이 수정되었습니다.", "BoardView.jsp?num=" + dto.getNum(), out);
	
}
// 실패 시 이전 페이지로 이동
else {
	JSFunction.alertBack("수정 실패", out);
}
%>