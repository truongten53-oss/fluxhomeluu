package org.example.fluxhome.controller;

import org.example.fluxhome.dao.TaskDAO;
import org.example.fluxhome.dao.TaskUpdateDAO;
import org.example.fluxhome.model.TaskUpdate;
import org.example.fluxhome.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;

@WebServlet("/employee/update-task")
public class EmployeeUpdateTaskServlet extends HttpServlet {
    private TaskDAO taskDAO = new TaskDAO();
    private TaskUpdateDAO taskUpdateDAO = new TaskUpdateDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int taskId = Integer.parseInt(req.getParameter("taskId"));
        String newStatus = req.getParameter("status");
        String note = req.getParameter("note");
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        try {
            // 1. Cập nhật trạng thái task
            taskDAO.updateTaskStatus(taskId, newStatus);

            // 2. Lưu ghi chú vào bảng task_updates (nếu có)
            if (note != null && !note.trim().isEmpty()) {
                TaskUpdate update = new TaskUpdate();
                update.setTaskId(taskId);
                update.setUserId(user.getId());
                update.setUpdateDate(new Timestamp(System.currentTimeMillis()));
                update.setNote(note);
                taskUpdateDAO.addTaskUpdate(update);
            }

            // 3. Quay lại danh sách task
            resp.sendRedirect(req.getContextPath() + "/tasks");
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi cập nhật task");
        }
    }
}