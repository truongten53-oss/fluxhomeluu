package org.example.fluxhome.controller.admin;

import org.example.fluxhome.dao.ProjectDAO;
import org.example.fluxhome.model.Project;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/projects")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024)
public class AdminProjectServlet extends HttpServlet {
    private ProjectDAO projectDAO = new ProjectDAO();
    private static final String UPLOAD_DIR = System.getenv().getOrDefault("UPLOAD_DIR", "/app/uploads");

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                projectDAO.deleteProject(id);
                resp.sendRedirect(req.getContextPath() + "/admin/projects");
                return;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        try {
            List<Project> projects = projectDAO.getAllProjects();
            req.setAttribute("projects", projects);
            req.getRequestDispatcher("/WEB-INF/views/admin/projects.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String location = req.getParameter("location");
        Part imagePart = req.getPart("image");
        String imageUrl = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            String unique = System.currentTimeMillis() + "_" + fileName;
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            File destination = new File(uploadDir, unique);
            imagePart.write(destination.getAbsolutePath());
            imageUrl = unique;
        }
        Project p = new Project();
        p.setName(name);
        p.setLocation(location);
        p.setImageUrl(imageUrl);
        try {
            projectDAO.addProject(p);
            resp.sendRedirect(req.getContextPath() + "/admin/projects");
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }
}