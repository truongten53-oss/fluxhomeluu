package org.example.fluxhome.controller;

import org.example.fluxhome.dao.UserDAO;
import org.example.fluxhome.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;

@WebServlet("/register")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private static final String UPLOAD_DIR = "D:\\fluxhome_uploads";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullName = req.getParameter("full_name");
        String role = req.getParameter("role");

        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                fullName == null || fullName.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            return;
        }

        Part filePart = req.getPart("avatar");
        String avatarFileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            String original = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String ext = "";
            int dot = original.lastIndexOf(".");
            if (dot > 0) ext = original.substring(dot);
            avatarFileName = System.currentTimeMillis() + "_avatar_" + username + ext;
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            filePart.write(UPLOAD_DIR + File.separator + avatarFileName);
        }

        try {
            if (userDAO.isUsernameExists(username)) {
                req.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
                return;
            }
            User newUser = new User();
            newUser.setUserName(username);
            newUser.setPasswordHash(password);
            newUser.setFullName(fullName);
            newUser.setRole(role != null ? role : "employee");
            newUser.setAvatar(avatarFileName);
            boolean success = userDAO.register(newUser);
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/login");
            } else {
                req.setAttribute("error", "Đăng ký thất bại!");
                req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi hệ thống!");
            req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
        }
    }
}