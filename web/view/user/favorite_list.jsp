<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>我的收藏 - 萌宠之家</title>
    <style>
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background-color: #FFFDF5; color: #2D2D2D; padding: 0; margin: 0; }
        .container { max-width: 1000px; margin: 0 auto; padding: 24px 24px 40px; }
        h2 { color: #06C270; text-align: center; margin-bottom: 30px; }
        .nav-back {
            display: inline-block; margin-bottom: 20px; color: #06C270;
            text-decoration: none; font-weight: bold;
        }
        .msg-toast {
            text-align: center; padding: 14px 20px; border-radius: 12px;
            font-size: 15px; font-weight: bold; margin-bottom: 20px;
            background: #D4EDDA; color: #155724; border: 1px solid #C3E6CB;
        }
        .empty-state {
            text-align: center; padding: 80px 20px; background: #fff;
            border-radius: 16px; box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        .empty-state .icon { font-size: 64px; margin-bottom: 20px; }
        .empty-state p { font-size: 18px; color: #666; margin-bottom: 20px; }
        .empty-state .btn-service {
            display: inline-block; background: #06C270; color: #fff;
            padding: 12px 36px; border-radius: 24px; font-weight: bold; text-decoration: none;
        }
        .card-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
        .service-card {
            background: #fff; border-radius: 16px; padding: 24px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
            border-left: 4px solid #FF6B81; position: relative;
        }
        .service-card .title { font-size: 18px; font-weight: bold; color: #333; margin: 0 0 8px 0; }
        .service-card .desc { font-size: 14px; color: #888; margin: 8px 0; line-height: 1.6; }
        .service-card .price { color: #FF6B6B; font-size: 22px; font-weight: bold; margin: 10px 0; }
        .service-card .fav-time { font-size: 12px; color: #BBB; margin-bottom: 12px; }
        .service-card .actions { display: flex; gap: 10px; margin-top: 12px; }
        .btn-book {
            flex: 1; background: #06C270; color: #fff; text-decoration: none;
            padding: 8px 0; border-radius: 20px; font-size: 14px; font-weight: bold;
            text-align: center; display: inline-block;
        }
        .btn-unfav {
            flex: 1; background: #FFF3CD; color: #856404; text-decoration: none;
            padding: 8px 0; border-radius: 20px; font-size: 14px; font-weight: bold;
            text-align: center; display: inline-block; border: 1px solid #FFE69C;
        }
        .service-card .fav-tag {
            position: absolute; top: 16px; right: 16px;
            background: #FF6B81; color: #fff; padding: 4px 12px;
            border-radius: 20px; font-size: 12px; font-weight: bold;
        }

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
    <a href="${pageContext.request.contextPath}/index.jsp" class="nav-back">⬅ 返回首页</a>
    <h2>❤️ 我的收藏</h2>

    <c:if test="${not empty param.msg}">
        <div class="msg-toast">${param.msg}</div>
    </c:if>

    <c:choose>
        <c:when test="${empty requestScope.favoriteList}">
            <div class="empty-state">
                <div class="icon">💝</div>
                <p>还没有收藏任何服务哦～</p>
                <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list" class="btn-service">去浏览服务</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card-grid">
                <c:forEach items="${requestScope.favoriteList}" var="item">
                    <div class="service-card">
                        <div class="fav-tag">❤️ 已收藏</div>
                        <h3 class="title">${item.title}</h3>
                        <div class="desc">${empty item.description ? '暂无描述' : fn:substring(item.description, 0, 60)}${fn:length(item.description) > 60 ? '...' : ''}</div>
                        <div class="price">¥${item.price}</div>
                        <div class="fav-time">⭐ 收藏时间：${fn:replace(item.favoriteCreateTime, 'T', ' ')}</div>
                        <div class="actions">
                            <a href="${pageContext.request.contextPath}/orderServlet?action=toBook&service_item_id=${item.id}&merchant_id=${item.merchantId}" class="btn-book">📅 去预约</a>
                            <a href="${pageContext.request.contextPath}/favoriteServlet?action=remove&serviceId=${item.id}" class="btn-unfav" onclick="return confirm('确定取消收藏吗？')">🗑️ 取消收藏</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
