<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>订单管理 - 萌宠之家</title>
    <style>
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background-color: #FFFDF5; color: #2D2D2D; padding: 40px; }
        .container { max-width: 1200px; margin: 0 auto; }

        h2 { color: #06C270; text-align: center; margin-bottom: 30px; }

        .nav-back {
            display: inline-block;
            margin-bottom: 20px;
            color: #06C270;
            text-decoration: none;
            font-weight: bold;
        }

        /* 空状态提示 */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        .empty-state .icon { font-size: 64px; margin-bottom: 20px; }
        .empty-state p { font-size: 18px; color: #666; }

        /* 表格样式 */
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        th {
            background: #06C270;
            color: #fff;
            padding: 14px 12px;
            text-align: left;
            font-size: 14px;
            white-space: nowrap;
        }
        td {
            padding: 12px;
            border-bottom: 1px solid #F0F0F0;
            font-size: 14px;
            vertical-align: middle;
        }
        tr:last-child td { border-bottom: none; }
        tr:hover { background: #F8FFF8; }
/* 状态标签样式 */
        /* 状态标签 */
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

        /* 接单按钮 */
        .btn-accept {
            display: inline-block;
            background: #06C270;
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
        .btn-accept:hover { background: #05A85E; }

        /* 完成服务按钮 */
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

        /* 评价星星 */
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
            background: #F9FFF9;
            padding: 4px 8px;
            border-radius: 6px;
            border-left: 3px solid #06C270;
        }
    </style>
</head>
<body>
<div class="container">

    <a href="${pageContext.request.contextPath}/view/merchant/home.jsp" class="nav-back">⬅ 返回工作台</a>
    <h2>📋 商家订单管理</h2>

    <c:choose>
        <c:when test="${empty requestScope.orderList}">
            <div class="empty-state">
                <div class="icon">📭</div>
                <p>暂无订单</p>
            </div>
        </c:when>

        <c:otherwise>
            <table>
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

</div>
</body>
</html>