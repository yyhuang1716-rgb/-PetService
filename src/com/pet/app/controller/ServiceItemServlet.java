package com.pet.app.controller;

import com.pet.app.entity.PageBean;
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
import java.util.Objects;

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
        } else if ("toAdd".equals(action)) {
            toAdd(req, resp);
        } else if ("delete".equals(action)) {
            deleteService(req, resp);
        } else if ("toEdit".equals(action)) {
            toEdit(req, resp);
        } else if ("edit".equals(action)) {
            editService(req, resp);
        } else if ("manageList".equals(action)) {
            manageList(req, resp);
        } else {
            listServices(req, resp); // 默认查询列表
        }
    }

    /**
     * 查询所有服务项目（分页），支持按类型过滤
     */
    private void listServices(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        int size = 6;
        String pageStr = req.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            page = Integer.parseInt(pageStr);
        }

        // 获取类型参数
        String type = req.getParameter("type");
        PageBean<ServiceItem> pageBean;
        if (type != null && !type.trim().isEmpty()) {
            pageBean = serviceItemService.getServicesPageByType(type, page, size);
        } else {
            pageBean = serviceItemService.getServicesPage(page, size);
        }
        req.setAttribute("pageBean", pageBean);
        req.setAttribute("serviceList", pageBean.getList());
        req.setAttribute("currentType", type);

        // 查询所有服务类型，供分类标签栏使用
        List<String> types = serviceItemService.getDistinctTypes();
        req.setAttribute("typeList", types);

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
            String type = req.getParameter("type");
            double price = Double.parseDouble(req.getParameter("price"));
            String description = req.getParameter("description");

            // 组装成 Java 对象
            ServiceItem serviceItem = new ServiceItem();
            serviceItem.setMerchantId(user.getId());
            serviceItem.setTitle(title);
            serviceItem.setType(type);
            serviceItem.setPrice(price);
            serviceItem.setDescription(description);

            // 调用 Service 存入数据库
            serviceItemService.addService(serviceItem);

            // 存完之后，重定向到商家管理列表页刷新数据
            resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=manageList");
        }
    }

    /**
     * 跳转到商家发布新服务页面
     */
    private void toAdd(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("contentPage", "serviceAdd");
        req.getRequestDispatcher("/view/merchant/home.jsp").forward(req, resp);
    }

    /**
     * 商家后台 - 服务项目管理列表
     */
    private void manageList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<ServiceItem> serviceList;
        if (keyword != null && !keyword.trim().isEmpty()) {
            serviceList = serviceItemService.getServicesByKeyword(keyword.trim());
        } else {
            serviceList = serviceItemService.getAllServices();
        }
        req.setAttribute("serviceList", serviceList);
        req.setAttribute("contentPage", "services");
        req.getRequestDispatcher("/view/merchant/home.jsp").forward(req, resp);
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
        resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=manageList");
    }

    /**
     * 跳转到编辑服务页面
     */
    private void toEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            ServiceItem serviceItem = serviceItemService.getServiceById(id);
            req.setAttribute("serviceItem", serviceItem);
        }
        req.setAttribute("contentPage", "serviceEdit");
        req.getRequestDispatcher("/view/merchant/home.jsp").forward(req, resp);
    }

    /**
     * 提交编辑服务
     */
    private void editService(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            String name = req.getParameter("name");
            String type = req.getParameter("type");
            double price = Double.parseDouble(req.getParameter("price"));
            String description = req.getParameter("description");

            ServiceItem serviceItem = new ServiceItem();
            serviceItem.setId(id);
            serviceItem.setName(name);
            serviceItem.setType(type);
            serviceItem.setPrice(price);
            serviceItem.setDescription(description);

            serviceItemService.updateService(serviceItem);
        }
        resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=manageList");
    }
}
