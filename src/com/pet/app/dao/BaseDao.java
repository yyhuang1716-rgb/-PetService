package com.pet.app.dao;

import com.pet.app.utils.JdbcUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

/**
 * 抽象的 BaseDao，提供给具体的 Dao 继承使用
 * 封装了基本的增、删、改、查操作
 */
public abstract class BaseDao {

    // 使用 Dbutils 提供的 QueryRunner 执行 SQL 语句
    private QueryRunner queryRunner = new QueryRunner();

    /**
     * update() 方法用来执行：Insert (新增), Update (修改), Delete (删除) 语句
     * @return 返回影响的行数，如果返回 -1 说明执行失败
     */
    public int update(String sql, Object... args) {
        Connection connection = null;
        try {
            connection = JdbcUtils.getConnection();
            return queryRunner.update(connection, sql, args);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            // 注意：如果在 Service 层使用了事务，这里的 close 需要做特殊处理，
            // 但作为初学者我们先在这里稳妥地关闭它
            try {
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 查询返回一个 JavaBean 实体类的对象 (例如查询单个用户)
     * @param type 返回的对象类型
     * @param sql  执行的 SQL 语句
     * @param args SQL 对应的参数值
     * @param <T>  返回的类型的泛型
     */
    public <T> T queryForOne(Class<T> type, String sql, Object... args) {
        Connection con = null;
        try {
            con = JdbcUtils.getConnection();
            return queryRunner.query(con, sql, new BeanHandler<T>(type), args);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    /**
     * 查询返回多个 JavaBean 实体类的对象集合 (例如查询所有订单列表)
     */
    public <T> List<T> queryForList(Class<T> type, String sql, Object... args) {
        Connection con = null;
        try {
            con = JdbcUtils.getConnection();
            return queryRunner.query(con, sql, new BeanListHandler<T>(type), args);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    /**
     * 执行返回一行一列的 SQL 语句 (例如 SELECT count(*) FROM table)
     */
    public Object queryForSingleValue(String sql, Object... args) {
        Connection con = null;
        try {
            con = JdbcUtils.getConnection();
            return queryRunner.query(con, sql, new ScalarHandler<>(), args);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}