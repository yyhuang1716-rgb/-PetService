package com.pet.app.test;

import com.pet.app.dao.UserDao;
import com.pet.app.entity.User;

public class UserDaoTest {

    public static void main(String[] args) {
        // 创建 UserDao 对象，准备调用我们刚才写好的增删改查方法
        UserDao userDao = new UserDao();

        System.out.println("========== 开始测试 UserDao ==========");

        // ----------------------------------------------------
        // 1. 测试：检查用户名是否可用 & 注册新用户 (saveUser)
        // ----------------------------------------------------
        System.out.println("\n--- 1. 测试注册功能 ---");
        String testUsername = "李四_Test";

        // 先查一下数据库里有没有叫这个名字的
        if (userDao.queryUserByUsername(testUsername) == null) {
            System.out.println("用户名可用，准备向数据库插入数据...");

            // 封装一个 User 实体对象
            User newUser = new User();
            newUser.setUsername(testUsername);
            newUser.setPassword("666888"); // 模拟密码
            newUser.setPhone("13911112222");
            newUser.setRole(0); // 0 代表普通用户

            // 调用 DAO 插入数据库
            int rows = userDao.saveUser(newUser);
            if (rows > 0) {
                System.out.println("✅ 注册成功！成功插入 " + rows + " 条数据。");
            } else {
                System.out.println("❌ 注册失败！");
            }
        } else {
            System.out.println("⚠️ 用户 [" + testUsername + "] 已存在，为了防止重复测试，跳过插入。");
        }

        // ----------------------------------------------------
        // 2. 测试：用户登录查询 (queryUserByUsernameAndPassword)
        // ----------------------------------------------------
        System.out.println("\n--- 2. 测试登录功能 ---");
        System.out.println("正在尝试用账号: " + testUsername + ", 密码: 666888 登录...");

        // 调用 DAO 查询账号密码是否匹配
        User loginUser = userDao.queryUserByUsernameAndPassword(testUsername, "666888");

        if (loginUser != null) {
            System.out.println("✅ 登录成功！从数据库抓取到的用户信息如下：");
            // 这里会调用 User 实体类里我们重写的 toString() 方法
            System.out.println(loginUser);
        } else {
            System.out.println("❌ 登录失败！账号或密码错误。");
        }

        System.out.println("\n========== UserDao 测试结束 ==========");
    }
}