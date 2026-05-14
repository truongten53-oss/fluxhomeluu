package org.example.fluxhome.model;

import java.sql.Timestamp;

public class Task {
    private int id;
    private int projectId;
    private String title;
    private String status;
    private int assigneeId;
    private String notes;
    private Timestamp createdAt;

    private String projectName;
    private String assigneeName;

    public Task() {}

    public int getId() {
        return id;
    }

    public int getProjectId() {
        return projectId;
    }

    public String getTitle() {
        return title;
    }

    public String getStatus() {
        return status;
    }

    public int getAssigneeId() {
        return assigneeId;
    }

    public String getNotes() {
        return notes;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public String getProjectName() {
        return projectName;
    }

    public String getAssigneeName() {
        return assigneeName;
    }

    public void setAssigneeName(String assigneeName) {
        this.assigneeName = assigneeName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public void setAssigneeId(int assigneeId) {
        this.assigneeId = assigneeId;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public void setId(int id) {
        this.id = id;
    }
}
