package com.pet.app.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * 拦截未登录用户的后端过滤器
 * 检查用户是否已登录，未登录则重定向到登录页面
 */
@WebFilter("/*")
public class AuthFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        // 1. 获取请求路径（去掉上下文路径）
        String path = req.getRequestURI().substring(req.getContextPath().length());

        // 2. 白名单判断 —— 不需要登录也能访问的资源
        if (isExcluded(path)) {
            chain.doFilter(req, res);
            return;
        }

        // 3. 检查 Session 中是否有用户信息
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            // 已登录，放行
            chain.doFilter(req, res);
        } else {
            // 未登录，重定向到登录页面
            res.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
        }
    }

    /**
     * 判断请求路径是否在白名单中（无需登录即可访问）
     */
    private boolean isExcluded(String path) {
        // 首页
        if ("/".equals(path) || "/index.jsp".equals(path)) {
            return true;
        }
        // 登录 / 注册页面
        if ("/view/user/login.jsp".equals(path) || "/view/user/register.jsp".equals(path)) {
            return true;
        }
        // 登录 / 注册请求（由 UserServlet 根据 action 参数区分）
        if ("/userServlet".equals(path)) {
            return true;
        }
        // 宠物相关页面
        if ("/petServlet".equals(path)) {
            return true;
        }
        // 服务项目相关页面
        if ("/serviceItemServlet".equals(path)) {
            return true;
        }
        // 订单相关页面
        if ("/orderServlet".equals(path)) {
            return true;
        }
        // 静态资源（CSS/JS/图片等）
        if (path.startsWith("/static/") || path.startsWith("/assets/")) {
            return true;
        }
        return false;
    }
}
