<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<head>
    <title>我的收藏 - 萌宠之家</title>
    <style>
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background-color: #FFFDF5; color: #2D2D2D; padding: 40px; }
        .container { max-width: 1000px; margin: 0 auto; }
        h2 { color: #06C270; text-align: center; margin-bottom: 30px; }
        .nav-back {
            display: inline-block; margin-bottom: 20px; color: #06C270;
            text-decoration: none; font-weight: bold;
        }
        .msg-toast {
            text-align: center; padding: 14px 20px; border-radius: 12px;
            font-size: 15px; font-weight: bold; margin-bottom: 20px;
            background: #D4EDDA; color: #155724; border: 1px solid #C3E6CB;
        }
        .empty-state {
            text-align: center; padding: 80px 20px; background: #fff;
            border-radius: 16px; box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        .empty-state .icon { font-size: 64px; margin-bottom: 20px; }
        .empty-state p { font-size: 18px; color: #666; margin-bottom: 20px; }
        .empty-state .btn-service {
            display: inline-block; background: #06C270; color: #fff;
            padding: 12px 36px; border-radius: 24px; font-weight: bold; text-decoration: none;
        }
        .card-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
        .service-card {
            background: #fff; border-radius: 16px; padding: 24px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
            border-left: 4px solid #FF6B81; position: relative;
        }
        .service-card .title { font-size: 18px; font-weight: bold; color: #333; margin: 0 0 8px 0; }
        .service-card .desc { font-size: 14px; color: #888; margin: 8px 0; line-height: 1.6; }
        .service-card .price { color: #FF6B6B; font-size: 22px; font-weight: bold; margin: 10px 0; }
        .service-card .fav-time { font-size: 12px; color: #BBB; margin-bottom: 12px; }
        .service-card .actions { display: flex; gap: 10px; margin-top: 12px; }
        .btn-book {
            flex: 1; background: #06C270; color: #fff; text-decoration: none;
            padding: 8px 0; border-radius: 20px; font-size: 14px; font-weight: bold;
            text-align: center; display: inline-block;
        }
        .btn-unfav {
            flex: 1; background: #FFF3CD; color: #856404; text-decoration: none;
            padding: 8px 0; border-radius: 20px; font-size: 14px; font-weight: bold;
            text-align: center; display: inline-block; border: 1px solid #FFE69C;
        }
        .service-card .fav-tag {
            position: absolute; top: 16px; right: 16px;
            background: #FF6B81; color: #fff; padding: 4px 12px;
            border-radius: 20px; font-size: 12px; font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/index.jsp" class="nav-back">⬅ 返回首页</a>
    <h2>❤️ 我的收藏</h2>

    <c:if test="${not empty param.msg}">
        <div class="msg-toast">${param.msg}</div>
    </c:if>

    <c:choose>
        <c:when test="${empty requestScope.favoriteList}">
            <div class="empty-state">
                <div class="icon">💝</div>
                <p>还没有收藏任何服务哦～</p>
                <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list" class="btn-service">去浏览服务</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card-grid">
                <c:forEach items="${requestScope.favoriteList}" var="item">
                    <div class="service-card">
                        <div class="fav-tag">❤️ 已收藏</div>
                        <h3 class="title">${item.title}</h3>
                        <div class="desc">${empty item.description ? '暂无描述' : fn:substring(item.description, 0, 60)}${fn:length(item.description) > 60 ? '...' : ''}</div>
                        <div class="price">¥${item.price}</div>
                        <div class="fav-time">⭐ 收藏时间：${fn:replace(item.favoriteCreateTime, 'T', ' ')}</div>
                        <div class="actions">
                            <a href="${pageContext.request.contextPath}/orderServlet?action=toBook&service_item_id=${item.id}&merchant_id=${item.merchantId}" class="btn-book">📅 去预约</a>
                            <a href="${pageContext.request.contextPath}/favoriteServlet?action=remove&serviceId=${item.id}" class="btn-unfav" onclick="return confirm('确定取消收藏吗？')">🗑️ 取消收藏</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
