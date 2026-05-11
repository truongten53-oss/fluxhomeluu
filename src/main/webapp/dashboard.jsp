<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>InTech - Bảng Công Việc</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f4f6f8; margin: 20px; color: #333; }
        .header { display: flex; justify-content: space-between; align-items: center; background: #fff; padding: 15px 25px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); margin-bottom: 25px; }
        .btn-group { display: flex; gap: 10px; align-items: center; margin-bottom: 15px; justify-content: space-between; }
        table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background-color: #0f172a; color: white; font-weight: 600; text-transform: uppercase; font-size: 13px; }
        tr:hover { background-color: #f9fafb; }

        .badge { padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: bold; display: inline-block; }
        .status-completed { background: #dcfce7; color: #166534; }
        .status-progress { background: #dbeafe; color: #1e40af; }
        .status-pending { background: #fef3c7; color: #92400e; }

        .btn-delete { color: #ef4444; text-decoration: none; font-size: 13px; margin-left: 10px; border: 1px solid #ef4444; padding: 2px 8px; border-radius: 4px; }
        .btn-delete:hover { background: #ef4444; color: white; }
    </style>
</head>
<body>

<div class="header">
    <h2>👋 Xin chào, ${sessionScope.user.fullName}</h2>
    <div style="text-align: right;">
        <span style="display: block; font-size: 12px; color: #666;">Chức vụ: <strong>${sessionScope.user.role}</strong></span>
        <a href="${pageContext.request.contextPath}/logout" style="color: #ef4444; text-decoration: none; font-weight: bold; font-size: 14px;">Đăng xuất</a>
    </div>
</div>

<div class="btn-group">
    <h3 style="margin: 0;">📋 Danh sách công việc dự án</h3>

    <c:if test="${sessionScope.user.role == 'admin'}">
        <div>
            <a href="${pageContext.request.contextPath}/manage-users" style="background: #6366f1; color: white; padding: 10px 15px; text-decoration: none; border-radius: 6px; font-size: 14px;">👥 Quản Lý Nhân Sự</a>
            <a href="${pageContext.request.contextPath}/register" style="background: #3b82f6; color: white; padding: 10px 15px; text-decoration: none; border-radius: 6px; font-size: 14px;">+ Tạo Tài Khoản</a>
            <a href="${pageContext.request.contextPath}/create-task" style="background: #22c55e; color: white; padding: 10px 15px; text-decoration: none; border-radius: 6px; font-size: 14px;">+ Giao Việc Mới</a>
            <a href="${pageContext.request.contextPath}/manage-projects" style="background: #eab308; color: white; padding: 10px 15px; border-radius: 4px; text-decoration: none; font-weight: bold; margin-right: 5px;">
                📂 Quản Lý Dự Án
            </a>
        </div>
    </c:if>
</div>

<c:if test="${sessionScope.user.role == 'admin'}">
    <div style="background: white; padding: 15px; border-radius: 8px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
        <h4 style="margin-top: 0; color: #1e293b;">📊 Trạng thái nhân sự</h4>
        <div style="display: flex; gap: 15px; flex-wrap: wrap;">
            <c:forEach var="entry" items="${employeeStatus}">
                <div style="padding: 10px 15px; border-radius: 6px; border: 1px solid #e2e8f0;
                        background-color: ${entry.value == 0 ? '#ecfdf5' : '#fef2f2'};
                        color: ${entry.value == 0 ? '#059669' : '#dc2626'}; font-size: 14px; font-weight: 500;">
                    👤 ${entry.key.fullName} -
                    <c:choose>
                        <c:when test="${entry.value == 0}">Đang rảnh</c:when>
                        <c:otherwise>Đang bận (${entry.value} việc)</c:otherwise>
                    </c:choose>
                </div>
            </c:forEach>
        </div>
    </div>
</c:if>

<div style="margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; background: #f8fafc; padding: 15px; border-radius: 8px; border: 1px solid #e2e8f0;">
    <form action="dashboard" method="GET" style="display: flex; gap: 15px; width: 100%;">

        <div style="flex: 1; position: relative;">
            <input list="projects-list" type="text" name="search" id="searchInput"
                   placeholder="🔍 Nhập hoặc chọn tên dự án..." value="${param.search}" autocomplete="off"
                   class="form-control" style="width: 100%; padding: 10px 15px; border: 1px solid #e2e8f0; border-radius: 8px; box-sizing: border-box;">

            <datalist id="projects-list">
                <c:choose>
                    <c:when test="${sessionScope.user.role == 'admin'}">
                        <c:forEach var="p" items="${projectList}">
                            <option value="${p.name}"></option>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <%-- Nhân viên: Gọi danh sách dự án đầy đủ từ Java --%>
                        <c:forEach var="pName" items="${myProjectNames}">
                            <option value="${pName}"></option>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </datalist>
        </div>

        <select name="filterStatus" class="form-control" style="padding: 10px 15px; border: 1px solid #e2e8f0; border-radius: 8px; width: 200px;">
            <option value="">-- Tất cả trạng thái --</option>
            <option value="pending" ${param.filterStatus == 'pending' ? 'selected' : ''}>Đang chờ</option>
            <option value="in_progress" ${param.filterStatus == 'in_progress' ? 'selected' : ''}>Đang làm</option>
            <option value="completed" ${param.filterStatus == 'completed' ? 'selected' : ''}>Hoàn thành</option>
        </select>

        <%-- ĐÃ XÓA SỰ KIỆN onclick báo lỗi --%>
        <button type="submit" class="btn-filter"
                style="background: #0f172a; color: white; border: none; padding: 10px 25px; border-radius: 8px; font-weight: 600; cursor: pointer;">
            Lọc Dữ Liệu
        </button>
        <a href="dashboard" class="btn-clear"
           style="background: #f1f5f9; color: #475569; text-decoration: none; padding: 10px 20px; border-radius: 8px; font-weight: 600; display: flex; align-items: center;">
            Xóa lọc
        </a>
    </form>
</div>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Dự Án</th>
        <th>Nội Dung Công Việc</th>
        <th>Người Phụ Trách</th>
        <th>Trạng Thái</th>
        <th>Thao Tác</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="t" items="${tasks}">
        <tr>
            <td style="color: #999;">#${t.id}</td>
            <td style="font-weight: bold;">${t.projectName}</td>
            <td>${t.title}</td>
            <td><span style="color: #4b5563;">👤 ${t.assigneeName}</span></td>
            <td>
                <c:choose>
                    <c:when test="${t.status == 'completed'}">
                        <span class="badge status-completed">✅ Hoàn thành</span>
                    </c:when>
                    <c:when test="${t.status == 'in_progress'}">
                        <span class="badge status-progress">🔵 Đang làm</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge status-pending">🕒 Đang chờ</span>
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <div style="display: flex; align-items: center;">
                        <%-- Form cập nhật trạng thái --%>
                    <form action="${pageContext.request.contextPath}/update-task" method="POST" style="display: flex; gap: 5px; margin: 0;">
                        <input type="hidden" name="taskId" value="${t.id}">
                        <select name="status" style="padding: 4px; border-radius: 4px; border: 1px solid #ccc; outline: none;">
                            <option value="pending" ${t.status == 'pending' ? 'selected' : ''}>Chờ</option>
                            <option value="in_progress" ${t.status == 'in_progress' ? 'selected' : ''}>Làm</option>
                            <option value="completed" ${t.status == 'completed' ? 'selected' : ''}>Xong</option>
                        </select>
                        <button type="submit" style="background: #0f172a; color: white; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer; font-size: 12px;">Lưu</button>
                    </form>

                        <%-- Nút Xóa công việc: Chỉ Admin mới thấy --%>
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <a href="${pageContext.request.contextPath}/dashboard?action=deleteTask&id=${t.id}"
                           class="btn-delete"
                           onclick="return confirm('Bạn có chắc chắn muốn xóa công việc này không?')">Xóa</a>
                    </c:if>
                </div>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>