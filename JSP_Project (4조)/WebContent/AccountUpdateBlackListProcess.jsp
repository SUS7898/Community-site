<%@ page import="UserMember.*"%>
<%@ page import="Utils.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String userId = request.getParameter("user_id");
String userBlackList = request.getParameter("user_blacklist");
System.out.println("userBlackList");
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

UserMemberDAO dao = new UserMemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
UserMemberDTO dto = dao.getUpdateBlackListAccount(userId, userBlackList);
dao.close();

JSFunction.alertLocation("블랙리스트가 수정되었습니다.", "MyPage.jsp", out);

%>