<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>FluxHome | Công việc của tôi</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Inter', sans-serif; background: #f0f2f5; color: #1e293b; }
    .app-container { display: flex; min-height: 100vh; }
    .sidebar {
      width: 280px;
      background: linear-gradient(180deg, #0f172a 0%, #1e293b 100%);
      color: #e2e8f0;
      padding: 30px 20px;
      position: sticky;
      top: 0;
      height: 100vh;
    }
    .logo {
      display: flex;
      align-items: center;
      gap: 12px;
      font-size: 24px;
      font-weight: 700;
      margin-bottom: 40px;
      padding-bottom: 20px;
      border-bottom: 1px solid #334155;
      color: white;
    }
    .logo i { font-size: 28px; color: #38bdf8; }
    .nav-menu { list-style: none; }
    .nav-item { margin-bottom: 12px; }
    .nav-link {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 12px 16px;
      border-radius: 12px;
      color: #cbd5e1;
      text-decoration: none;
      transition: all 0.2s;
      font-weight: 500;
    }
    .nav-link i { width: 24px; font-size: 18px; }
    .nav-link:hover, .nav-link.active { background: #334155; color: white; }
    .main-content { flex: 1; padding: 30px 40px; overflow-y: auto; }
    .page-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
      flex-wrap: wrap;
      gap: 15px;
    }
    .greeting h1 { font-size: 28px; font-weight: 600; margin-bottom: 6px; }
    .greeting p { color: #475569; }
    .user-info {
      display: flex;
      align-items: center;
      gap: 20px;
      background: white;
      padding: 8px 20px;
      border-radius: 40px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.05);
    }
    .logout-btn {
      background: #ef4444;
      color: white;
      border: none;
      padding: 8px 16px;
      border-radius: 30px;
      cursor: pointer;
      font-weight: 500;
    }
    .card {
      background: white;
      border-radius: 20px;
      padding: 25px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.05);
      border: 1px solid #e2e8f0;
    }
    .card h3 {
      margin-bottom: 20px;
      font-weight: 600;
      font-size: 18px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      text-align: left;
      padding: 14px 12px;
      border-bottom: 1px solid #e2e8f0;
      vertical-align: middle;
    }
    th {
      font-weight: 600;
      color: #475569;
    }
    .status-badge {
      display: inline-block;
      padding: 4px 10px;
      border-radius: 30px;
      font-size: 12px;
      font-weight: 500;
    }
    .status-pending { background: #fef3c7; color: #92400e; }
    .status-inprogress { background: #dbeafe; color: #1e40af; }
    .status-completed { background: #dcfce7; color: #166534; }
    .update-form {
      display: flex;
      gap: 10px;
      align-items: center;
    }
    .update-form select {
      padding: 6px 10px;
      border: 1px solid #cbd5e1;
      border-radius: 12px;
      font-size: 13px;
    }
    .update-form button {
      background: #3b82f6;
      color: white;
      border: none;
      padding: 6px 12px;
      border-radius: 20px;
      cursor: pointer;
      font-weight: 500;
      font-size: 12px;
    }
    .update-form button:hover { background: #2563eb; }
    @media (max-width: 900px) {
      .sidebar { width: 80px; padding: 20px 10px; }
      .sidebar .logo span, .sidebar .nav-link span { display: none; }
      .main-content { padding: 20px; }
    }
  </style>
</head>
<body>
<div class="app-container">
  <aside class="sidebar">
    <div class="logo"><i class="fas fa-cubes"></i><span>FluxHome</span></div>
    <ul class="nav-menu">
      <li class="nav-item"><a href="${pageContext.request.contextPath}/employee/tasks" class="nav-link active"><i class="fas fa-tasks"></i><span>Công việc của tôi</span></a></li>
    </ul>
  </aside>

  <main class="main-content">
    <div class="page-header">
      <div class="greeting">
        <h1>Xin chào, ${sessionScope.user.fullName}</h1>
        <p>Danh sách công việc được giao</p>
      </div>
      <div class="user-info">
        <i class="fas fa-bell"></i>
        <i class="fas fa-user-circle"></i>
        <form action="${pageContext.request.contextPath}/logout" method="get" style="display: inline;">
          <button class="logout-btn"><i class="fas fa-sign-out-alt"></i> Đăng xuất</button>
        </form>
      </div>
    </div>

    <div class="card">
      <h3><i class="fas fa-list-check"></i> Công việc của tôi</h3>
      <c:if test="${empty tasks}">
        <p>Bạn chưa có công việc nào.</p>
      </c:if>
      <c:if test="${not empty tasks}">
        <table>
          <thead>
          <tr><th>Dự án</th><th>Tiêu đề</th><th>Trạng thái</th><th>Cập nhật</th></tr>
          </thead>
          <tbody>
          <c:forEach var="t" items="${tasks}">
            <tr>
              <td>${t.projectName}</td>
              <td>${t.title}</td>
              <td>
                                <span class="status-badge
                                    ${t.status == 'pending' ? 'status-pending' : (t.status == 'in_progress' ? 'status-inprogress' : 'status-completed')}">
                                    ${t.status == 'pending' ? 'Chờ' : (t.status == 'in_progress' ? 'Đang làm' : 'Hoàn thành')}
                                </span>
              </td>
              <td>
                <form action="${pageContext.request.contextPath}/employee/update-task" method="post" class="update-form">
                  <input type="hidden" name="taskId" value="${t.id}">
                  <select name="status">
                    <option value="pending" ${t.status == 'pending' ? 'selected' : ''}>Chờ</option>
                    <option value="in_progress" ${t.status == 'in_progress' ? 'selected' : ''}>Đang làm</option>
                    <option value="completed" ${t.status == 'completed' ? 'selected' : ''}>Hoàn thành</option>
                  </select>
                  <button type="submit"><i class="fas fa-save"></i> Cập nhật</button>
                </form>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </c:if>
    </div>
  </main>
</div>
</body>
</html>