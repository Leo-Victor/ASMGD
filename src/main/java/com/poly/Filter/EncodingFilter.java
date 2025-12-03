package com.poly.Filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;

import java.io.IOException;

@WebFilter("/*")
public class EncodingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // 1. Ép mã hóa đầu vào (Request) sang UTF-8
        // Giúp đọc được dữ liệu tiếng Việt từ Form
        request.setCharacterEncoding("UTF-8");

        // 2. Ép mã hóa đầu ra (Response) sang UTF-8
        // Giúp hiển thị tiếng Việt đúng trên trình duyệt
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // 3. Cho phép đi tiếp
        chain.doFilter(request, response);
    }
}