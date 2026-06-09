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
     * @return 用户对象，如果用户名或密码错误则返回 null
     */
    public User login(String username, String password) {
        return userDao.queryUserByUsernameAndPassword(username, password);
    }

    /**
     * 业务：更新用户信息（手机号和密码）
     */
    public boolean updateUserInfo(Integer id, String phone, String password) {
        return userDao.updateUserInfo(id, phone, password) > 0;
    }

    /**
     * 根据ID获取用户完整信息
     */
    public User getUserById(Integer id) {
        return userDao.queryUserById(id);
    }
}