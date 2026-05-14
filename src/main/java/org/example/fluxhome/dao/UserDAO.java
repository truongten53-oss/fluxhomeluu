package org.example.fluxhome.dao;

import org.example.fluxhome.model.User;
import org.example.fluxhome.utils.DBConnection;
import org.example.fluxhome.utils.PasswordUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public boolean isUsernameExists(String username) throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE username=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    public boolean register(User user) throws SQLException {
        String sql = "INSERT INTO users (full_name, username, password_hash, role, avatar) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getUserName());
            String hashed = PasswordUtil.hashPassword(user.getPasswordHash());
            ps.setString(3, hashed);
            ps.setString(4, user.getRole());
            ps.setString(5, user.getAvatar());
            return ps.executeUpdate() > 0;
        }
    }

    public User checkLogin(String username, String plainPassword) throws SQLException {
        String sql = "SELECT id, full_name, username, role, avatar, password_hash FROM users WHERE username=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashed = rs.getString("password_hash");
                    if (PasswordUtil.checkPassword(plainPassword, hashed)) {
                        User u = new User();
                        u.setId(rs.getInt("id"));
                        u.setFullName(rs.getString("full_name"));
                        u.setUserName(rs.getString("username"));
                        u.setRole(rs.getString("role"));
                        u.setAvatar(rs.getString("avatar"));
                        return u;
                    }
                }
            }
        }
        return null;
    }

    public List<User> getAllUsers() throws SQLException {
        List<User> list = new ArrayList<>();
        String sql = "SELECT id, full_name, username, role, avatar FROM users";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setFullName(rs.getString("full_name"));
                u.setUserName(rs.getString("username"));
                u.setRole(rs.getString("role"));
                u.setAvatar(rs.getString("avatar"));
                list.add(u);
            }
        }
        return list;
    }

    public User getUserById(int id) throws SQLException {
        String sql = "SELECT id, full_name, username, role, avatar FROM users WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setFullName(rs.getString("full_name"));
                    u.setUserName(rs.getString("username"));
                    u.setRole(rs.getString("role"));
                    u.setAvatar(rs.getString("avatar"));
                    return u;
                }
            }
        }
        return null;
    }

    public boolean deleteUser(int userId) throws SQLException {
        String sql = "DELETE FROM users WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        }
    }
}