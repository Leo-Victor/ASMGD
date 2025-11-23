package com.poly.Filter;

import com.poly.util.SessionUtil;
import jakarta.servlet.Filter; // Đã sửa
import jakarta.servlet.FilterChain; // Đã sửa
import jakarta.servlet.ServletException; // Đã sửa
import jakarta.servlet.ServletRequest; // Đã sửa
import jakarta.servlet.ServletResponse; // Đã sửa
import jakarta.servlet.annotation.WebFilter; // Đã sửa
import jakarta.servlet.http.HttpServletRequest; // Đã sửa
import jakarta.servlet.http.HttpServletResponse; // Đã sửa
import java.io.IOException;

@WebFilter(urlPatterns = {"/favorite", "/share", "/my-favorites", "/admin/*"})
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // Ép kiểu (Casting) từ ServletRequest/ServletResponse sang HttpServletRequest/HttpServletResponse
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        String uri = req.getRequestURI();

        // 1. Xác định: Có phải trang yêu cầu quyền Admin không?
        boolean requiresAdmin = uri.startsWith(req.getContextPath() + "/admin");

        // --- KIỂM TRA ĐĂNG NHẬP ---
        if (!SessionUtil.isLogin(req)) {
            //[cite_start]// Chưa đăng nhập: Yêu cầu đăng nhập trước khi thực hiện các tương tác [cite: 51]

            // Lưu lại URI hiện tại vào session để redirect sau khi đăng nhập thành công
            SessionUtil.setSession(req, "security-uri", uri);

            // Chuyển hướng đến trang Login
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // --- KIỂM TRA QUYỀN ADMIN (nếu cần) ---
        if (requiresAdmin) {
           // [cite_start]// Yêu cầu phải là Admin để truy cập các trang quản trị [cite: 399]
            if (!SessionUtil.isAdmin(req)) {
                // Đã đăng nhập nhưng không phải Admin: Chặn truy cập
                req.setAttribute("error", "Bạn không có quyền truy cập vào trang quản trị.");

                // Chuyển hướng đến trang lỗi (hoặc trang chủ)
                req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
                return;
            }
        }

        // Đã qua kiểm tra bảo mật: Cho phép truy cập vào tài nguyên tiếp theo
        chain.doFilter(request, response);
    }
}
