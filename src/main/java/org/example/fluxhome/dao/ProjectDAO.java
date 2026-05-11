package org.example.fluxhome.dao;

import org.example.fluxhome.model.Project;
import org.example.fluxhome.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProjectDAO {


    public List<Project> getAllProjects() {
        List<Project> list = new ArrayList<>();

        String sql = "SELECT p.*, GROUP_CONCAT(DISTINCT u.full_name SEPARATOR ', ') as participants " +
                "FROM projects p " +
                "LEFT JOIN tasks t ON p.id = t.project_id " +
                "LEFT JOIN users u ON t.assignee_id = u.id " +
                "GROUP BY p.id " +
                "ORDER BY p.id DESC";

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


                p.setParticipantNames(rs.getString("participants"));

                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Thêm một dự án mới (GIỮ NGUYÊN của bạn)
    public boolean addProject(Project project) {
        String sql = "INSERT INTO projects (name, image_url, location) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, project.getName());
            ps.setString(2, project.getImageUrl());
            ps.setString(3, project.getLocation());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 3. Xóa dự án (MỚI THÊM)
    public boolean deleteProject(int projectId) {
        // Cần xóa công việc thuộc dự án này trước để không bị lỗi khóa ngoại
        String deleteTasksSql = "DELETE FROM tasks WHERE project_id = ?";
        String deleteProjectSql = "DELETE FROM projects WHERE id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            // Bước 1: Xóa tasks
            try (PreparedStatement psTask = conn.prepareStatement(deleteTasksSql)) {
                psTask.setInt(1, projectId);
                psTask.executeUpdate();
            }

            // Bước 2: Xóa project
            try (PreparedStatement psProject = conn.prepareStatement(deleteProjectSql)) {
                psProject.setInt(1, projectId);
                int rows = psProject.executeUpdate();
                return rows > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}