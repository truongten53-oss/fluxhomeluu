package org.example.fluxhome.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@WebServlet("/images/*")
public class ImageServlet extends HttpServlet {
    private static final String UPLOAD_DIR = System.getenv().getOrDefault("UPLOAD_DIR", "/app/uploads");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy tên file từ đường dẫn: /images/abc.jpg -> lấy "abc.jpg"
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        // Bỏ dấu '/' đầu tiên
        String fileName = pathInfo.substring(1);
        File file = new File(UPLOAD_DIR, fileName);
        if (!file.exists() || !file.isFile()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        // Xác định MIME type dựa trên phần mở rộng (hoặc dùng Files.probeContentType)
        String mimeType = getServletContext().getMimeType(fileName);
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }
        resp.setContentType(mimeType);
        resp.setContentLengthLong(file.length());
        // Ghi nội dung file vào response
        Files.copy(file.toPath(), resp.getOutputStream());
    }
}