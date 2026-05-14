package org.example.fluxhome.dao;

import org.example.fluxhome.model.TaskUpdate;
import org.example.fluxhome.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskUpdateDAO {

    // Thêm một bản ghi cập nhật
    public boolean addTaskUpdate(TaskUpdate update) throws SQLException {
        String sql = "INSERT INTO task_updates (task_id, user_id, update_date, note) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, update.getTaskId());
            ps.setInt(2, update.getUserId());
            ps.setTimestamp(3, update.getUpdateDate());
            ps.setString(4, update.getNote());
            return ps.executeUpdate() > 0;
        }
    }

    // Lấy danh sách cập nhật theo task_id (kèm tên user và tên task)
    public List<TaskUpdate> getUpdatesByTaskId(int taskId) throws SQLException {
        List<TaskUpdate> list = new ArrayList<>();
        String sql = "SELECT tu.*, u.full_name as user_name, t.title as task_title " +
                "FROM task_updates tu " +
                "JOIN users u ON tu.user_id = u.id " +
                "JOIN tasks t ON tu.task_id = t.id " +
                "WHERE tu.task_id = ? ORDER BY tu.update_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, taskId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TaskUpdate tu = new TaskUpdate();
                tu.setId(rs.getInt("id"));
                tu.setTaskId(rs.getInt("task_id"));
                tu.setUserId(rs.getInt("user_id"));
                tu.setUpdateDate(rs.getTimestamp("update_date"));
                tu.setNote(rs.getString("note"));
                tu.setUserName(rs.getString("user_name"));
                tu.setTaskTitle(rs.getString("task_title"));
                list.add(tu);
            }
        }
        return list;
    }
}