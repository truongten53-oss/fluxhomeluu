<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FluxHome | Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Inter', sans-serif; background: #f0f2f5; color: #1e293b; }
    .app-container { display: flex; min-height: 100vh; }
    /* Sidebar */
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
    /* Main content */
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
    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 20px;
      margin-bottom: 40px;
    }
    .stat-card {
      background: white;
      border-radius: 20px;
      padding: 20px;
      box-shadow: 0 4px 6px -2px rgba(0,0,0,0.05);
      border: 1px solid #e2e8f0;
    }
    .stat-card:hover { transform: translateY(-4px); }
    .stat-title { font-size: 14px; font-weight: 500; color: #64748b; margin-bottom: 8px; }
    .stat-value { font-size: 36px; font-weight: 700; color: #0f172a; }
    .stat-icon { float: right; font-size: 32px; color: #94a3b8; }
    .full-width-card {
      background: white;
      border-radius: 20px;
      padding: 20px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.05);
      border: 1px solid #e2e8f0;
    }
    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      font-weight: 600;
      font-size: 18px;
    }
    table { width: 100%; border-collapse: collapse; }
    th, td { text-align: left; padding: 12px 8px; border-bottom: 1px solid #e2e8f0; }
    th { font-weight: 600; color: #475569; }
    select, button { padding: 6px 12px; border-radius: 8px; border: 1px solid #cbd5e1; background: white; cursor: pointer; }
    button { background: #3b82f6; color: white; border: none; }
    .view-staff-btn {
      background: #10b981;
      color: white;
      border: none;
      padding: 4px 12px;
      border-radius: 20px;
      cursor: pointer;
      font-size: 12px;
    }
    /* Modal */
    .modal {
      display: none;
      position: fixed;
      z-index: 1000;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0,0,0,0.5);
      justify-content: center;
      align-items: center;
    }
    .modal-content {
      background: white;
      padding: 25px;
      border-radius: 16px;
      width: 400px;
      max-width: 90%;
      box-shadow: 0 20px 25px -12px rgba(0,0,0,0.2);
    }
    .modal-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
      font-weight: 600;
      font-size: 18px;
    }
    .close-modal {
      cursor: pointer;
      font-size: 24px;
    }
    .staff-list {
      list-style: none;
      max-height: 300px;
      overflow-y: auto;
    }
    .staff-list li {
      padding: 8px 0;
      border-bottom: 1px solid #e2e8f0;
    }
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
      <li class="nav-item"><a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link active"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a></li>
      <li class="nav-item"><a href="${pageContext.request.contextPath}/admin/projects" class="nav-link"><i class="fas fa-folder-open"></i><span>Dự án đang chạy</span></a></li>
      <li class="nav-item"><a href="${pageContext.request.contextPath}/admin/tasks" class="nav-link"><i class="fas fa-tasks"></i><span>Công việc</span></a></li>
      <li class="nav-item"><a href="${pageContext.request.contextPath}/admin/users" class="nav-link"><i class="fas fa-users"></i><span>Đội ngũ nhân sự</span></a></li>
    </ul>
  </aside>

  <main class="main-content">
    <div class="page-header">
      <div class="greeting">
        <h1>Chào buổi ${greeting}, ${sessionScope.user.fullName}</h1>
        <p>Hôm nay bạn có ${pendingTasksCount} dự án đang chờ duyệt.</p>
      </div>
      <div class="user-info">
        <i class="fas fa-bell"></i>
        <i class="fas fa-user-circle"></i>
        <form action="${pageContext.request.contextPath}/logout" method="get" style="display: inline;">
          <button class="logout-btn"><i class="fas fa-sign-out-alt"></i> Đăng xuất</button>
        </form>
      </div>
    </div>

    <div class="stats-grid">
      <div class="stat-card"><div class="stat-icon"><i class="fas fa-project-diagram"></i></div><div class="stat-title">Tổng dự án</div><div class="stat-value">${totalProjects}</div></div>
      <div class="stat-card"><div class="stat-icon"><i class="fas fa-chart-line"></i></div><div class="stat-title">Đang tiến hành</div><div class="stat-value">${inProgressProjectsCount}</div></div>
      <div class="stat-card"><div class="stat-icon"><i class="fas fa-clock"></i></div><div class="stat-title">Đang chờ duyệt</div><div class="stat-value">${pendingTasksCount}</div></div>
      <div class="stat-card"><div class="stat-icon"><i class="fas fa-user-friends"></i></div><div class="stat-title">Thành viên</div><div class="stat-value">${totalUsers}</div></div>
      <div class="stat-card"><div class="stat-icon"><i class="fas fa-check-circle"></i></div><div class="stat-title">Hoàn thành</div><div class="stat-value">${completedProjectsCount}</div></div>
    </div>

    <div class="full-width-card">
      <div class="card-header">
        <span><i class="fas fa-rocket"></i> Dự án đang tiến hành</span>
        <a href="${pageContext.request.contextPath}/admin/projects">Xem tất cả <i class="fas fa-arrow-right"></i></a>
      </div>
      <table>
        <thead>
        <tr><th>Tên dự án</th><th>Người phụ trách</th><th>Trạng thái</th><th>Thao tác</th></tr>
        </thead>
        <tbody>
        <c:choose>
          <c:when test="${empty activeProjects}">
            <tr><td colspan="4" style="text-align: center;">Chưa có dự án nào</td></tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="proj" items="${activeProjects}">
              <form action="${pageContext.request.contextPath}/admin/update-project-status" method="post">
                <input type="hidden" name="projectId" value="${proj.id}">
                <tr>
                  <td>${proj.name}</td>
                  <td>
                    <c:set var="staffNames" value="${proj.participantNames}" />
                    <c:choose>
                      <c:when test="${empty staffNames or staffNames == 'Chưa có'}">
                        <span>Chưa có</span>
                      </c:when>
                      <c:otherwise>
                        <c:set var="staffArray" value="${fn:split(staffNames, ',')}" />
                        <button type="button" class="view-staff-btn" onclick="showStaffModal('${proj.name}', '${proj.participantNames}')">
                          Xem (${fn:length(staffArray)})
                        </button>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <select name="status">
                      <option value="pending" ${proj.status == 'pending' ? 'selected' : ''}>Chờ duyệt</option>
                      <option value="in_progress" ${proj.status == 'in_progress' ? 'selected' : ''}>Đang tiến hành</option>
                      <option value="completed" ${proj.status == 'completed' ? 'selected' : ''}>Hoàn thành</option>
                    </select>
                  </td>
                  <td><button type="submit">Lưu</button></td>
                </tr>
              </form>
            </c:forEach>
          </c:otherwise>
        </c:choose>
        </tbody>
      </table>
    </div>
  </main>
</div>

<!-- Modal -->
<div id="staffModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <span id="modalTitle">Danh sách người phụ trách</span>
      <span class="close-modal" onclick="closeModal()">&times;</span>
    </div>
    <ul id="staffList" class="staff-list"></ul>
  </div>
</div>

<script>
  function showStaffModal(projectName, staffNamesStr) {
    document.getElementById('modalTitle').innerHTML = 'Dự án: ' + projectName;
    var list = staffNamesStr.split(',');
    var html = '';
    for (var i = 0; i < list.length; i++) {
      html += '<li>' + list[i].trim() + '</li>';
    }
    document.getElementById('staffList').innerHTML = html;
    document.getElementById('staffModal').style.display = 'flex';
  }
  function closeModal() {
    document.getElementById('staffModal').style.display = 'none';
  }
  window.onclick = function(event) {
    var modal = document.getElementById('staffModal');
    if (event.target == modal) {
      modal.style.display = 'none';
    }
  }
</script>
</body>
</html>