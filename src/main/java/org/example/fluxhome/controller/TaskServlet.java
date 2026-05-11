package org.example.fluxhome.controller;

import org.example.fluxhome.dao.ProjectDAO;
import org.example.fluxhome.dao.TaskDAO;
import org.example.fluxhome.dao.UserDAO;
import org.example.fluxhome.model.Task;
import org.example.fluxhome.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "TaskServlet", value = "/dashboard")
public class TaskServlet extends HttpServlet {
    private TaskDAO taskDAO = new TaskDAO();
    private UserDAO userDAO = new UserDAO();
    private ProjectDAO projectDAO = new ProjectDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }


        String action = request.getParameter("action");
        if ("deleteTask".equals(action) && "admin".equals(loggedInUser.getRole())) {
            try {
                int taskId = Integer.parseInt(request.getParameter("id"));
                taskDAO.deleteTask(taskId);
                response.sendRedirect(request.getContextPath() + "/dashboard");
                return;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }


        String search = request.getParameter("search");
        String filterStatus = request.getParameter("filterStatus");

        if (search == null) search = "";
        if (filterStatus == null) filterStatus = "";

        List<Task> tasks = new ArrayList<>();

        if ("admin".equals(loggedInUser.getRole())) {

            tasks = taskDAO.searchTasks(search, filterStatus);


            Map<User, Integer> employeeStatus = userDAO.getEmployeeWorkloads();
            request.setAttribute("employeeStatus", employeeStatus);

        } else {

            List<Task> allMyTasks = taskDAO.getTasksByUserId(loggedInUser.getId());


            List<String> myProjectNames = allMyTasks.stream()
                    .map(Task::getProjectName)
                    .filter(name -> name != null && !name.trim().isEmpty())
                    .distinct()
                    .collect(Collectors.toList());
            request.setAttribute("myProjectNames", myProjectNames);


            tasks = allMyTasks;

            final String finalSearch = search.toLowerCase().trim();
            final String finalStatus = filterStatus;

            if (!finalSearch.isEmpty() || !finalStatus.isEmpty()) {
                tasks = tasks.stream()
                        .filter(t -> finalSearch.isEmpty() || (t.getProjectName() != null && t.getProjectName().toLowerCase().contains(finalSearch)))
                        .filter(t -> finalStatus.isEmpty() || finalStatus.equals(t.getStatus()))
                        .collect(Collectors.toList());
            }
        }

        request.setAttribute("projectList", projectDAO.getAllProjects());
        request.setAttribute("tasks", tasks);
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}