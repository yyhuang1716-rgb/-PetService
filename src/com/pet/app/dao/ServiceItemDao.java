package com.pet.app.dao;

import com.pet.app.entity.ServiceItem;

import java.util.List;

public class ServiceItemDao extends BaseDao {

    /**
     * 查询所有服务项目
     * @return 服务项目列表，可能为空
     */
    public List<ServiceItem> queryAllServices() {
        String sql = "SELECT id, merchant_id merchantId, title, price, description, create_time createTime FROM service_item ORDER BY id ASC";
        return queryForList(ServiceItem.class, sql);
    }

    /**
     * 根据商家ID查询该商家的所有服务项目
     * @param merchantId 商家ID
     * @return 服务项目列表
     */
    public List<ServiceItem> queryServicesByMerchantId(Integer merchantId) {
        String sql = "SELECT id, merchant_id merchantId, title, price, description, create_time createTime FROM service_item WHERE merchant_id = ?";
        return queryForList(ServiceItem.class, sql, merchantId);
    }

    /**
     * 根据服务ID查询单个服务项目
     * @param id 服务ID
     * @return 返回 null 说明未找到该服务
     */
    public ServiceItem queryServiceById(Integer id) {
        String sql = "SELECT id, merchant_id merchantId, title, price, description, create_time createTime FROM service_item WHERE id = ?";
        return queryForOne(ServiceItem.class, sql, id);
    }

    /**
     * 添加新的服务项目
     * @param serviceItem 服务项目对象
     * @return 影响的行数，大于 0 说明成功
     */
    public int saveService(ServiceItem serviceItem) {
        String sql = "INSERT INTO service_item(merchant_id, title, price, description) VALUES(?, ?, ?, ?)";
        return update(sql, serviceItem.getMerchantId(), serviceItem.getTitle(), serviceItem.getPrice(), serviceItem.getDescription());
    }

    /**
     * 根据关键字模糊查询服务项目（按名称）
     * @param keyword 搜索关键字
     * @return 服务项目列表
     */
    public List<ServiceItem> queryServicesByKeyword(String keyword) {
        String sql = "SELECT id, merchant_id merchantId, title, type, price, description, create_time createTime FROM service_item WHERE title LIKE ? ORDER BY id ASC";
        return queryForList(ServiceItem.class, sql, "%" + keyword + "%");
    }

    /**
     * 更新服务项目信息
     * @param serviceItem 包含更新后的服务项目对象
     * @return 影响的行数，大于 0 说明成功
     */
    public int updateService(ServiceItem serviceItem) {
        String sql = "UPDATE service_item SET title = ?, type = ?, price = ?, description = ? WHERE id = ?";
        return update(sql, serviceItem.getTitle(), serviceItem.getType(), serviceItem.getPrice(), serviceItem.getDescription(), serviceItem.getId());
    }

    /**
     * 分页查询服务项目
     * @param page 页码（从1开始）
     * @param size 每页条数
     * @return 服务项目列表
     */
    public List<ServiceItem> queryServicesPage(int page, int size) {
        String sql = "SELECT id, merchant_id merchantId, title, price, description, create_time createTime FROM service_item ORDER BY id ASC LIMIT ?, ?";
        return queryForList(ServiceItem.class, sql, (page - 1) * size, size);
    }

    /**
     * 统计服务项目总数
     * @return 总记录数
     */
    public int countServices() {
        String sql = "SELECT COUNT(*) FROM service_item";
        Number num = (Number) queryForSingleValue(sql);
        return num != null ? num.intValue() : 0;
    }

    /**
     * 根据服务ID删除服务项目
     * @param id 服务ID
     * @return 影响的行数，大于 0 说明成功
     */
    public int deleteServiceById(Integer id) {
        String sql = "DELETE FROM service_item WHERE id = ?";
        return update(sql, id);
    }
}
