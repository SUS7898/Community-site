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
String usertel = request.getParameter("user_tel");

String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

UserMemberDAO dao = new UserMemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
UserMemberDTO dto = dao.getCreateAccount(userId, userPass, userName, userGenger, usertel);
dao.close();

System.out.println(userId);
System.out.println(userPass);
System.out.println(userName);
System.out.println(userGenger);
System.out.println(usertel);

JSFunction.alertLocation("계정이 생성되었습니다..", "MainPage.jsp", out);
%>