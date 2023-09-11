<%@ page import="UserMember.*"%>
<%@ page import="Utils.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String userId = request.getParameter("user_id");
String userPass = request.getParameter("user_pass");
String userName = request.getParameter("user_name");
String userGenger = request.getParameter("user_gender");
String userTel = request.getParameter("user_tel");

String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

UserMemberDAO dao = new UserMemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
UserMemberDTO dto = dao.getUpdateAccount(userId, userPass, userName, userGenger, userTel);
dao.close();

JSFunction.alertLocation("회원정보가 수정되었습니다.", "MainPage.jsp", out);
%>