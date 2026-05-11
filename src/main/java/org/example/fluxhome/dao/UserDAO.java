package org.example.fluxhome.dao;

import org.example.fluxhome.model.User;
import org.example.fluxhome.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

public class UserDAO {

    // Hàm kiểm tra Đăng nhập
    public User checkLogin(String username, String password) {
        User user = null;
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));

                // ĐÃ THÊM: Lấy đường dẫn ảnh khi đăng nhập để hiển thị trên Header/Dashboard
                user.setAvatar(rs.getString("avatar"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    //check tên đăng nhập khi tạo TK
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    // Lấy danh sách tất cả người dùng
    public java.util.List<User> getAllUsers() {
        java.util.List<User> list = new java.util.ArrayList<>();
        String sql = "SELECT * FROM users";

        try (java.sql.Connection conn = DBConnection.getConnection();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql);
             java.sql.ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setUsername(rs.getString("username"));
                user.setRole(rs.getString("role"));
                user.setAvatar(rs.getString("avatar")); // Đã có sẵn

                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean register(User user) {
        String sql = "INSERT INTO users (full_name, username, password, role, avatar) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());
            ps.setString(5, user.getAvatar());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ĐÃ SỬA: Đổi thành boolean và xử lý lỗi Khóa Ngoại (Foreign Key)
    public boolean deleteUser(int userId) {
        boolean isDeleted = false;

        // 1. Cập nhật các task của user này thành chưa ai làm (NULL) để không bị lỗi DB
        String updateTasksSql = "UPDATE tasks SET assignee_id = NULL WHERE assignee_id = ?";
        // 2. Lệnh xóa user
        String deleteUserSql = "DELETE FROM users WHERE id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            // Gỡ task trước
            try (PreparedStatement psUpdate = conn.prepareStatement(updateTasksSql)) {
                psUpdate.setInt(1, userId);
                psUpdate.executeUpdate();
            }

            // Xóa user sau
            try (PreparedStatement psDelete = conn.prepareStatement(deleteUserSql)) {
                psDelete.setInt(1, userId);
                isDeleted = psDelete.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isDeleted;
    }

    // Trả về danh sách User và Số lượng công việc họ đang làm (chưa hoàn thành)
    // Trả về danh sách User và Số lượng công việc họ đang làm (chưa hoàn thành)
    public Map<User, Integer> getEmployeeWorkloads() {
        Map<User, Integer> map = new java.util.LinkedHashMap<>();

        // 1. ĐÃ SỬA: Thêm "u.role" vào phần SELECT và GROUP BY của câu lệnh SQL
        String sql = "SELECT u.id, u.full_name, u.role, COUNT(t.id) as active_tasks " +
                "FROM users u " +
                "LEFT JOIN tasks t ON u.id = t.assignee_id AND (t.status != 'completed' AND t.status != 'Hoàn thành') " +
                "WHERE u.role != 'admin' " +
                "GROUP BY u.id, u.full_name, u.role";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setFullName(rs.getString("full_name"));

                // 2. ĐÃ THÊM: Bắt buộc phải có dòng này để lấy chức vụ gán vào User
                u.setRole(rs.getString("role"));

                int activeTasks = rs.getInt("active_tasks");
                map.put(u, activeTasks);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }


}