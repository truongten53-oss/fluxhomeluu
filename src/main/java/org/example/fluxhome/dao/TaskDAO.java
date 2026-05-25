package org.example.fluxhome.dao;

import org.example.fluxhome.model.Task;
import org.example.fluxhome.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    public boolean addTask(Task task) throws SQLException {
        String sql = "INSERT INTO tasks (project_id, title, status, assignee_id, notes) VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, task.getProjectId());
            ps.setString(2, task.getTitle());
            ps.setString(3, task.getStatus());
            if (task.getAssigneeId() > 0) ps.setInt(4, task.getAssigneeId());
            else ps.setNull(4, Types.INTEGER);
            ps.setString(5, task.getNotes());
            return ps.executeUpdate() > 0;
        }
    }

    public List<Task> getTasksByUserId(int userId) throws SQLException {
        List<Task> list = new ArrayList<>();
        String sql = "SELECT t.*, p.name AS project_name, u.full_name AS assignee_name " +
                "FROM tasks t " +
                "LEFT JOIN projects p ON t.project_id = p.id " +
                "LEFT JOIN users u ON t.assignee_id = u.id " +
                "WHERE t.assignee_id = ? ORDER BY t.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Task t = new Task();
                t.setId(rs.getInt("id"));
                t.setProjectId(rs.getInt("project_id"));
                t.setTitle(rs.getString("title"));
                t.setStatus(rs.getString("status"));
                t.setAssigneeId(rs.getInt("assignee_id"));
                t.setNotes(rs.getString("notes"));
                t.setCreatedAt(rs.getTimestamp("created_at"));
                t.setProjectName(rs.getString("project_name"));
                t.setAssigneeName(rs.getString("assignee_name"));
                list.add(t);
            }
        }
        return list;
    }

    public List<Task> getAllTasks() throws SQLException {
        List<Task> list = new ArrayList<>();
        String sql = "SELECT t.*, p.name AS project_name, u.full_name AS assignee_name " +
                "FROM tasks t " +
                "LEFT JOIN projects p ON t.project_id = p.id " +
                "LEFT JOIN users u ON t.assignee_id = u.id " +
                "ORDER BY t.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Task t = new Task();
                t.setId(rs.getInt("id"));
                t.setProjectId(rs.getInt("project_id"));
                t.setTitle(rs.getString("title"));
                t.setStatus(rs.getString("status"));
                t.setAssigneeId(rs.getInt("assignee_id"));
                t.setNotes(rs.getString("notes"));
                t.setCreatedAt(rs.getTimestamp("created_at"));
                t.setProjectName(rs.getString("project_name"));
                t.setAssigneeName(rs.getString("assignee_name"));
                list.add(t);
            }
        }
        return list;
    }

    public boolean updateTaskStatus(int taskId, String status) throws SQLException {
        String sql = "UPDATE tasks SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, taskId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteTask(int taskId) throws SQLException {
        String sql = "DELETE FROM tasks WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, taskId);
            return ps.executeUpdate() > 0;
        }
    }


    // Trong TaskDAO.java
    public int getProjectIdByTaskId(int taskId) throws SQLException {
        String sql = "SELECT project_id FROM tasks WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, taskId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("project_id");
            }
            return -1;
        }
    }


}