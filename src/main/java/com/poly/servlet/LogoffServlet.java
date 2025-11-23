package com.poly.servlet;

import com.poly.util.SessionUtil;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/logoff")
public class LogoffServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // Đăng xuất: Xóa Session
        SessionUtil.invalidate(request);

        // Trở về trang chủ
        response.sendRedirect(request.getContextPath() + "/home");
    }
}
