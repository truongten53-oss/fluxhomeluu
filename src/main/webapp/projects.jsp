<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Quản Lý Dự Án</title>
  <style>
    body { font-family: Arial; background: #f4f6f8; margin: 20px; }
    .container { display: flex; gap: 20px; }

    .form-box { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); width: 35%; height: fit-content; }
    .form-group { margin-bottom: 15px; }
    label { display: block; font-weight: bold; margin-bottom: 5px; }
    input[type="text"], input[type="file"] { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
    button { background: #0f172a; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; width: 100%; }

    .table-box { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); width: 65%; }
    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    th, td { padding: 12px; border-bottom: 1px solid #ddd; text-align: left; vertical-align: middle; }
    th { background: #0f172a; color: white; }
    .project-img { width: 80px; height: 60px; border-radius: 4px; object-fit: cover; border: 1px solid #ccc; }

    .toast-notification {
      visibility: hidden; min-width: 250px; color: #fff; text-align: center;
      border-radius: 8px; padding: 16px; position: fixed; z-index: 1001;
      right: 30px; bottom: 30px; font-size: 15px; box-shadow: 0px 4px 10px rgba(0,0,0,0.2);
      transform: translateX(120%); transition: transform 0.4s ease, visibility 0.4s; font-weight: bold;
    }
    .toast-notification.show { visibility: visible; transform: translateX(0); }
    .toast-success { background-color: #10b981; }
    .toast-error { background-color: #ef4444; }

    /* --- THÊM CSS KHUNG POPUP XÓA --- */
    .modal-overlay {
      display: none;
      position: fixed; top: 0; left: 0; width: 100%; height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      z-index: 1000;
      justify-content: center; align-items: center;
    }
    .modal-box {
      background-color: white; padding: 25px; border-radius: 10px;
      width: 380px; text-align: center; box-shadow: 0 5px 15px rgba(0,0,0,0.3);
      animation: fadeIn 0.3s ease;
    }
    @keyframes fadeIn { from { opacity: 0; transform: scale(0.9); } to { opacity: 1; transform: scale(1); } }
    .modal-box h3 { margin-top: 0; color: #1e293b; font-size: 20px; }
    .modal-box p { color: #475569; margin-bottom: 10px; line-height: 1.5; }
    .modal-warning { color: #ef4444; font-size: 13px; font-style: italic; margin-bottom: 25px; }
    .modal-buttons { display: flex; justify-content: space-around; }
    .btn-cancel { background: #e2e8f0; color: #475569; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; }
    .btn-cancel:hover { background: #cbd5e1; }
    .btn-confirm { background: #ef4444; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-weight: bold; }
    .btn-confirm:hover { background: #dc2626; }
  </style>
</head>
<body>
<div style="margin-bottom: 20px;">
  <a href="${pageContext.request.contextPath}/dashboard" style="text-decoration: none; color: #3b82f6;">← Quay lại Dashboard</a>
</div>

<h2>Quản Lý Dự Án Công Ty</h2>

<div class="container">
  <div class="form-box">
    <h3>Thêm Dự Án Mới</h3>
    <form action="${pageContext.request.contextPath}/manage-projects" method="POST" enctype="multipart/form-data">
      <div class="form-group">
        <label>Tên Dự Án (*):</label>
        <input type="text" name="name" required placeholder="VD: Nhà phố anh A...">
      </div>
      <div class="form-group">
        <label>Tỉnh/Thành phố:</label>
        <input type="text" name="location" placeholder="VD: Hà Nội">
      </div>
      <div class="form-group">
        <label>Tải Ảnh Lên (từ máy tính):</label>
        <input type="file" name="imageFile" accept="image/*">
      </div>
      <button type="submit">+ Thêm Dự Án</button>
    </form>
  </div>

  <div class="table-box">
    <h3>Danh Sách Dự Án</h3>
    <table>
      <thead>
      <tr>
        <th>STT</th>
        <th>Ảnh minh họa</th>
        <th>Tên Dự Án</th>
        <th>Địa điểm</th>
        <th>Người Tham Gia</th>
        <th>Thao Tác</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="p" items="${projectList}" varStatus="loop">
        <tr>
          <td>${loop.count}</td>
          <td>
            <c:choose>
              <c:when test="${empty p.imageUrl}">
                <img src="https://via.placeholder.com/150?text=Chưa+có+ảnh" class="project-img">
              </c:when>
              <c:when test="${p.imageUrl.startsWith('http')}">
                <img src="${p.imageUrl}" class="project-img" onerror="this.onerror=null; this.src='https://via.placeholder.com/150?text=Lỗi+Ảnh';">
              </c:when>
              <c:otherwise>
                <img src="${pageContext.request.contextPath}/images/${p.imageUrl}" class="project-img" onerror="this.onerror=null; this.src='https://via.placeholder.com/150?text=Lỗi+Ảnh';">
              </c:otherwise>
            </c:choose>
          </td>
          <td><strong>${p.name}</strong></td>
          <td>${not empty p.location ? p.location : 'Chưa cập nhật'}</td>

          <td>
            <c:choose>
              <c:when test="${not empty p.participantNames}">
                <span style="color: #4b5563; line-height: 1.5;">${p.participantNames}</span>
              </c:when>
              <c:otherwise>
                <em style="color: #9ca3af;">Chưa có ai</em>
              </c:otherwise>
            </c:choose>
          </td>

          <td>
              <%-- ĐÃ SỬA: Đổi nút xóa thành gọi hàm showModal --%>
            <a href="javascript:void(0);"
               onclick="showModal('${pageContext.request.contextPath}/manage-projects?action=delete&id=${p.id}', '${p.name}')"
               style="background-color: #ef4444; color: white; padding: 6px 12px; text-decoration: none; border-radius: 4px; font-size: 13px; display: inline-block; white-space: nowrap;">
              🗑️ Xóa
            </a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<%-- THÊM HTML: KHUNG POPUP XÓA --%>
<div id="customModal" class="modal-overlay">
  <div class="modal-box">
    <h3>Xác nhận xóa dự án</h3>
    <p>Bạn có chắc chắn muốn xóa dự án <br> <strong id="modalProjectName" style="color: #ef4444; font-size: 18px;"></strong> không?</p>
    <div class="modal-warning">(Lưu ý: Xóa dự án sẽ xóa luôn toàn bộ công việc bên trong)</div>
    <div class="modal-buttons">
      <button class="btn-cancel" onclick="hideModal()">Không Xóa</button>
      <a id="modalConfirmBtn" href="#" class="btn-confirm">Có, Xóa</a>
    </div>
  </div>
</div>

<c:if test="${not empty sessionScope.toastMsg}">
  <div id="toast" class="toast-notification toast-${sessionScope.toastType}">
      ${sessionScope.toastMsg}
  </div>
  <c:remove var="toastMsg" scope="session" />
  <c:remove var="toastType" scope="session" />
  <script>
    window.addEventListener('load', function() {
      var toast = document.getElementById("toast");
      toast.className += " show";
      setTimeout(function(){ toast.className = toast.className.replace(" show", ""); }, 3500);
    });
  </script>
</c:if>

<%-- THÊM SCRIPT ĐIỀU KHIỂN POPUP --%>
<script>
  function showModal(deleteUrl, projectName) {
    document.getElementById("modalProjectName").innerText = "[ " + projectName + " ]";
    document.getElementById("modalConfirmBtn").href = deleteUrl;
    document.getElementById("customModal").style.display = "flex";
  }

  function hideModal() {
    document.getElementById("customModal").style.display = "none";
  }
</script>

</body>
</html>