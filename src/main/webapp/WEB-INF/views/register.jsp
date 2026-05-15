<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Đăng ký</title>
  <style>
    body { font-family: Arial; background: #f0f2f5; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .register-box { background: white; padding: 30px; border-radius: 8px; width: 350px; }
    input, select { width: 100%; padding: 8px; margin: 8px 0; box-sizing: border-box; }
    button { width: 100%; padding: 10px; background: #28a745; color: white; border: none; cursor: pointer; }
    .error { color: red; text-align: center; }
  </style>
</head>
<body>
<div class="register-box">
  <h2>Đăng ký</h2>
  <c:if test="${not empty error}"><div class="error">${error}</div></c:if>
  <form action="${pageContext.request.contextPath}/register" method="POST">
    <input type="text" name="full_name" placeholder="Họ và tên" required>
    <input type="text" name="username" placeholder="Tên đăng nhập" required>
    <input type="password" name="password" placeholder="Mật khẩu" required>
    <select name="role">
      <option value="employee">Nhân viên</option>
      <option value="admin">Quản trị viên</option>
    </select>
    <button type="submit">Đăng ký</button>
  </form>
  <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
</div>
</body>
</html>