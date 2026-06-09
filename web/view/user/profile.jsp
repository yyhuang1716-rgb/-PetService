<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>个人中心 - 萌宠之家</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', 'PingFang SC', 'Microsoft YaHei', sans-serif;
            background-color: #FFFDF5; color: #2D2D2D; padding: 40px;
        }
        .container { max-width: 600px; margin: 0 auto; }
        .page-title {
            text-align: center; font-size: 28px; font-weight: 700;
            color: #06C270; margin-bottom: 32px;
        }
        .nav-back {
            display: inline-block; margin-bottom: 20px; color: #06C270;
            text-decoration: none; font-weight: bold; font-size: 15px;
        }

        /* 用户信息卡片 */
        .info-card {
            background: #fff; border-radius: 16px; padding: 32px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06); margin-bottom: 24px;
        }
        .info-row {
            display: flex; align-items: center; padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .info-row:last-child { border-bottom: none; }
        .info-label {
            width: 100px; font-size: 14px; color: #999; font-weight: 500;
        }
        .info-value {
            flex: 1; font-size: 16px; color: #333; font-weight: 600;
        }
        .role-badge {
            display: inline-block; padding: 3px 14px; border-radius: 16px;
            font-size: 13px; font-weight: 600;
        }
        .role-badge.user { background: #E8FAF0; color: #06C270; }
        .role-badge.merchant { background: #FFF4D6; color: #FF8C00; }
        .role-badge.admin { background: #FFE8E8; color: #FF4444; }

        /* 编辑表单 */
        .form-card {
            background: #fff; border-radius: 16px; padding: 32px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        .form-card h3 {
            font-size: 18px; font-weight: 700; margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block; font-size: 14px; font-weight: 600;
            color: #555; margin-bottom: 6px;
        }
        .form-group input {
            width: 100%; padding: 12px 16px; border: 2px solid #e8e8e8;
            border-radius: 12px; font-size: 15px; outline: none;
            transition: border-color 0.2s;
        }
        .form-group input:focus {
            border-color: #06C270;
        }
        .btn-submit {
            width: 100%; padding: 14px; background: #06C270; color: #fff;
            border: none; border-radius: 12px; font-size: 16px;
            font-weight: 700; cursor: pointer; transition: background 0.25s;
        }
        .btn-submit:hover { background: #04A05C; }

        /* 消息提示 */
        .msg-toast {
            text-align: center; padding: 14px 20px; border-radius: 12px;
            font-size: 15px; font-weight: bold; margin-bottom: 20px;
        }
        .msg-success { background: #D4EDDA; color: #155724; border: 1px solid #C3E6CB; }
        .msg-error { background: #F8D7DA; color: #721C24; border: 1px solid #F5C6CB; }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/index.jsp" class="nav-back">⬅ 返回首页</a>
    <h1 class="page-title">👤 个人中心</h1>

    <%-- 消息提示 --%>
    <c:if test="${not empty param.msg}">
        <div class="msg-toast msg-success">${param.msg}</div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="msg-toast msg-error">${param.error}</div>
    </c:if>

    <%-- 用户信息展示 --%>
    <div class="info-card">
        <div class="info-row">
            <span class="info-label">用户名</span>
            <span class="info-value"><c:out value="${sessionScope.user.username}" /></span>
        </div>
        <div class="info-row">
            <span class="info-label">角色</span>
            <span class="info-value">
                <c:choose>
                    <c:when test="${sessionScope.user.role == 0}">
                        <span class="role-badge user">普通用户</span>
                    </c:when>
                    <c:when test="${sessionScope.user.role == 1}">
                        <span class="role-badge merchant">商家</span>
                    </c:when>
                    <c:when test="${sessionScope.user.role == 2}">
                        <span class="role-badge admin">管理员</span>
                    </c:when>
                </c:choose>
            </span>
        </div>
        <div class="info-row">
            <span class="info-label">手机号</span>
            <span class="info-value"><c:out value="${empty sessionScope.user.phone ? '未设置' : sessionScope.user.phone}" /></span>
        </div>
        <div class="info-row">
            <span class="info-label">密码</span>
            <span class="info-value">••••••••</span>
        </div>
    </div>

    <%-- 修改信息表单 --%>
    <div class="form-card">
        <h3>✏️ 修改信息</h3>
        <form action="${pageContext.request.contextPath}/userServlet?action=updateProfile" method="post">
            <div class="form-group">
                <label for="phone">手机号</label>
                <input type="text" id="phone" name="phone"
                       value="${empty sessionScope.user.phone ? '' : sessionScope.user.phone}"
                       placeholder="请输入新的手机号" maxlength="20" />
            </div>
            <div class="form-group">
                <label for="password">登录密码</label>
                <input type="password" id="password" name="password"
                       placeholder="请输入新的密码（留空则不修改）" maxlength="50" />
                <div style="font-size: 12px; color: #999; margin-top: 4px;">如不修改密码，请留空</div>
            </div>
            <button type="submit" class="btn-submit">💾 保存修改</button>
        </form>
    </div>
</div>
</body>
</html>
