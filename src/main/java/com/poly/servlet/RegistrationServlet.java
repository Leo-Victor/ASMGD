package com.poly.servlet;

import com.poly.DAO.IUserDAO;
import com.poly.DAOImpl.UserDAO;
import com.poly.entity.User;
import com.poly.util.BeanUtil;
import com.poly.util.EmailUtil;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/registration")
public class RegistrationServlet extends HttpServlet {

    // Sử dụng Interface để khai báo biến
    private IUserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị form đăng ký [cite: 328]
        request.getRequestDispatcher("/views/account/registration.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 1. Map dữ liệu form vào Entity User (Sửa User -> User)
            User user = BeanUtil.fillForm(request, User.class);

            // 2. Kiểm tra tên đăng nhập đã tồn tại chưa [cite: 323]
            // Vì không có hàm exists, ta dùng findById kiểm tra null
            if (userDAO.findById(user.getId()) != null) {
                request.setAttribute("message", "Tên đăng nhập đã tồn tại.");
                request.getRequestDispatcher("/views/account/registration.jsp").forward(request, response);
                return;
            }

            // Thiết lập mặc định là User thường (không phải Admin)
            user.setAdmin(false);

            // 3. Thêm mới người dùng vào CSDL [cite: 340]
            // Sử dụng hàm 'create' thay vì 'insert' theo chuẩn IGenericDAO
            userDAO.create(user);

            // 4. Gửi email chào mừng [cite: 55, 340]
            String subject = "Chào mừng đến với ONLINE ENTERTAINMENT!";
            String content = "Xin chào " + user.getFullname() + ", cảm ơn bạn đã đăng ký tài khoản thành công!";

            // Bọc trong try-catch riêng để nếu lỗi gửi mail thì vẫn báo đăng ký thành công
            try {
                EmailUtil.sendEmail(user.getEmail(), subject, content);
                request.setAttribute("message", "Đăng ký thành công! Email chào mừng đã được gửi.");
            } catch (MessagingException e) {
                request.setAttribute("message", "Đăng ký thành công nhưng gửi email thất bại: " + e.getMessage());
            }

            // Chuyển hướng về trang đăng nhập hoặc hiển thị thông báo thành công
            // Nếu dùng forward thì giữ nguyên dữ liệu để user đỡ phải nhập lại nếu muốn sửa
            request.getRequestDispatcher("/views/account/login.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Đăng ký thất bại: " + e.getMessage());
            request.getRequestDispatcher("/views/account/registration.jsp").forward(request, response);
        }
    }
}