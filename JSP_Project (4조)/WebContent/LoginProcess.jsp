<%@ page import="UserMember.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String userId = request.getParameter("user_id");
String userPass = request.getParameter("user_pass");

String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

UserMemberDAO dao = new UserMemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
UserMemberDTO dto = dao.getUserMemberDTO(userId, userPass);
dao.close();

if (dto.getId() != null) {
	session.setAttribute("UserId", dto.getId());
	session.setAttribute("UserName", dto.getName());
	session.setAttribute("UserGender", dto.getGender());
	session.setAttribute("UserTel", dto.getTel());
	session.setAttribute("BlackList", dto.getBlacklist());
	String blacklist = (String) session.getAttribute("BlackList");
	System.out.println("블랙리스트: " + blacklist);
	response.sendRedirect("MainPage.jsp");
	

} else {
	request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
	request.getRequestDispatcher("MainPage.jsp").forward(request, response);
}
%>