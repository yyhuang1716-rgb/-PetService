package com.pet.app.entity;

import java.util.Date;

public class User {
    private Integer id;           // 主键ID
    private String username;      // 用户名
    private String password;      // 登录密码
    private String phone;         // 联系电话
    private Integer role;         // 角色：0普通用户, 1商家, 2管理员
    private Date createTime;      // 注册时间 (对应 create_time)

    // 无参构造方法 (JavaBean 必备)
    public User() {}

    // Getter 和 Setter 方法
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public Integer getRole() { return role; }
    public void setRole(Integer role) { this.role = role; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", phone='" + phone + '\'' +
                ", role=" + role +
                '}';
    }
}