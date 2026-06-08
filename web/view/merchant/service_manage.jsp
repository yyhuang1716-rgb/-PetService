<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>服务管理 - 萌宠之家</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
            background: #F0F2F5;
            display: flex;
            min-height: 100vh;
            color: #1A1A2E;
        }

        /* ====== 左侧边栏 ====== */
        .sidebar {
            width: 260px;
            background: linear-gradient(180deg, #00D2D3 0%, #089B9C 100%);
            color: #fff;
            display: flex;
            flex-direction: column;
            flex-shrink: 0;
            box-shadow: 4px 0 20px rgba(0, 210, 211, 0.18);
            position: sticky;
            top: 0;
            height: 100vh;
        }
        .sidebar-header {
            padding: 34px 24px 22px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.12);
        }
        .sidebar-header .logo {
            font-size: 26px;
            font-weight: 800;
            letter-spacing: 2px;
        }
        .sidebar-header .logo span { color: #FF6B81; }
        .sidebar-header .sub {
            font-size: 14px;
            opacity: 0.7;
            margin-top: 6px;
            letter-spacing: 3px;
        }
        .sidebar-nav { padding: 20px 0; flex: 1; }
        .sidebar-nav a {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 16px 28px;
            color: rgba(255, 255, 255, 0.82);
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.25s;
            border-left: 4px solid transparent;
            cursor: pointer;
        }
        .sidebar-nav a:hover {
            background: rgba(255, 255, 255, 0.14);
            color: #fff;
            padding-left: 32px;
        }
        .sidebar-nav a.active {
            background: rgba(255, 255, 255, 0.16);
            color: #fff;
            border-left-color: #FF6B81;
            font-weight: 700;
        }
        .sidebar-nav .icon { font-size: 20px; }
        .sidebar-footer {
            padding: 18px 24px;
            border-top: 1px solid rgba(255,255,255,0.12);
            font-size: 13px;
            opacity: 0.55;
            text-align: center;
            letter-spacing: 1px;
        }

        /* ====== 右侧主区域 ====== */
        .main {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        /* ====== 顶部栏 ====== */
        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 22px 40px;
            background: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        .topbar h3 {
            font-size: 18px;
            font-weight: 500;
            color: #555;
        }
        .topbar h3 strong { color: #FF6B81; font-weight: 700; font-size: 20px; }
        .topbar-right { display: flex; align-items: center; gap: 24px; }
        .topbar-right .badge {
            font-size: 14px;
            color: #00D2D3;
            font-weight: 700;
            background: rgba(0, 210, 211, 0.08);
            padding: 4px 14px;
            border-radius: 20px;
        }
        .btn-logout {
            background: #FF6B81;
            color: #fff;
            border: none;
            padding: 9px 22px;
            border-radius: 22px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.25s, transform 0.2s;
        }
        .btn-logout:hover { background: #E55A6F; transform: scale(1.03); }

        /* ====== 内容区域 ====== */
        .content {
            padding: 36px 40px;
            flex: 1;
        }
        .content-title {
            font-size: 26px;
            font-weight: 700;
            color: #1A1A2E;
            margin-bottom: 8px;
            letter-spacing: 1px;
        }
        .content-sub {
            font-size: 15px;
            color: #999;
            margin-bottom: 28px;
        }

        /* ====== 顶栏操作行 ====== */
        .toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            flex-wrap: wrap;
            gap: 12px;
        }
        .btn-add {
            background: #FF6B81;
            color: #fff;
            border: none;
            padding: 11px 26px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.25s, transform 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-add:hover { background: #E55A6F; transform: scale(1.02); }

        .search-box {
            display: flex;
            gap: 0;
            border-radius: 10px;
            overflow: hidden;
            border: 1px solid #E0E0E0;
            background: #fff;
        }
        .search-box input {
            border: none;
            padding: 10px 16px;
            font-size: 14px;
            outline: none;
            width: 220px;
        }
        .search-box button {
            background: #00D2D3;
            color: #fff;
            border: none;
            padding: 10px 18px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.25s;
        }
        .search-box button:hover { background: #089B9C; }

        /* ====== 服务卡片网格 ====== */
        .service-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 20px;
        }
        .service-card {
            background: #fff;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.04);
            transition: transform 0.25s, box-shadow 0.25s;
            border-left: 5px solid #00D2D3;
            display: flex;
            flex-direction: column;
        }
        .service-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 28px rgba(0,0,0,0.08);
        }
        .service-card .svc-title {
            font-size: 18px;
            font-weight: 700;
            color: #1A1A2E;
            margin-bottom: 6px;
        }
        .service-card .svc-price {
            font-size: 24px;
            font-weight: 800;
            color: #FF6B81;
            margin: 6px 0 10px;
        }
        .service-card .svc-desc {
            font-size: 14px;
            color: #888;
            line-height: 1.6;
            flex: 1;
            margin-bottom: 16px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .service-card .svc-actions {
            display: flex;
            gap: 10px;
            border-top: 1px solid #F0F0F0;
            padding-top: 14px;
        }
        .svc-btn {
            flex: 1;
            text-align: center;
            padding: 8px 0;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.25s;
            border: none;
        }
        .svc-btn.edit {
            background: rgba(0, 210, 211, 0.10);
            color: #00D2D3;
        }
        .svc-btn.edit:hover { background: #00D2D3; color: #fff; }
        .svc-btn.delete {
            background: rgba(255, 107, 129, 0.10);
            color: #FF6B81;
        }
        .svc-btn.delete:hover { background: #FF6B81; color: #fff; }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.04);
        }
        .empty-state .icon { font-size: 56px; margin-bottom: 16px; }
        .empty-state p { font-size: 16px; color: #999; }

        /* ====== 响应式 ====== */
        @media (max-width: 768px) {
            .sidebar { width: 72px; }
            .sidebar-header .logo,
            .sidebar-header .sub,
            .sidebar-nav a span { display: none; }
            .sidebar-nav a { justify-content: center; padding: 16px 0; }
            .topbar { padding: 16px 20px; }
            .content { padding: 24px 16px; }
            .search-box input { width: 140px; }
        }
    </style>
</head>
<body>

<!-- ===== 左侧边栏 ===== -->
<div class="sidebar">
    <div class="sidebar-header">
        <div class="logo">🐾 <span>萌宠</span>之家</div>
        <div class="sub">商家管理后台</div>
    </div>
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/view/merchant/home.jsp">
            <span class="icon">🏠</span><span>工作台首页</span>
        </a>
        <a href="${pageContext.request.contextPath}/orderServlet?action=manageList">
            <span class="icon">📋</span><span>订单管理</span>
        </a>
        <a href="${pageContext.request.contextPath}/serviceItemServlet?action=manageList" class="active">
            <span class="icon">🛠</span><span>服务管理</span>
        </a>
        <a href="javascript:void(0);" onclick="alert('店铺设置功能正在建设中...')">
            <span class="icon">⚙️</span><span>店铺设置</span>
        </a>
    </nav>
    <div class="sidebar-footer">萌宠之家 v1.0</div>
</div>

<!-- ===== 右侧主区域 ===== -->
<div class="main">

    <!-- 顶部栏 -->
    <div class="topbar">
        <h3>欢迎回来，<strong>${sessionScope.user.username}</strong> <span class="badge">商家</span></h3>
        <div class="topbar-right">
            <a href="${pageContext.request.contextPath}/userServlet?action=logout" class="btn-logout">退出登录</a>
        </div>
    </div>

    <!-- 内容区域 -->
    <div class="content">
        <div class="content-title">🛠 服务项目管理</div>
        <div class="content-sub">管理您店铺提供的所有宠物服务项目</div>

        <!-- 工具栏 -->
        <div class="toolbar">
            <a href="${pageContext.request.contextPath}/serviceItemServlet?action=toAdd" class="btn-add">＋ 发布新服务</a>
            <div class="search-box">
                <input type="text" placeholder="搜索服务名称..." disabled>
                <button onclick="alert('🔍 搜索功能即将上线')">搜索</button>
            </div>
        </div>

        <!-- 服务列表 -->
        <c:choose>
            <c:when test="${empty requestScope.serviceList}">
                <div class="empty-state">
                    <div class="icon">📭</div>
                    <p>暂无服务项目，点击上方「发布新服务」开始添加</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="service-grid">
                    <c:forEach items="${requestScope.serviceList}" var="svc">
                        <div class="service-card">
                            <div class="svc-title">${svc.title}</div>
                            <div class="svc-price">¥${svc.price}</div>
                            <div class="svc-desc">${not empty svc.description ? svc.description : '暂无描述'}</div>
                            <div class="svc-actions">
                                <a href="${pageContext.request.contextPath}/serviceItemServlet?action=toEdit&id=${svc.id}" class="svc-btn edit">✏️ 编辑</a>
                                <a href="javascript:if(confirm('确定要下架该服务吗？')) location.href='${pageContext.request.contextPath}/serviceItemServlet?action=delete&id=${svc.id}'" class="svc-btn delete">🗑️ 下架</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>
