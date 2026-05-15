<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>FluxHome | Quản lý công việc</title>
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
        .page-header h1 { font-size: 28px; font-weight: 600; }
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
            margin-bottom: 30px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            border: 1px solid #e2e8f0;
        }
        .card h3 { margin-bottom: 20px; font-weight: 600; font-size: 18px; }
        .form-grid { display: flex; gap: 15px; flex-wrap: wrap; align-items: flex-end; }
        .form-group { flex: 1; min-width: 160px; }
        .form-group label { display: block; font-size: 12px; font-weight: 500; color: #64748b; margin-bottom: 5px; }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 12px;
            font-size: 14px;
        }
        button {
            background: #3b82f6;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 500;
        }
        table { width: 100%; border-collapse: collapse; }
        th, td { text-align: left; padding: 14px 12px; border-bottom: 1px solid #e2e8f0; }
        th { font-weight: 600; color: #475569; }
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
        .delete-btn {
            background: #ef4444;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            border: none;
            cursor: pointer;
            color: white;
        }
        .delete-btn:hover { background: #dc2626; }
        /* Modal styles */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        .modal-content {
            background: white;
            border-radius: 20px;
            padding: 25px;
            width: 400px;
            max-width: 90%;
            text-align: center;
            box-shadow: 0 20px 25px -12px rgba(0,0,0,0.2);
        }
        .modal-content h3 { font-size: 20px; margin-bottom: 15px; }
        .modal-content p { margin-bottom: 25px; color: #475569; }
        .modal-buttons { display: flex; justify-content: center; gap: 15px; }
        .btn-cancel {
            background: #e2e8f0;
            color: #1e293b;
            border: none;
            padding: 8px 20px;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 500;
        }
        .btn-confirm {
            background: #ef4444;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 500;
        }
        .btn-confirm:hover { background: #dc2626; }
        .btn-cancel:hover { background: #cbd5e1; }
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
            <li class="nav-item"><a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/admin/projects" class="nav-link"><i class="fas fa-folder-open"></i><span>Dự án đang chạy</span></a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/admin/tasks" class="nav-link active"><i class="fas fa-tasks"></i><span>Công việc</span></a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/admin/users" class="nav-link"><i class="fas fa-users"></i><span>Đội ngũ nhân sự</span></a></li>
        </ul>
    </aside>

    <main class="main-content">
        <div class="page-header">
            <h1>Quản lý công việc</h1>
            <div class="user-info">
                <i class="fas fa-bell"></i>
                <i class="fas fa-user-circle"></i>
                <form action="${pageContext.request.contextPath}/logout" method="get" style="display: inline;">
                    <button class="logout-btn"><i class="fas fa-sign-out-alt"></i> Đăng xuất</button>
                </form>
            </div>
        </div>

        <div class="card">
            <h3><i class="fas fa-plus-circle"></i> Giao việc mới</h3>
            <form action="${pageContext.request.contextPath}/admin/tasks" method="post">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Dự án</label>
                        <select name="projectId" required>
                            <option value="">-- Chọn dự án --</option>
                            <c:forEach var="proj" items="${projects}">
                                <option value="${proj.id}">${proj.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Tiêu đề</label>
                        <input type="text" name="title" placeholder="Tiêu đề công việc" required>
                    </div>
                    <div class="form-group">
                        <label>Giao cho</label>
                        <select name="assigneeId">
                            <option value="">-- Chọn người làm --</option>
                            <c:forEach var="u" items="${users}">
                                <option value="${u.id}">${u.fullName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Ghi chú</label>
                        <textarea name="notes" rows="1" placeholder="Ghi chú"></textarea>
                    </div>
                    <div class="form-group">
                        <button type="submit"><i class="fas fa-paper-plane"></i> Giao việc</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="card">
            <h3><i class="fas fa-list"></i> Danh sách công việc</h3>
            <table>
                <thead>
                <tr><th>ID</th><th>Dự án</th><th>Tiêu đề</th><th>Người làm</th><th>Trạng thái</th><th>Ghi chú</th><th>Thao tác</th></tr>
                </thead>
                <tbody>
                <c:forEach var="t" items="${tasks}">
                    <tr>
                        <td>${t.id}</td>
                        <td>${t.projectName}</td>
                        <td>${t.title}</td>
                        <td>${t.assigneeName != null ? t.assigneeName : 'Chưa giao'}</td>
                        <td>
                            <span class="status-badge
                                ${t.status == 'pending' ? 'status-pending' : (t.status == 'in_progress' ? 'status-inprogress' : 'status-completed')}">
                                    ${t.status == 'pending' ? 'Chờ' : (t.status == 'in_progress' ? 'Đang làm' : 'Hoàn Thành')}
                            </span>
                        </td>
                        <td>${t.notes != null ? t.notes : '—'}</td>
                        <td>
                            <button class="delete-btn" onclick="showDeleteModal(${t.id}, '${t.title}')">
                                <i class="fas fa-trash-alt"></i> Xóa
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</div>

<!-- Modal xác nhận xóa -->
<div id="deleteModal" class="modal-overlay">
    <div class="modal-content">
        <h3>Xác nhận xóa</h3>
        <p id="deleteModalMessage">Bạn có chắc chắn muốn xóa công việc này?</p>
        <div class="modal-buttons">
            <button class="btn-cancel" onclick="closeModal()">Hủy</button>
            <button class="btn-confirm" id="confirmDeleteBtn">Xóa</button>
        </div>
    </div>
</div>

<script>
    let taskIdToDelete = null;

    function showDeleteModal(taskId, taskTitle) {
        taskIdToDelete = taskId;
        document.getElementById('deleteModalMessage').innerHTML = 'Bạn có chắc chắn muốn xóa công việc <strong>' + taskTitle + '</strong>?';
        document.getElementById('deleteModal').style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('deleteModal').style.display = 'none';
        taskIdToDelete = null;
    }

    document.getElementById('confirmDeleteBtn').onclick = function() {
        if (taskIdToDelete) {
            window.location.href = '${pageContext.request.contextPath}/admin/tasks?action=delete&id=' + taskIdToDelete;
        }
    };

    window.onclick = function(event) {
        const modal = document.getElementById('deleteModal');
        if (event.target === modal) {
            closeModal();
        }
    }
</script>

</body>
</html>