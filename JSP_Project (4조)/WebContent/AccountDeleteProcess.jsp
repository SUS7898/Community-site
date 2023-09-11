<%@ page import="UserMember.*"%>
<%@ page import="Utils.*" %>
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
UserMemberDTO dto = dao.getDeleteAccount(userId, userPass);
dao.close();
session.invalidate(); // 세션 무효화
JSFunction.alertLocation("계정이 제거되었습니다..", "MainPage.jsp", out);
%>