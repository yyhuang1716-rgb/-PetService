package com.pet.app.dao;

import com.pet.app.entity.ServiceOrder;

public class ServiceOrderDao extends BaseDao {

    /**
     * 插入新的服务预约订单
     */
    public int insertOrder(ServiceOrder order) {
        String sql = "INSERT INTO service_order(user_id, pet_id, service_id, title, price, description, appoint_time, status) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
        return update(sql, order.getUserId(), order.getPetId(), order.getServiceId(), order.getTitle(), order.getPrice(), order.getDescription(), order.getAppointTime(), order.getStatus());
    }

    /**
     * 根据订单ID查询订单详情
     */
    public ServiceOrder queryOrderById(Integer id) {
        String sql = "SELECT id, user_id userId, pet_id petId, service_id serviceId, title, price, description, remark, appoint_time appointTime, status, create_time createTime FROM service_order WHERE id = ?";
        return queryForOne(ServiceOrder.class, sql, id);
    }

    /**
     * 根据用户ID查询该用户的所有订单（多表联查，包含服务名称、宠物名称和用户名）
     */
    public java.util.List<ServiceOrder> queryOrdersByUserId(Integer userId) {
        // ✅ 核心修复：把 sys_pet 改成了 pet_info
        String sql = "SELECT so.id, so.user_id userId, so.pet_id petId, so.service_id serviceId, " +
                "so.title, so.price, so.description, so.remark, so.appoint_time appointTime, so.status, so.create_time createTime, " +
                "si.title AS serviceTitle, " +
                "pi.name AS petName, " +
                "u.username AS username, " +
                "ur.rating AS rating, ur.content AS reviewContent, ur.create_time AS reviewTime " +
                "FROM service_order so " +
                "LEFT JOIN service_item si ON so.service_id = si.id " +
                "LEFT JOIN pet_info pi ON so.pet_id = pi.id " + // ← 这里改成了正确的宠物表名
                "LEFT JOIN sys_user u ON so.user_id = u.id " +
                "LEFT JOIN user_review ur ON so.id = ur.order_id " +
                "WHERE so.user_id = ? ORDER BY so.create_time DESC";
        return queryForList(ServiceOrder.class, sql, userId);
    }

    /**
     * 更新订单状态
     */
    public int updateOrderStatus(Integer id, Integer status) {
        String sql = "UPDATE service_order SET status = ? WHERE id = ?";
        return update(sql, status, id);
    }

    /**
     * 取消订单
     */
    public int cancelOrder(Integer id) {
        return updateOrderStatus(id, 4);
    }

    /**
     * 更新订单备注
     */
    public int updateOrderRemark(Integer id, String remark) {
        String sql = "UPDATE service_order SET remark = ? WHERE id = ?";
        return update(sql, remark, id);
    }

    /**
     * 查询所有订单（多表联查，含用户名、宠物名、服务名）
     */
    public java.util.List<ServiceOrder> getAllOrders() {
        String sql = "SELECT so.id, so.user_id userId, so.pet_id petId, so.service_id serviceId, " +
                "so.title, so.price, so.description, so.remark, so.appoint_time appointTime, so.status, so.create_time createTime, " +
                "si.title AS serviceTitle, " +
                "pi.name AS petName, " +
                "u.username AS username, " +
                "ur.rating AS rating, ur.content AS reviewContent, ur.create_time AS reviewTime " +
                "FROM service_order so " +
                "LEFT JOIN service_item si ON so.service_id = si.id " +
                "LEFT JOIN pet_info pi ON so.pet_id = pi.id " +
                "LEFT JOIN sys_user u ON so.user_id = u.id " +
                "LEFT JOIN user_review ur ON so.id = ur.order_id " +
                "ORDER BY so.create_time DESC";
        return queryForList(ServiceOrder.class, sql);
    }

    /**
     * 查询正在服务中的订单（已接单 status=1 和 服务中 status=2）
     */
    public java.util.List<ServiceOrder> getOrdersByServiceIng() {
        String sql = "SELECT so.id, so.user_id userId, so.pet_id petId, so.service_id serviceId, " +
                "so.title, so.price, so.description, so.remark, so.appoint_time appointTime, so.status, so.create_time createTime, " +
                "si.title AS serviceTitle, " +
                "pi.name AS petName, " +
                "u.username AS username, " +
                "ur.rating AS rating, ur.content AS reviewContent, ur.create_time AS reviewTime " +
                "FROM service_order so " +
                "LEFT JOIN service_item si ON so.service_id = si.id " +
                "LEFT JOIN pet_info pi ON so.pet_id = pi.id " +
                "LEFT JOIN sys_user u ON so.user_id = u.id " +
                "LEFT JOIN user_review ur ON so.id = ur.order_id " +
                "WHERE so.status IN (1, 2) " +
                "ORDER BY so.create_time DESC";
        return queryForList(ServiceOrder.class, sql);
    }

    /**
     * 根据状态统计订单数量
     */
    public Long countOrdersByStatus(Integer status) {
        String sql = "SELECT COUNT(*) FROM service_order WHERE status = ?";
        Object result = queryForSingleValue(sql, status);
        return result != null ? ((Number) result).longValue() : 0L;
    }

    /**
     * 查询商家所有的已完成评价订单（含评分和评价内容）
     */
    public java.util.List<ServiceOrder> queryReviewedOrdersByMerchantId(Integer merchantId) {
        String sql = "SELECT so.id, so.user_id userId, so.pet_id petId, so.service_id serviceId, " +
                "so.title, so.price, so.description, so.remark, so.appoint_time appointTime, so.status, so.create_time createTime, " +
                "si.title AS serviceTitle, " +
                "pi.name AS petName, " +
                "u.username AS username, " +
                "ur.rating AS rating, ur.content AS reviewContent, ur.create_time AS reviewTime " +
                "FROM service_order so " +
                "INNER JOIN user_review ur ON so.id = ur.order_id " +
                "LEFT JOIN service_item si ON so.service_id = si.id " +
                "LEFT JOIN pet_info pi ON so.pet_id = pi.id " +
                "LEFT JOIN sys_user u ON so.user_id = u.id " +
                "WHERE si.merchant_id = ? " +
                "ORDER BY ur.create_time DESC";
        return queryForList(ServiceOrder.class, sql, merchantId);
    }

    /**
     * 查询当前用户所有已评价的订单（含评分和评价内容）
     */
    public java.util.List<ServiceOrder> queryReviewedOrdersByUserId(Integer userId) {
        String sql = "SELECT so.id, so.user_id userId, so.pet_id petId, so.service_id serviceId, " +
                "so.title, so.price, so.description, so.remark, so.appoint_time appointTime, so.status, so.create_time createTime, " +
                "si.title AS serviceTitle, " +
                "pi.name AS petName, " +
                "u.username AS username, " +
                "ur.rating AS rating, ur.content AS reviewContent, ur.create_time AS reviewTime " +
                "FROM service_order so " +
                "INNER JOIN user_review ur ON so.id = ur.order_id " +
                "LEFT JOIN service_item si ON so.service_id = si.id " +
                "LEFT JOIN pet_info pi ON so.pet_id = pi.id " +
                "LEFT JOIN sys_user u ON so.user_id = u.id " +
                "WHERE so.user_id = ? " +
                "ORDER BY ur.create_time DESC";
        return queryForList(ServiceOrder.class, sql, userId);
    }
}