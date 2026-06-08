package com.pet.app.controller;

import com.pet.app.entity.ServiceItem;
import com.pet.app.entity.User;
import com.pet.app.service.ServiceItemService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/serviceItemServlet")
public class ServiceItemServlet extends HttpServlet {

    private ServiceItemService serviceItemService = new ServiceItemService();

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

        if ("list".equals(action)) {
            listServices(req, resp);
        } else if ("add".equals(action)) {
            addService(req, resp);
        } else if ("delete".equals(action)) {
            deleteService(req, resp);
        } else if ("manageList".equals(action)) {
            manageList(req, resp);
        } else {
            listServices(req, resp); // 默认查询列表
        }
    }

    /**
     * 查询所有服务项目
     */
    private void listServices(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 获取所有服务项目
        List<ServiceItem> serviceList = serviceItemService.getAllServices();
        // 把数据塞进 request 中
        req.setAttribute("serviceList", serviceList);
        // 转发给 JSP 页面去渲染展示
        req.getRequestDispatcher("/view/service/service_list.jsp").forward(req, resp);
    }

    /**
     * 添加新的服务项目
     */
    private void addService(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            // 接收表单传来的数据
            String title = req.getParameter("title");
            double price = Double.parseDouble(req.getParameter("price"));
            String description = req.getParameter("description");

            // 组装成 Java 对象
            ServiceItem serviceItem = new ServiceItem();
            serviceItem.setMerchantId(user.getId());
            serviceItem.setTitle(title);
            serviceItem.setPrice(price);
            serviceItem.setDescription(description);

            // 调用 Service 存入数据库
            serviceItemService.addService(serviceItem);

            // 存完之后，重定向到列表页刷新数据
            resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=list");
        }
    }

    /**
     * 商家后台 - 服务项目管理列表
     */
    private void manageList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ServiceItem> serviceList = serviceItemService.getAllServices();
        req.setAttribute("serviceList", serviceList);
        req.getRequestDispatcher("/view/merchant/service_manage.jsp").forward(req, resp);
    }

    /**
     * 删除服务项目
     */
    private void deleteService(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            serviceItemService.deleteService(id);
        }
        resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=list");
    }
}
