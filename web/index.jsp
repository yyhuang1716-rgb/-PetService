<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<html>
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>萌宠之家 - 宠物服务预约平台</title>
    <style>
        /* ===== 全局重置 & 基础 ===== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', 'PingFang SC', 'Microsoft YaHei', sans-serif;
            font-weight: 400;
            background-color: #FFFDF5;
            color: #2D2D2D;
            line-height: 1.6;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        ul {
            list-style: none;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 24px;
        }

        /* ===== 导航栏 ===== */
        .navbar {
            background: #FFFFFF;
            border-bottom: 2px solid #06C270;
            padding: 16px 0;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 8px rgba(6, 194, 112, 0.06);
        }

        .navbar .container {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .navbar .logo {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 22px;
            font-weight: 700;
            color: #06C270;
        }

        .navbar .logo span {
            font-size: 26px;
        }

        .navbar .nav-links {
            display: flex;
            gap: 32px;
            font-size: 16px;
            font-weight: 500;
        }

        .navbar .nav-links a {
            color: #444;
            transition: color 0.2s;
        }

        .navbar .nav-links a:hover {
            color: #06C270;
        }

        .navbar .nav-buttons {
            display: flex;
            gap: 12px;
        }

        .navbar .nav-buttons .btn-login {
            padding: 8px 24px;
            border: 2px solid #06C270;
            border-radius: 24px;
            color: #06C270;
            font-weight: 600;
            font-size: 14px;
            background: transparent;
            transition: all 0.25s;
            cursor: pointer;
        }

        .navbar .nav-buttons .btn-login:hover {
            background: #06C270;
            color: #FFFFFF;
        }

        .navbar .nav-buttons .btn-register {
            padding: 8px 24px;
            border: 2px solid #FFD166;
            border-radius: 24px;
            background: #FFD166;
            color: #3D3D3D;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.25s;
            cursor: pointer;
        }

        .navbar .nav-buttons .btn-register:hover {
            background: #FFAB00;
            border-color: #FFAB00;
        }

        /* ===== 英雄区域 ===== */
        .hero {
            height: 420px;
            background: linear-gradient(135deg, #FFFDF5 60%, #E8FAF0);
            display: flex;
            align-items: center;
        }

        .hero .container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
        }

        .hero .hero-text {
            flex: 1;
            max-width: 560px;
        }

        .hero .hero-text h1 {
            font-size: 44px;
            font-weight: 700;
            line-height: 1.25;
            color: #222;
            margin-bottom: 16px;
        }

        .hero .hero-text p {
            font-size: 18px;
            color: #666;
            margin-bottom: 32px;
        }

        .hero .hero-text .btn-book {
            display: inline-block;
            padding: 14px 40px;
            background: #06C270;
            color: #FFFFFF;
            font-size: 18px;
            font-weight: 600;
            border: none;
            border-radius: 32px;
            cursor: pointer;
            transition: background 0.25s, transform 0.2s;
            box-shadow: 0 4px 14px rgba(6, 194, 112, 0.35);
        }

        .hero .hero-text .btn-book:hover {
            background: #04A05C;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(6, 194, 112, 0.45);
        }

        .hero .hero-graphic {
            flex-shrink: 0;
            width: 220px;
            height: 220px;
            border-radius: 50%;
            background: linear-gradient(135deg, #FFD166, #06C270);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 80px;
            box-shadow: 0 8px 32px rgba(255, 209, 102, 0.3);
        }

        /* ===== 服务卡片区 ===== */
        .section-services {
            padding: 72px 0 80px;
        }

        .section-title {
            font-size: 32px;
            font-weight: 700;
            text-align: center;
            margin-bottom: 48px;
            color: #222;
        }

        .services-grid {
            display: flex;
            gap: 24px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .service-card {
            background: #FFFFFF;
            border-radius: 16px;
            padding: 32px 24px 28px;
            flex: 1 1 220px;
            max-width: 260px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            border-left: 4px solid #06C270;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
        }

        .service-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 28px rgba(0, 0, 0, 0.12);
        }

        .service-card .icon {
            font-size: 40px;
            margin-bottom: 16px;
        }

        .service-card h3 {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 8px;
            color: #2D2D2D;
        }

        .service-card p {
            font-size: 14px;
            color: #777;
            margin-bottom: 4px;
        }

        .service-card .price-tag {
            display: inline-block;
            margin-top: 14px;
            background: #E8FAF0;
            color: #06C270;
            font-weight: 700;
            font-size: 14px;
            padding: 4px 16px;
            border-radius: 20px;
        }

        /* ===== 数据条 ===== */
        .stats-bar {
            background: #06C270;
            padding: 48px 0;
        }

        .stats-bar .container {
            display: flex;
            justify-content: space-around;
            align-items: center;
            flex-wrap: wrap;
            gap: 32px;
        }

        .stats-bar .stat-item {
            text-align: center;
        }

        .stats-bar .stat-item .number {
            font-size: 40px;
            font-weight: 700;
            color: #FFFFFF;
        }

        .stats-bar .stat-item .label {
            font-size: 16px;
            color: rgba(255, 255, 255, 0.88);
            margin-top: 4px;
        }

        /* ===== 公告栏 ===== */
        .section-notice {
            padding: 72px 0 80px;
        }

        .notice-list {
            max-width: 800px;
            margin: 0 auto;
        }

        .notice-item {
            display: flex;
            align-items: center;
            padding: 14px 20px;
            background: #FFFFFF;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 12px;
            transition: box-shadow 0.2s;
            cursor: pointer;
        }

        .notice-item:hover {
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.10);
        }

        .notice-item .dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: #06C270;
            flex-shrink: 0;
            margin-right: 16px;
        }

        .notice-item .title {
            flex: 1;
            font-size: 15px;
            font-weight: 500;
        }

        .notice-item .date {
            font-size: 13px;
            color: #999;
            flex-shrink: 0;
            margin-left: 16px;
        }

        .notice-empty {
            text-align: center;
            padding: 40px 0;
            color: #aaa;
            font-size: 16px;
        }

        /* ===== 热门服务人员 ===== */
        .section-workers {
            padding: 0 0 80px;
        }

        .workers-grid {
            display: flex;
            gap: 24px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .worker-card {
            background: #FFFFFF;
            border-radius: 16px;
            padding: 32px 24px 28px;
            flex: 1 1 260px;
            max-width: 300px;
            text-align: center;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .worker-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 28px rgba(0, 0, 0, 0.12);
        }

        .worker-card .avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #FFD166, #06C270);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            font-weight: 700;
            color: #FFFFFF;
            margin: 0 auto 16px;
        }

        .worker-card h4 {
            font-size: 20px;
            font-weight: 700;
            color: #2D2D2D;
            margin-bottom: 8px;
        }

        .worker-card .badge {
            display: inline-block;
            background: #E8FAF0;
            color: #06C270;
            font-size: 13px;
            font-weight: 600;
            padding: 4px 16px;
            border-radius: 20px;
            margin-bottom: 10px;
        }

        .worker-card .years {
            font-size: 14px;
            color: #888;
        }

        /* ===== 页脚 ===== */
        .footer {
            background: #04A05C;
            color: #FFFFFF;
            text-align: center;
            padding: 36px 24px;
        }

        .footer h3 {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .footer p {
            font-size: 14px;
            opacity: 0.85;
            margin-bottom: 4px;
        }

        .footer .copyright {
            margin-top: 12px;
            font-size: 13px;
            opacity: 0.7;
        }

        /* ===== 响应式微调 ===== */
        @media (max-width: 768px) {
            .navbar .nav-links {
                display: none;
            }

            .hero {
                height: auto;
                padding: 48px 0;
            }

            .hero .container {
                flex-direction: column;
                text-align: center;
                gap: 32px;
            }

            .hero .hero-text h1 {
                font-size: 32px;
            }

            .hero .hero-graphic {
                width: 160px;
                height: 160px;
                font-size: 60px;
            }

            .stats-bar .stat-item .number {
                font-size: 30px;
            }

            .services-grid,
            .workers-grid {
                flex-direction: column;
                align-items: center;
            }

            .service-card,
            .worker-card {
                max-width: 100%;
                width: 100%;
            }
        }
    </style>
</head>
<body>

<!-- ==================== 导航栏 ==================== -->
<nav class="navbar">
    <div class="container">
        <div class="logo">
            <span>🐾</span> 萌宠之家
        </div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">首页</a>
            <a href="#">服务介绍</a>
            <a href="#">联系我们</a>
        </div>
        <div class="nav-buttons">
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn-login">登录</a>
            <a href="${pageContext.request.contextPath}/register.jsp" class="btn-register">立即注册</a>
        </div>
    </div>
</nav>

<!-- ==================== 英雄区域 ==================== -->
<section class="hero">
    <div class="container">
        <div class="hero-text">
            <h1>给毛孩子，最贴心的照料</h1>
            <p>专业宠物美容、寄养、看诊、训练一站式服务平台，让每一只毛孩子都能享受五星级的关爱。</p>
            <a href="#" class="btn-book">立即预约</a>
        </div>
        <div class="hero-graphic">🐾</div>
    </div>
</section>

<!-- ==================== 服务卡片区 ==================== -->
<section class="section-services">
    <div class="container">
        <h2 class="section-title">我们的服务</h2>
        <div class="services-grid">
            <div class="service-card">
                <div class="icon">✂️</div>
                <h3>美容护理</h3>
                <p>专业宠物美容师提供</p>
                <p>洗护、修剪、造型服务</p>
                <span class="price-tag">¥68 起</span>
            </div>
            <div class="service-card">
                <div class="icon">🏠</div>
                <h3>温馨寄养</h3>
                <p>24 小时专人陪伴看护</p>
                <p>独立舒适寄养空间</p>
                <span class="price-tag">¥88 起</span>
            </div>
            <div class="service-card">
                <div class="icon">💉</div>
                <h3>健康看诊</h3>
                <p>资深兽医师常规检查</p>
                <p>疫苗接种与健康咨询</p>
                <span class="price-tag">¥50 起</span>
            </div>
            <div class="service-card">
                <div class="icon">🏅</div>
                <h3>行为训练</h3>
                <p>科学正向激励训练</p>
                <p>纠正不良行为习惯</p>
                <span class="price-tag">¥128 起</span>
            </div>
        </div>
    </div>
</section>

<!-- ==================== 数据条 ==================== -->
<section class="stats-bar">
    <div class="container">
        <div class="stat-item">
            <div class="number">1000+</div>
            <div class="label">注册用户</div>
        </div>
        <div class="stat-item">
            <div class="number">5000+</div>
            <div class="label">服务次数</div>
        </div>
        <div class="stat-item">
            <div class="number">98%</div>
            <div class="label">好评率</div>
        </div>
    </div>
</section>

<!-- ==================== 公告栏 ==================== -->
<section class="section-notice">
    <div class="container">
        <h2 class="section-title">平台公告</h2>
        <div class="notice-list">
            <c:if test="${empty noticeList}">
                <div class="notice-empty">📢 暂无公告</div>
            </c:if>
            <c:forEach items="${noticeList}" var="notice">
                <div class="notice-item" onclick="window.location.href='${pageContext.request.contextPath}/noticeDetail?id=${notice.id}'">
                    <span class="dot"></span>
                    <span class="title"><c:out value="${notice.title}" /></span>
                    <span class="date"><c:out value="${notice.createTime}" /></span>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- ==================== 热门服务人员 ==================== -->
<section class="section-workers">
    <div class="container">
        <h2 class="section-title">专业服务团队</h2>
        <div class="workers-grid">
            <c:forEach items="${workerList}" var="worker">
                <div class="worker-card">
                    <div class="avatar">
                        <c:out value="${fn:substring(worker.name, 0, 1)}" />
                    </div>
                    <h4><c:out value="${worker.name}" /></h4>
                    <span class="badge"><c:out value="${worker.serviceType}" /></span>
                    <div class="years"><c:out value="${worker.experience}" /></div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- ==================== 页脚 ==================== -->
<footer class="footer">
    <h3>🐾 萌宠之家</h3>
    <p>用爱守护每一只毛孩子的健康成长</p>
    <p class="copyright">&copy; 2025 萌宠之家 · 让爱宠生活更美好</p>
</footer>

</body>
</html>
