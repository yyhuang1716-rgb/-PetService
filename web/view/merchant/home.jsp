<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>商家工作台 - 萌宠之家</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
            background: #F8F9FC;
            display: flex;
            min-height: 100vh;
            color: #2D2D2D;
        }

        /* ====== 左侧边栏 ====== */
        .sidebar {
            width: 240px;
            background: linear-gradient(180deg, #00D2D3 0%, #0AB3B4 100%);
            color: #fff;
            display: flex;
            flex-direction: column;
            flex-shrink: 0;
            box-shadow: 2px 0 12px rgba(0, 210, 211, 0.15);
        }
        .sidebar-header {
            padding: 28px 20px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.15);
        }
        .sidebar-header .logo {
            font-size: 22px;
            font-weight: 700;
            letter-spacing: 1px;
        }
        .sidebar-header .logo span { color: #FF6B81; }
        .sidebar-header .sub {
            font-size: 12px;
            opacity: 0.75;
            margin-top: 4px;
        }
        .sidebar-nav { padding: 16px 0; flex: 1; }
        .sidebar-nav a {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 13px 24px;
            color: rgba(255, 255, 255, 0.85);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.25s;
            border-left: 3px solid transparent;
        }
        .sidebar-nav a:hover {
            background: rgba(255, 255, 255, 0.12);
            color: #fff;
        }
        .sidebar-nav a.active {
            background: rgba(255, 255, 255, 0.15);
            color: #fff;
            border-left-color: #FF6B81;
            font-weight: 600;
        }
        .sidebar-nav .icon { font-size: 18px; }

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
            padding: 18px 32px;
            background: #fff;
            box-shadow: 0 1px 4px rgba(0,0,0,0.04);
        }
        .topbar h3 {
            font-size: 16px;
            font-weight: 500;
            color: #555;
        }
        .topbar h3 strong { color: #FF6B81; font-weight: 700; }
        .topbar-right { display: flex; align-items: center; gap: 20px; }
        .topbar-right .badge {
            font-size: 13px;
            color: #00D2D3;
            font-weight: 600;
        }
        .btn-logout {
            background: #FF6B81;
            color: #fff;
            border: none;
            padding: 7px 18px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.25s;
        }
        .btn-logout:hover { background: #E55A6F; }

        /* ====== 内容区域 ====== */
        .content {
            padding: 28px 32px;
            flex: 1;
        }
        .content-title {
            font-size: 20px;
            font-weight: 600;
            color: #333;
            margin-bottom: 24px;
        }

        /* ====== 数据卡片网格 ====== */
        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(230px, 1fr));
            gap: 20px;
        }
        .stat-card {
            background: #fff;
            border-radius: 14px;
            padding: 24px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.04);
            transition: transform 0.2s, box-shadow 0.2s;
            position: relative;
            overflow: hidden;
        }
        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
        }
        .stat-card .card-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }
        .stat-card .card-icon {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }
        .stat-card .card-label {
            font-size: 14px;
            color: #888;
            font-weight: 500;
            margin-bottom: 8px;
        }
        .stat-card .card-value {
            font-size: 32px;
            font-weight: 700;
            color: #333;
            margin: 6px 0 4px;
        }
        .stat-card .card-footer {
            font-size: 12px;
            color: #AAA;
            margin-top: 8px;
        }

        /* 边框主题色 */
        .card-pink { border-left: 4px solid #FF6B81; }
        .card-pink .card-icon { background: rgba(255, 107, 129, 0.10); color: #FF6B81; }
        .card-blue { border-left: 4px solid #00D2D3; }
        .card-blue .card-icon { background: rgba(0, 210, 211, 0.10); color: #00D2D3; }

        /* ====== 快速操作 ====== */
        .quick-actions {
            margin-top: 32px;
        }
        .quick-actions h4 {
            font-size: 16px;
            font-weight: 600;
            color: #555;
            margin-bottom: 14px;
        }
        .action-btns { display: flex; gap: 14px; flex-wrap: wrap; }
        .action-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 22px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.25s;
            border: none;
            cursor: pointer;
        }
        .action-btn.primary { background: #FF6B81; color: #fff; }
        .action-btn.primary:hover { background: #E55A6F; }
        .action-btn.secondary { background: #00D2D3; color: #fff; }
        .action-btn.secondary:hover { background: #0AB3B4; }
        .action-btn.outline {
            background: transparent;
            color: #FF6B81;
            border: 2px solid #FF6B81;
        }
        .action-btn.outline:hover { background: #FF6B81; color: #fff; }

        /* ====== 响应式 ====== */
        @media (max-width: 768px) {
            .sidebar { width: 60px; }
            .sidebar-header .logo,
            .sidebar-header .sub,
            .sidebar-nav a span { display: none; }
            .sidebar-nav a { justify-content: center; padding: 13px 0; }
            .topbar { padding: 14px 16px; }
            .content { padding: 20px 16px; }
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
        <a href="${pageContext.request.contextPath}/view/merchant/home.jsp" class="active">
            <span class="icon">🏠</span><span>工作台首页</span>
        </a>
        <a href="${pageContext.request.contextPath}/orderServlet?action=manageList">
            <span class="icon">📋</span><span>订单管理</span>
        </a>
        <a href="#">
            <span class="icon">🛠</span><span>服务管理</span>
        </a>
        <a href="#">
            <span class="icon">⚙️</span><span>店铺设置</span>
        </a>
    </nav>
    <div style="padding: 16px 20px; border-top: 1px solid rgba(255,255,255,0.15); font-size: 12px; opacity: 0.6; text-align: center;">
        v1.0
    </div>
</div>

<!-- ===== 右侧主区域 ===== -->
<div class="main">

    <!-- 顶部栏 -->
    <div class="topbar">
        <h3>欢迎回来，<strong>${sessionScope.user.username}</strong> <span class="badge">(商家)</span></h3>
        <div class="topbar-right">
            <a href="${pageContext.request.contextPath}/userServlet?action=logout" class="btn-logout">退出登录</a>
        </div>
    </div>

    <!-- 内容区域 -->
    <div class="content">
        <div class="content-title">📊 数据看板</div>

        <!-- 4 个数据卡片 -->
        <div class="card-grid">
            <div class="stat-card card-pink">
                <div class="card-top">
                    <div>
                        <div class="card-label">今日新订单</div>
                        <div class="card-value">12</div>
                    </div>
                    <div class="card-icon">📦</div>
                </div>
                <div class="card-footer">较昨日 ↑ 3 单</div>
            </div>

            <div class="stat-card card-blue">
                <div class="card-top">
                    <div>
                        <div class="card-label">待处理预约</div>
                        <div class="card-value">5</div>
                    </div>
                    <div class="card-icon">⏳</div>
                </div>
                <div class="card-footer">需要及时确认</div>
            </div>

            <div class="stat-card card-pink">
                <div class="card-top">
                    <div>
                        <div class="card-label">本月营业额</div>
                        <div class="card-value">¥3,680</div>
                    </div>
                    <div class="card-icon">💰</div>
                </div>
                <div class="card-footer">月度目标 60%</div>
            </div>

            <div class="stat-card card-blue">
                <div class="card-top">
                    <div>
                        <div class="card-label">服务中宠物</div>
                        <div class="card-value">8</div>
                    </div>
                    <div class="card-icon">🐕</div>
                </div>
                <div class="card-footer">当前正在服务</div>
            </div>
        </div>

        <!-- 快速操作 -->
        <div class="quick-actions">
            <h4>⚡ 快速操作</h4>
            <div class="action-btns">
                <a href="${pageContext.request.contextPath}/orderServlet?action=manageList" class="action-btn primary">📋 查看全部订单</a>
                <a href="${pageContext.request.contextPath}/orderServlet?action=manageList" class="action-btn secondary">✅ 处理待接单</a>
                <a href="#" class="action-btn outline">🛠 管理服务项目</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
