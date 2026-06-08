<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>编辑服务 - 萌宠之家</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
            background: #F0F2F5;
            display: flex;
            min-height: 100vh;
            color: #1A1A2E;
        }

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
        .sidebar-header .logo { font-size: 26px; font-weight: 800; letter-spacing: 2px; }
        .sidebar-header .logo span { color: #FF6B81; }
        .sidebar-header .sub {
            font-size: 14px; opacity: 0.7; margin-top: 6px; letter-spacing: 3px;
        }
        .sidebar-nav { padding: 20px 0; flex: 1; }
        .sidebar-nav a {
            display: flex; align-items: center; gap: 14px;
            padding: 16px 28px; color: rgba(255, 255, 255, 0.82);
            text-decoration: none; font-size: 16px; font-weight: 500;
            transition: all 0.25s; border-left: 4px solid transparent; cursor: pointer;
        }
        .sidebar-nav a:hover { background: rgba(255, 255, 255, 0.14); color: #fff; padding-left: 32px; }
        .sidebar-nav a.active {
            background: rgba(255, 255, 255, 0.16); color: #fff;
            border-left-color: #FF6B81; font-weight: 700;
        }
        .sidebar-nav .icon { font-size: 20px; }
        .sidebar-footer {
            padding: 18px 24px; border-top: 1px solid rgba(255,255,255,0.12);
            font-size: 13px; opacity: 0.55; text-align: center; letter-spacing: 1px;
        }

        .main { flex: 1; display: flex; flex-direction: column; }

        .topbar {
            display: flex; justify-content: space-between; align-items: center;
            padding: 22px 40px; background: #fff; box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        .topbar h3 { font-size: 18px; font-weight: 500; color: #555; }
        .topbar h3 strong { color: #FF6B81; font-weight: 700; font-size: 20px; }
        .topbar-right { display: flex; align-items: center; gap: 24px; }
        .topbar-right .badge {
            font-size: 14px; color: #00D2D3; font-weight: 700;
            background: rgba(0, 210, 211, 0.08); padding: 4px 14px; border-radius: 20px;
        }
        .btn-logout {
            background: #FF6B81; color: #fff; border: none; padding: 9px 22px;
            border-radius: 22px; font-size: 15px; font-weight: 600;
            cursor: pointer; text-decoration: none; transition: background 0.25s, transform 0.2s;
        }
        .btn-logout:hover { background: #E55A6F; transform: scale(1.03); }

        .content { padding: 36px 40px; flex: 1; }
        .content-title { font-size: 26px; font-weight: 700; color: #1A1A2E; margin-bottom: 8px; letter-spacing: 1px; }
        .content-sub { font-size: 15px; color: #999; margin-bottom: 32px; }

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
            border-color: #00D2D3;
            box-shadow: 0 0 0 3px rgba(0, 210, 211, 0.10);
            background: #fff;
        }
        .form-control::placeholder { color: #BBB; }
        textarea.form-control { min-height: 120px; resize: vertical; }
        select.form-control { cursor: pointer; appearance: none; background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%23999' d='M6 8L0 0h12z'/%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 14px center; padding-right: 36px; }

        .form-actions {
            display: flex;
            gap: 14px;
            margin-top: 8px;
            padding-top: 20px;
            border-top: 1px solid #F0F0F0;
        }
        .btn-submit {
            background: #00D2D3; color: #fff; border: none; padding: 12px 36px;
            border-radius: 10px; font-size: 16px; font-weight: 700;
            cursor: pointer; text-decoration: none; transition: background 0.25s, transform 0.2s;
        }
        .btn-submit:hover { background: #089B9C; transform: scale(1.02); }
        .btn-back {
            background: #FF6B81; color: #fff; border: none; padding: 12px 36px;
            border-radius: 10px; font-size: 16px; font-weight: 700;
            cursor: pointer; text-decoration: none; transition: background 0.25s, transform 0.2s;
            display: inline-flex; align-items: center; justify-content: center;
        }
        .btn-back:hover { background: #E55A6F; transform: scale(1.02); }

        @media (max-width: 768px) {
            .sidebar { width: 72px; }
            .sidebar-header .logo, .sidebar-header .sub, .sidebar-nav a span { display: none; }
            .sidebar-nav a { justify-content: center; padding: 16px 0; }
            .topbar { padding: 16px 20px; }
            .content { padding: 24px 16px; }
            .form-wrapper { padding: 24px 20px; }
            .form-actions { flex-direction: column; }
            .btn-submit, .btn-back { width: 100%; text-align: center; }
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

    <div class="topbar">
        <h3>欢迎回来，<strong>${sessionScope.user.username}</strong> <span class="badge">商家</span></h3>
        <div class="topbar-right">
            <a href="${pageContext.request.contextPath}/userServlet?action=logout" class="btn-logout">退出登录</a>
        </div>
    </div>

    <div class="content">
        <div class="content-title">✏️ 编辑服务</div>
        <div class="content-sub">修改服务项目信息</div>

        <div class="form-wrapper">
            <form action="${pageContext.request.contextPath}/serviceItemServlet?action=edit" method="post">
                <input type="hidden" name="id" value="${serviceItem.id}">

                <div class="form-group">
                    <label>服务名称 <span class="required">*</span></label>
                    <input type="text" name="name" class="form-control" value="${serviceItem.name}" placeholder="例如：高级犬类美容" required>
                </div>

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

                <div class="form-group">
                    <label>服务价格 (¥) <span class="required">*</span></label>
                    <input type="number" name="price" class="form-control" value="${serviceItem.price}" placeholder="例如：299" min="0" step="0.01" required>
                </div>

                <div class="form-group">
                    <label>服务描述</label>
                    <textarea name="description" class="form-control" placeholder="请详细描述服务内容、适用宠物、注意事项等…">${serviceItem.description}</textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn-submit">✅ 保存修改</button>
                    <a href="${pageContext.request.contextPath}/serviceItemServlet?action=manageList" class="btn-back">⬅ 返回列表</a>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
