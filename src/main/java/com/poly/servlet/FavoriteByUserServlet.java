package com.poly.servlet;

import com.poly.DAO.IFavoriteDAO;
import com.poly.DAO.IUserDAO;
import com.poly.DAOImpl.FavoriteDAO;
import com.poly.DAOImpl.UserDAO;
import com.poly.entity.Favorite;
import com.poly.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/favorite-by-user")
public class FavoriteByUserServlet extends HttpServlet {

    // Khai báo các DAO cần thiết bằng Interface
    private IUserDAO userDAO = new UserDAO();
    private IFavoriteDAO favoriteDAO = new FavoriteDAO();

    // Giả định ID người dùng (Trong thực tế nên lấy từ Session hoặc tham số request)
    private static final String USER_ID = "teonv";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Lấy thông tin người dùng
            User user = userDAO.findById(USER_ID);

            if (user != null) {
                // 2. Lấy danh sách Favorite thông qua DAO riêng biệt
                // Cách này an toàn hơn user.getFavorites() vì tránh được lỗi LazyInitializationException
                List<Favorite> favorites = favoriteDAO.findByUser(USER_ID);

                // 3. Đưa dữ liệu vào request
                request.setAttribute("user", user);
                request.setAttribute("favorites", favorites);

                // 4. Forward sang trang hiển thị
                // Đảm bảo bạn đã tạo file này tại: src/main/webapp/views/video/favorites.jsp
                // (Tôi điều chỉnh đường dẫn cho khớp với cấu trúc thư mục đã thống nhất)
                request.getRequestDispatcher("/views/video/favorites.jsp").forward(request, response);
            } else {
                // Xử lý khi không tìm thấy user
                request.setAttribute("error", "Không tìm thấy người dùng có ID: " + USER_ID);
                request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }
}