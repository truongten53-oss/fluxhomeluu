package org.example.fluxhome.dao;

import org.example.fluxhome.model.Project;
import org.example.fluxhome.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjectDAO {

    public List<Project> getAllProjects() throws SQLException {
        List<Project> list = new ArrayList<>();
        String sql = "SELECT * FROM projects ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Project p = new Project();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setImageUrl(rs.getString("image_url"));
                p.setLocation(rs.getString("location"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(p);
            }
        }
        return list;
    }

    public boolean addProject(Project p) throws SQLException {
        String sql = "INSERT INTO projects (name, image_url, location) VALUES (?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getImageUrl());
            ps.setString(3, p.getLocation());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteProject(int projectId) throws SQLException {
        String sql = "DELETE FROM projects WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            return ps.executeUpdate() > 0;
        }
    }

    public Project getProjectById(int id) throws SQLException {
        String sql = "SELECT * FROM projects WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Project p = new Project();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setImageUrl(rs.getString("image_url"));
                p.setLocation(rs.getString("location"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                return p;
            }
        }
        return null;
    }

    public List<Project> getProjectsWithAssigneesAndStatus() throws SQLException {
        List<Project> list = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.location, p.image_url, p.created_at, p.status, " +
                "GROUP_CONCAT(DISTINCT u.full_name SEPARATOR ', ') as assignee_names " +
                "FROM projects p " +
                "LEFT JOIN tasks t ON p.id = t.project_id " +
                "LEFT JOIN users u ON t.assignee_id = u.id " +
                "GROUP BY p.id " +
                "ORDER BY p.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Project proj = new Project();
                proj.setId(rs.getInt("id"));
                proj.setName(rs.getString("name"));
                proj.setLocation(rs.getString("location"));
                proj.setImageUrl(rs.getString("image_url"));
                proj.setCreatedAt(rs.getTimestamp("created_at"));
                proj.setStatus(rs.getString("status"));
                String assignees = rs.getString("assignee_names");
                proj.setParticipantNames(assignees != null ? assignees : "Chưa có");
                list.add(proj);
            }
        }
        return list;
    }

    public boolean updateProjectStatus(int projectId, String status) throws SQLException {
        String sql = "UPDATE projects SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, projectId);
            return ps.executeUpdate() > 0;
        }
    }

    // === SỬA LOGIC CHUẨN ===
    public void updateProjectStatusBasedOnTasks(int projectId) throws SQLException {
        String sql = "SELECT COUNT(*) as total, " +
                "SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) as completed_count, " +
                "SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) as pending_count " +
                "FROM tasks WHERE project_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int total = rs.getInt("total");
                int completed = rs.getInt("completed_count");
                int pending = rs.getInt("pending_count");
                String newStatus;
                if (total == 0 || pending == total) {
                    // Không có task hoặc tất cả đang pending -> dự án chờ duyệt
                    newStatus = "pending";
                } else if (completed == total) {
                    // Tất cả đã hoàn thành
                    newStatus = "completed";
                } else {
                    // Còn lại: có ít nhất 1 task in_progress hoặc hỗn hợp (pending + completed)
                    newStatus = "in_progress";
                }
                updateProjectStatus(projectId, newStatus);
            }
        }
    }
}