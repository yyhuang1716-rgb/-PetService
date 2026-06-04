package com.pet.app.service;

import com.pet.app.dao.UserDao;
import com.pet.app.entity.User;

public class UserService {

    // 引入我们之前写好的 UserDao
    private UserDao userDao = new UserDao();

    /**
     * 业务：用户注册
     * @param user 包含注册信息的用户对象
     * @return true 表示注册成功，false 表示注册失败（用户名已存在）
     */
    public boolean registerUser(User user) {
        // 1. 检查用户名是否已存在
        if (userDao.queryUserByUsername(user.getUsername()) != null) {
            // 用户名被占用，业务要求不允许注册
            return false;
        }
        // 2. 没有被占用，调用 DAO 保存到数据库
        int rows = userDao.saveUser(user);
        return rows > 0;
    }

    /**
     * 业务：用户登录
     * @param username 用户名
     * @param password 密码
     * @return 登录成功返回 User 对象，失败返回 null
     */
    public User login(String username, String password) {
        return userDao.queryUserByUsernameAndPassword(username, password);
    }
}