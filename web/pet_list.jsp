<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>我的宠物档案 - 萌宠之家</title>
    <style>
        body { font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif; background-color: #FFFDF5; color: #2D2D2D; padding: 40px; }
        .container { max-width: 900px; margin: 0 auto; }
        h2 { color: #06C270; text-align: center; margin-bottom: 30px; }

        /* 宠物卡片布局 */
        .pet-grid { display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 40px; }
        .pet-card { background: #fff; border-radius: 16px; padding: 20px; width: calc(33.333% - 14px); box-shadow: 0 4px 16px rgba(0,0,0,0.06); border-top: 4px solid #FFD166; position: relative; }
        .pet-card h3 { margin: 0 0 10px 0; color: #333; }
        .pet-card p { margin: 5px 0; color: #666; font-size: 14px; }
        .btn-del { position: absolute; top: 15px; right: 15px; background: #FF6B6B; color: white; border: none; border-radius: 8px; padding: 5px 10px; cursor: pointer; text-decoration: none; font-size: 12px; }
        .btn-del:hover { background: #FF4444; }
        .empty-tips { text-align: center; color: #999; width: 100%; padding: 40px 0; }

        /* 添加表单样式 */
        .add-form { background: #fff; border-radius: 16px; padding: 30px; box-shadow: 0 4px 16px rgba(0,0,0,0.06); }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; font-size: 14px; }
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px; box-sizing: border-box; }
        .btn-submit { background: #06C270; color: white; border: none; border-radius: 20px; padding: 10px 30px; font-size: 16px; cursor: pointer; font-weight: bold; width: 100%; transition: background 0.3s; }
        .btn-submit:hover { background: #04A05C; }
        .nav-back { display: inline-block; margin-bottom: 20px; color: #06C270; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/index.jsp" class="nav-back">⬅ 返回主页</a>
    <h2>🐾 我的毛孩子档案</h2>

    <div class="pet-grid">
        <c:choose>
            <c:when test="${empty petList}">
                <div class="empty-tips">您还没有添加任何宠物哦，快去下方添加一只吧！🐶🐱</div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${petList}" var="pet">
                    <div class="pet-card">
                        <h3>${pet.name}</h3>
                        <p><strong>品种:</strong> ${pet.type}</p>
                        <p><strong>年龄:</strong> ${pet.age} 岁</p>
                        <p><strong>体重:</strong> ${pet.weight} kg</p>
                        <a href="${pageContext.request.contextPath}/petServlet?action=delete&id=${pet.id}" class="btn-del" onclick="return confirm('确定要删除这只可爱的小家伙吗？');">删除</a>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="add-form">
        <h3 style="margin-top:0;">➕ 添加新宠物</h3>
        <form action="${pageContext.request.contextPath}/petServlet?action=add" method="post">
            <div class="form-group">
                <label>宠物昵称</label>
                <input type="text" name="name" required placeholder="例如：旺财、咪咪">
            </div>
            <div class="form-group">
                <label>宠物类型</label>
                <select name="type">
                    <option value="狗狗">狗狗 🐶</option>
                    <option value="猫咪">猫咪 🐱</option>
                    <option value="异宠">异宠 🐰🐦</option>
                </select>
            </div>
            <div class="form-group">
                <label>年龄 (岁)</label>
                <input type="number" name="age" required min="0" placeholder="例如：2">
            </div>
            <div class="form-group">
                <label>体重 (kg)</label>
                <input type="number" name="weight" required step="0.1" placeholder="例如：5.5">
            </div>
            <button type="submit" class="btn-submit">保存档案</button>
        </form>
    </div>
</div>
</body>
</html>