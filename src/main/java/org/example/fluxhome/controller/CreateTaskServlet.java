package org.example.fluxhome.controller;

import org.example.fluxhome.dao.TaskDAO;
import org.example.fluxhome.dao.UserDAO;
import org.example.fluxhome.dao.ProjectDAO;
import org.example.fluxhome.model.Task;
import org.example.fluxhome.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CreateTaskServlet", value = "/create-task")
public class CreateTaskServlet extends HttpServlet {

    private TaskDAO taskDAO = new TaskDAO();
    private UserDAO userDAO = new UserDAO();
    private ProjectDAO projectDAO = new ProjectDAO(); // Thêm ProjectDAO

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 1. Lấy danh sách toàn bộ nhân viên kèm số lượng việc đang làm
        Map<User, Integer> workloads = userDAO.getEmployeeWorkloads();

        // Gửi TOÀN BỘ danh sách sang form, không cần vòng lặp lọc "người rảnh" nữa
        request.setAttribute("employeeWorkloads", workloads);

        // 2. Lấy danh sách dự án
        request.setAttribute("projectList", projectDAO.getAllProjects());

        // 3. Mở form (Đảm bảo tên file .jsp đúng với tên file của bạn)
        request.getRequestDispatcher("/create-task.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Thiết lập Tiếng Việt
        request.setCharacterEncoding("UTF-8");

        Task newTask = new Task();

        // --- ĐÃ SỬA: Dùng projectId (chuyển sang số) thay vì projectName ---
        String projectIdStr = request.getParameter("projectId");
        if (projectIdStr != null && !projectIdStr.isEmpty()) {
            newTask.setProjectId(Integer.parseInt(projectIdStr));
        }

        newTask.setTitle(request.getParameter("title"));

        // Đảm bảo status mặc định là pending nếu form không gửi lên
        String status = request.getParameter("status");
        newTask.setStatus((status != null && !status.isEmpty()) ? status : "pending");

        String assigneeIdStr = request.getParameter("assigneeId");
        if (assigneeIdStr != null && !assigneeIdStr.isEmpty()) {
            newTask.setAssigneeId(Integer.parseInt(assigneeIdStr));
        }

        newTask.setNotes(request.getParameter("notes"));

        // Lưu vào database
        taskDAO.addTask(newTask);

        // Quay về trang chủ
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
}