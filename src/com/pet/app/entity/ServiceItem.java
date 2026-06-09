package com.pet.app.entity;

import java.time.LocalDateTime;

public class ServiceItem {
    private Integer id;
    private Integer merchantId;   // 所属商家ID
    private String title;         // 服务名称
    private String type;          // 服务类型
    private Double price;         // 服务价格
    private String description;   // 详细描述
    private LocalDateTime createTime;

    // 收藏相关（联表查询收藏列表时使用）
    private Integer favoriteId;   // 收藏记录ID
    private LocalDateTime favoriteCreateTime;  // 收藏时间

    public ServiceItem() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getMerchantId() { return merchantId; }
    public void setMerchantId(Integer merchantId) { this.merchantId = merchantId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getName() { return title; }
    public void setName(String name) { this.title = name; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public LocalDateTime getCreateTime() { return createTime; }
    public void setCreateTime(LocalDateTime createTime) { this.createTime = createTime; }

    public Integer getFavoriteId() { return favoriteId; }
    public void setFavoriteId(Integer favoriteId) { this.favoriteId = favoriteId; }

    public LocalDateTime getFavoriteCreateTime() { return favoriteCreateTime; }
    public void setFavoriteCreateTime(LocalDateTime favoriteCreateTime) { this.favoriteCreateTime = favoriteCreateTime; }
}