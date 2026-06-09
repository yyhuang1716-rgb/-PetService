package com.pet.app.controller;
import com.pet.app.entity.User;
import com.pet.app.service.UserService;

// 注意这里一定是 jakarta，不能是 javax！
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// 这个注解非常重要！它定义了浏览器访问这个 Servlet 的网址路径
@WebServlet("/userServlet")
public class UserServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 设置请求和响应的中文编码，防止乱码
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // 2. 获取前端传来的“动作”指令（判断是来登录的，还是来注册的）
        String action = req.getParameter("action");

        if ("login".equals(action)) {
            // ==== 处理登录请求 ====
            String username = req.getParameter("username");
            String password = req.getParameter("password");

            User loginUser = userService.login(username, password);
            if (loginUser != null) {
                // 登录成功：把用户信息存进 Session（这样后续在这个浏览器里就能一直保持登录状态了）
                req.getSession().setAttribute("user", loginUser);
                // 根据角色分流：0-普通用户跳转宠物列表，1-商家跳转首页
                if (loginUser.getRole() == 0) {
                    resp.sendRedirect(req.getContextPath() + "/petServlet?action=list");
                } else if (loginUser.getRole() == 1) {
                    resp.sendRedirect(req.getContextPath() + "/view/merchant/home.jsp");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/view/merchant/home.jsp");
                }
            } else {
                // 登录失败：跳转回登录页并显示错误信息
                req.setAttribute("error", "用户名或密码错误！");
                req.getRequestDispatcher("/view/user/login.jsp").forward(req, resp);
            }

        } else if ("register".equals(action)) {
            // ==== 处理注册请求 ====
            // 仅接受 POST 方式提交注册，直接 GET 访问则转发到注册页面
            if (!"POST".equalsIgnoreCase(req.getMethod())) {
                req.getRequestDispatcher("/view/user/register.jsp").forward(req, resp);
                return;
            }

            User newUser = new User();
            newUser.setUsername(req.getParameter("username"));
            newUser.setPassword(req.getParameter("password"));
            newUser.setPhone(req.getParameter("phone"));
            // 为了演示，前端传来的 role (0或1)，转换成数字存入
            newUser.setRole(Integer.parseInt(req.getParameter("role")));

            boolean isSuccess = userService.registerUser(newUser);
            if (isSuccess) {
                // 注册成功：跳转到登录页
                resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp?msg=注册成功，请登录");
            } else {
                // 注册失败：返回注册页并显示错误
                req.setAttribute("error", "该用户名已经被占用了！");
                req.getRequestDispatcher("/view/user/register.jsp").forward(req, resp);
            }
        } else if ("logout".equals(action)) {
            // ==== 处理退出登录请求 ====
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath() + "/index.jsp");

        } else if ("updateProfile".equals(action)) {
            // ==== 处理修改个人信息 ====
            updateProfile(req, resp);
        }
    }

    /**
     * 修改个人信息（手机号和密码）
     */
    private void updateProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 检查是否已登录
        User loginUser = (User) req.getSession().getAttribute("user");
        if (loginUser == null) {
            resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
            return;
        }

        // 2. 获取表单数据
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");

        // 3. 如果密码为空，则沿用旧密码
        if (password == null || password.trim().isEmpty()) {
            password = loginUser.getPassword();
        }

        // 4. 调用 Service 更新数据库
        boolean success = userService.updateUserInfo(loginUser.getId(), phone, password);

        if (success) {
            // 5. 更新成功后，重新从数据库拉取最新用户信息，刷新 Session
            User updatedUser = userService.getUserById(loginUser.getId());
            req.getSession().setAttribute("user", updatedUser);
            resp.sendRedirect(req.getContextPath() + "/view/user/profile.jsp?msg=" + java.net.URLEncoder.encode("个人信息修改成功！", "UTF-8"));
        } else {
            resp.sendRedirect(req.getContextPath() + "/view/user/profile.jsp?error=" + java.net.URLEncoder.encode("修改失败，请重试", "UTF-8"));
        }
    }

    // 如果浏览器发来的是 GET 请求，也统统交给 doPost 处理
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}