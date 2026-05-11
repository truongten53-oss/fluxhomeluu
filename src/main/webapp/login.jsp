<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>InTech Design - Đăng Nhập</title>
  <style>
    body { font-family: Arial, sans-serif; background: #0f172a; color: white; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .login-box { background: #1e293b; padding: 40px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.5); width: 300px; text-align: center; }
    input { width: 90%; padding: 10px; margin: 10px 0; border-radius: 5px; border: 1px solid #ccc; }
    button { width: 100%; padding: 10px; background: #ffc107; color: black; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; }
    .error { color: #ff4d4d; font-size: 14px; margin-bottom: 10px; }
  </style>
</head>
<body>

<div class="login-box">
  <h2>ĐĂNG NHẬP</h2>

  <% if (request.getAttribute("errorMessage") != null) { %>
  <div class="error"><%= request.getAttribute("errorMessage") %></div>
  <% } %>

  <form action="${pageContext.request.contextPath}/login" method="POST">
    <input type="text" name="username" placeholder="Tên đăng nhập" required>
    <input type="password" name="password" placeholder="Mật khẩu" required>
    <button type="submit">Đăng Nhập</button>
  </form>
</div>

</body>
</html>