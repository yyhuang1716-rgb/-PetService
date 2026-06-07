package com.pet.app.entity;

import java.util.Date;

public class ServiceOrder {
    private Integer id;
    private Integer userId;       // 预约用户ID
    private Integer petId;        // 预约宠物ID
    private Integer serviceId;    // 预约服务项目ID
    private String title;         // 服务名称快照（下单时从 service_item 冗余）
    private Double price;         // 服务价格快照
    private String description;   // 服务描述快照
    private Date appointTime;     // 预约服务时间
    private Integer status;       // 状态：0待接单, 1已接单, 2服务中, 3已完成, 4已取消
    private Date createTime;

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

    public Date getAppointTime() { return appointTime; }
    public void setAppointTime(Date appointTime) { this.appointTime = appointTime; }

    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}