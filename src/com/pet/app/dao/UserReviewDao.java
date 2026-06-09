package com.pet.app.dao;

import com.pet.app.entity.ServiceOrder;
import com.pet.app.entity.UserReview;

import java.util.List;

public class UserReviewDao extends BaseDao {

    /**
     * 插入评价记录
     */
    public int insertReview(UserReview review) {
        String sql = "INSERT INTO user_review(order_id, rating, content) VALUES(?, ?, ?)";
        return update(sql, review.getOrderId(), review.getRating(), review.getContent());
    }

    /**
     * 根据订单ID查询评价
     */
    public UserReview queryByOrderId(Integer orderId) {
        String sql = "SELECT id, order_id orderId, rating, content, create_time createTime FROM user_review WHERE order_id = ?";
        return queryForOne(UserReview.class, sql, orderId);
    }

    /**
     * 查询所有评价记录（多表 JOIN 获取用户名、服务名称、宠物名称）
     */
    public List<ServiceOrder> getAllReviews() {
        String sql = "SELECT so.id, so.user_id userId, so.pet_id petId, so.service_id serviceId, " +
                "so.title, so.price, so.description, so.remark, so.appoint_time appointTime, so.status, so.create_time createTime, " +
                "si.title AS serviceTitle, " +
                "pi.name AS petName, " +
                "u.username AS username, " +
                "ur.rating AS rating, ur.content AS reviewContent, ur.create_time AS reviewTime " +
                "FROM user_review ur " +
                "INNER JOIN service_order so ON ur.order_id = so.id " +
                "LEFT JOIN service_item si ON so.service_id = si.id " +
                "LEFT JOIN pet_info pi ON so.pet_id = pi.id " +
                "LEFT JOIN sys_user u ON so.user_id = u.id " +
                "ORDER BY ur.create_time DESC";
        return queryForList(ServiceOrder.class, sql);
    }
}
