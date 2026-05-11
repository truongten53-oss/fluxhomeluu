<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
  <title>Tạo Tài Khoản Nhân Viên</title>
  <style>
    body { font-family: Arial; background: #f4f6f8; padding: 50px; }
    .form-container { background: white; padding: 20px; max-width: 400px; margin: auto; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    input, select { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
    button { width: 100%; padding: 10px; background: #0f172a; color: white; border: none; border-radius: 4px; cursor: pointer; }
  </style>
</head>
<body>
<div class="form-container">
  <h2>Tạo tài khoản mới</h2>

  <c:if test="${not empty errorMessage}">
    <div style="color: #ef4444; background: #fee2e2; padding: 10px; border-radius: 4px; margin-bottom: 15px; text-align: center; font-size: 14px; border: 1px solid #fecaca;">
      ⚠️ ${errorMessage}
    </div>
  </c:if>

  <form action="${pageContext.request.contextPath}/register" method="POST" enctype="multipart/form-data">

    <label>Họ và Tên:</label>
    <input type="text" name="fullName" required>

    <label>Tên đăng nhập:</label>
    <input type="text" name="username" required>

    <label>Mật khẩu:</label>
    <input type="password" name="password" required>

    <label>Ảnh đại diện (Không bắt buộc):</label>
    <input type="file" name="avatar" accept="image/*">

    <label>Chức vụ:</label>
    <select name="role">
      <option value="designer">Nhân viên Thiết kế</option>
      <option value="sale">Nhân viên Sale</option>
      <option value="student">Sinh viên Thực tập</option>
      <option value="accountant">Kế toán</option>
      <option value="supervisor">Giám sát</option>
      <option value="marketing">Marketing</option>
    </select>

    <button type="submit">Tạo tài khoản</button>

  </form>
  <br>
  <a href="${pageContext.request.contextPath}/dashboard" style="display: block; text-align: center; text-decoration: none; color: #3b82f6;">Quay lại Dashboard</a>
</div>
</body>
</html>