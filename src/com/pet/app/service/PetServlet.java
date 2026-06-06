package com.pet.app.service; // 注意：如果你的Servlet在controller包，请改为 com.pet.app.controller

import com.pet.app.entity.Pet;
import com.pet.app.entity.User;
import com.pet.app.service.PetService; // 如果都在同一个包可以不用import这个
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/petServlet")
public class PetServlet extends HttpServlet {

    // 引入刚刚写好的业务层
    private PetService petService = new PetService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置编码，防止中文乱码（虽然Filter里可能有，但加上更保险）
        req.setCharacterEncoding("UTF-8");

        // 获取前端想执行的动作
        String action = req.getParameter("action");

        if ("list".equals(action)) {
            listPets(req, resp);
        } else if ("add".equals(action)) {
            addPet(req, resp);
        } else if ("delete".equals(action)) {
            deletePet(req, resp);
        } else {
            listPets(req, resp); // 默认查询列表
        }
    }

    // 1. 查询当前登录用户的所有宠物
    private void listPets(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            // 去数据库查属于这个人的宠物集合
            List<Pet> petList = petService.getMyPets(user.getId());
            // 把数据塞进 request 中，起个名字叫 petList
            req.setAttribute("petList", petList);
            // 转发给 JSP 页面去渲染展示
            req.getRequestDispatcher("/pet_list.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }

    // 2. 添加新宠物
    private void addPet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            // 接收表单传来的数据
            String name = req.getParameter("name");
            String type = req.getParameter("type");
            int age = Integer.parseInt(req.getParameter("age"));
            double weight = Double.parseDouble(req.getParameter("weight"));

            // 组装成 Java 对象
            Pet pet = new Pet();
            pet.setUserId(user.getId());
            pet.setName(name);
            pet.setType(type);
            pet.setAge(age);
            pet.setWeight(weight);

            // 调用 Service 存入数据库
            petService.addPet(pet);

            // 存完之后，让浏览器重新去请求一次列表页（重定向），刷新数据
            resp.sendRedirect(req.getContextPath() + "/petServlet?action=list");
        }
    }

    // 3. 删除宠物
    private void deletePet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            petService.deletePet(id);
        }
        resp.sendRedirect(req.getContextPath() + "/petServlet?action=list");
    }
}