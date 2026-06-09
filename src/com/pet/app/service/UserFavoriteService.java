package com.pet.app.service;

import com.pet.app.dao.UserFavoriteDao;
import com.pet.app.entity.ServiceItem;
import com.pet.app.entity.UserFavorite;

import java.util.List;

public class UserFavoriteService {

    private UserFavoriteDao userFavoriteDao = new UserFavoriteDao();

    /**
     * 添加收藏（检查是否已收藏，防止重复）
     * @return true 表示添加成功，false 表示已收藏或失败
     */
    public boolean addFavorite(Integer userId, Integer serviceId) {
        // 检查是否已收藏
        if (userFavoriteDao.checkExists(userId, serviceId) != null) {
            return false; // 已收藏，不重复添加
        }
        UserFavorite favorite = new UserFavorite();
        favorite.setUserId(userId);
        favorite.setServiceId(serviceId);
        return userFavoriteDao.insertFavorite(favorite) > 0;
    }

    /**
     * 取消收藏
     * @return true 表示取消成功
     */
    public boolean removeFavorite(Integer userId, Integer serviceId) {
        return userFavoriteDao.deleteFavorite(userId, serviceId) > 0;
    }

    /**
     * 查询用户收藏的服务列表
     */
    public List<ServiceItem> getFavoritesByUserId(Integer userId) {
        return userFavoriteDao.queryFavoritesByUserId(userId);
    }

    /**
     * 检查是否已收藏
     */
    public boolean isFavorited(Integer userId, Integer serviceId) {
        return userFavoriteDao.checkExists(userId, serviceId) != null;
    }
}
