package org.example.fluxhome.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@WebServlet(name = "ImageServlet", value = "/images/*")
public class ImageServlet extends HttpServlet {


    private final String IMAGE_DIR = "D:\\fluxhome_images\\";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String filename = request.getPathInfo();

        if (filename == null || filename.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }


        File file = new File(IMAGE_DIR, filename.substring(1));

        if (file.exists()) {
            response.setContentType(getServletContext().getMimeType(file.getName()));
            Files.copy(file.toPath(), response.getOutputStream());
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}