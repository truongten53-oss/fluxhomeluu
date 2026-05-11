package org.example.fluxhome.model;

import java.sql.Timestamp;

public class TaskUpdate {
    private int id;
    private int taskId;
    private int userId;
    private String userName; // Tên người cập nhật (để hiển thị cho Sếp xem)
    private Timestamp updateDate;
    private String note;

    // Các hàm Getter và Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTaskId() { return taskId; }
    public void setTaskId(int taskId) { this.taskId = taskId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public Timestamp getUpdateDate() { return updateDate; }
    public void setUpdateDate(Timestamp updateDate) { this.updateDate = updateDate; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}
