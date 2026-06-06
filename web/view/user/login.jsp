<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>宠物服务平台 - 登录</title>
    <style>
        body { font-family: '微软雅黑', Arial, sans-serif; text-align: center; margin-top: 100px; background-color: #f9f9f9;}
        form { display: inline-block; text-align: left; background: white; border: 1px solid #ddd; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);}
        input { margin-bottom: 15px; width: 220px; padding: 8px; border: 1px solid #ccc; border-radius: 4px;}
        button { width: 100%; padding: 10px; background-color: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px;}
        button:hover { background-color: #45a049; }
        .error-msg { color: red; font-size: 14px; margin-bottom: 15px; }
        .success-msg { color: green; font-size: 14px; margin-bottom: 15px; }
    </style>
</head>
<body>
<h2>🐾 宠物服务平台</h2>

<%-- 显示错误信息 --%>
<% if (request.getAttribute("error") != null) { %>
    <p class="error-msg"><%= request.getAttribute("error") %></p>
<% } %>

<%-- 显示成功信息（从URL参数获取） --%>
<% if (request.getParameter("msg") != null) { %>
    <p class="success-msg"><%= request.getParameter("msg") %></p>
<% } %>

<form action="${pageContext.request.contextPath}/userServlet?action=login" method="post">
    <label>用户名：</label><br>
    <input type="text" name="username" placeholder="请输入用户名" required><br>

    <label>密 码：</label><br>
    <input type="password" name="password" placeholder="请输入密码" required><br>

    <button type="submit">登 录</button>
    <p style="text-align: center; font-size: 14px; margin-top: 15px;">
        还没有账号？ <a href="${pageContext.request.contextPath}/view/user/register.jsp" style="color: #2196F3;">点击这里注册</a>
    </p>
</form>
</body>
</html>