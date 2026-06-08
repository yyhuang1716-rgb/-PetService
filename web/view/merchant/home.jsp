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
            margin-bottom: 28px;
            letter-spacing: 1px;
        }

        /* ====== 数据卡片网格 ====== */
        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 24px;
        }
        .stat-card {
            background: #fff;
            border-radius: 18px;
            padding: 32px;
            box-shadow: 0 6px 24px rgba(0,0,0,0.05);
            transition: transform 0.25s, box-shadow 0.25s;
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 14px 36px rgba(0,0,0,0.10);
        }
        .stat-card:active { transform: translateY(-2px); }
        .stat-card .card-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }
        .stat-card .card-icon {
            width: 56px;
            height: 56px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
        }
        .stat-card .card-label {
            font-size: 18px;
            color: #888;
            font-weight: 500;
            margin-bottom: 10px;
        }
        .stat-card .card-value {
            font-size: 46px;
            font-weight: 800;
            color: #1A1A2E;
            margin: 4px 0 6px;
            line-height: 1.1;
        }
        .stat-card .card-footer {
            font-size: 14px;
            color: #AAA;
            margin-top: 12px;
            letter-spacing: 0.5px;
        }

        /* 6px 厚实彩色左边框 */
        .card-pink { border-left: 6px solid #FF6B81; }
        .card-pink .card-icon { background: rgba(255, 107, 129, 0.10); color: #FF6B81; }
        .card-blue { border-left: 6px solid #00D2D3; }
        .card-blue .card-icon { background: rgba(0, 210, 211, 0.10); color: #00D2D3; }

        /* ====== 快速操作区域 ====== */
        .quick-actions {
            margin-top: 40px;
        }
        .quick-actions .qa-title {
            font-size: 22px;
            font-weight: 700;
            color: #1A1A2E;
            margin-bottom: 20px;
            letter-spacing: 1px;
        }
        .qa-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 18px;
        }
        .qa-card {
            background: #fff;
            border-radius: 16px;
            padding: 26px 24px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.04);
            cursor: pointer;
            transition: transform 0.25s, box-shadow 0.25s;
            display: flex;
            align-items: center;
            gap: 16px;
            border: 2px solid transparent;
        }
        .qa-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 28px rgba(0,0,0,0.08);
        }
        .qa-card:active { transform: translateY(-1px); }
        .qa-card .qa-icon {
            width: 50px;
            height: 50px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            flex-shrink: 0;
        }
        .qa-card .qa-info { flex: 1; }
        .qa-card .qa-info .qa-label {
            font-size: 16px;
            font-weight: 700;
            color: #333;
        }
        .qa-card .qa-info .qa-desc {
            font-size: 13px;
            color: #999;
            margin-top: 3px;
        }
        .qa-card .qa-arrow {
            font-size: 18px;
            color: #CCC;
            transition: color 0.2s, transform 0.2s;
        }
        .qa-card:hover .qa-arrow { color: #FF6B81; transform: translateX(4px); }

        .qa-pink { border-color: rgba(255, 107, 129, 0.20); }
        .qa-pink .qa-icon { background: rgba(255, 107, 129, 0.10); color: #FF6B81; }
        .qa-pink:hover { border-color: #FF6B81; }

        .qa-blue { border-color: rgba(0, 210, 211, 0.20); }
        .qa-blue .qa-icon { background: rgba(0, 210, 211, 0.10); color: #00D2D3; }
        .qa-blue:hover { border-color: #00D2D3; }

        .qa-purple { border-color: rgba(108, 92, 231, 0.20); }
        .qa-purple .qa-icon { background: rgba(108, 92, 231, 0.10); color: #6C5CE7; }
        .qa-purple:hover { border-color: #6C5CE7; }

        /* ====== 响应式 ====== */
        @media (max-width: 768px) {
            .sidebar { width: 72px; }
            .sidebar-header .logo,
            .sidebar-header .sub,
            .sidebar-nav a span { display: none; }
            .sidebar-nav a { justify-content: center; padding: 16px 0; }
            .topbar { padding: 16px 20px; }
            .content { padding: 24px 16px; }
            .stat-card .card-value { font-size: 34px; }
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
        <a href="${pageContext.request.contextPath}/serviceItemServlet?action=manageList">
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
        <div class="content-title">📊 数据看板</div>

        <!-- 4 个可点击数据卡片 -->
        <div class="card-grid">
            <div class="stat-card card-pink"
                 onclick="location.href='${pageContext.request.contextPath}/orderServlet?action=manageList'">
                <div class="card-top">
                    <div>
                        <div class="card-label">今日新订单</div>
                        <div class="card-value">12</div>
                    </div>
                    <div class="card-icon">📦</div>
                </div>
                <div class="card-footer">📈 较昨日 ↑ 3 单</div>
            </div>

            <div class="stat-card card-blue"
                 onclick="location.href='${pageContext.request.contextPath}/orderServlet?action=manageList'">
                <div class="card-top">
                    <div>
                        <div class="card-label">待处理预约</div>
                        <div class="card-value">5</div>
                    </div>
                    <div class="card-icon">⏳</div>
                </div>
                <div class="card-footer">⚡ 需要及时确认</div>
            </div>

            <div class="stat-card card-pink"
                 onclick="alert('🎯 本月营业额详细报表即将上线，敬请期待！')">
                <div class="card-top">
                    <div>
                        <div class="card-label">本月营业额</div>
                        <div class="card-value">¥3,680</div>
                    </div>
                    <div class="card-icon">💰</div>
                </div>
                <div class="card-footer">🎯 月度目标已完成 60%</div>
            </div>

            <div class="stat-card card-blue"
                 onclick="location.href='${pageContext.request.contextPath}/serviceItemServlet?action=manageList'">
                <div class="card-top">
                    <div>
                        <div class="card-label">服务中宠物</div>
                        <div class="card-value">8</div>
                    </div>
                    <div class="card-icon">🐕</div>
                </div>
                <div class="card-footer">🔧 当前正在服务</div>
            </div>
        </div>

        <!-- ====== 快速操作区域 ====== -->
        <div class="quick-actions">
            <div class="qa-title">⚡ 快速操作</div>
            <div class="qa-grid">
                <!-- 发布新服务 -->
                <div class="qa-card qa-pink"
                     onclick="location.href='${pageContext.request.contextPath}/serviceItemServlet?action=manageList'">
                    <div class="qa-icon">📢</div>
                    <div class="qa-info">
                        <div class="qa-label">发布新服务</div>
                        <div class="qa-desc">上架新的宠物服务项目</div>
                    </div>
                    <div class="qa-arrow">→</div>
                </div>

                <!-- 导出财务报表 -->
                <div class="qa-card qa-blue"
                     onclick="alert('✅ 财务报表已开始生成，请稍后查看下载！')">
                    <div class="qa-icon">📊</div>
                    <div class="qa-info">
                        <div class="qa-label">导出财务报表</div>
                        <div class="qa-desc">下载月度经营数据报表</div>
                    </div>
                    <div class="qa-arrow">→</div>
                </div>

                <!-- 查看客户评价 -->
                <div class="qa-card qa-purple"
                     onclick="alert('💬 客户评价功能正在建设中，敬请期待！')">
                    <div class="qa-icon">💬</div>
                    <div class="qa-info">
                        <div class="qa-label">查看客户评价</div>
                        <div class="qa-desc">浏览用户反馈与评分</div>
                    </div>
                    <div class="qa-arrow">→</div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
