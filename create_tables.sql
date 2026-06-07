-- 创建宠物服务系统数据库表
-- 使用前请确保已创建数据库: CREATE DATABASE IF NOT EXISTS pet_service_db DEFAULT CHARACTER SET utf8mb4;

USE pet_service_db;

-- 1. 用户与商家表
CREATE TABLE IF NOT EXISTS sys_user (
    id INT AUTO_INCREMENT COMMENT '主键ID' PRIMARY KEY,
    username VARCHAR(50) NOT NULL COMMENT '用户名',
    password VARCHAR(50) NOT NULL COMMENT '登录密码',
    phone VARCHAR(20) NULL COMMENT '联系电话',
    role INT DEFAULT 0 COMMENT '角色：0普通用户, 1商家, 2管理员',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间'
) COMMENT = '用户与商家表' CHARSET = utf8mb4;

-- 2. 宠物档案表
CREATE TABLE IF NOT EXISTS pet_info (
    id INT AUTO_INCREMENT COMMENT '宠物ID' PRIMARY KEY,
    user_id INT NOT NULL COMMENT '所属用户ID',
    name VARCHAR(50) NOT NULL COMMENT '宠物昵称',
    type VARCHAR(20) NULL COMMENT '种类：猫/狗/其他',
    age INT NULL COMMENT '年龄(岁/月)',
    weight DECIMAL(5, 2) NULL COMMENT '体重(kg)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '建档时间',
    CONSTRAINT pet_info_ibfk_1 FOREIGN KEY (user_id) REFERENCES sys_user (id) ON DELETE CASCADE
) COMMENT = '宠物档案表' CHARSET = utf8mb4;

CREATE INDEX idx_user_id ON pet_info (user_id);

-- 3. 服务项目表
CREATE TABLE IF NOT EXISTS service_item (
    id INT AUTO_INCREMENT COMMENT '服务项目ID' PRIMARY KEY,
    merchant_id INT NOT NULL COMMENT '所属商家ID',
    title VARCHAR(100) NOT NULL COMMENT '服务名称(如：高级犬类美容)',
    price DECIMAL(10, 2) NOT NULL COMMENT '服务价格',
    description TEXT NULL COMMENT '服务详细描述',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
    CONSTRAINT service_item_ibfk_1 FOREIGN KEY (merchant_id) REFERENCES sys_user (id) ON DELETE CASCADE
) COMMENT = '服务项目表' CHARSET = utf8mb4;

CREATE INDEX idx_merchant_id ON service_item (merchant_id);

-- 4. 服务预约订单表
CREATE TABLE IF NOT EXISTS service_order (
    id INT AUTO_INCREMENT COMMENT '订单ID' PRIMARY KEY,
    user_id INT NOT NULL COMMENT '预约用户ID',
    pet_id INT NOT NULL COMMENT '预约宠物ID',
    service_id INT NOT NULL COMMENT '预约服务项目ID',
    title VARCHAR(100) NOT NULL COMMENT '服务名称快照',
    price DECIMAL(10, 2) NOT NULL COMMENT '服务价格快照',
    description TEXT NULL COMMENT '服务描述快照',
    appoint_time DATETIME NOT NULL COMMENT '预约服务时间',
    status INT DEFAULT 0 COMMENT '状态：0待接单, 1已接单, 2服务中, 3已完成, 4已取消',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '订单创建时间',
    remark VARCHAR(255) NULL COMMENT '订单备注',
    CONSTRAINT service_order_ibfk_1 FOREIGN KEY (user_id) REFERENCES sys_user (id) ON DELETE CASCADE,
    CONSTRAINT service_order_ibfk_2 FOREIGN KEY (pet_id) REFERENCES pet_info (id) ON DELETE CASCADE,
    CONSTRAINT service_order_ibfk_3 FOREIGN KEY (service_id) REFERENCES service_item (id) ON DELETE CASCADE
) COMMENT = '服务预约订单表' CHARSET = utf8mb4;

CREATE INDEX idx_order_user_id ON service_order (user_id);
CREATE INDEX idx_order_pet_id ON service_order (pet_id);
CREATE INDEX idx_order_service_id ON service_order (service_id);

-- 5. 用户评价表
CREATE TABLE IF NOT EXISTS user_review (
    id INT AUTO_INCREMENT COMMENT '评价ID' PRIMARY KEY,
    order_id INT NOT NULL COMMENT '关联的订单ID',
    rating INT NOT NULL COMMENT '评分：1-5星',
    content TEXT NULL COMMENT '评价文字内容',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '评价时间',
    CONSTRAINT user_review_ibfk_1 FOREIGN KEY (order_id) REFERENCES service_order (id) ON DELETE CASCADE
) COMMENT = '用户评价表' CHARSET = utf8mb4;

CREATE INDEX idx_review_order_id ON user_review (order_id);
