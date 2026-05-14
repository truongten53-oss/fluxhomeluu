<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><title>Công việc của tôi</title>
  <style> body { font-family: Arial; margin: 20px; } table { border-collapse: collapse; width: 100%; } th, td { border: 1px solid #ddd; padding: 8px; } </style>
</head>
<body>
<h1>Xin chào, ${sessionScope.user.fullName}</h1>
<h3>Công việc được giao</h3>
<table>
  <thead><tr><th>Dự án</th><th>Tiêu đề</th><th>Trạng thái</th><th>Ghi chú</th><th>Lịch sử</th><th>Cập nhật</th></tr></thead>
  <tbody>
  <c:forEach var="t" items="${tasks}">
    <tr>
      <td>${t.projectName}</td><td>${t.title}</td><td>${t.status}</td><td>${t.notes}</td>
      <td><a href="${pageContext.request.contextPath}/task-history?taskId=${t.id}">Lịch sử</a></td>
      <td>
        <form action="${pageContext.request.contextPath}/employee/update-task" method="post">
          <input type="hidden" name="taskId" value="${t.id}">
          <select name="status">
            <option value="pending" ${t.status=='pending'?'selected':''}>Chờ</option>
            <option value="in_progress" ${t.status=='in_progress'?'selected':''}>Đang làm</option>
            <option value="completed" ${t.status=='completed'?'selected':''}>Hoàn thành</option>
          </select>
          <textarea name="note" rows="2" cols="30" placeholder="Ghi chú cập nhật (nếu có)"></textarea>
          <button type="submit">Cập nhật</button>
        </form>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>
</body>
</html>