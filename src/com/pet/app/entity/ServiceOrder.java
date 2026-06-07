package com.pet.app.entity;

import java.time.LocalDateTime;

public class ServiceOrder {
    private Integer id;
    private Integer userId;       // 预约用户ID
    private Integer petId;        // 预约宠物ID
    private Integer serviceId;    // 预约服务项目ID
    private String title;         // 服务名称快照（下单时从 service_item 冗余）
    private Double price;         // 服务价格快照
    private String description;   // 服务描述快照
    private String serviceTitle;  // 服务名称（联表查询从 service_item 获取）
    private String petName;       // 宠物名称（联表查询从 sys_pet 或 pet_info 获取）
    private String username;      // 用户名（联表查询从 sys_user 获取）
    private LocalDateTime appointTime;     // 预约服务时间

    private String status;  // 状态：待接单/已接单/已完成/已取消

    private LocalDateTime createTime;

    public ServiceOrder() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public Integer getPetId() { return petId; }
    public void setPetId(Integer petId) { this.petId = petId; }

    public Integer getServiceId() { return serviceId; }
    public void setServiceId(Integer serviceId) { this.serviceId = serviceId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getServiceTitle() { return serviceTitle; }
    public void setServiceTitle(String serviceTitle) { this.serviceTitle = serviceTitle; }

    public String getPetName() { return petName; }
    public void setPetName(String petName) { this.petName = petName; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public LocalDateTime getAppointTime() { return appointTime; }
    public void setAppointTime(LocalDateTime appointTime) { this.appointTime = appointTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getCreateTime() { return createTime; }
    public void setCreateTime(LocalDateTime createTime) { this.createTime = createTime; }
}