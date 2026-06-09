<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>正在服务的宠物 - 萌宠之家</title>
    <style>
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background-color: #FFFDF5; color: #2D2D2D; padding: 40px; }
        .container { max-width: 1000px; margin: 0 auto; }
        h2 { color: #06C270; text-align: center; margin-bottom: 30px; }
        .nav-back {
            display: inline-block; margin-bottom: 20px; color: #06C270;
            text-decoration: none; font-weight: bold;
        }
        .empty-state {
            text-align: center; padding: 80px 20px; background: #fff;
            border-radius: 16px; box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        .empty-state .icon { font-size: 64px; margin-bottom: 20px; }
        .empty-state p { font-size: 18px; color: #666; }
        .order-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(340px, 1fr)); gap: 20px; }
        .order-card {
            background: #fff; border-radius: 16px; padding: 24px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
            border-left: 4px solid #00D2D3; position: relative;
        }
        .order-card .service-name {
            font-size: 18px; font-weight: bold; color: #333; margin: 0 0 8px 0;
        }
        .order-card .meta { font-size: 14px; color: #888; margin: 4px 0; }
        .order-card .meta span { color: #333; font-weight: 500; }
        .order-card .price {
            color: #FF6B6B; font-size: 22px; font-weight: bold; margin: 12px 0;
        }
        .status-badge {
            display: inline-block; padding: 4px 14px; border-radius: 12px;
            font-size: 13px; font-weight: bold; margin-top: 8px;
        }
        .status-service { background: #CCE5FF; color: #004085; }
        .service-tag {
            position: absolute; top: 16px; right: 16px;
            background: #00D2D3; color: #fff; padding: 4px 14px;
            border-radius: 20px; font-size: 12px; font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/orderServlet?action=home" class="nav-back">⬅ 返回工作台</a>
    <h2>🐕 正在服务的宠物</h2>

    <p style="text-align:center;color:#888;margin-top:-20px;margin-bottom:30px;">含已接单和服务中的订单</p>

    <c:choose>
        <c:when test="${empty requestScope.orderList}">
            <div class="empty-state">
                <div class="icon">🐶</div>
                <p>当前没有正在服务的宠物</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="order-grid">
                <c:forEach items="${requestScope.orderList}" var="order">
                    <div class="order-card">
                        <div class="service-tag">🔧 服务中</div>
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
</div>
</body>
</html>
