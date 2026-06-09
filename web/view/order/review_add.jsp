<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>发表评价 - 萌宠之家</title>
    <style>
        body {
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
            background-color: #FFFDF5;
            color: #2D2D2D;
            padding: 40px;
        }
        .container {
            max-width: 560px;
            margin: 0 auto;
        }
        h2 {
            color: #06C270;
            text-align: center;
            margin-bottom: 30px;
        }
        .review-form {
            background: #fff;
            border-radius: 16px;
            padding: 30px 35px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        .form-group {
            margin-bottom: 24px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            font-size: 15px;
            color: #333;
        }

        /* 星级评分 */
        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
            gap: 4px;
        }
        .star-rating input {
            display: none;
        }
        .star-rating label {
            font-size: 36px;
            color: #DDD;
            cursor: pointer;
            transition: color 0.2s;
        }
        .star-rating label:hover,
        .star-rating label:hover ~ label,
        .star-rating input:checked ~ label {
            color: #FFD166;
        }

        /* 文本框 */
        .form-group textarea {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
            font-family: inherit;
            box-sizing: border-box;
            background: #FAFAFA;
            resize: vertical;
            min-height: 120px;
        }
        .form-group textarea:focus {
            outline: none;
            border-color: #06C270;
            background: #fff;
        }

        .btn-submit {
            background: #06C270;
            color: white;
            border: none;
            border-radius: 20px;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: bold;
            width: 100%;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn-submit:hover {
            background: #04A05C;
        }

        .order-info {
            background: #F8FFF8;
            border: 1px solid #D4EDDA;
            border-radius: 10px;
            padding: 14px 18px;
            margin-bottom: 24px;
            font-size: 14px;
            color: #155724;
        }
        .order-info strong {
            font-size: 15px;
        }

        .nav-back {
            display: inline-block;
            margin-bottom: 20px;
            color: #06C270;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/orderServlet?action=myOrders" class="nav-back">⬅ 返回我的预约</a>
    <h2>📝 发表评价</h2>

    <form class="review-form" action="${pageContext.request.contextPath}/reviewServlet?action=add" method="post">
        <input type="hidden" name="orderId" value="${requestScope.orderId}">

        <div class="order-info">
            <strong>订单号：#${requestScope.orderId}</strong><br>
            感谢您使用萌宠之家服务，请为本次服务评分并留下宝贵意见 🙏
        </div>

        <%-- 评分 --%>
        <div class="form-group">
            <label>⭐ 评分</label>
            <div class="star-rating">
                <input type="radio" name="rating" value="5" id="star5">
                <label for="star5" title="非常满意">★</label>
                <input type="radio" name="rating" value="4" id="star4">
                <label for="star4" title="满意">★</label>
                <input type="radio" name="rating" value="3" id="star3" checked>
                <label for="star3" title="一般">★</label>
                <input type="radio" name="rating" value="2" id="star2">
                <label for="star2" title="不满意">★</label>
                <input type="radio" name="rating" value="1" id="star1">
                <label for="star1" title="非常差">★</label>
            </div>
        </div>

        <%-- 评价内容 --%>
        <div class="form-group">
            <label for="content">💬 评价内容</label>
            <textarea id="content" name="comment" placeholder="请描述您的服务体验…（选填）" maxlength="500"></textarea>
        </div>

        <button type="submit" class="btn-submit">✅ 提交评价</button>
    </form>
</div>
</body>
</html>
