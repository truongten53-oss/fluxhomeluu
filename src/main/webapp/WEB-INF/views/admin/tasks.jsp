<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><title>Quản lý công việc</title>
    <style> body { font-family: Arial; margin: 20px; } table { border-collapse: collapse; width: 100%; } th, td { border: 1px solid #ddd; padding: 8px; } .form-box { background: #f0f0f0; padding: 15px; margin-bottom: 20px; } </style>
</head>
<body>
<h1>Quản lý công việc</h1>
<div class="form-box">
    <h3>Giao việc mới</h3>
    <form action="${pageContext.request.contextPath}/admin/tasks" method="post">
        <select name="projectId" required><option value="">-- Chọn dự án --</option><c:forEach var="proj" items="${projects}"><option value="${proj.id}">${proj.name}</option></c:forEach></select>
        <input type="text" name="title" placeholder="Tiêu đề" required>
        <select name="assigneeId"><option value="">-- Chọn người làm --</option><c:forEach var="u" items="${users}"><option value="${u.id}">${u.fullName} (${u.username})</option></c:forEach></select>
        <textarea name="notes" placeholder="Ghi chú"></textarea>
        <button type="submit">Giao việc</button>
    </form>
</div>
<h3>Danh sách công việc</h3>
<table border="1">
    <thead><tr><th>ID</th><th>Dự án</th><th>Tiêu đề</th><th>Người làm</th><th>Trạng thái</th><th>Ghi chú</th><th>Lịch sử</th><th>Xóa</th></tr></thead>
    <tbody>
    <c:forEach var="t" items="${tasks}">
        <tr><td>${t.id}</td><td>${t.projectName}</td><td>${t.title}</td><td>${t.assigneeName != null ? t.assigneeName : "Chưa giao"}</td><td>${t.status}</td><td>${t.notes}</td><td><a href="${pageContext.request.contextPath}/task-history?taskId=${t.id}">Xem lịch sử</a></td><td><a href="${pageContext.request.contextPath}/admin/tasks?action=delete&id=${t.id}" onclick="return confirm('Xóa?')">Xóa</a></td></tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
