package org.example.fluxhome.model;

import java.sql.Timestamp;

public class Project {
    private int id;
    private String name;
    private String imageUrl;
    private String location;
    private Timestamp createdAt;

    // --- MỚI THÊM: Biến lưu danh sách tên người tham gia ---
    private String participantNames;

    public Project() {}

    public Project(int id, String name, String imageUrl, String location, Timestamp createdAt) {
        this.id = id;
        this.name = name;
        this.imageUrl = imageUrl;
        this.location = location;
        this.createdAt = createdAt;
    }

    // Các hàm Getters và Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    // --- MỚI THÊM: Getters và Setters cho participantNames ---
    public String getParticipantNames() {
        return participantNames;
    }

    public void setParticipantNames(String participantNames) {
        this.participantNames = participantNames;
    }
}