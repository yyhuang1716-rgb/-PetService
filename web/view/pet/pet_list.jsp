<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>我的宠物档案 - 萌宠之家</title>
    <style>
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background-color: #FFFDF5; color: #2D2D2D; padding: 0; margin: 0; }
        .container { max-width: 900px; margin: 0 auto; padding: 24px 24px 40px; }
        h2 { color: #06C270; text-align: center; margin-bottom: 30px; }

        /* 宠物卡片布局 */
        .pet-grid { display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 40px; }
        .pet-card { background: #fff; border-radius: 16px; padding: 20px; width: calc(33.333% - 14px); box-shadow: 0 4px 16px rgba(0,0,0,0.06); border-top: 4px solid #FFD166; position: relative; }
        .pet-card h3 { margin: 0 0 10px 0; color: #333; }
        .pet-card p { margin: 5px 0; color: #666; font-size: 14px; }
        .btn-del { position: absolute; top: 15px; right: 15px; background: #FF6B6B; color: white; border: none; border-radius: 8px; padding: 5px 10px; cursor: pointer; text-decoration: none; font-size: 12px; }
        .btn-del:hover { background: #FF4444; }
        .empty-tips { text-align: center; color: #999; width: 100%; padding: 40px 0; }

        /* 添加表单样式 */
        .add-form { background: #fff; border-radius: 16px; padding: 30px; box-shadow: 0 4px 16px rgba(0,0,0,0.06); }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; font-size: 14px; }
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box; }
        .btn-submit { background: #06C270; color: white; border: none; border-radius: 20px; padding: 10px 30px; font-size: 16px; cursor: pointer; font-weight: bold; width: 100%; transition: background 0.3s; }
        .btn-submit:hover { background: #04A05C; }
        .nav-back { display: inline-block; margin-bottom: 20px; color: #06C270; text-decoration: none; font-weight: bold; }

        /* ===== 导航栏 ===== */
        .navbar { background: #FFFFFF; border-bottom: 2px solid #06C270; padding: 16px 0; position: sticky; top: 0; z-index: 100; box-shadow: 0 2px 8px rgba(6, 194, 112, 0.06); }
        .navbar .nav-wrap { display: flex; align-items: center; justify-content: space-between; max-width: 1200px; margin: 0 auto; padding: 0 24px; }
        .navbar .logo { display: flex; align-items: center; gap: 8px; font-size: 22px; font-weight: 700; color: #06C270; text-decoration: none; }
        .navbar .logo span { font-size: 26px; }
        .navbar .nav-links { display: flex; gap: 32px; font-size: 16px; font-weight: 500; }
        .navbar .nav-links a { color: #444; transition: color 0.2s; text-decoration: none; }
        .navbar .nav-links a:hover { color: #06C270; }
        .navbar .nav-buttons { display: flex; gap: 12px; align-items: center; }
        .navbar .user-info { display: flex; align-items: center; gap: 16px; }
        .navbar .user-avatar { width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, #FFD166, #06C270); display: flex; align-items: center; justify-content: center; font-size: 16px; font-weight: 700; color: #FFFFFF; }
        .navbar .username { font-size: 15px; font-weight: 600; color: #2D2D2D; }
        .navbar .role-badge { padding: 4px 12px; border-radius: 16px; font-size: 12px; font-weight: 600; }
        .role-badge.user { background: #E8FAF0; color: #06C270; }
        .role-badge.merchant { background: #FFF4D6; color: #FF8C00; }
        .role-badge.admin { background: #FFE8E8; color: #FF4444; }
        .navbar .btn-login { padding: 8px 24px; border: 2px solid #06C270; border-radius: 24px; color: #06C270; font-weight: 600; font-size: 14px; background: transparent; transition: all 0.25s; cursor: pointer; text-decoration: none; }
        .navbar .btn-login:hover { background: #06C270; color: #FFFFFF; }
        .navbar .btn-register { padding: 8px 24px; border: 2px solid #FFD166; border-radius: 24px; background: #FFD166; color: #3D3D3D; font-weight: 600; font-size: 14px; transition: all 0.25s; cursor: pointer; text-decoration: none; }
        .navbar .btn-register:hover { background: #FFAB00; border-color: #FFAB00; }
        .navbar .btn-logout { padding: 8px 20px; border: 2px solid #FF6B6B; border-radius: 24px; color: #FF6B6B; font-weight: 600; font-size: 14px; background: transparent; transition: all 0.25s; cursor: pointer; text-decoration: none; }
        .navbar .btn-logout:hover { background: #FF6B6B; color: #FFFFFF; }
        .contact-dropdown { position: relative; display: inline-block; }
        .contact-dropdown .contact-trigger { color: #444; transition: color 0.2s; cursor: pointer; font-weight: 500; }
        .contact-dropdown:hover .contact-trigger { color: #06C270; }
        .contact-dropdown-menu { display: none; position: absolute; top: calc(100% + 8px); left: 50%; transform: translateX(-50%); background: #FFFFFF; border-radius: 12px; box-shadow: 0 8px 32px rgba(0,0,0,0.15); min-width: 200px; padding: 16px 20px; z-index: 200; border: 1px solid #f0f0f0; }
        .contact-dropdown:hover .contact-dropdown-menu { display: block; }
        .contact-dropdown-menu p { margin: 6px 0; font-size: 14px; color: #555; }
        .contact-dropdown-menu p strong { color: #333; }
    </style>
</head>
<body>

<!-- ==================== 导航栏 ==================== -->
<nav class="navbar">
    <div class="nav-wrap">
        <a href="${pageContext.request.contextPath}/" class="logo">
            <span>🐾</span> 萌宠之家
        </a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">首页</a>
            <c:choose>
                <c:when test="${not empty sessionScope.user && sessionScope.user.role == 1}">
                    <a href="${pageContext.request.contextPath}/view/merchant/home.jsp">商家工作台</a>
                    <a href="${pageContext.request.contextPath}/orderServlet?action=manageList">订单管理</a>
                    <a href="${pageContext.request.contextPath}/serviceItemServlet?action=manageList">服务管理</a>
                </c:when>
                <c:when test="${not empty sessionScope.user && sessionScope.user.role == 2}">
                    <a href="#">用户管理</a>
                    <a href="#">平台管理</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list">服务项目</a>
                    <div class="contact-dropdown">
                        <span class="contact-trigger">联系我们</span>
                        <div class="contact-dropdown-menu">
                            <p>📞 联系电话：<strong>1234567</strong></p>
                            <p>👩 联系人：<strong>黄女士</strong></p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="nav-buttons">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/view/user/login.jsp" class="btn-login">登录</a>
                    <a href="${pageContext.request.contextPath}/view/user/register.jsp" class="btn-register">立即注册</a>
                </c:when>
                <c:otherwise>
                    <div class="user-info">
                        <div class="user-avatar">
                            <c:out value="${fn:substring(sessionScope.user.username, 0, 1)}" />
                        </div>
                        <span class="username"><c:out value="${sessionScope.user.username}" /></span>
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
                    </div>
                    <a href="${pageContext.request.contextPath}/userServlet?action=logout" class="btn-logout">退出</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<div class="container">
    <a href="${pageContext.request.contextPath}/" style="display: inline-block; margin-bottom: 20px; color: #06C270; text-decoration: none; font-weight: bold;">⬅ 返回主页</a>
    <h2>🐾 我的毛孩子档案</h2>

    <div class="pet-grid">
        <c:choose>
            <c:when test="${empty petList}">
                <div class="empty-tips">您还没有添加任何宠物哦，快去下方添加一只吧！🐶🐱</div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${petList}" var="pet">
                    <div class="pet-card">
                        <h3>${pet.name}</h3>
                        <p><strong>品种:</strong> ${pet.type}</p>
                        <p><strong>年龄:</strong> ${pet.age} 岁</p>
                        <p><strong>体重:</strong> ${pet.weight} kg</p>
                        <a href="${pageContext.request.contextPath}/petServlet?action=delete&id=${pet.id}" class="btn-del" onclick="return confirm('确定要删除这只可爱的小家伙吗？');">删除</a>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="add-form">
        <h3 style="margin-top:0;">➕ 添加新宠物</h3>
        <form action="${pageContext.request.contextPath}/petServlet?action=add" method="post">
            <div class="form-group">
                <label>宠物昵称</label>
                <input type="text" name="name" required placeholder="例如：旺财、咪咪">
            </div>
            <div class="form-group">
                <label>宠物类型</label>
                <select name="type">
                    <option value="狗狗">狗狗 🐶</option>
                    <option value="猫咪">猫咪 🐱</option>
                    <option value="异宠">异宠 🐰🐦</option>
                </select>
            </div>
            <div class="form-group">
                <label>年龄 (岁)</label>
                <input type="number" name="age" required min="0" placeholder="例如：2">
            </div>
            <div class="form-group">
                <label>体重 (kg)</label>
                <input type="number" name="weight" required step="0.1" placeholder="例如：5.5">
            </div>
            <button type="submit" class="btn-submit">保存档案</button>
        </form>
    </div>
</div>
</body>
</html>