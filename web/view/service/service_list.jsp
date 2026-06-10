<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>服务项目 - 萌宠之家</title>
    <style>
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background-color: #FFFDF5; color: #2D2D2D; padding: 40px; }
        .container { max-width: 1000px; margin: 0 auto; }
        h2 { color: #06C270; text-align: center; margin-bottom: 30px; }

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
        .nav-back { display: inline-block; margin-bottom: 20px; color: #06C270; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/index.jsp" class="nav-back">⬅ 返回主页</a>
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
                <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list&page=${pageBean.page - 1}"
                   style="display: inline-block; padding: 8px 18px; margin: 0 4px; background: #06C270; color: white; border-radius: 20px; text-decoration: none; font-size: 14px;">上一页</a>
            </c:if>
            <c:forEach begin="1" end="${pageBean.totalPages}" var="i">
                <c:choose>
                    <c:when test="${i == pageBean.page}">
                        <span style="display: inline-block; padding: 8px 16px; margin: 0 2px; background: #FFD166; color: #333; border-radius: 50%; font-weight: bold;">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list&page=${i}"
                           style="display: inline-block; padding: 8px 16px; margin: 0 2px; background: #f0f0f0; color: #333; border-radius: 50%; text-decoration: none;">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${pageBean.page < pageBean.totalPages}">
                <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list&page=${pageBean.page + 1}"
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
