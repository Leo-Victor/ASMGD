package com.poly.servlet;

import com.poly.DAO.IUserDAO;
import com.poly.DAOImpl.UserDAO;
import com.poly.entity.User;
import com.poly.util.BeanUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet({"/admin/users", "/admin/users/update", "/admin/users/delete", "/admin/users/edit"})
public class AdminUserServlet extends HttpServlet {
    private IUserDAO userDAO = new UserDAO();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uri = request.getRequestURI();
        String message = "";

        try {
            if (uri.contains("edit")) {
                String id = request.getParameter("id");
                User user = userDAO.findById(id);
                request.setAttribute("user", user);
            } else if (uri.contains("update")) {
                User user = BeanUtil.fillForm(request, User.class);
                // Vì BeanUtil tạo mới, cần lấy password cũ nếu form không gửi pass
                User oldUser = userDAO.findById(user.getId());
                user.setPassword(oldUser.getPassword()); // Giữ nguyên pass

                userDAO.update(user);
                message = "Cập nhật thành công!";
                request.setAttribute("user", user);
            } else if (uri.contains("delete")) {
                String id = request.getParameter("id");
                userDAO.delete(id);
                message = "Xóa thành công!";
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
        }

        request.setAttribute("message", message);

        // Load danh sách
        List<User> list = userDAO.findAll();
        request.setAttribute("items", list);

        request.getRequestDispatcher("/views/admin/user-management.jsp").forward(request, response);
    }
}