package org.example.fluxhome.model;

import java.sql.Timestamp;

public class Task {
    private int id;
    private int projectId;          // Thêm thuộc tính này để lưu ID của dự án vào CSDL
    private String projectName;     // Giữ lại thuộc tính này để lấy tên dự án (từ lệnh JOIN) hiển thị lên giao diện
    private String title;
    private String status;          // pending, in_progress, completed
    private int assigneeId;
    private String notes;
    private Timestamp createdAt;

    // Các thuộc tính phụ (không có trong DB nhưng cần để hiển thị giao diện)
    private String assigneeName;

    public Task() {
    }

    // Cập nhật lại Constructor để có thêm projectId
    public Task(int id, int projectId, String projectName, String title, String status, int assigneeId, String notes, Timestamp createdAt) {
        this.id = id;
        this.projectId = projectId;
        this.projectName = projectName;
        this.title = title;
        this.status = status;
        this.assigneeId = assigneeId;
        this.notes = notes;
        this.createdAt = createdAt;
    }

    // --- Các hàm Getter và Setter ---

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    // --- Getter & Setter mới cho projectId ---
    public int getProjectId() { return projectId; }
    public void setProjectId(int projectId) { this.projectId = projectId; }

    public String getProjectName() { return projectName; }
    public void setProjectName(String projectName) { this.projectName = projectName; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getAssigneeId() { return assigneeId; }
    public void setAssigneeId(int assigneeId) { this.assigneeId = assigneeId; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getAssigneeName() { return assigneeName; }
    public void setAssigneeName(String assigneeName) { this.assigneeName = assigneeName; }
}