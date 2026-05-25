package org.example.fluxhome.controller;

import org.example.fluxhome.dao.TaskDAO;
import org.example.fluxhome.dao.ProjectDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/employee/update-task")
public class EmployeeUpdateTaskServlet extends HttpServlet {
    private TaskDAO taskDAO = new TaskDAO();
    private ProjectDAO projectDAO = new ProjectDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int taskId = Integer.parseInt(req.getParameter("taskId"));
        String newStatus = req.getParameter("status");
        try {
            int projectId = taskDAO.getProjectIdByTaskId(taskId);
            if (projectId == -1) {
                resp.sendError(404, "Task not found");
                return;
            }
            taskDAO.updateTaskStatus(taskId, newStatus);
            projectDAO.updateProjectStatusBasedOnTasks(projectId);
            resp.sendRedirect(req.getContextPath() + "/employee/tasks");
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }
}