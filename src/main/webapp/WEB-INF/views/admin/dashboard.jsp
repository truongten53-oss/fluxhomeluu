<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard</title>
  <style>
    body { font-family: Arial; margin: 20px; }
    .menu a { margin-right: 15px; text-decoration: none; background: #007bff; color: white; padding: 5px 10px; border-radius: 4px; }
  </style>
</head>
<body>
<h1>Xin chào, ${sessionScope.user.fullName} (${sessionScope.user.role})</h1>
<div class="menu">
  <a href="${pageContext.request.contextPath}/admin/projects">Quản lý dự án</a>
  <a href="${pageContext.request.contextPath}/admin/tasks">Quản lý công việc</a>
  <a href="${pageContext.request.contextPath}/admin/users">Quản lý nhân sự</a>
  <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
</div>
</body>
</html>
