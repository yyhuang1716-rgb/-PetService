package com.pet.app.listener;

import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

@WebListener
public class OnlineUserCounterListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        ServletContext ctx = se.getSession().getServletContext();
        Integer count = (Integer) ctx.getAttribute("onlineCount");
        if (count == null) {
            count = 0;
        }
        ctx.setAttribute("onlineCount", count + 1);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        ServletContext ctx = se.getSession().getServletContext();
        Integer count = (Integer) ctx.getAttribute("onlineCount");
        if (count != null && count > 0) {
            ctx.setAttribute("onlineCount", count - 1);
        }
    }
}
