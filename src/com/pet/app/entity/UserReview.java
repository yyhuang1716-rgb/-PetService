package com.pet.app.entity;

import java.time.LocalDateTime;

public class UserReview {
    private Integer id;
    private Integer orderId;      // 关联的订单ID
    private Integer rating;       // 评分：1-5星
    private String content;       // 评价文字内容
    private LocalDateTime createTime;

    public UserReview() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getOrderId() { return orderId; }
    public void setOrderId(Integer orderId) { this.orderId = orderId; }

    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public LocalDateTime getCreateTime() { return createTime; }
    public void setCreateTime(LocalDateTime createTime) { this.createTime = createTime; }
}