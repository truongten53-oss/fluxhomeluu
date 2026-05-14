package org.example.fluxhome.model;

public class User {
    private int id;
    private String fullName;
    private String userName;
    private String passwordHash;
    private String role;
    private String avatar;

    public User() {}

    public User(int id, String fullName, String username, String passwordHash, String role, String avatar) {
        this.id = id;
        this.fullName = fullName;
        this.userName = username;
        this.passwordHash = passwordHash;
        this.role = role;
        this.avatar = avatar;
    }

    public int getId() {
        return id;
    }

    public String getFullName() {
        return fullName;
    }

    public String getUserName() {
        return userName;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public String getRole() {
        return role;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}