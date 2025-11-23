package com.poly.servlet;

import com.poly.DAO.IUserDAO;
import com.poly.DAOImpl.UserDAO;
import com.poly.entity.User;
import com.poly.util.CookieUtil;
import com.poly.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    // Sử dụng Interface để khai báo
    private IUserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //[cite_start]// Khởi đầu: Hiển thị username và password đã ghi nhớ (từ Cookie) lên form [cite: 319]
        String username = CookieUtil.getCookieValue(request, "username");
        String password = CookieUtil.getCookieValue(request, "password");

        request.setAttribute("username", username);
        request.setAttribute("password", password);

        request.getRequestDispatcher("/views/account/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy dữ liệu từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean remember = request.getParameter("remember") != null;

        // --- DEBUG: In ra console để kiểm tra dữ liệu ---
        System.out.println(">>> CHECK LOGIN:");
        System.out.println("Username nhập vào: [" + username + "]");
        System.out.println("Password nhập vào: [" + password + "]");

        try {
            //[cite_start]// 2. Kiểm tra đăng nhập trong CSDL [cite: 323]
            User user = userDAO.findByIdAndPassword(username, password);

            if (user != null) {
                // --- ĐĂNG NHẬP THÀNH CÔNG ---
                System.out.println(">>> KẾT QUẢ: Đăng nhập thành công!");

                //[cite_start]// 3. Duy trì thông tin user vào session [cite: 324]
                SessionUtil.setSession(request, SessionUtil.AUTH_USER, user);

                //[cite_start]// 4 & 5. Ghi nhớ/Xóa ghi nhớ tài khoản bằng cookie [cite: 325, 326]
                if (remember) {
                    // Lưu trong 7 ngày
                    CookieUtil.addCookie(response, "username", username, 7 * 24 * 60 * 60);
                    CookieUtil.addCookie(response, "password", password, 7 * 24 * 60 * 60);
                } else {
                    // Xóa cookie nếu không chọn Remember me
                    CookieUtil.removeCookie(response, "username");
                    CookieUtil.removeCookie(response, "password");
                }

                //[cite_start]// 6. Điều hướng (Redirect) [cite: 327]
                // Kiểm tra xem trước đó user có bị chặn ở trang nào không (ví dụ đang vào /admin thì bị đá về login)
                String securedUri = (String) SessionUtil.getSession(request, "security-uri");
                if (securedUri != null) {
                    SessionUtil.setSession(request, "security-uri", null); // Xóa session lưu uri
                    response.sendRedirect(securedUri);
                } else {
                    // Mặc định về trang chủ
                    response.sendRedirect(request.getContextPath() + "/home");
                }
            } else {
                // --- ĐĂNG NHẬP THẤT BẠI ---
                System.out.println(">>> KẾT QUẢ: Sai thông tin hoặc User không tồn tại.");

                request.setAttribute("message", "Tên đăng nhập hoặc mật khẩu không chính xác.");
                // Giữ lại username trên form để người dùng đỡ phải nhập lại
                request.setAttribute("username", username);
                request.getRequestDispatcher("/views/account/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/views/account/login.jsp").forward(request, response);
        }
    }
}
