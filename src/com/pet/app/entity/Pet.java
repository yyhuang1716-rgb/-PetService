package com.pet.app.entity;

import java.util.Date;

public class Pet {
    private Integer id;
    private Integer userId;       // 所属用户ID
    private String name;          // 宠物昵称
    private String type;          // 种类：猫/狗/其他
    private Integer age;          // 年龄
    private Double weight;        // 体重 (对应 DECIMAL，Java 中用 Double 接收)
    private Date createTime;

    public Pet() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }

    public Double getWeight() { return weight; }
    public void setWeight(Double weight) { this.weight = weight; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}