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

    /**
     * 更新用户信息（手机号和密码）
     * @param id 用户ID
     * @param phone 新手机号
     * @param password 新密码
     * @return 影响的行数，大于 0 说明成功
     */
    public int updateUserInfo(Integer id, String phone, String password) {
        String sql = "UPDATE sys_user SET phone = ?, password = ? WHERE id = ?";
        return update(sql, phone, password, id);
    }

    /**
     * 根据ID查询用户
     */
    public User queryUserById(Integer id) {
        String sql = "SELECT id, username, password, phone, role, create_time createTime FROM sys_user WHERE id = ?";
        return queryForOne(User.class, sql, id);
    }
}