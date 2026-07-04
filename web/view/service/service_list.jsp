<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>服务项目 - 萌宠之家</title>
    <style>
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background-color: #FFFDF5; color: #2D2D2D; padding: 0; margin: 0; }
        .container { max-width: 1000px; margin: 0 auto; padding: 24px 24px 40px; }
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

        /* 消息提示 */
        .msg-toast {
            text-align: center;
            padding: 12px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: bold;
            font-size: 15px;
        }
        .msg-success { background: #E8F8E8; color: #06C270; border: 1px solid #B8E8B8; }
        .msg-error { background: #FFE8E8; color: #FF4444; border: 1px solid #FFCCCC; }

        /* 服务卡片布局 */
        .service-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 24px; margin-bottom: 40px; }
        .service-card { background: #fff; border-radius: 16px; padding: 24px; box-shadow: 0 4px 16px rgba(0,0,0,0.06); border-left: 4px solid #06C270; display: flex; flex-direction: column; min-height: 200px; }
        .service-card h3 { margin: 0 0 12px 0; color: #333; font-size: 18px; }
        .service-card .desc { margin: 0 0 12px 0; color: #666; font-size: 14px; line-height: 1.6; flex: 1; }
        .service-card .price { color: #FF6B6B; font-size: 24px; font-weight: bold; margin: 8px 0 16px 0; }
        .service-card .price small { font-size: 14px; font-weight: normal; color: #999; }
        .empty-tips { text-align: center; color: #999; width: 100%; padding: 60px 0; font-size: 16px; grid-column: 1 / -1; }

        /* 按钮组 */
        .btn-group { display: flex; gap: 12px; margin-top: auto; }
        .btn-book { background: #FFD166; color: #333; border: none; border-radius: 20px; padding: 10px 20px; cursor: pointer; font-size: 14px; font-weight: bold; text-decoration: none; text-align: center; transition: background 0.3s; flex: 1; }
        .btn-book:hover { background: #FFC233; }
        .btn-fav { background: #FF6B81; color: #fff; border: none; border-radius: 20px; padding: 10px 16px; cursor: pointer; text-decoration: none; font-size: 13px; text-align: center; transition: background 0.3s; white-space: nowrap; }
        .btn-fav:hover { background: #E85A6F; }
        .btn-del { background: #FF6B6B; color: white; border: none; border-radius: 20px; padding: 10px 16px; cursor: pointer; text-decoration: none; font-size: 12px; text-align: center; transition: background 0.3s; }
        .btn-del:hover { background: #FF4444; }

        /* 添加表单样式 */
        .add-form { background: #fff; border-radius: 16px; padding: 30px; box-shadow: 0 4px 16px rgba(0,0,0,0.06); }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; font-size: 14px; }
        .form-group input, .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box; }
        .form-group textarea { resize: vertical; min-height: 80px; }
        .btn-submit { background: #06C270; color: white; border: none; border-radius: 20px; padding: 10px 30px; font-size: 16px; cursor: pointer; font-weight: bold; width: 100%; transition: background 0.3s; }
        .btn-submit:hover { background: #04A05C; }

        /* ====== 分类标签栏 ====== */
        .category-bar {
            background: #fff;
            border-bottom: 1px solid #f0f0f0;
            padding: 0 24px;
            display: flex;
            align-items: center;
            gap: 0;
            overflow-x: auto;
            box-shadow: 0 2px 8px rgba(0,0,0,0.03);
        }
        .category-bar .cat-label {
            font-size: 20px;
            color: #999;
            font-weight: 600;
            margin-right: 16px;
            white-space: nowrap;
            padding: 14px 0;
        }
        .category-bar a {
            display: inline-block;
            padding: 10px 20px;
            font-size: 18px;
            font-weight: 500;
            color: #666;
            text-decoration: none;
            border-bottom: 3px solid transparent;
            transition: all 0.25s;
            white-space: nowrap;
        }
        .category-bar a:hover {
            color: #06C270;
            background: rgba(6, 194, 112, 0.04);
        }
        .category-bar a.active {
            color: #06C270;
            border-bottom-color: #06C270;
            font-weight: 700;
        }
        .category-bar a .count {
            font-size: 12px;
            color: #bbb;
            margin-left: 4px;
        }
        .category-bar a.active .count {
            color: #06C270;
        }

        /* 服务类型标签 */
        .type-tag {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 10px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 8px;
        }
        .type-tag-美容护理 { background: rgba(255, 107, 129, 0.10); color: #FF6B81; }
        .type-tag-温馨寄养 { background: rgba(0, 210, 211, 0.10); color: #00D2D3; }
        .type-tag-健康看诊 { background: rgba(108, 92, 231, 0.10); color: #6C5CE7; }
        .type-tag-行为训练 { background: rgba(255, 209, 102, 0.15); color: #CC8800; }
        .type-tag-宠物洗护 { background: rgba(6, 194, 112, 0.10); color: #06C270; }
        .type-tag-其他 { background: rgba(0, 0, 0, 0.05); color: #888; }
        .type-tag-宠物美容 { background: rgba(255, 140, 0, 0.12); color: #FF8C00; }
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

<%-- ====== 分类标签栏 ====== --%>
<div class="category-bar">
    <span class="cat-label">🏷️ 分类</span>
    <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list"
       class="${empty currentType ? 'active' : ''}">全部</a>
    <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list&type=美容护理"
       class="${currentType == '美容护理' ? 'active' : ''}">美容护理</a>
    <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list&type=温馨寄养"
       class="${currentType == '温馨寄养' ? 'active' : ''}">温馨寄养</a>
    <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list&type=健康看诊"
       class="${currentType == '健康看诊' ? 'active' : ''}">健康看诊</a>
    <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list&type=行为训练"
       class="${currentType == '行为训练' ? 'active' : ''}">行为训练</a>
    <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list&type=宠物洗护"
       class="${currentType == '宠物洗护' ? 'active' : ''}">宠物洗护</a>
    <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list&type=其他"
       class="${currentType == '其他' ? 'active' : ''}">其他</a>
</div>

<div class="container">
    <a href="${pageContext.request.contextPath}/" style="display: inline-block; margin-bottom: 20px; color: #06C270; text-decoration: none; font-weight: bold;">⬅ 返回主页</a>
    <h2>🎯 所有服务项目</h2>

    <%-- 显示操作结果消息（预约成功/失败等） --%>
    <c:if test="${not empty param.msg}">
        <c:choose>
            <c:when test="${param.msg eq '预约成功'}">
                <div class="msg-toast msg-success">✅ ${param.msg}！商家将尽快与您联系确认。</div>
            </c:when>
            <c:when test="${param.msg eq '收藏成功'}">
                <div class="msg-toast msg-success">✅ ${param.msg}</div>
            </c:when>
            <c:otherwise>
                <div class="msg-toast msg-error">❌ ${param.msg}</div>
            </c:otherwise>
        </c:choose>
    </c:if>

    <div class="service-grid">
        <c:choose>
            <c:when test="${empty requestScope.serviceList}">
                <div class="empty-tips">
                    😅 暂无可预约的服务项目<br>
                    <span style="font-size: 14px; color: #bbb;">商家正在努力上架中，请稍后再来看看吧！</span>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${requestScope.serviceList}" var="service">
                    <div class="service-card">
                        <c:if test="${not empty service.type}">
                            <span class="type-tag type-tag-${service.type}">${service.type}</span>
                        </c:if>
                        <h3>${service.title}</h3>
                        <p class="desc">${service.description}</p>
                        <p class="price">¥${service.price} <small>/ 次</small></p>
                        <div class="btn-group">
                            <a href="${pageContext.request.contextPath}/orderServlet?action=toBook&service_item_id=${service.id}&merchant_id=${service.merchantId}" class="btn-book">立即预约</a>
                            <c:if test="${not empty sessionScope.user}">
                                <a href="${pageContext.request.contextPath}/favoriteServlet?action=add&serviceId=${service.id}" class="btn-fav">❤️ 收藏</a>
                            </c:if>
                            <c:if test="${not empty sessionScope.user && sessionScope.user.role == 1}">
                                <a href="${pageContext.request.contextPath}/serviceItemServlet?action=delete&id=${service.id}" class="btn-del" onclick="return confirm('确定要删除这个服务项目吗？');">删除</a>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- 分页导航 --%>
    <c:if test="${pageBean.totalPages > 1}">
        <div style="text-align: center; margin-bottom: 30px;">
            <c:if test="${pageBean.page > 1}">
                <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list&page=${pageBean.page - 1}<c:if test='${not empty currentType}'>&type=${currentType}</c:if>"
                   style="display: inline-block; padding: 8px 18px; margin: 0 4px; background: #06C270; color: white; border-radius: 20px; text-decoration: none; font-size: 14px;">上一页</a>
            </c:if>
            <c:forEach begin="1" end="${pageBean.totalPages}" var="i">
                <c:choose>
                    <c:when test="${i == pageBean.page}">
                        <span style="display: inline-block; padding: 8px 16px; margin: 0 2px; background: #FFD166; color: #333; border-radius: 50%; font-weight: bold;">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list&page=${i}<c:if test='${not empty currentType}'>&type=${currentType}</c:if>"
                           style="display: inline-block; padding: 8px 16px; margin: 0 2px; background: #f0f0f0; color: #333; border-radius: 50%; text-decoration: none;">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${pageBean.page < pageBean.totalPages}">
                <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list&page=${pageBean.page + 1}<c:if test='${not empty currentType}'>&type=${currentType}</c:if>"
                   style="display: inline-block; padding: 8px 18px; margin: 0 4px; background: #06C270; color: white; border-radius: 20px; text-decoration: none; font-size: 14px;">下一页</a>
            </c:if>
        </div>
    </c:if>

    <div class="add-form">
        <c:if test="${not empty sessionScope.user && sessionScope.user.role == 1}">
            <h3 style="margin-top:0;">➕ 添加新服务项目</h3>
            <form action="${pageContext.request.contextPath}/serviceItemServlet?action=add" method="post">
                <div class="form-group">
                    <label>服务名称</label>
                    <input type="text" name="title" required placeholder="例如：全套洗护(中型犬)">
                </div>
                <div class="form-group">
                    <label>服务类型</label>
                    <select name="type" required style="width:100%;padding:10px;border:1px solid #ddd;border-radius:8px;font-size:14px;">
                        <option value="" disabled selected>请选择服务类型</option>
                        <option value="美容护理">美容护理</option>
                        <option value="温馨寄养">温馨寄养</option>
                        <option value="健康看诊">健康看诊</option>
                        <option value="行为训练">行为训练</option>
                        <option value="宠物洗护">宠物洗护</option>
                        <option value="其他">其他</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>服务价格 (元)</label>
                    <input type="number" name="price" required step="0.01" placeholder="例如：150.00">
                </div>
                <div class="form-group">
                    <label>服务描述</label>
                    <textarea name="description" placeholder="详细描述服务内容和注意事项"></textarea>
                </div>
                <button type="submit" class="btn-submit">保存服务</button>
            </form>
        </c:if>
    </div>
</div>
</body>
</html>
