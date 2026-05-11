package org.example.fluxhome.controller;

import jakarta.servlet.annotation.MultipartConfig;
import org.example.fluxhome.dao.ProjectDAO;
import org.example.fluxhome.model.Project;
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
import java.util.List;

@WebServlet(name = "ProjectServlet", value = "/manage-projects")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class ProjectServlet extends HttpServlet {
    private ProjectDAO projectDAO = new ProjectDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            try {
                int projectId = Integer.parseInt(request.getParameter("id"));
                projectDAO.deleteProject(projectId);


                response.sendRedirect(request.getContextPath() + "/manage-projects");
                return;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }


        List<Project> projectList = projectDAO.getAllProjects();
        request.setAttribute("projectList", projectList);
        request.getRequestDispatcher("/projects.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String location = request.getParameter("location");


        Part filePart = request.getPart("imageFile");
        String imageUrl = "";

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uniqueFileName = System.currentTimeMillis() + "_project_" + fileName;


            String uploadPath = "D:\\fluxhome_images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();


            filePart.write(uploadPath + File.separator + uniqueFileName);


            imageUrl = uniqueFileName;
        }


        Project p = new Project();
        p.setName(name);
        p.setImageUrl(imageUrl);
        p.setLocation(location);

        boolean isAdded = projectDAO.addProject(p);

        HttpSession session = request.getSession();
        if (isAdded) {
            session.setAttribute("toastMsg", "Đã thêm dự án mới thành công!");
            session.setAttribute("toastType", "success");
        } else {
            session.setAttribute("toastMsg", "Thêm dự án thất bại!");
            session.setAttribute("toastType", "error");
        }

        response.sendRedirect(request.getContextPath() + "/manage-projects");
    }
}