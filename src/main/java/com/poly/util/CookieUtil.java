package com.poly.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

public class CookieUtil {
    // Thêm Cookie
    public static Cookie addCookie(HttpServletResponse resp, String name, String value, int maxAge) {
        try {
            // Encode giá trị để tránh lỗi ký tự đặc biệt
            String encodedValue = URLEncoder.encode(value, "UTF-8");
            Cookie cookie = new Cookie(name, encodedValue);
            cookie.setMaxAge(maxAge);
            cookie.setPath("/"); // Áp dụng cho toàn bộ domain
            resp.addCookie(cookie);
            return cookie;
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("Lỗi Encode Cookie: " + e.getMessage());
        }
    }

    // Đọc giá trị Cookie
    public static String getCookieValue(HttpServletRequest req, String name) {
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equalsIgnoreCase(name)) {
                    try {
                        // Decode giá trị trước khi trả về
                        return URLDecoder.decode(cookie.getValue(), "UTF-8");
                    } catch (UnsupportedEncodingException e) {
                        return null; // Trả về null nếu decode thất bại
                    }
                }
            }
        }
        return null;
    }

    // Xóa Cookie
    public static void removeCookie(HttpServletResponse resp, String name) {
        Cookie cookie = new Cookie(name, "");
        cookie.setMaxAge(0); // Đặt MaxAge = 0 để xóa ngay lập tức
        cookie.setPath("/");
        resp.addCookie(cookie);
    }
}
