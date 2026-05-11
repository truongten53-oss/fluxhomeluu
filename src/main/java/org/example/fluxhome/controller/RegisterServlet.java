package org.example.fluxhome.controller;

import jakarta.servlet.annotation.MultipartConfig;
import org.example.fluxhome.dao.UserDAO;
import org.example.fluxhome.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet(name = "RegisterServlet", value = "/register")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser != null && "admin".equals(loggedInUser.getRole())) {
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");

        if (userDAO.isUsernameExists(username)) {
            request.setAttribute("errorMessage", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }


        Part filePart = request.getPart("avatar");


        String avatarUrl = "https://cdn-icons-png.flaticon.com/512/149/149071.png";

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;


            String uploadPath = "D:\\fluxhome_images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();


            filePart.write(uploadPath + File.separator + uniqueFileName);


            avatarUrl = uniqueFileName;
        }


        User user = new User();
        user.setFullName(request.getParameter("fullName"));
        user.setUsername(username);
        user.setPassword(request.getParameter("password"));
        user.setRole(request.getParameter("role"));
        user.setAvatar(avatarUrl);

        if (userDAO.register(user)) {
            response.sendRedirect(request.getContextPath() + "/manage-users");
        } else {
            request.setAttribute("errorMessage", "Lỗi khi lưu dữ liệu!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}