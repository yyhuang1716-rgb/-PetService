package com.pet.app.test;

import com.pet.app.utils.JdbcUtils;
import java.sql.Connection;

public class ConnectionTest {

    // main 方法是 Java 程序的独立入口，不需要启动 Tomcat 就能直接运行
    public static























































    void main(String[] args) {
        System.out.println("🚀 正在尝试连接 MySQL 数据库...");

        try {
            // 调用我们刚才写的工具类获取连接
            Connection conn = JdbcUtils.getConnection();

            if (conn != null) {
                System.out.println("🎉 恭喜你！数据库连接完全成功！");
                System.out.println("打印连接对象信息: " + conn);

                // 测试完毕后，把连接还给 Druid 连接池
                conn.close();
                System.out.println("🔒 连接已安全释放。");
            }
        } catch (Exception e) {
            System.err.println("❌ 数据库连接失败！请根据下方红字报错检查：");
            System.err.println("1. 你的 MySQL 软件启动了吗？");
            System.err.println("2. druid.properties 里的账号、密码是不是写错了？");
            System.err.println("3. URL 里的数据库名字（pet_service_db）对吗？");
            // 打印具体的报错日志，方便排查
            e.printStackTrace();
        }
    }
}