<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><title>Quản lý nhân sự</title>
  <style> body { font-family: Arial; margin: 20px; } table { border-collapse: collapse; width: 100%; } th, td { border: 1px solid #ddd; padding: 8px; } </style>
</head>
<body>
<h1>Danh sách nhân viên</h1>
<table>
  <thead><tr><th>ID</th><th>Họ tên</th><th>Username</th><th>Role</th><th>Thao tác</th></tr></thead>
  <tbody>
  <c:forEach var="u" items="${users}">
    <tr><td>${u.id}</td><td>${u.fullName}</td><td>${u.username}</td><td>${u.role}</td><td><c:if test="${u.role != 'admin'}"><a href="${pageContext.request.contextPath}/admin/users?action=delete&id=${u.id}" onclick="return confirm('Xóa?')">Xóa</a></c:if></td></tr>
  </c:forEach>
  </tbody>
</table>
</body>
</html>