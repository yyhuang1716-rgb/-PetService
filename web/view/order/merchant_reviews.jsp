<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>客户评价 - 萌宠之家</title>
    <style>
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background-color: #FFFDF5; color: #2D2D2D; padding: 40px; }
        .container { max-width: 1100px; margin: 0 auto; }
        h2 { color: #06C270; text-align: center; margin-bottom: 30px; }
        .nav-back {
            display: inline-block; margin-bottom: 20px; color: #06C270;
            text-decoration: none; font-weight: bold;
        }
        .empty-state { text-align: center; padding: 80px 20px; background: #fff; border-radius: 16px; box-shadow: 0 4px 16px rgba(0,0,0,0.06); }
        .empty-state .icon { font-size: 64px; margin-bottom: 20px; }
        .empty-state p { font-size: 18px; color: #666; }
        .review-card {
            background: #fff; border-radius: 16px; padding: 24px; margin-bottom: 20px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06); border-left: 4px solid #06C270;
        }
        .review-card .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
        .review-card .user { font-size: 16px; font-weight: bold; color: #333; }
        .review-card .service { font-size: 14px; color: #888; }
        .review-card .stars { color: #FFD166; font-size: 20px; }
        .review-card .content { font-size: 15px; color: #444; line-height: 1.7; margin: 8px 0; }
        .review-card .meta { font-size: 13px; color: #AAA; }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/view/merchant/home.jsp" class="nav-back">⬅ 返回工作台</a>
    <h2>💬 客户评价</h2>

    <c:choose>
        <c:when test="${empty requestScope.reviewList}">
            <div class="empty-state">
                <div class="icon">📭</div>
                <p>暂无客户评价</p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${requestScope.reviewList}" var="r">
                <div class="review-card">
                    <div class="header">
                        <div>
                            <div class="user">👤 ${r.username}</div>
                            <div class="service">📋 ${r.serviceTitle} · 🐾 ${r.petName}</div>
                        </div>
                        <div class="stars">
                            <c:forEach begin="1" end="5" var="i">
                                <c:choose>
                                    <c:when test="${i <= r.rating}">★</c:when>
                                    <c:otherwise>☆</c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="content">${r.reviewContent}</div>
                    <div class="meta">${fn:replace(r.reviewTime, 'T', ' ')}</div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
