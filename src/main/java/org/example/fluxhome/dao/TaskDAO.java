package org.example.fluxhome.dao;

import org.example.fluxhome.model.Task;
import org.example.fluxhome.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {


    public List<Task> getAllTasks() {
        List<Task> list = new ArrayList<>();


        String sql = "SELECT t.*, u.full_name AS assignee_name, p.name AS project_name " +
                "FROM tasks t " +
                "LEFT JOIN users u ON t.assignee_id = u.id " +
                "LEFT JOIN projects p ON t.project_id = p.id " +
                "ORDER BY t.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Task task = new Task();
                task.setId(rs.getInt("id"));


                task.setProjectId(rs.getInt("project_id"));
                task.setProjectName(rs.getString("project_name"));

                task.setTitle(rs.getString("title"));
                task.setStatus(rs.getString("status"));
                task.setAssigneeId(rs.getInt("assignee_id"));
                task.setNotes(rs.getString("notes"));
                task.setCreatedAt(rs.getTimestamp("created_at"));


                task.setAssigneeName(rs.getString("assignee_name"));

                list.add(task);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    public void addTask(Task task) {

        String sql = "INSERT INTO tasks (project_id, title, status, assignee_id, notes) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {


            ps.setInt(1, task.getProjectId());
            ps.setString(2, task.getTitle());
            ps.setString(3, task.getStatus());

            if (task.getAssigneeId() > 0) {
                ps.setInt(4, task.getAssigneeId());
            } else {
                ps.setNull(4, java.sql.Types.INTEGER);
            }

            ps.setString(5, task.getNotes());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public List<Task> getTasksByUserId(int userId) {
        List<Task> list = new ArrayList<>();

        String sql = "SELECT t.*, u.full_name AS assignee_name, p.name AS project_name " +
                "FROM tasks t " +
                "LEFT JOIN users u ON t.assignee_id = u.id " +
                "LEFT JOIN projects p ON t.project_id = p.id " +
                "WHERE t.assignee_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Task task = new Task();
                task.setId(rs.getInt("id"));
                task.setProjectId(rs.getInt("project_id"));
                task.setProjectName(rs.getString("project_name"));
                task.setTitle(rs.getString("title"));
                task.setStatus(rs.getString("status"));
                task.setAssigneeName(rs.getString("assignee_name"));
                list.add(task);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    public void updateTaskStatus(int taskId, String status) {
        String sql = "UPDATE tasks SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, taskId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void deleteTask(int id) {
        String sql = "DELETE FROM tasks WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public List<Task> searchTasks(String keyword, String status) {
        List<Task> list = new ArrayList<>();


        String sql = "SELECT t.*, u.full_name AS assignee_name, p.name AS project_name " +
                "FROM tasks t " +
                "LEFT JOIN users u ON t.assignee_id = u.id " +
                "LEFT JOIN projects p ON t.project_id = p.id " +
                "WHERE 1=1 ";


        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND p.name LIKE ? ";
        }


        if (status != null && !status.trim().isEmpty()) {
            sql += " AND t.status = ? ";
        }


        sql += " ORDER BY t.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int paramIndex = 1;


            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + keyword.trim() + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(paramIndex++, status.trim());
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Task task = new Task();
                task.setId(rs.getInt("id"));
                task.setProjectId(rs.getInt("project_id"));
                task.setProjectName(rs.getString("project_name"));
                task.setTitle(rs.getString("title"));
                task.setStatus(rs.getString("status"));
                task.setAssigneeName(rs.getString("assignee_name"));
                list.add(task);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}