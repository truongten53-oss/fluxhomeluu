package org.example.fluxhome.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Thông tin kết nối MySQL của bạn (Thay đổi password nếu MySQL của bạn có mật khẩu)
    private static final String URL = "jdbc:mysql://localhost:3306/intech_design?useSSL=false&useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASSWORD = "04012004"; // <-- Điền mật khẩu MySQL của bạn vào đây nếu có

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Tải Driver của MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Mở kết nối
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    // Hàm main này chỉ dùng để TEST thử xem đã kết nối được chưa
    public static void main(String[] args) {
        Connection conn = getConnection();
        if (conn != null) {
            System.out.println("Tuyệt vời! Đã kết nối MySQL thành công!");
        } else {
            System.out.println("Lỗi rồi! Chưa kết nối được MySQL.");
        }
    }
}
