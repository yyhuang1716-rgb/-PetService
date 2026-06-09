package com.pet.app.controller;

import com.pet.app.entity.ServiceItem;
import com.pet.app.entity.User;
import com.pet.app.service.UserFavoriteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@WebServlet("/favoriteServlet")
public class FavoriteServlet extends HttpServlet {

    private UserFavoriteService favoriteService = new UserFavoriteService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("list".equals(action)) {
            listFavorites(req, resp);
        } else if ("add".equals(action)) {
            addFavorite(req, resp);
        } else if ("remove".equals(action)) {
            removeFavorite(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/favoriteServlet?action=list");
        }
    }

    /**
     * 查看我的收藏列表
     */
    private void listFavorites(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
            return;
        }

        List<ServiceItem> favoriteList = favoriteService.getFavoritesByUserId(user.getId());
        req.setAttribute("favoriteList", favoriteList);
        req.getRequestDispatcher("/view/user/favorite_list.jsp").forward(req, resp);
    }

    /**
     * 添加收藏
     */
    private void addFavorite(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
            return;
        }

        try {
            int serviceId = Integer.parseInt(req.getParameter("serviceId"));
            boolean success = favoriteService.addFavorite(user.getId(), serviceId);

            if (success) {
                resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=list&msg=" + URLEncoder.encode("收藏成功", "UTF-8"));
            } else {
                resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=list&msg=" + URLEncoder.encode("已收藏过该服务", "UTF-8"));
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/serviceItemServlet?action=list&msg=" + URLEncoder.encode("参数错误", "UTF-8"));
        }
    }

    /**
     * 取消收藏
     */
    private void removeFavorite(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
            return;
        }

        try {
            int serviceId = Integer.parseInt(req.getParameter("serviceId"));
            favoriteService.removeFavorite(user.getId(), serviceId);
            resp.sendRedirect(req.getContextPath() + "/favoriteServlet?action=list&msg=" + URLEncoder.encode("已取消收藏", "UTF-8"));
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/favoriteServlet?action=list&msg=" + URLEncoder.encode("参数错误", "UTF-8"));
        }
    }
}
