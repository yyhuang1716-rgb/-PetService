package com.pet.app.entity;

import java.util.Date;

public class ServiceItem {
    private Integer id;
    private Integer merchantId;   // 所属商家ID
    private String title;         // 服务名称
    private Double price;         // 服务价格
    private String description;   // 详细描述
    private Date createTime;

    public ServiceItem() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getMerchantId() { return merchantId; }
    public void setMerchantId(Integer merchantId) { this.merchantId = merchantId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}