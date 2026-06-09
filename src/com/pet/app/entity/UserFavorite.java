package com.pet.app.entity;

import java.time.LocalDateTime;

public class UserFavorite {
    private Integer id;
    private Integer userId;       // 用户ID
    private Integer serviceId;    // 服务项目ID
    private LocalDateTime createTime; // 收藏时间

    public UserFavorite() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public Integer getServiceId() { return serviceId; }
    public void setServiceId(Integer serviceId) { this.serviceId = serviceId; }

    public LocalDateTime getCreateTime() { return createTime; }
    public void setCreateTime(LocalDateTime createTime) { this.createTime = createTime; }
}
