<%@ page import="Utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 로그인되어있지 않으면 "로그인 후 이용" 메시지 출력 후 로그인 페이지(LoginForm.jsp)로 이동
if (session.getAttribute("UserId") == null) {
	JSFunction.alertLocation("로그인 후 이용해주십시오.", "MainPage.jsp", out);
	return;
}
%>