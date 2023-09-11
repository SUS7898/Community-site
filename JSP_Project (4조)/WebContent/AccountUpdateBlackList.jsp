<%@ page import="UserMember.*"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>블랙리스트 수정</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>
    body {
        padding: 20px;
    }
    .form-group {
        margin-bottom: 15px;
    }
    .form-control, .btn {
        border-radius: 0;
    }
</style>
</head>
<body>

    <h2 class="text-center">블랙리스트 추가여부</h2>
    <form action="AccountUpdateBlackListProcess.jsp" method="post" class="mx-auto" style="max-width: 400px;">
        <div class="form-group">
            <label>아이디:</label>
            <input type="text" name="user_id" class="form-control" required/>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="user_blacklist" id="add" value="true" checked>
            <label class="form-check-label" for="add">추가</label>
        </div>
        <div class="form-check mb-3">
            <input class="form-check-input" type="radio" name="user_blacklist" id="remove" value="false">
            <label class="form-check-label" for="remove">제거</label>
        </div>
        <input type="submit" class="btn btn-primary btn-block" value="회원정보 수정">
    </form>
    
    <h2 class="text-center mt-5">블랙리스트 멤버</h2>
    <div class="container mt-4">
    <%
        UserMemberDAO dao = new UserMemberDAO(application);
        List<UserMemberDTO> BlackList = dao.getBlackList();
        dao.close();

        for (UserMemberDTO dto : BlackList) {
            String userId = dto.getId();
            String userName = dto.getName();
            String blacklistStatus = dto.getBlacklist();
    %>
        <div class="card mb-3">
            <div class="card-body">
                <h5 class="card-title">아이디 : <%= userId %></h5>
                <p class="card-text">이름 : <%= userName %></p>
                <p class="card-text">블랙리스트 : <%= blacklistStatus %></p>
            </div>
        </div>
    <%
        }
    %>
    </div>

</body>
</html>
