package com.pet.app.controller;

import com.pet.app.dao.PetDao;
import com.pet.app.dao.ServiceItemDao;
import com.pet.app.entity.Pet;
import com.pet.app.entity.ServiceItem;
import com.pet.app.entity.ServiceOrder;
import com.pet.app.entity.User;
import com.pet.app.entity.UserReview;
import com.pet.app.service.ServiceOrderService;
import com.pet.app.service.UserReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/orderServlet")
public class OrderServlet extends HttpServlet {

    private PetDao petDao = new PetDao();
    private ServiceItemDao serviceItemDao = new ServiceItemDao();
    private ServiceOrderService serviceOrderService = new ServiceOrderService();
    private UserReviewService userReviewService = new UserReviewService();

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
        } else if ("myOrders".equals(action)) {
            myOrders(req, resp);
        } else if ("cancelOrder".equals(action)) {
            cancelOrder(req, resp);
        } else if ("updateRemark".equals(action)) {
            updateRemark(req, resp);
        } else if ("manageList".equals(action)) {
            manageList(req, resp);
        } else if ("acceptOrder".equals(action)) {
            acceptOrder(req, resp);
        } else if ("completeOrder".equals(action)) {
            completeOrder(req, resp);
        } else if ("serviceIng".equals(action)) {
            serviceIng(req, resp);
        } else if ("toReview".equals(action)) {
            toReview(req, resp);
        } else if ("submitReview".equals(action)) {
            submitReview(req, resp);
        } else if ("home".equals(action)) {
            home(req, resp);
        } else if ("exportReport".equals(action)) {
            exportReport(req, resp);
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
     * 查看当前登录用户的预约订单列表
     */
    private void myOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
            return;
        }

        // 调用 DAO 多表联查该用户的所有预约订单
        List<ServiceOrder> orderList = serviceOrderService.getOrdersByUserId(user.getId());
        req.setAttribute("orderList", orderList);

        // 转发到我的预约页面
        req.getRequestDispatcher("/view/order/my_orders.jsp").forward(req, resp);
    }

    /**
     * 取消预约订单
     * 将订单状态更新为 已取消，然后重定向到我的预约列表
     */
    private void cancelOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
            return;
        }

        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            boolean result = serviceOrderService.cancelOrder(orderId);
            resp.sendRedirect(req.getContextPath() + "/orderServlet?action=myOrders&msg=" + URLEncoder.encode(result ? "订单已取消" : "取消失败，请重试", "UTF-8"));
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/orderServlet?action=myOrders&msg=" + URLEncoder.encode("参数错误", "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/orderServlet?action=myOrders&msg=" + URLEncoder.encode("服务器异常，请稍后重试", "UTF-8"));
        }
    }

    /**
     * 更新订单备注
     */
    private void updateRemark(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
            return;
        }

        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            String remark = req.getParameter("remark");

            boolean result = serviceOrderService.updateOrderRemark(orderId, remark);

            if (result) {
                resp.sendRedirect(req.getContextPath() + "/orderServlet?action=myOrders&msg=" + URLEncoder.encode("备注更新成功", "UTF-8"));
            } else {
                resp.sendRedirect(req.getContextPath() + "/orderServlet?action=myOrders&msg=" + URLEncoder.encode("备注更新失败", "UTF-8"));
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/orderServlet?action=myOrders&msg=" + URLEncoder.encode("参数错误", "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/orderServlet?action=myOrders&msg=" + URLEncoder.encode("服务器异常，请稍后重试", "UTF-8"));
        }
    }

    /**
     * 跳转到商家订单管理页面
     */
    private void manageList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ServiceOrder> orderList = serviceOrderService.getAllOrders();
        req.setAttribute("orderList", orderList);
        req.setAttribute("contentPage", "orders");
        req.getRequestDispatcher("/view/merchant/home.jsp").forward(req, resp);
    }

    /**
     * 商家接单，将订单状态更新为 1（已接单）
     */
    private void acceptOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            serviceOrderService.updateOrderStatus(orderId, 1);
            resp.sendRedirect(req.getContextPath() + "/orderServlet?action=manageList");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/orderServlet?action=manageList");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/orderServlet?action=manageList");
        }
    }

    /**
     * 商家完成服务，将订单状态更新为 已完成
     */
    private void completeOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            serviceOrderService.updateOrderStatus(orderId, 3);
            resp.sendRedirect(req.getContextPath() + "/orderServlet?action=manageList");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/orderServlet?action=manageList");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/orderServlet?action=manageList");
        }
    }

    /**
     * 查看当前正在服务中的订单（已接单+服务中）
     */
    private void serviceIng(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ServiceOrder> orderList = serviceOrderService.getOrdersByServiceIng();
        req.setAttribute("orderList", orderList);
        req.setAttribute("contentPage", "serviceIng");
        req.getRequestDispatcher("/view/merchant/home.jsp").forward(req, resp);
    }

    /**
     * 商家工作台首页 - 动态加载数据看板数据
     */
    private void home(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 统计服务中宠物数量（已接单+服务中）
        long serviceIngCount = serviceOrderService.countOrdersByStatus(1)
                + serviceOrderService.countOrdersByStatus(2);
        req.setAttribute("serviceIngCount", serviceIngCount);
        req.getRequestDispatcher("/view/merchant/home.jsp").forward(req, resp);
    }

    /**
     * 导出财务报表（CSV格式）
     */
    private void exportReport(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<ServiceOrder> orderList = serviceOrderService.getAllOrders();

        // 设置响应头，以附件形式下载 CSV 文件
        resp.setContentType("text/csv;charset=UTF-8");
        resp.setHeader("Content-Disposition",
                "attachment;filename=" + URLEncoder.encode("财务报表", "UTF-8") + "_"
                        + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss")) + ".csv");

        // 写入 UTF-8 BOM，使 Excel 正确识别中文
        PrintWriter writer = resp.getWriter();
        writer.write("\uFEFF");

        // CSV 表头
        writer.println("订单号,用户名,宠物名,服务名称,价格,预约时间,订单状态,创建时间");

        // CSV 数据行
        for (ServiceOrder order : orderList) {
            // 状态码转中文
            String statusText;
            switch (order.getStatus() == null ? -1 : order.getStatus()) {
                case 0:  statusText = "待接单"; break;
                case 1:  statusText = "已接单"; break;
                case 2:  statusText = "服务中"; break;
                case 3:  statusText = "已完成"; break;
                case 4:  statusText = "已取消"; break;
                case 5:  statusText = "已评价"; break;
                default: statusText = "未知"; break;
            }

            // 处理 null 值和逗号转义
            String safeUsername = order.getUsername() == null ? "" : order.getUsername().replace(",", "，");
            String safePetName = order.getPetName() == null ? "" : order.getPetName().replace(",", "，");
            String safeServiceTitle = order.getServiceTitle() == null ? "" : order.getServiceTitle().replace(",", "，");
            String appointTimeStr = order.getAppointTime() == null ? "" : order.getAppointTime().toString().replace("T", " ");
            String createTimeStr = order.getCreateTime() == null ? "" : order.getCreateTime().toString().replace("T", " ");
            double price = order.getPrice() == null ? 0.0 : order.getPrice();

            writer.println(order.getId() + ","
                    + safeUsername + ","
                    + safePetName + ","
                    + safeServiceTitle + ","
                    + price + ","
                    + appointTimeStr + ","
                    + statusText + ","
                    + createTimeStr);
        }

        writer.flush();
    }

    /**
     * 跳转到评价页面
     */
    private void toReview(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("orderId", req.getParameter("orderId"));
        req.getRequestDispatcher("/view/order/review_add.jsp").forward(req, resp);
    }

    /**
     * 提交评价
     * 保存评价内容，同时将订单状态更新为 已评价
     */
    private void submitReview(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
            return;
        }

        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            int rating = Integer.parseInt(req.getParameter("rating"));
            String content = req.getParameter("content");

            // 创建评价对象
            UserReview review = new UserReview();
            review.setOrderId(orderId);
            review.setRating(rating);
            review.setContent(content);

            boolean reviewOk = userReviewService.submitReview(review);

            if (reviewOk) {
                // 将订单状态更新为 已评价
                serviceOrderService.updateOrderStatus(orderId, 5);
                resp.sendRedirect(req.getContextPath() + "/orderServlet?action=myOrders&msg=" + URLEncoder.encode("评价成功，感谢您的反馈！", "UTF-8"));
            } else {
                resp.sendRedirect(req.getContextPath() + "/orderServlet?action=myOrders&msg=" + URLEncoder.encode("评价提交失败，请重试", "UTF-8"));
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/orderServlet?action=myOrders&msg=" + URLEncoder.encode("参数错误", "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/orderServlet?action=myOrders&msg=" + URLEncoder.encode("服务器异常，请稍后重试", "UTF-8"));
        }
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



               // 解析预约时间字符串为 LocalDateTime 对象
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime appointTime = LocalDateTime.parse(appointTimeStr, formatter);

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
            // 新创建的订单状态默认为"待接单"
            order.setStatus(0);

            // 调用 Service 层插入订单
            boolean success = serviceOrderService.createOrder(order);

            if (success) {
                // 预约成功，重定向到服务列表页
                resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=list&msg=" + URLEncoder.encode("预约成功", "UTF-8"));
            } else {
                // 预约失败，返回服务列表页
                resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=list&msg=" + URLEncoder.encode("预约失败，请重试", "UTF-8"));
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            // 参数解析失败，重定向并提示错误
            resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=list&msg=" + URLEncoder.encode("参数错误，请重新预约", "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            // 时间解析失败或其他异常
            resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=list&msg=" + URLEncoder.encode("时间格式错误，请重新预约", "UTF-8"));
        }
    }
}
