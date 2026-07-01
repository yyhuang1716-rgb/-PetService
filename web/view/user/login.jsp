<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>宠物服务平台 - 登录</title>
    <style>
        body { font-family: '微软雅黑', Arial, sans-serif; text-align: center; margin-top: 100px; background-color: #f9f9f9; font-size: 16px;} /* 字体大小从24px改为16px */
        h2 { font-size: 36px; margin-bottom: 30px;} /* 字体大小从48px改为36px，底部间距减小 */
        form { display: inline-block; text-align: left; background: white; border: 3px solid #ddd; padding: 40px 60px; border-radius: 30px; box-shadow: 0 12px 36px rgba(0,0,0,0.3);} /* 内边距从60px 80px改为40px 60px */
        label { font-size: 18px; display: block; margin-bottom: 10px;} /* 字体大小从24px改为18px，底部间距减小 */
        input { margin-bottom: 20px; width: 350px; padding: 15px; border: 2px solid #ccc; border-radius: 15px; font-size: 18px;} /* 宽度从500px改为350px，内边距从20px改为15px，字体大小从24px改为18px，底部间距减小 */
        button { width: 100%; padding: 15px; background-color: #4CAF50; color: white; border: none; border-radius: 15px; cursor: pointer; font-size: 20px; font-weight: bold;} /* 内边距从25px改为15px，字体大小从28px改为20px */
        button:hover { background-color: #45a049; }
        .error-msg { color: red; font-size: 16px; margin-bottom: 20px; } /* 字体大小从20px改为16px，底部间距减小 */
        .success-msg { color: green; font-size: 16px; margin-bottom: 20px; } /* 字体大小从20px改为16px，底部间距减小 */
    </style>
</head>
<body>
<h2>🐾 宠物服务平台</h2>

<% if (request.getAttribute("error") != null) { %>
<p class="error-msg"><%= request.getAttribute("error") %></p >
<% } %>

<% if (request.getParameter("msg") != null) { %>
<p class="success-msg"><%= request.getParameter("msg") %></p >
<% } %>

<form action="${pageContext.request.contextPath}/userServlet?action=login" method="post">
    <label>用户名：</label>
    <input type="text" name="username" placeholder="请输入用户名" required>

    <label>密 码：</label>
    <input type="password" name="password" placeholder="请输入密码" required>

    <button type="submit">登 录</button>
    <p style="text-align: center; font-size: 18px; margin-top: 30px;"> <!-- 字体大小从24px改为18px，顶部间距减小 -->
        还没有账号？ <a href="${pageContext.request.contextPath}/view/user/register.jsp" style="color: #2196F3; font-size: 18px;">点击这里注册</a > <!-- 字体大小从24px改为18px -->
    </p >
</form>
</body>
</html>