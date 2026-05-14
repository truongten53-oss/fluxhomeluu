package org.example.fluxhome.model;

import java.sql.Timestamp;

public class TaskUpdate {
    private int id;
    private int taskId;
    private int userId;
    private String userName;
    private Timestamp updateDate;
    private String note;

    public TaskUpdate() {}

    public int getId() {
        return id;
    }

    public int getTaskId() {
        return 0;
    }

    public int getUserId() {
        return userId;
    }

    public String getUserName() {
        return userName;
    }

    public Timestamp getUpdateDate() {
        return updateDate;
    }

    public String getNote() {
        return note;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setUpdateDate(Timestamp updateDate) {
        this.updateDate = updateDate;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public void setTaskTitle(String taskTitle) {
    }
}
