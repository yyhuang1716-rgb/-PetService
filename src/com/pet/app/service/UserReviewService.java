package com.pet.app.service;

import com.pet.app.dao.UserReviewDao;
import com.pet.app.entity.ServiceOrder;
import com.pet.app.entity.UserReview;

import java.util.List;

public class UserReviewService {

    private UserReviewDao userReviewDao = new UserReviewDao();

    /**
     * 提交评价
     * @return true 表示成功，false 表示失败
     */
    public boolean submitReview(UserReview review) {
        int rows = userReviewDao.insertReview(review);
        return rows > 0;
    }

    /**
     * 查询订单是否已有评价
     */
    public UserReview getReviewByOrderId(Integer orderId) {
        return userReviewDao.queryByOrderId(orderId);
    }

    /**
     * 查询所有评价记录（含用户名、服务名、宠物名）
     */
    public List<ServiceOrder> getAllReviews() {
        return userReviewDao.getAllReviews();
    }
}
