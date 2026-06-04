<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>宠物服务平台 - 注册</title>
    <style>
        body { font-family: '微软雅黑', Arial, sans-serif; text-align: center; margin-top: 50px; background-color: #f9f9f9;}
        form { display: inline-block; text-align: left; background: white; border: 1px solid #ddd; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);}
        input, select { margin-bottom: 15px; width: 220px; padding: 8px; border: 1px solid #ccc; border-radius: 4px;}
        button { width: 100%; padding: 10px; background-color: #2196F3; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px;}
        button:hover { background-color: #0b7dda; }
    </style>
</head>
<body>
<h2>📝 欢迎加入宠物平台</h2>
<form action="userServlet?action=register" method="post">
    <label>用户名：</label><br>
    <input type="text" name="username" placeholder="起个响亮的名字吧" required><br>

    <label>密 码：</label><br>
    <input type="password" name="password" placeholder="设置登录密码" required><br>

    <label>手机号：</label><br>
    <input type="text" name="phone" placeholder="请输入手机号码"><br>

    <label>选择您的角色：</label><br>
    <select name="role">
        <option value="0">我是铲屎官 (普通用户)</option>
        <option value="1">我是宠物店 (商家)</option>
    </select><br><br>

    <button type="submit">立即注册</button>
    <p style="text-align: center; font-size: 14px; margin-top: 15px;">
        已有账号？ <a href="login.jsp" style="color: #4CAF50;">返回登录</a>
    </p>
</form>
</body>
</html>