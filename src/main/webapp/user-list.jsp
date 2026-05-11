<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Nhân Viên</title>
    <style>
        body { font-family: Arial; background: #f4f6f8; margin: 20px; }
        table { width: 100%; border-collapse: collapse; background: white; margin-top: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        th, td { padding: 12px; border-bottom: 1px solid #ddd; text-align: left; vertical-align: middle; }
        th { background: #0f172a; color: white; }
        .btn-delete { color: #ef4444; text-decoration: none; font-weight: bold; cursor: pointer; }
        .nav { margin-bottom: 20px; }
        .avatar-img { width: 45px; height: 45px; border-radius: 50%; object-fit: cover; border: 1px solid #ccc; }

        /* --- CSS cho Khung Modal (Popup) --- */
        .modal-overlay {
            display: none;
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center; align-items: center;
        }
        .modal-box {
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            width: 350px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            animation: fadeIn 0.3s ease;
        }
        @keyframes fadeIn { from { opacity: 0; transform: scale(0.9); } to { opacity: 1; transform: scale(1); } }
        .modal-box h3 { margin-top: 0; color: #1e293b; font-size: 20px; }
        .modal-box p { color: #475569; margin-bottom: 25px; line-height: 1.5; }
        .modal-buttons { display: flex; justify-content: space-around; }
        .btn-cancel { background: #e2e8f0; color: #475569; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; }
        .btn-cancel:hover { background: #cbd5e1; }
        .btn-confirm { background: #ef4444; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-weight: bold; }
        .btn-confirm:hover { background: #dc2626; }
    </style>
</head>
<body>
<div class="nav">
    <a href="${pageContext.request.contextPath}/dashboard" style="text-decoration: none; color: #3b82f6;">← Quay lại Dashboard</a>
</div>
<h2>Danh sách nhân viên </h2>
<table>
    <thead>
    <tr>
        <th>STT</th>
        <th>Ảnh</th>
        <th>Họ Tên</th>
        <th>Tên đăng nhập</th>
        <th>Chức vụ</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="u" items="${not empty users ? users : userList}" varStatus="loop">
        <tr>
            <td>${loop.count}</td>
            <td>
                <c:choose>
                    <c:when test="${empty u.avatar}">
                        <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" class="avatar-img">
                    </c:when>
                    <c:when test="${u.avatar.startsWith('http')}">
                        <img src="${u.avatar}" class="avatar-img" onerror="this.onerror=null; this.src='https://cdn-icons-png.flaticon.com/512/149/149071.png';">
                    </c:when>
                    <c:otherwise>
                        <%-- ĐÃ SỬA CHỖ NÀY: Gọi qua /images/ để ImageServlet tải ảnh từ ổ D lên --%>
                        <img src="${pageContext.request.contextPath}/images/${u.avatar}" class="avatar-img" onerror="this.onerror=null; this.src='https://cdn-icons-png.flaticon.com/512/149/149071.png';">
                    </c:otherwise>
                </c:choose>
            </td>
            <td><strong>${u.fullName}</strong></td>
            <td>${u.username}</td>
            <td>
                <c:choose>
                    <c:when test="${u.role == 'admin'}">Giám đốc</c:when>
                    <c:when test="${u.role == 'designer'}">Thiết kế</c:when>
                    <c:when test="${u.role == 'sale'}">Sale</c:when>
                    <c:when test="${u.role == 'supervisor'}">Giám sát</c:when>
                    <c:when test="${u.role == 'marketing'}">Marketing</c:when>
                    <c:when test="${u.role == 'accountant'}">Kế toán</c:when>
                    <c:when test="${u.role == 'student'}">Thực tập sinh</c:when>
                    <c:otherwise>${u.role}</c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:if test="${u.role != 'admin'}">
                    <a href="javascript:void(0);"
                       class="btn-delete"
                       onclick="showModal('${pageContext.request.contextPath}/manage-users?action=deleteUser&id=${u.id}', '${u.fullName}')">Xóa</a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<div id="customModal" class="modal-overlay">
    <div class="modal-box">
        <h3>Xác nhận xóa</h3>
        <p>Bạn có chắc chắn muốn xóa nhân viên <br> <strong id="modalUserName" style="color: #ef4444; font-size: 18px;"></strong> không?</p>
        <div class="modal-buttons">
            <button class="btn-cancel" onclick="hideModal()">Hủy</button>
            <a id="modalConfirmBtn" href="#" class="btn-confirm">Có, Xóa</a>
        </div>
    </div>
</div>

<script>
    // Hàm mở modal: Truyền vào đường link xóa và tên nhân viên
    function showModal(deleteUrl, userName) {
        document.getElementById("modalUserName").innerText = "[ " + userName + " ]";
        document.getElementById("modalConfirmBtn").href = deleteUrl;
        document.getElementById("customModal").style.display = "flex";
    }

    // Hàm ẩn modal đi nếu bấm Hủy
    function hideModal() {
        document.getElementById("customModal").style.display = "none";
    }
</script>

</body>
</html>