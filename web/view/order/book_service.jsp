<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="java.time.LocalDateTime" %>
<html>
<head>
    <title>预约服务 - 萌宠之家</title>
    <style>
        body {
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
            background-color: #FFFDF5;
            color: #2D2D2D;
            padding: 40px;
        }
        .container {
            max-width: 520px;
            margin: 0 auto;
        }
        h2 {
            color: #06C270;
            text-align: center;
            margin-bottom: 30px;
        }
        .book-form {
            background: #fff;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            font-size: 14px;
            color: #333;
        }
        .form-group select,
        .form-group input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
            box-sizing: border-box;
            background: #FAFAFA;
        }
        .form-group select:focus,
        .form-group input:focus {
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
        .nav-back {
            display: inline-block;
            margin-bottom: 20px;
            color: #06C270;
            text-decoration: none;
            font-weight: bold;
        }
        .empty-pet {
            text-align: center;
            color: #999;
            padding: 20px 0;
        }
        .empty-pet a {
            color: #06C270;
        }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/serviceItemServlet?action=list" class="nav-back">⬅ 返回服务列表</a>
    <h2>📅 预约服务</h2>

    <form class="book-form" action="${pageContext.request.contextPath}/orderServlet?action=submitBook" method="post">

        <%-- 隐藏域：服务项目ID和商家ID --%>
        <input type="hidden" name="service_item_id" value="${requestScope.service_item_id}">
        <input type="hidden" name="merchant_id" value="${requestScope.merchant_id}">

        <%-- 宠物选择 --%>
        <div class="form-group">
            <label for="petId">🐾 选择宠物</label>
            <c:choose>
                <c:when test="${empty requestScope.petList}">
                    <div class="empty-pet">
                        😅 您还没有添加宠物<br>
                        <a href="#">去添加宠物</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <select id="petId" name="pet_id" required>
                        <option value="">-- 请选择你的宠物 --</option>
                        <c:forEach items="${requestScope.petList}" var="pet">
                            <option value="${pet.id}">
                                ${pet.name}（${pet.type}，${pet.age}岁）
                            </option>
                        </c:forEach>
                    </select>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- 预约时间 --%>
        <div class="form-group">
            <label for="appointmentTime">⏰ 预约时间</label>
            <input type="datetime-local" id="appointmentTime" name="appointment_time"
                   required min="<%= LocalDateTime.now().toString().substring(0, 16) %>">
        </div>

        <button type="submit" class="btn-submit">✅ 确认提交订单</button>
    </form>
</div>
</body>
</html>
