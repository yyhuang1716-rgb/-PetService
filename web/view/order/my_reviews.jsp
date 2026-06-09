<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>我的评价 - 萌宠之家</title>
    <style>
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background-color: #FFFDF5; color: #2D2D2D; padding: 40px; }
        .container { max-width: 800px; margin: 0 auto; }
        h2 { color: #06C270; text-align: center; margin-bottom: 30px; }
        .nav-back {
            display: inline-block; margin-bottom: 20px; color: #06C270;
            text-decoration: none; font-weight: bold;
        }
        .empty-state { text-align: center; padding: 80px 20px; background: #fff; border-radius: 16px; box-shadow: 0 4px 16px rgba(0,0,0,0.06); }
        .empty-state .icon { font-size: 64px; margin-bottom: 20px; }
        .empty-state p { font-size: 18px; color: #666; }
        .empty-state .btn-service {
            display: inline-block; margin-top: 20px; background: #06C270; color: #fff;
            padding: 12px 36px; border-radius: 24px; font-weight: bold; text-decoration: none;
        }
        .review-card {
            background: #fff; border-radius: 16px; padding: 24px; margin-bottom: 20px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06); border-left: 4px solid #06C270;
        }
        .review-card .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
        .review-card .service-name { font-size: 18px; font-weight: bold; color: #333; }
        .review-card .stars { color: #FFD166; font-size: 22px; }
        .review-card .content { font-size: 15px; color: #444; line-height: 1.7; margin: 8px 0; padding: 12px 16px; background: #F8FFF8; border-radius: 8px; }
        .review-card .meta { font-size: 13px; color: #AAA; display: flex; gap: 16px; }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/index.jsp" class="nav-back">⬅ 返回首页</a>
    <h2>⭐ 我的评价</h2>

    <c:choose>
        <c:when test="${empty requestScope.reviewList}">
            <div class="empty-state">
                <div class="icon">📭</div>
                <p>您还没有发表过评价</p>
                <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list" class="btn-service">去预约服务</a>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${requestScope.reviewList}" var="r">
                <div class="review-card">
                    <div class="header">
                        <div class="service-name">${r.serviceTitle}</div>
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
                    <div class="meta">
                        <span>🐾 ${r.petName}</span>
                        <span>📅 ${fn:replace(r.reviewTime, 'T', ' ')}</span>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
