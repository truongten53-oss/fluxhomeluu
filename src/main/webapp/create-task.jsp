<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Công Việc Mới</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f8; margin: 20px; }
        .form-box { background: #fff; padding: 20px; border-radius: 8px; max-width: 500px; margin: auto; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: bold; margin-bottom: 5px; }
        input[type="text"], select, textarea { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        button { background: #0f172a; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; }
        .btn-cancel { background: #ccc; color: black; text-decoration: none; padding: 10px 15px; border-radius: 4px; margin-left: 10px; }
    </style>
</head>
<body>
<div class="form-box">
    <h2>Thêm Công Việc Mới</h2>
    <form action="${pageContext.request.contextPath}/create-task" method="POST">
        <div class="form-group">
            <label>Dự Án Công Ty (*):</label>
            <select name="projectId" required>
                <option value="">-- Bấm để chọn dự án --</option>
                <c:forEach var="p" items="${projectList}">
                    <option value="${p.id}">${p.name} - ${p.location}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label>Tên Công Việc:</label>
            <input type="text" name="title" required>
        </div>

        <div class="form-group">
            <label>Người Phụ Trách:</label>
            <select name="assigneeId" required>
                <option value="">-- Chọn nhân sự --</option>

                <c:forEach var="entry" items="${employeeWorkloads}">
                    <option value="${entry.key.id}">
                        👤 ${entry.key.fullName}

                        (<c:choose>
                        <c:when test="${entry.key.role == 'admin'}">Giám đốc</c:when>
                        <c:when test="${entry.key.role == 'designer'}">Thiết kế</c:when>
                        <c:when test="${entry.key.role == 'sale'}">Sale</c:when>
                        <c:when test="${entry.key.role == 'supervisor'}">Giám sát</c:when>
                        <c:when test="${entry.key.role == 'marketing'}">Marketing</c:when>
                        <c:when test="${entry.key.role == 'accountant'}">Kế toán</c:when>
                        <c:when test="${entry.key.role == 'student'}">Thực tập sinh</c:when>
                        <c:otherwise>${entry.key.role}</c:otherwise>
                    </c:choose>)

                        -
                        <c:choose>
                            <c:when test="${entry.value == 0}">[Đang rảnh]</c:when>
                            <c:otherwise>[Đang làm ${entry.value} việc]</c:otherwise>
                        </c:choose>
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label>Trạng Thái:</label>
            <select name="status">
                <option value="pending">Đang chờ (Pending)</option>
                <option value="in_progress">Đang tiến hành (In Progress)</option>
                <option value="completed">Đã hoàn thành (Completed)</option>
            </select>
        </div>
        <div class="form-group">
            <label>Ghi chú:</label>
            <textarea name="notes" rows="4"></textarea>
        </div>
        <button type="submit">Lưu Công Việc</button>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn-cancel">Hủy</a>
    </form>
</div>
</body>
</html>