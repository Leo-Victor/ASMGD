package com.poly.servlet;

import com.poly.DAO.IUserDAO;
import com.poly.DAOImpl.UserDAO;
import com.poly.entity.User;
import com.poly.util.EmailUtil;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/forgot-password") // <--- Quan trọng: Dòng này giúp Tomcat nhận diện đường dẫn
public class ForgotPasswordServlet extends HttpServlet {

    private IUserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng sang trang giao diện nhập email
        request.getRequestDispatcher("/views/account/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");

        try {
            // 1. Kiểm tra thông tin
            User user = userDAO.findByUsernameAndEmail(username, email);

            if (user == null) {
                request.setAttribute("error", "Tên đăng nhập hoặc Email không chính xác!");
            } else {
                // 2. Gửi mật khẩu qua email
                String subject = "Lấy lại mật khẩu - OE Entertainment";
                String content = "Xin chào " + user.getFullname() + ",<br>"
                        + "Mật khẩu của bạn là: <b style='color:red'>" + user.getPassword() + "</b><br>"
                        + "Vui lòng đăng nhập và đổi mật khẩu ngay để bảo mật.";

                EmailUtil.sendEmail(user.getEmail(), subject, content);
                request.setAttribute("message", "Mật khẩu đã được gửi về email của bạn!");
            }
        } catch (MessagingException e) {
            request.setAttribute("error", "Lỗi gửi mail: " + e.getMessage());
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }

        // Quay lại trang cũ để hiện thông báo
        request.getRequestDispatcher("/views/account/forgot-password.jsp").forward(request, response);
    }
}