package org.example.fluxhome.model;

public class User {
    private int id;
    private String fullName;
    private String username;
    private String password;
    private String role;// admin, sale, designer, supervisor
    private String avatar;

    // Constructor rỗng (Bắt buộc phải có)
    public User() {
    }

    // Constructor đầy đủ
    public User(int id, String fullName, String username, String password, String role) {
        this.id = id;
        this.fullName = fullName;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    // --- Các hàm Getter và Setter ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}
