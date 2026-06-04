package com.pet.app.dao;

import com.pet.app.entity.User;

public class UserDao extends BaseDao {

    /**
     * 根据用户名查询用户信息（用于注册时检查用户名是否已存在）
     * @param username 用户名
     * @return 如果返回 null，说明没有这个人，可以注册；否则说明已存在
     */
    public User queryUserByUsername(String username) {
        String sql = "SELECT id, username, password, phone, role FROM sys_user WHERE username = ?";
        return queryForOne(User.class, sql, username);
    }

    /**
     * 根据用户名和密码查询用户信息（用于用户登录）
     * @param username 用户名
     * @param password 密码
     * @return 返回 null 说明用户名或密码错误
     */
    public User queryUserByUsernameAndPassword(String username, String password) {
        String sql = "SELECT id, username, password, phone, role FROM sys_user WHERE username = ? AND password = ?";
        return queryForOne(User.class, sql, username, password);
    }

    /**
     * 保存（注册）一个新用户
     * @param user 用户对象
     * @return 影响的行数，大于 0 说明成功
     */
    public int saveUser(User user) {
        String sql = "INSERT INTO sys_user(username, password, phone, role) VALUES(?, ?, ?, ?)";
        return update(sql, user.getUsername(), user.getPassword(), user.getPhone(), user.getRole());
    }
}