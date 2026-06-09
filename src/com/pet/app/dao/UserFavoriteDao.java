package com.pet.app.dao;

import com.pet.app.entity.ServiceItem;
import com.pet.app.entity.UserFavorite;

import java.util.List;

public class UserFavoriteDao extends BaseDao {

    /**
     * 添加收藏
     */
    public int insertFavorite(UserFavorite favorite) {
        String sql = "INSERT INTO user_favorite(user_id, service_id) VALUES(?, ?)";
        return update(sql, favorite.getUserId(), favorite.getServiceId());
    }

    /**
     * 取消收藏（根据 user_id 和 service_id）
     */
    public int deleteFavorite(Integer userId, Integer serviceId) {
        String sql = "DELETE FROM user_favorite WHERE user_id = ? AND service_id = ?";
        return update(sql, userId, serviceId);
    }

    /**
     * 检查是否已收藏
     */
    public UserFavorite checkExists(Integer userId, Integer serviceId) {
        String sql = "SELECT id, user_id userId, service_id serviceId, create_time createTime FROM user_favorite WHERE user_id = ? AND service_id = ?";
        return queryForOne(UserFavorite.class, sql, userId, serviceId);
    }

    /**
     * 查询用户的所有收藏（多表 JOIN 获取服务名称、价格、描述）
     */
    public List<ServiceItem> queryFavoritesByUserId(Integer userId) {
        String sql = "SELECT si.id, si.merchant_id merchantId, si.title, si.price, si.description, si.create_time createTime, " +
                "uf.id AS favoriteId, uf.create_time AS favoriteCreateTime " +
                "FROM user_favorite uf " +
                "INNER JOIN service_item si ON uf.service_id = si.id " +
                "WHERE uf.user_id = ? " +
                "ORDER BY uf.create_time DESC";
        return queryForList(ServiceItem.class, sql, userId);
    }
}
