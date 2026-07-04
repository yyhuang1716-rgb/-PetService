<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>我的评价 - 萌宠之家</title>
    <style>
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background-color: #FFFDF5; color: #2D2D2D; padding: 0; margin: 0; }
        .container { max-width: 800px; margin: 0 auto; padding: 24px 24px 40px; }
        h2 { color: #06C270; text-align: center; margin-bottom: 30px; }

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

        /* ===== 头像悬停下拉菜单 ===== */
        .user-dropdown-wrap { position: relative; display: inline-block; }
        .user-dropdown-wrap .user-trigger { display: flex; align-items: center; gap: 10px; cursor: pointer; padding: 4px 8px; border-radius: 24px; transition: background 0.2s; }
        .user-dropdown-wrap .user-trigger:hover { background: #f5f5f5; }
        .user-dropdown-menu { display: none; position: absolute; top: calc(100% + 8px); right: 0; background: #FFFFFF; border-radius: 16px; box-shadow: 0 8px 32px rgba(0,0,0,0.15); min-width: 240px; padding: 20px; z-index: 200; border: 1px solid #f0f0f0; }
        .user-dropdown-wrap:hover .user-dropdown-menu { display: block; }
        .user-dropdown-menu .dropdown-header { display: flex; align-items: center; gap: 12px; padding-bottom: 14px; border-bottom: 1px solid #f0f0f0; margin-bottom: 12px; }
        .user-dropdown-menu .dropdown-avatar { width: 44px; height: 44px; border-radius: 50%; background: linear-gradient(135deg, #FFD166, #06C270); display: flex; align-items: center; justify-content: center; font-size: 18px; font-weight: 700; color: #FFFFFF; flex-shrink: 0; }
        .user-dropdown-menu .dropdown-name { font-size: 16px; font-weight: 700; color: #2D2D2D; }
        .user-dropdown-menu .dropdown-role { font-size: 12px; color: #999; margin-top: 2px; }
        .user-dropdown-menu .dropdown-info { padding: 8px 0; font-size: 13px; color: #888; border-bottom: 1px solid #f0f0f0; margin-bottom: 12px; }
        .user-dropdown-menu .dropdown-info div { padding: 4px 0; }
        .user-dropdown-menu .dropdown-links { display: flex; flex-direction: column; gap: 4px; }
        .user-dropdown-menu .dropdown-links a { display: flex; align-items: center; gap: 8px; padding: 10px 12px; border-radius: 10px; font-size: 14px; font-weight: 500; color: #333; transition: background 0.2s; text-decoration: none; }
        .user-dropdown-menu .dropdown-links a:hover { background: #E8FAF0; color: #06C270; }
        .user-dropdown-menu .dropdown-links .logout-link { color: #FF6B6B; }
        .user-dropdown-menu .dropdown-links .logout-link:hover { background: #FFE8E8; color: #FF4444; }

        .empty-state { text-align: center; padding: 80px 20px; background: #fff; border-radius: 16px; box-shadow: 0 4px 16px rgba(0,0,0,0.06); }
        .empty-state .icon { font-size: 64px; margin-bottom: 20px; }
        .empty-state p { font-size: 18px; color: #666; }
        .empty-state .btn-service {
            display: inline-block; margin-top: 20px; background: #06C270; color: #fff;
            padding: 12px 36px; border-radius: 24px; font-weight: bold; text-decoration: none;
        }
        .review-card {
            background: #fff; border-radius: 16px; padding: 24px; margin-bottom: 20px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06); border-left: 4px solid #06C270;
        }
        .review-card .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
        .review-card .service-name { font-size: 18px; font-weight: bold; color: #333; }
        .review-card .stars { color: #FFD166; font-size: 22px; }
        .review-card .content { font-size: 15px; color: #444; line-height: 1.7; margin: 8px 0; padding: 12px 16px; background: #F8FFF8; border-radius: 8px; }
        .review-card .meta { font-size: 13px; color: #AAA; display: flex; gap: 16px; }
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
                    <div class="user-dropdown-wrap">
                        <div class="user-trigger">
                            <div class="user-avatar">
                                <c:out value="${fn:substring(sessionScope.user.username, 0, 1)}" />
                            </div>
                            <span class="username"><c:out value="${sessionScope.user.username}" /></span>
                        </div>
                        <div class="user-dropdown-menu">
                            <div class="dropdown-header">
                                <div class="dropdown-avatar">
                                    <c:out value="${fn:substring(sessionScope.user.username, 0, 1)}" />
                                </div>
                                <div>
                                    <div class="dropdown-name"><c:out value="${sessionScope.user.username}" /></div>
                                    <div class="dropdown-role">
                                        <c:choose>
                                            <c:when test="${sessionScope.user.role == 0}">普通用户</c:when>
                                            <c:when test="${sessionScope.user.role == 1}">商家</c:when>
                                            <c:when test="${sessionScope.user.role == 2}">管理员</c:when>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                            <div class="dropdown-info">
                                <div>📱 <c:out value="${empty sessionScope.user.phone ? '未设置手机号' : sessionScope.user.phone}" /></div>
                            </div>
                            <div class="dropdown-links">
                                <a href="${pageContext.request.contextPath}/view/user/profile.jsp">👤 个人中心</a>
                                <a href="${pageContext.request.contextPath}/orderServlet?action=myOrders">📅 我的预约</a>
                                <a href="${pageContext.request.contextPath}/favoriteServlet?action=list">⭐ 我的收藏</a>
                                <a href="${pageContext.request.contextPath}/userServlet?action=logout" class="logout-link">🚪 退出登录</a>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<div class="container">
    <a href="${pageContext.request.contextPath}/" style="display: inline-block; margin-bottom: 20px; color: #06C270; text-decoration: none; font-weight: bold;">⬅ 返回主页</a>
    <h2>⭐ 我的评价</h2>

    <c:choose>
        <c:when test="${empty requestScope.reviewList}">
            <div class="empty-state">
                <div class="icon">📭</div>
                <p>您还没有发表过评价</p>
                <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list" class="btn-service">去预约服务</a>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${requestScope.reviewList}" var="r">
                <div class="review-card">
                    <div class="header">
                        <div class="service-name">${r.serviceTitle}</div>
                        <div class="stars">
                            <c:forEach begin="1" end="5" var="i">
                                <c:choose>
                                    <c:when test="${i <= r.rating}">★</c:when>
                                    <c:otherwise>☆</c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="content">${r.reviewContent}</div>
                    <div class="meta">
                        <span>🐾 ${r.petName}</span>
                        <span>📅 ${fn:replace(r.reviewTime, 'T', ' ')}</span>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
