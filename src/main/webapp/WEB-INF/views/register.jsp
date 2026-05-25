<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FluxHome | Đăng ký</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    body {
      font-family: 'Inter', sans-serif;
      background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }
    .register-container {
      width: 100%;
      max-width: 480px;
    }
    .card {
      background: white;
      border-radius: 32px;
      padding: 40px 36px;
      box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
      transition: transform 0.2s ease;
    }
    .logo {
      text-align: center;
      margin-bottom: 28px;
    }
    .logo i {
      font-size: 48px;
      color: #38bdf8;
      background: #e0f2fe;
      padding: 14px;
      border-radius: 28px;
    }
    .logo h2 {
      margin-top: 16px;
      font-size: 28px;
      font-weight: 700;
      background: linear-gradient(135deg, #0f172a, #38bdf8);
      -webkit-background-clip: text;
      background-clip: text;
      color: transparent;
    }
    .logo p {
      color: #64748b;
      font-size: 14px;
      margin-top: 6px;
    }
    .input-group {
      margin-bottom: 18px;
    }
    .input-group label {
      display: block;
      font-size: 13px;
      font-weight: 500;
      color: #334155;
      margin-bottom: 6px;
    }
    .input-group i {
      position: absolute;
      left: 14px;
      top: 38px;
      color: #94a3b8;
      font-size: 16px;
    }
    .input-group input, .input-group select {
      width: 100%;
      padding: 12px 12px 12px 40px;
      border: 1px solid #e2e8f0;
      border-radius: 20px;
      font-size: 14px;
      font-family: 'Inter', sans-serif;
      transition: all 0.2s;
      background: #f8fafc;
      appearance: none;
    }
    .input-group select {
      padding: 12px 12px 12px 40px;
      cursor: pointer;
    }
    .input-group input:focus, .input-group select:focus {
      outline: none;
      border-color: #38bdf8;
      box-shadow: 0 0 0 3px rgba(56, 189, 248, 0.2);
      background: white;
    }
    .btn-register {
      width: 100%;
      background: #10b981;
      color: white;
      border: none;
      padding: 12px;
      border-radius: 40px;
      font-weight: 600;
      font-size: 16px;
      cursor: pointer;
      transition: all 0.2s;
      margin-top: 8px;
      font-family: 'Inter', sans-serif;
    }
    .btn-register:hover {
      background: #059669;
      transform: translateY(-2px);
      box-shadow: 0 10px 15px -3px rgba(16, 185, 129, 0.3);
    }
    .login-link {
      text-align: center;
      margin-top: 24px;
      font-size: 14px;
      color: #475569;
    }
    .login-link a {
      color: #3b82f6;
      text-decoration: none;
      font-weight: 600;
    }
    .login-link a:hover {
      text-decoration: underline;
    }
    .error-message {
      background: #fee2e2;
      color: #dc2626;
      padding: 12px 16px;
      border-radius: 20px;
      font-size: 13px;
      margin-bottom: 20px;
      text-align: center;
      border-left: 4px solid #dc2626;
    }
    @media (max-width: 480px) {
      .card { padding: 30px 24px; }
    }
  </style>
</head>
<body>
<div class="register-container">
  <div class="card">
    <div class="logo">
      <i class="fas fa-user-plus"></i>
      <h2>FluxHome</h2>
      <p>Tạo tài khoản mới</p>
    </div>

    <c:if test="${not empty error}">
      <div class="error-message">
        <i class="fas fa-exclamation-circle"></i> ${error}
      </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="POST">
      <div class="input-group">
        <label>Họ và tên</label>
        <i class="fas fa-user-circle"></i>
        <input type="text" name="full_name" placeholder="Nguyễn Văn A" required>
      </div>
      <div class="input-group">
        <label>Tên đăng nhập</label>
        <i class="fas fa-user"></i>
        <input type="text" name="username" placeholder="username" required>
      </div>
      <div class="input-group">
        <label>Mật khẩu</label>
        <i class="fas fa-lock"></i>
        <input type="password" name="password" placeholder="••••••••" required>
      </div>
      <div class="input-group">
        <label>Vai trò</label>
        <i class="fas fa-badge"></i>
        <select name="role">
          <option value="employee">Nhân viên</option>
          <option value="admin">Quản trị viên</option>
        </select>
      </div>
      <button type="submit" class="btn-register">Đăng ký</button>
    </form>

    <div class="login-link">
      Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
    </div>
  </div>
</div>
</body>
</html>