package org.example.fluxhome.controller.admin;

import org.example.fluxhome.dao.UserDAO;
import org.example.fluxhome.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            HttpSession session = req.getSession(false);
            User currentUser = (User) session.getAttribute("user");
            // Không cho xóa chính mình
            if (currentUser.getId() == id) {
                req.setAttribute("error", "Bạn không thể xóa tài khoản đang đăng nhập!");
                // vẫn hiển thị danh sách nhưng có thông báo lỗi
            } else {
                try {
                    userDAO.deleteUser(id);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            // redirect để reload lại danh sách
            resp.sendRedirect(req.getContextPath() + "/admin/users");
            return;
        }
        try {
            List<User> users = userDAO.getAllUsers();
            req.setAttribute("users", users);
            req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }
}