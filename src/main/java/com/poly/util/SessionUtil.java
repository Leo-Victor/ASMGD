package com.poly.util;

import com.poly.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {
    public static final String AUTH_USER = "currentUser";

    // Lấy đối tượng User từ Session
    public static Object getSession(HttpServletRequest req, String key) {
        HttpSession session = req.getSession();
        return session.getAttribute(key);
    }

    // Đặt đối tượng vào Session
    public static void setSession(HttpServletRequest req, String key, Object value) {
        HttpSession session = req.getSession();
        session.setAttribute(key, value);
    }

    // Xóa Session
    public static void invalidate(HttpServletRequest req) {
        HttpSession session = req.getSession();
        session.invalidate();
    }

    // Kiểm tra đã đăng nhập chưa
    public static boolean isLogin(HttpServletRequest req) {
        return getSession(req, AUTH_USER) != null;
    }

    // Kiểm tra có phải Admin không
    public static boolean isAdmin(HttpServletRequest req) {
        Object userObj = getSession(req, AUTH_USER);
        if (userObj instanceof User) {
            User user = (User) userObj;
            return user.getAdmin(); // Giả sử entity.User có getter getAdmin()
        }
        return false;
    }

    // Lấy User đang đăng nhập
    public static User getLoggedInUser(HttpServletRequest req) {
        return (User) getSession(req, AUTH_USER);
    }
}
