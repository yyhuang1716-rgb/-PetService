package com.pet.app.dao;

import com.pet.app.entity.ServiceOrder;

public class ServiceOrderDao extends BaseDao {

    /**
     * 插入新的服务预约订单
     * @param order 订单对象
     * @return 影响的行数，大于 0 说明成功
     */
    public int insertOrder(ServiceOrder order) {
        String sql = "INSERT INTO service_order(user_id, pet_id, service_id, title, price, description, appoint_time, status) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
        return update(sql, order.getUserId(), order.getPetId(), order.getServiceId(), order.getTitle(), order.getPrice(), order.getDescription(), order.getAppointTime(), order.getStatus());
    }

    /**
     * 根据订单ID查询订单详情
     * @param id 订单ID
     * @return 返回 null 说明未找到该订单
     */
    public ServiceOrder queryOrderById(Integer id) {
        String sql = "SELECT id, user_id userId, pet_id petId, service_id serviceId, title, price, description, appoint_time appointTime, status, create_time createTime FROM service_order WHERE id = ?";
        return queryForOne(ServiceOrder.class, sql, id);
    }

    /**
     * 根据用户ID查询该用户的所有订单（多表联查，包含服务名称、宠物名称和用户名）
     * @param userId 用户ID
     * @return 订单列表
     */
    public java.util.List<ServiceOrder> queryOrdersByUserId(Integer userId) {
        String sql = "SELECT so.id, so.user_id userId, so.pet_id petId, so.service_id serviceId, " +
                "so.title, so.price, so.description, so.appoint_time appointTime, so.status, so.create_time createTime, " +
                "si.title AS serviceTitle, " +
                "pi.name AS petName, " +
                "u.username AS username " +
                "FROM service_order so " +
                "LEFT JOIN service_item si ON so.service_id = si.id " +
                "LEFT JOIN sys_pet pi ON so.pet_id = pi.id " +
                "LEFT JOIN sys_user u ON so.user_id = u.id " +
                "WHERE so.user_id = ? ORDER BY so.create_time DESC";
        return queryForList(ServiceOrder.class, sql, userId);
    }

    /**
     * 更新订单状态
     * @param id 订单ID
     * @param status 新的状态（如：已接单、服务中、已完成、已取消）
     * @return 影响的行数，大于 0 说明成功
     */
    public int updateOrderStatus(Integer id, String status) {
        String sql = "UPDATE service_order SET status = ? WHERE id = ?";
        int rows = update(sql, status, id);
        return rows;
    }

    /**
     * 取消订单（将状态设置为 已取消）
     * @param id 订单ID
     * @return 影响的行数，大于 0 说明成功
     */
    public int cancelOrder(Integer id) {
        return updateOrderStatus(id, "已取消");
    }
}
