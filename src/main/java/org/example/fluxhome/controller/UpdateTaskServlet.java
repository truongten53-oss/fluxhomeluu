package org.example.fluxhome.controller;

import org.example.fluxhome.dao.TaskDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdateTaskServlet", value = "/update-task")
public class UpdateTaskServlet extends HttpServlet {
    private TaskDAO taskDAO = new TaskDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        int taskId = Integer.parseInt(request.getParameter("taskId"));
        String newStatus = request.getParameter("status");


        taskDAO.updateTaskStatus(taskId, newStatus);


        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
}
