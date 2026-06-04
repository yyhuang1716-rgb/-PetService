package com.pet.app.entity;

import java.util.Date;

public class UserReview {
    private Integer id;
    private Integer orderId;      // 关联的订单ID
    private Integer rating;       // 评分：1-5星
    private String content;       // 评价文字内容
    private Date createTime;

    public UserReview() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getOrderId() { return orderId; }
    public void setOrderId(Integer orderId) { this.orderId = orderId; }

    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}