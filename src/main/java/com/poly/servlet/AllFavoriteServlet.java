package com.poly.servlet;

import com.poly.DAO.IFavoriteDAO;
import com.poly.DAOImpl.FavoriteDAO;
import com.poly.entity.Favorite;
import com.poly.util.XJPA;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/all-favorites")
public class AllFavoriteServlet extends HttpServlet {
    // Khai báo bằng Interface, Khởi tạo bằng Class Impl
    // Không cần truyền EntityManager vào constructor vì DAO tự xử lý qua JPAUtil
    private IFavoriteDAO favoriteDAO = new FavoriteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // (Tùy chọn) Kiểm tra đăng nhập nếu trang này yêu cầu bảo mật
            /*
            if (!SessionUtil.isLogin(request)) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            */

            // 1. Truy vấn tất cả các Favorites (Hàm findAll đã có trong AbstractDAO)
            List<Favorite> favorites = favoriteDAO.findAll();

            // 2. Đưa dữ liệu vào request
            request.setAttribute("favorites", favorites);

            // 3. Forward sang trang hiển thị (Đảm bảo đường dẫn file JSP đúng)
            // Theo cấu trúc thư mục trước đó, file này nên là views/video/favorites.jsp
            request.getRequestDispatcher("/views/video/favorites.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi truy xuất dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
        }
    }
}
