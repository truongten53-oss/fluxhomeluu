package org.example.fluxhome.controller.admin;

import org.example.fluxhome.dao.TaskDAO;
import org.example.fluxhome.dao.ProjectDAO;
import org.example.fluxhome.dao.UserDAO;
import org.example.fluxhome.model.Task;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/tasks")
public class AdminTaskServlet extends HttpServlet {
    private TaskDAO taskDAO = new TaskDAO();
    private ProjectDAO projectDAO = new ProjectDAO();
    private UserDAO userDAO = new UserDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                taskDAO.deleteTask(id);
                resp.sendRedirect(req.getContextPath() + "/admin/tasks");
                return;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        try {
            List<Task> tasks = taskDAO.getAllTasks();
            req.setAttribute("tasks", tasks);
            req.setAttribute("projects", projectDAO.getAllProjects());
            req.setAttribute("users", userDAO.getAllUsers());
            req.getRequestDispatcher("/WEB-INF/views/admin/tasks.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String projectIdStr = req.getParameter("projectId");
        String title = req.getParameter("title");
        String assigneeIdStr = req.getParameter("assigneeId");
        String notes = req.getParameter("notes");
        if (projectIdStr == null || title == null || title.trim().isEmpty()) {
            // lỗi
            resp.sendRedirect(req.getContextPath() + "/admin/tasks");
            return;
        }
        Task task = new Task();
        task.setProjectId(Integer.parseInt(projectIdStr));
        task.setTitle(title);
        if (assigneeIdStr != null && !assigneeIdStr.isEmpty())
            task.setAssigneeId(Integer.parseInt(assigneeIdStr));
        task.setNotes(notes);
        try {
            taskDAO.addTask(task);
            resp.sendRedirect(req.getContextPath() + "/admin/tasks");
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }
}