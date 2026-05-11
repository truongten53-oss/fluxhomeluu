<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chào Mừng - Chọn Vai Trò</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #e2e8f0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .header-title {
            margin-bottom: 40px;
            color: #0f172a;
            text-align: center;
        }
        .header-title h1 { margin-bottom: 10px; font-size: 32px; }
        .header-title p { color: #475569; font-size: 16px; margin: 0; }

        .role-container {
            display: flex;
            gap: 40px;
        }
        .role-card {
            background: white;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            text-align: center;
            text-decoration: none;
            color: #333;
            width: 220px;
            transition: all 0.3s ease;
            border: 2px solid transparent;
            cursor: pointer;
        }
        .role-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        .role-card.admin:hover { border-color: #3b82f6; }
        .role-card.employee:hover { border-color: #10b981; }

        .role-icon { font-size: 70px; margin-bottom: 20px; }
        .role-title { font-size: 22px; font-weight: bold; margin-bottom: 12px; color: #1e293b; }
        .role-desc { font-size: 14px; color: #64748b; line-height: 1.5; }
    </style>
</head>
<body>

<div class="header-title">
    <h1>Hệ Thống Quản Lý Dự Án</h1>
    <p>Vui lòng chọn vai trò để đăng nhập vào hệ thống</p>
</div>

<div class="role-container">
    <a href="${pageContext.request.contextPath}/login.jsp?type=admin" class="role-card admin">
        <div class="role-icon">👨‍💼</div>
        <div class="role-title">Giám Đốc</div>
        <div class="role-desc">Quản lý tổng thể dự án, phân công công việc và nhân sự.</div>
    </a>

    <a href="${pageContext.request.contextPath}/login.jsp?type=employee" class="role-card employee">
        <div class="role-icon">👷‍♂️</div>
        <div class="role-title">Nhân Viên</div>
        <div class="role-desc">Xem nhiệm vụ được giao và cập nhật tiến độ công việc.</div>
    </a>
</div>

</body>
</html>
