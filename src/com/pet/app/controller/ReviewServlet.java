package com.pet.app.controller;

import com.pet.app.entity.User;
import com.pet.app.entity.UserReview;
import com.pet.app.entity.ServiceOrder;
import com.pet.app.service.ServiceOrderService;
import com.pet.app.service.UserReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/reviewServlet")
public class ReviewServlet extends HttpServlet {

    private UserReviewService userReviewService = new UserReviewService();
    private ServiceOrderService serviceOrderService = new ServiceOrderService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            add(req, resp);
        } else if ("merchantList".equals(action)) {
            merchantList(req, resp);
        } else if ("myReviews".equals(action)) {
            myReviews(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/orderServlet?action=myOrders");
        }
    }

    /**
     * 商家查看所有客户评价
     */
    private void merchantList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole() != 1) {
            resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
            return;
        }

        java.util.List<ServiceOrder> list = userReviewService.getAllReviews();
        req.setAttribute("reviewList", list);
        req.getRequestDispatcher("/view/order/merchant_reviews.jsp").forward(req, resp);
    }

    /**
     * 用户查看自己的全部评价
     */
    private void myReviews(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
            return;
        }

        java.util.List<ServiceOrder> reviewList = serviceOrderService.getReviewedOrdersByUserId(user.getId());
        req.setAttribute("reviewList", reviewList);
        req.getRequestDispatcher("/view/order/my_reviews.jsp").forward(req, resp);
    }

    /**
     * 提交评价
     * 保存评价到 user_review 表，并将订单状态从 已完成 更新为 已评价
     */
    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/view/user/login.jsp");
            return;
        }

        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            int rating = Integer.parseInt(req.getParameter("rating"));
            String comment = req.getParameter("comment");

            // 创建评价对象
            UserReview review = new UserReview();
            review.setOrderId(orderId);
            review.setRating(rating);
            review.setContent(comment);

            boolean reviewOk = userReviewService.submitReview(review);

            if (reviewOk) {
                // 保存成功，将订单状态从 2（已完成）更新为 3（已评价）
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
}
