package com.pet.app.utils;

import com.alibaba.druid.pool.DruidDataSourceFactory;
import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

public class JdbcUtils {

    // 定义一个静态的数据源变量
    private static DataSource dataSource;

    // 使用静态代码块，在类加载时只执行一次，初始化连接池
    static {
        try {
            // 1. 创建属性配置对象
            Properties props = new Properties();
            // 2. 利用类加载器读取 src 下的 druid.properties 文件
            InputStream is = JdbcUtils.class.getClassLoader().getResourceAsStream("druid.properties");
            props.load(is);
            // 3. 通过 Druid 的工厂类创建数据源（连接池）
            dataSource = DruidDataSourceFactory.createDataSource(props);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("初始化数据库连接池失败，请检查配置文件！");
        }
    }

    /**
     * 获取数据源（提供给后面的 Dbutils 使用）
     */
    public static DataSource getDataSource() {
        return dataSource;
    }

    /**
     * 从连接池中获取一个数据库连接
     */
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}