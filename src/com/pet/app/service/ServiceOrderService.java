package com.pet.app.service;

import com.pet.app.dao.ServiceOrderDao;
import com.pet.app.entity.ServiceOrder;

import java.util.List;

public class ServiceOrderService {

    private ServiceOrderDao serviceOrderDao = new ServiceOrderDao();

    /**
     * 业务：创建新的预约订单
     * @param order 订单对象（需设置 userId, petId, serviceId, appointTime, status）
     * @return true 表示创建成功，false 表示创建失败
     */
    public boolean createOrder(ServiceOrder order) {
        int rows = serviceOrderDao.insertOrder(order);
        return rows > 0;
    }

    /**
     * 业务：根据ID获取订单详情
     * @param id 订单ID
     * @return 订单对象
     */
    public ServiceOrder getOrderById(Integer id) {
        return serviceOrderDao.queryOrderById(id);
    }

    /**
     * 业务：获取用户的所有订单
     * @param userId 用户ID
     * @return 订单列表
     */
    public List<ServiceOrder> getOrdersByUserId(Integer userId) {
        return serviceOrderDao.queryOrdersByUserId(userId);
    }

    /**
     * 业务：更新订单状态
     * @param orderId 订单ID
     * @param newStatus 新状态（0待接单, 1已接单, 2服务中, 3已完成, 4已取消）
     * @return true 表示更新成功
     */
    public boolean updateOrderStatus(Integer orderId, Integer newStatus) {
        int rows = serviceOrderDao.updateOrderStatus(orderId, newStatus);
        return rows > 0;
    }

    /**
     * 业务：取消订单
     * @param orderId 订单ID
     * @return true 表示取消成功
     */
    public boolean cancelOrder(Integer orderId) {
        return updateOrderStatus(orderId, 4);
    }
}
