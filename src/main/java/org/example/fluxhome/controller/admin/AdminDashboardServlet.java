package org.example.fluxhome.controller.admin;

import org.example.fluxhome.dao.ProjectDAO;
import org.example.fluxhome.dao.UserDAO;
import org.example.fluxhome.model.Project;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private ProjectDAO projectDAO = new ProjectDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Lấy danh sách dự án kèm người phụ trách và status
            List<Project> activeProjects = projectDAO.getProjectsWithAssigneesAndStatus();

            int totalProjects = projectDAO.getAllProjects().size();
            int totalUsers = userDAO.getAllUsers().size();

            // Đếm số dự án theo trạng thái (tùy bạn có thể dùng thống kê khác)
            long inProgressCount = activeProjects.stream().filter(p -> "in_progress".equals(p.getStatus())).count();
            long pendingCount = activeProjects.stream().filter(p -> "pending".equals(p.getStatus())).count();

            req.setAttribute("totalProjects", totalProjects);
            req.setAttribute("totalUsers", totalUsers);
            req.setAttribute("inProgressProjectsCount", inProgressCount);
            req.setAttribute("pendingTasksCount", pendingCount);
            req.setAttribute("activeProjects", activeProjects);

            // Lời chào theo giờ
            int hour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
            String greeting = (hour < 12) ? "sáng" : (hour < 18) ? "chiều" : "tối";
            req.setAttribute("greeting", greeting);

            req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }
}