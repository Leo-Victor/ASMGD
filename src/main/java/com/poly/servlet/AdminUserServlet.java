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
    // Sử dụng Interface để khai báo
    private IUserDAO userDAO = new UserDAO();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uri = request.getRequestURI();
        String message = "";
        String error = "";

        try {
            // 1. EDIT: Đổ dữ liệu lên form
            if (uri.contains("edit")) {
                String id = request.getParameter("id");
                User user = userDAO.findById(id);
                request.setAttribute("user", user);
            }
            // 2. UPDATE: Cập nhật thông tin
            else if (uri.contains("update")) {
                User user = BeanUtil.fillForm(request, User.class);

                // Vì form không hiện password, ta phải lấy password cũ từ DB để gán lại
                User oldUser = userDAO.findById(user.getId());

                if (oldUser != null) {
                    user.setPassword(oldUser.getPassword()); // Giữ nguyên mật khẩu cũ
                    userDAO.update(user);
                    message = "Cập nhật thành công!";
                    request.setAttribute("user", user); // Giữ lại dữ liệu trên form
                } else {
                    error = "Không tìm thấy người dùng này!";
                }
            }
            // 3. DELETE: Xóa người dùng
            else if (uri.contains("delete")) {
                String id = request.getParameter("id");

                // Lấy ID người đang đăng nhập hiện tại
                User currentUser = (User) request.getSession().getAttribute("currentUser");
                String currentUserId = currentUser.getId();

                // KIỂM TRA BẢO MẬT:
                if (id.equals("admin")) {
                    error = "Không thể xóa tài khoản Quản trị viên (Super Admin)!";
                } else if (id.equals(currentUserId)) {
                    error = "Bạn không thể tự xóa chính mình!";
                } else {
                    // Nếu thỏa mãn thì mới cho xóa
                    userDAO.delete(id);
                    message = "Xóa thành công!";
                    request.setAttribute("user", new User()); // Reset form
                }
            }
            // 4. RESET: Làm mới form (Xóa trắng)
            else if (uri.contains("reset")) {
                request.setAttribute("user", new User());
            }

        } catch (Exception e) {
            e.printStackTrace();
            error = "Lỗi: " + e.getMessage();
        }

        request.setAttribute("message", message);
        request.setAttribute("error", error);

        // 5. Load danh sách User để hiển thị ra bảng
        List<User> list = userDAO.findAll();
        request.setAttribute("items", list);

        // Forward về trang giao diện
        request.getRequestDispatcher("/views/admin/user-management.jsp").forward(request, response);
    }
}