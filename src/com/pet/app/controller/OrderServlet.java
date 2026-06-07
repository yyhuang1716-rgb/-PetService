package com.pet.app.controller;

import com.pet.app.dao.PetDao;
import com.pet.app.dao.ServiceItemDao;
import com.pet.app.entity.Pet;
import com.pet.app.entity.ServiceItem;
import com.pet.app.entity.ServiceOrder;
import com.pet.app.entity.User;
import com.pet.app.service.ServiceOrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/orderServlet")
public class OrderServlet extends HttpServlet {

    private PetDao petDao = new PetDao();
    private ServiceItemDao serviceItemDao = new ServiceItemDao();
    private ServiceOrderService serviceOrderService = new ServiceOrderService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置编码，防止中文乱码
        req.setCharacterEncoding("UTF-8");

        // 获取前端想执行的动作
        String action = req.getParameter("action");

        if ("toBook".equals(action)) {
            toBook(req, resp);
        } else if ("submitBook".equals(action)) {
            submitBook(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=list");
        }
    }

    /**
     * 跳转到预约页面
     * 获取服务项目ID和商家ID，查询用户宠物列表，转发到 book_service.jsp
     */
    private void toBook(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            // 未登录，重定向到登录页
            resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
            return;
        }

        // 获取请求参数：服务项目ID和商家ID
        String serviceItemId = req.getParameter("service_item_id");
        String merchantId = req.getParameter("merchant_id");

        if (serviceItemId != null && !serviceItemId.isEmpty()) {
            req.setAttribute("service_item_id", serviceItemId);
        }
        if (merchantId != null && !merchantId.isEmpty()) {
            req.setAttribute("merchant_id", merchantId);
        }

        // 查询当前登录用户的所有宠物
        List<Pet> petList = petDao.queryPetsByUserId(user.getId());
        req.setAttribute("petList", petList);

        // 转发到预约页面
        req.getRequestDispatcher("/view/order/book_service.jsp").forward(req, resp);
    }

    /**
     * 提交预约订单
     * 接收表单数据，封装成 ServiceOrder 对象，调用 DAO 插入数据库
     */
    private void submitBook(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
            return;
        }

        // 检查是否是 POST 提交（防止直接 GET 访问）
        if (!"POST".equalsIgnoreCase(req.getMethod())) {
            resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=list&msg=" + URLEncoder.encode("请通过表单提交预约", "UTF-8"));
            return;
        }

        try {
            // 接收表单传来的数据
            int serviceId = Integer.parseInt(req.getParameter("service_item_id"));
            int petId = Integer.parseInt(req.getParameter("pet_id"));
            String appointTimeStr = req.getParameter("appointment_time");

            // 解析预约时间字符串为 Date 对象
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date appointTime = sdf.parse(appointTimeStr);

            // 获取服务项目信息（用于快照冗余）
            ServiceItem serviceItem = serviceItemDao.queryServiceById(serviceId);

            // 组装 ServiceOrder 对象
            ServiceOrder order = new ServiceOrder();
            order.setUserId(user.getId());
            order.setPetId(petId);
            order.setServiceId(serviceId);
            if (serviceItem != null) {
                order.setTitle(serviceItem.getTitle());
                order.setPrice(serviceItem.getPrice());
                order.setDescription(serviceItem.getDescription());
            }
            order.setAppointTime(appointTime);
            order.setStatus(0); // 0 代表待接单

            // 调用 Service 层插入订单
            boolean success = serviceOrderService.createOrder(order);

            if (success) {
                // 预约成功，重定向到服务列表页
                resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=list&msg=" + URLEncoder.encode("预约成功", "UTF-8"));
            } else {
                // 预约失败，返回服务列表页
                resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=list&msg=" + URLEncoder.encode("预约失败，请重试", "UTF-8"));
            }

        } catch (NumberFormatException | ParseException e) {
            e.printStackTrace();
            // 参数解析失败，重定向并提示错误
            resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=list&msg=" + URLEncoder.encode("参数错误，请重新预约", "UTF-8"));
        }
    }
}
