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
            background: linear-gradient(180deg, #001A1A 0%, #000F0F 100%);
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

        /* ====== 订单管理表格 ====== */
        .order-table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        .order-table th {
            background: #FF6B81;
            color: #fff;
            padding: 14px 12px;
            text-align: left;
            font-size: 14px;
            white-space: nowrap;
        }
        .order-table td {
            padding: 12px;
            border-bottom: 1px solid #F0F0F0;
            font-size: 14px;
            vertical-align: middle;
        }
        .order-table tr:last-child td { border-bottom: none; }
        .order-table tr:hover { background: #FFF5F7; }
        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: bold;
        }
        .status-pending { background: #FFF3CD; color: #856404; }
        .status-accepted { background: #D4EDDA; color: #155724; }
        .status-service { background: #CCE5FF; color: #004085; }
        .status-done { background: #E2E3E5; color: #383D41; }
        .status-reviewed { background: #D4EDDA; color: #155724; }
        .status-cancel { background: #F8D7DA; color: #721C24; }
        .btn-accept {
            display: inline-block;
            background: #FF6B81;
            color: white;
            text-decoration: none;
            padding: 6px 18px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
            border: none;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn-accept:hover { background: #E55A6F; }
        .btn-complete {
            display: inline-block;
            background: #00D2D3;
            color: white;
            text-decoration: none;
            padding: 6px 18px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
            border: none;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn-complete:hover { background: #089B9C; }
        .remark-text {
            max-width: 200px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            color: #666;
        }
        .star-rating {
            color: #FFD166;
            font-size: 16px;
            letter-spacing: 2px;
        }
        .star-empty { color: #DDD; }
        .review-preview {
            max-width: 180px;
            font-size: 12px;
            color: #666;
            margin-top: 4px;
            line-height: 1.4;
            background: #FFF5F7;
            padding: 4px 8px;
            border-radius: 6px;
            border-left: 3px solid #FF6B81;
        }
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        .empty-state .icon { font-size: 64px; margin-bottom: 20px; }
        .empty-state p { font-size: 18px; color: #666; }

        /* ====== 服务管理 ====== */
        .content-sub {
            font-size: 15px;
            color: #999;
            margin-bottom: 28px;
        }
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
            border-left: 5px solid #FF6B81;
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

        /* ====== 服务中项目卡片 ====== */
        .ing-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 20px;
        }
        .ing-card {
            background: #fff;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.04);
            border-left: 4px solid #00D2D3;
            position: relative;
            transition: transform 0.25s, box-shadow 0.25s;
        }
        .ing-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 28px rgba(0,0,0,0.08);
        }
        .ing-card .service-name {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin: 0 0 8px 0;
        }
        .ing-card .meta {
            font-size: 14px;
            color: #888;
            margin: 4px 0;
        }
        .ing-card .meta span {
            color: #333;
            font-weight: 500;
        }
        .ing-card .price {
            color: #FF6B81;
            font-size: 22px;
            font-weight: bold;
            margin: 12px 0;
        }
        .ing-tag {
            position: absolute;
            top: 16px;
            right: 16px;
            background: #00D2D3;
            color: #fff;
            padding: 4px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        /* ====== 发布新服务表单 ====== */
        .form-wrapper {
            background: #fff;
            border-radius: 18px;
            padding: 40px 44px;
            box-shadow: 0 6px 24px rgba(0,0,0,0.05);
            max-width: 720px;
        }
        .form-group { margin-bottom: 24px; }
        .form-group label {
            display: block;
            font-size: 15px;
            font-weight: 600;
            color: #444;
            margin-bottom: 8px;
        }
        .form-group label .required { color: #FF6B81; margin-left: 2px; }
        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 1.5px solid #E0E0E0;
            border-radius: 10px;
            font-size: 15px;
            font-family: inherit;
            color: #333;
            transition: border-color 0.25s, box-shadow 0.25s;
            outline: none;
            background: #FAFAFA;
        }
        .form-control:focus {
            border-color: #FF6B81;
            box-shadow: 0 0 0 3px rgba(255, 107, 129, 0.10);
            background: #fff;
        }
        .form-control::placeholder { color: #BBB; }
        textarea.form-control { min-height: 120px; resize: vertical; }
        select.form-control {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%23999' d='M6 8L0 0h12z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 14px center;
            padding-right: 36px;
        }
        .form-actions {
            display: flex;
            gap: 14px;
            margin-top: 8px;
            padding-top: 20px;
            border-top: 1px solid #F0F0F0;
        }
        .btn-submit {
            background: #FF6B81;
            color: #fff;
            border: none;
            padding: 12px 36px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.25s, transform 0.2s;
        }
        .btn-submit:hover { background: #E55A6F; transform: scale(1.02); }
        .btn-back {
            background: #00D2D3;
            color: #fff;
            border: none;
            padding: 12px 36px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.25s, transform 0.2s;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        .btn-back:hover { background: #089B9C; transform: scale(1.02); }

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
        <a href="${pageContext.request.contextPath}/orderServlet?action=home"
           class="${empty contentPage ? 'active' : ''}">
            <span class="icon">🏠</span><span>工作台首页</span>
        </a>
        <a href="${pageContext.request.contextPath}/orderServlet?action=manageList"
           class="${contentPage == 'orders' ? 'active' : ''}">
            <span class="icon">📋</span><span>订单管理</span>
        </a>
        <a href="${pageContext.request.contextPath}/serviceItemServlet?action=manageList"
           class="${contentPage == 'services' || contentPage == 'serviceEdit' ? 'active' : ''}">
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

        <%-- ========== 工作台首页（数据看板） ========== --%>
        <c:if test="${empty contentPage}">
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
                 onclick="location.href='${pageContext.request.contextPath}/orderServlet?action=serviceIng'">
                <div class="card-top">
                    <div>
                        <div class="card-label">服务中宠物</div>
                        <div class="card-value">${not empty serviceIngCount ? serviceIngCount : 0}</div>
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
                     onclick="location.href='${pageContext.request.contextPath}/serviceItemServlet?action=toAdd'">
                    <div class="qa-icon">📢</div>
                    <div class="qa-info">
                        <div class="qa-label">发布新服务</div>
                        <div class="qa-desc">上架新的宠物服务项目</div>
                    </div>
                    <div class="qa-arrow">→</div>
                </div>

                <!-- 导出财务报表 -->
                <div class="qa-card qa-blue"
                     onclick="location.href='${pageContext.request.contextPath}/orderServlet?action=exportReport'">
                    <div class="qa-icon">📊</div>
                    <div class="qa-info">
                        <div class="qa-label">导出财务报表</div>
                        <div class="qa-desc">下载月度经营数据报表</div>
                    </div>
                    <div class="qa-arrow">→</div>
                </div>

            </div>
        </div>
        </c:if>

        <%-- ========== 订单管理 ========== --%>
        <c:if test="${contentPage == 'orders'}">
        <div class="content-title">📋 订单管理</div>

        <c:choose>
            <c:when test="${empty requestScope.orderList}">
                <div class="empty-state">
                    <div class="icon">📭</div>
                    <p>暂无订单</p>
                </div>
            </c:when>
            <c:otherwise>
                <table class="order-table">
                    <thead>
                    <tr>
                        <th>订单号</th>
                        <th>用户名</th>
                        <th>宠物名</th>
                        <th>服务名称</th>
                        <th>预约时间</th>
                        <th>备注</th>
                        <th>状态</th>
                        <th>客户评价</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${requestScope.orderList}" var="order">
                        <tr>
                            <td>${order.id}</td>
                            <td>${order.username}</td>
                            <td>${order.petName}</td>
                            <td>${order.serviceTitle}</td>
                            <td>${fn:replace(order.appointTime, 'T', ' ')}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty order.remark}">
                                        <span style="color: #CCC;">-</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="remark-text" title="${order.remark}">${order.remark}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 0}">
                                        <span class="status-badge status-pending">⏳ 待接单</span>
                                    </c:when>
                                    <c:when test="${order.status == 1}">
                                        <span class="status-badge status-accepted">✅ 已接单</span>
                                    </c:when>
                                    <c:when test="${order.status == 2}">
                                        <span class="status-badge status-service">🔧 服务中</span>
                                    </c:when>
                                    <c:when test="${order.status == 3}">
                                        <span class="status-badge status-done">✔️ 已完成</span>
                                    </c:when>
                                    <c:when test="${order.status == 5}">
                                        <span class="status-badge status-reviewed">⭐ 已评价</span>
                                    </c:when>
                                    <c:when test="${order.status == 4}">
                                        <span class="status-badge status-cancel">❌ 已取消</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-done">${order.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty order.rating}">
                                        <div class="star-rating">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= order.rating}">★</c:when>
                                                    <c:otherwise><span class="star-empty">★</span></c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                        <c:if test="${not empty order.reviewContent}">
                                            <div class="review-preview" title="${order.reviewContent}">${order.reviewContent}</div>
                                        </c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #CCC; font-size: 13px;">-</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${order.status == 0}">
                                    <a href="${pageContext.request.contextPath}/orderServlet?action=acceptOrder&orderId=${order.id}"
                                       class="btn-accept">接单</a>
                                </c:if>
                                <c:if test="${order.status == 1}">
                                    <a href="${pageContext.request.contextPath}/orderServlet?action=completeOrder&orderId=${order.id}"
                                       class="btn-complete">完成服务</a>
                                </c:if>
                                <c:if test="${order.status != 0 && order.status != 1}">
                                    <span style="color: #999; font-size: 13px;">-</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
        </c:if>

        <%-- ========== 服务管理 ========== --%>
        <c:if test="${contentPage == 'services'}">
        <div class="content-title">🛠 服务项目管理</div>
        <div class="content-sub">管理您店铺提供的所有宠物服务项目</div>

        <!-- 工具栏 -->
        <div class="toolbar">
            <a href="${pageContext.request.contextPath}/serviceItemServlet?action=toAdd" class="btn-add">＋ 发布新服务</a>
            <form action="${pageContext.request.contextPath}/serviceItemServlet?action=manageList" method="post" class="search-box">
                <input type="text" name="keyword" placeholder="搜索服务名称..." value="${param.keyword}">
                <button type="submit">🔍 搜索</button>
            </form>
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
        </c:if>

        <%-- ========== 服务中项目 ========== --%>
        <c:if test="${contentPage == 'serviceIng'}">
        <div class="content-title">🐕 正在服务的宠物</div>
        <div class="content-sub">含已接单和服务中的订单</div>

        <c:choose>
            <c:when test="${empty requestScope.orderList}">
                <div class="empty-state">
                    <div class="icon">🐶</div>
                    <p>当前没有正在服务的宠物</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="ing-grid">
                    <c:forEach items="${requestScope.orderList}" var="order">
                        <div class="ing-card">
                            <div class="ing-tag">🔧 服务中</div>
                            <h3 class="service-name">${order.serviceTitle}</h3>
                            <p class="meta">👤 用户：<span>${order.username}</span></p>
                            <p class="meta">🐾 宠物：<span>${order.petName}</span></p>
                            <p class="meta">⏰ 预约时间：<span>${fn:replace(order.appointTime, 'T', ' ')}</span></p>
                            <p class="meta">📝 备注：<span>${empty order.remark ? '无' : order.remark}</span></p>
                            <div class="price">¥${order.price}</div>
                            <span class="status-badge status-service">🔧 服务中</span>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        </c:if>

        <%-- ========== 发布新服务 ========== --%>
        <c:if test="${contentPage == 'serviceAdd'}">
        <div class="content-title">📢 发布新服务</div>
        <div class="content-sub">为您的宠物店铺添加一项新的服务项目</div>

        <div class="form-wrapper">
            <form action="${pageContext.request.contextPath}/serviceItemServlet?action=add" method="post">
                <!-- 服务名称 -->
                <div class="form-group">
                    <label>服务名称 <span class="required">*</span></label>
                    <input type="text" name="title" class="form-control" placeholder="例如：高级犬类美容" required>
                </div>

                <!-- 服务类型 -->
                <div class="form-group">
                    <label>服务类型 <span class="required">*</span></label>
                    <select name="type" class="form-control" required>
                        <option value="" disabled selected>请选择服务类型</option>
                        <option value="美容护理">美容护理</option>
                        <option value="温馨寄养">温馨寄养</option>
                        <option value="健康看诊">健康看诊</option>
                        <option value="行为训练">行为训练</option>
                        <option value="宠物洗护">宠物洗护</option>
                        <option value="其他">其他</option>
                    </select>
                </div>

                <!-- 服务价格 -->
                <div class="form-group">
                    <label>服务价格 (¥) <span class="required">*</span></label>
                    <input type="number" name="price" class="form-control" placeholder="例如：299" min="0" step="0.01" required>
                </div>

                <!-- 服务描述 -->
                <div class="form-group">
                    <label>服务描述</label>
                    <textarea name="description" class="form-control" placeholder="请详细描述服务内容、适用宠物、注意事项等…"></textarea>
                </div>

                <!-- 提交按钮 -->
                <div class="form-actions">
                    <button type="submit" class="btn-submit">✅ 提交发布</button>
                    <a href="${pageContext.request.contextPath}/serviceItemServlet?action=manageList" class="btn-back">⬅ 返回列表</a>
                </div>
            </form>
        </div>
        </c:if>

        <%-- ========== 编辑服务 ========== --%>
        <c:if test="${contentPage == 'serviceEdit'}">
        <div class="content-title">✏️ 编辑服务</div>
        <div class="content-sub">修改服务项目信息</div>

        <div class="form-wrapper">
            <form action="${pageContext.request.contextPath}/serviceItemServlet?action=edit" method="post">
                <input type="hidden" name="id" value="${serviceItem.id}">

                <!-- 服务名称 -->
                <div class="form-group">
                    <label>服务名称 <span class="required">*</span></label>
                    <input type="text" name="name" class="form-control" value="${serviceItem.name}" placeholder="例如：高级犬类美容" required>
                </div>

                <!-- 服务类型 -->
                <div class="form-group">
                    <label>服务类型 <span class="required">*</span></label>
                    <select name="type" class="form-control" required>
                        <option value="" disabled>请选择服务类型</option>
                        <option value="美容护理" ${serviceItem.type == '美容护理' ? 'selected' : ''}>美容护理</option>
                        <option value="温馨寄养" ${serviceItem.type == '温馨寄养' ? 'selected' : ''}>温馨寄养</option>
                        <option value="健康看诊" ${serviceItem.type == '健康看诊' ? 'selected' : ''}>健康看诊</option>
                        <option value="行为训练" ${serviceItem.type == '行为训练' ? 'selected' : ''}>行为训练</option>
                        <option value="宠物洗护" ${serviceItem.type == '宠物洗护' ? 'selected' : ''}>宠物洗护</option>
                        <option value="其他" ${serviceItem.type == '其他' ? 'selected' : ''}>其他</option>
                    </select>
                </div>

                <!-- 服务价格 -->
                <div class="form-group">
                    <label>服务价格 (¥) <span class="required">*</span></label>
                    <input type="number" name="price" class="form-control" value="${serviceItem.price}" placeholder="例如：299" min="0" step="0.01" required>
                </div>

                <!-- 服务描述 -->
                <div class="form-group">
                    <label>服务描述</label>
                    <textarea name="description" class="form-control" placeholder="请详细描述服务内容、适用宠物、注意事项等…">${serviceItem.description}</textarea>
                </div>

                <!-- 提交按钮 -->
                <div class="form-actions">
                    <button type="submit" class="btn-submit">✅ 保存修改</button>
                    <a href="${pageContext.request.contextPath}/serviceItemServlet?action=manageList" class="btn-back">⬅ 返回列表</a>
                </div>
            </form>
        </div>
        </c:if>

    </div>
</div>

</body>
</html>
