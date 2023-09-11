<%@ page import="CafeBoard.*"%>
<%@ page import="java.io.File" %>
<%@ page import="Utils.*" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if(session.getAttribute("UserId")!=null){
	

String saveDirectory = application.getRealPath("/Uploads");
int maxSize = 5 * 1024 * 1024;
String encoding = "UTF-8";
String BlackList = (String)session.getAttribute("BlackList");
MultipartRequest multi = new MultipartRequest(request, saveDirectory, maxSize, encoding);
int iResult = 0;
// 폼값 받기
String title = multi.getParameter("title");
String content = multi.getParameter("content");
String category = multi.getParameter("category"); // 추가된 부분: 폼에서 선택한 분류값 받기
String fileName = multi.getFilesystemName("fileName");  // 이미지 파일명 가져오기

// 폼값을 DTO 객체에 저장
CafeBoardDTO dto = new CafeBoardDTO();

dto.setTitle(title);
dto.setContent(content);
dto.setId(session.getAttribute("UserId").toString());
dto.setCategory(category); // 추가된 부분: DTO에 분류값 설정
dto.setFileName(fileName);

// DAO 객체를 통해 DB에 DTO 저장
CafeBoardDAO dao = new CafeBoardDAO(application);
System.out.println("BlackLsit");
if(BlackList.equals("false")){
iResult = dao.insertWrite(dto);
} 
dao.close();

if (iResult == 1 ) {

JSFunction.alertLocation("게시글이 생성되었습니다.", "MainPage.jsp", out);
} else if(dto.getTitle()==null || dto.getContent()==null||dto.getCategory()==null){
	JSFunction.alertBack("내용을 입력해주세요.", out);
}
else {
		JSFunction.alertBack("블랙리스트에 등록된 유저입니다.", out);
}
	

}else{
	JSFunction.alertBack("미등록 유저입니다.", out);
}

%>