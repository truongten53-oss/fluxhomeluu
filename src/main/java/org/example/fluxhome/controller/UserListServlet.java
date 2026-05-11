package org.example.fluxhome.controller;

import org.example.fluxhome.dao.UserDAO;
import org.example.fluxhome.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserListServlet", value = "/manage-users")
public class UserListServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }


        String action = request.getParameter("action");
        if ("deleteUser".equals(action)) {
            String idParam = request.getParameter("id");
            if (idParam != null) {
                try {
                    int id = Integer.parseInt(idParam);
                    userDAO.deleteUser(id); // Gọi hàm xóa
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }

            response.sendRedirect(request.getContextPath() + "/manage-users");
            return;
        }


        List<User> userList = userDAO.getAllUsers();
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/user-list.jsp").forward(request, response);
    }
}