<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>我的预约 - 萌宠之家</title>
    <style>
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background-color: #FFFDF5; color: #2D2D2D; padding: 40px; }
        .container { max-width: 1000px; margin: 0 auto; }

        h2 { color: #06C270; text-align: center; margin-bottom: 30px; }

        /* 空状态提示 */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        .empty-state .icon { font-size: 64px; margin-bottom: 20px; }
        .empty-state p { font-size: 18px; color: #666; margin-bottom: 30px; line-height: 1.8; }
        .empty-state .btn-service {
            display: inline-block;
            background: #FFD166;
            color: #333;
            text-decoration: none;
            padding: 12px 36px;
            border-radius: 24px;
            font-weight: bold;
            font-size: 16px;
            transition: background 0.3s;
        }
        .empty-state .btn-service:hover { background: #FFC233; }

        /* 订单卡片网格 */
        .order-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(340px, 1fr)); gap: 20px; }
        .order-card {
            background: #fff;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
            border-left: 4px solid #06C270;
            display: flex;
            flex-direction: column;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .order-card:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(0,0,0,0.1); }

        .order-card .service-name {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin: 0 0 8px 0;
        }
        .order-card .meta {
            font-size: 14px;
            color: #888;
            margin: 4px 0;
        }
        .order-card .meta span { color: #333; font-weight: 500; }
        .order-card .price {
            color: #FF6B6B;
            font-size: 22px;
            font-weight: bold;
            margin: 12px 0;
        }

        /* 状态标签 */
        .status-badge {
            display: inline-block;
            padding: 4px 14px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: bold;
            margin-top: 8px;
        }
        .status-pending { background: #FFF3CD; color: #856404; }     /* 黄色-待接单 */
        .status-accepted { background: #D4EDDA; color: #155724; }    /* 绿色-已接单 */
        .status-done { background: #E2E3E5; color: #383D41; }        /* 灰色-已完成/取消 */

        .nav-back {
            display: inline-block;
            margin-bottom: 20px;
            color: #06C270;
            text-decoration: none;
            font-weight: bold;
        }

        /* 取消预约按钮 */
        .btn-cancel {
            display: inline-block;
            background: #FFF3CD;
            color: #856404;
            text-decoration: none;
            padding: 8px 18px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
            transition: background 0.3s;
            border: 1px solid #FFE69C;
        }
        .btn-cancel:hover { background: #FFE69C; }

        /* 消息提示 */
        .msg-toast {
            text-align: center;
            padding: 14px 20px;
            border-radius: 12px;
            font-size: 15px;
            font-weight: bold;
            margin-bottom: 20px;
            animation: fadeIn 0.3s ease;
        }
        .msg-success { background: #D4EDDA; color: #155724; border: 1px solid #C3E6CB; }
        .msg-error   { background: #FFF3CD; color: #856404; border: 1px solid #FFE69C; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>
<div class="container">

    <a href="${pageContext.request.contextPath}/index.jsp" class="nav-back">⬅ 返回主页</a>
    <h2>📋 我的预约</h2>

    <%-- 操作结果消息提示 --%>
    <c:if test="${not empty param.msg}">
        <div class="msg-toast ${(param.msg eq '取消成功' || param.msg eq '备注更新成功') ? 'msg-success' : 'msg-error'}">
                ${(param.msg eq '取消成功' || param.msg eq '备注更新成功') ? '✅' : '⚠️'} ${param.msg}
        </div>
    </c:if>

    <c:choose>
        <%-- ⭐ 如果 orderList 是空的，显示这里 --%>
        <c:when test="${empty requestScope.orderList}">
            <div class="empty-state">
                <div class="icon">🐶</div>
                <p>暂无预约记录<br>快去给毛孩子预约服务吧！</p>
                <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list" class="btn-service">🎯 浏览服务项目</a>
            </div>
        </c:when>

        <%-- ⭐ 如果有数据，循环显示卡片 --%>
        <c:otherwise>
            <div class="order-grid">
                <c:forEach items="${requestScope.orderList}" var="order">
                    <div class="order-card">
                        <h3 class="service-name">${order.serviceTitle}</h3>
                            <%-- 如果联查没查出username，就用当前登录的 sessionScope.user.username 兜底 --%>
                        <p class="meta">👤 用户：<span>${not empty order.username ? order.username : sessionScope.user.username}</span></p>
                        <p class="meta">🐾 宠物：<span>${order.petName}</span></p>
                        <p class="meta">⏰ 预约时间：<span>${fn:replace(order.appointTime, 'T', ' ')}</span></p>
                        <div class="price">¥${order.price}</div>

                            <%-- 备注编辑表单 --%>
                        <form action="${pageContext.request.contextPath}/orderServlet?action=updateRemark" method="post" style="margin-top: 10px; display: flex; gap: 8px;">
                            <input type="hidden" name="orderId" value="${order.id}">
                            <input type="text" name="remark" value="${order.remark}" placeholder="添加或修改备注（如：狗狗怕生）"
                                   style="flex: 1; padding: 6px 12px; border: 1px solid #DDD; border-radius: 8px; font-size: 13px;">
                            <button type="submit" style="background: #06C270; color: white; border: none; padding: 6px 14px; border-radius: 8px; font-size: 13px; font-weight: bold; cursor: pointer;">
                                保存
                            </button>
                        </form>

                            <%-- 根据数据库中文状态值显示对应的标签 --%>
                        <c:choose>
                            <c:when test="${order.status == 0}">
                                <span class="status-badge status-pending">⏳ 待接单</span>
                            </c:when>
                            <c:when test="${order.status == 1}">
                                <span class="status-badge status-accepted">✅ 商家已接单</span>
                            </c:when>
                            <c:when test="${order.status == 2}">
                                <span class="status-badge status-accepted">🔧 服务中</span>
                            </c:when>
                            <c:when test="${order.status == 3}">
                                <span class="status-badge status-done">✔️ 已完成</span>
                            </c:when>
                            <c:when test="${order.status == 5}">
                                <span class="status-badge status-done">⭐ 已评价</span>
                            </c:when>
                            <c:when test="${order.status == 4}">
                                <span class="status-badge status-done" style="text-decoration: line-through;">❌ 已取消</span>
                            </c:when>
                        </c:choose>

                            <%-- 取消预约按钮（仅"待接单"状态可取消） --%>
                        <c:if test="${order.status == 0}">
                            <div style="margin-top: 12px;">
                                <a href="${pageContext.request.contextPath}/orderServlet?action=cancelOrder&orderId=${order.id}"
                                   class="btn-cancel"
                                   onclick="return confirm('确定要取消这个预约吗？')">

                                    🗑️ 取消预约
                                </a>
                            </div>
                        </c:if>

                            <%-- 已完成 → 去评价；已评价 → 纯文本 --%>
                        <c:if test="${order.status == 3}">
                            <div style="margin-top: 12px;">
                                <a href="${pageContext.request.contextPath}/orderServlet?action=toReview&orderId=${order.id}"
                                   style="display: inline-block; background: #06C270; color: white; text-decoration: none; padding: 8px 18px; border-radius: 20px; font-size: 14px; font-weight: bold; transition: background 0.3s;">
                                    📝 去评价
                                </a>
                            </div>
                        </c:if>
                        <c:if test="${order.status == 5}">
                            <div style="margin-top: 12px; color: #06C270; font-size: 14px; font-weight: bold;">✅ 已评价</div>
                            <c:if test="${not empty order.rating}">
                                <div style="margin-top: 6px; color: #FFD166; font-size: 18px; letter-spacing: 2px;">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${i <= order.rating}">★</c:when>
                                            <c:otherwise><span style="color: #DDD;">★</span></c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </c:if>
                            <c:if test="${not empty order.reviewContent}">
                                <div style="margin-top: 6px; padding: 8px 12px; background: #F0FFF4; border-left: 3px solid #06C270; border-radius: 6px; font-size: 13px; color: #333; line-height: 1.5;">
                                        ${order.reviewContent}
                                </div>
                            </c:if>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>
</body>
</html>