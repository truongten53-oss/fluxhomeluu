<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><title>Quản lý dự án</title>
  <style> body { font-family: Arial; margin: 20px; } .form-box, .list-box { background: #f9f9f9; padding: 15px; margin-bottom: 20px; } table { border-collapse: collapse; width: 100%; } th, td { border: 1px solid #ddd; padding: 8px; } img { width: 50px; height: 50px; } </style>
</head>
<body>
<h1>Quản lý dự án</h1>
<div class="form-box">
  <h3>Thêm dự án mới</h3>
  <form action="${pageContext.request.contextPath}/admin/projects" method="post" enctype="multipart/form-data">
    <input type="text" name="name" placeholder="Tên dự án" required><br>
    <input type="text" name="location" placeholder="Địa điểm"><br>
    <input type="file" name="image" accept="image/*"><br>
    <button type="submit">Thêm</button>
  </form>
</div>
<div class="list-box">
  <h3>Danh sách dự án</h3>
  <table>
    <thead><tr><th>ID</th><th>Ảnh</th><th>Tên</th><th>Địa điểm</th><th>Thao tác</th></tr></thead>
    <tbody>
    <c:forEach var="p" items="${projects}">
      <tr><td>${p.id}</td><td><c:if test="${not empty p.imageUrl}"><img src="${pageContext.request.contextPath}/images/${p.imageUrl}"></c:if></td><td>${p.name}</td><td>${p.location}</td><td><a href="${pageContext.request.contextPath}/admin/projects?action=delete&id=${p.id}" onclick="return confirm('Xóa?')">Xóa</a></td></tr>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>