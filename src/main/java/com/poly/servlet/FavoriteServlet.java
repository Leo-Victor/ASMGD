package com.poly.servlet;

import com.poly.DAO.IFavoriteDAO;
import com.poly.DAO.IVideoDAO;
import com.poly.DAOImpl.FavoriteDAO;
import com.poly.DAOImpl.VideoDAO;
import com.poly.entity.Favorite;
import com.poly.entity.User;
import com.poly.entity.Video;
import com.poly.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Date;

@WebServlet("/favorite")
public class FavoriteServlet extends HttpServlet {

    // Sử dụng Interface để khai báo
    private IFavoriteDAO favDAO = new FavoriteDAO();
    private IVideoDAO videoDAO = new VideoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Kiểm tra bảo mật: Phải đăng nhập
        if (!SessionUtil.isLogin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Xử lý logic Like/Unlike
        String action = request.getParameter("action");
        String videoId = request.getParameter("videoId");
        User user = SessionUtil.getLoggedInUser(request); // Sửa User -> User

        if (videoId != null && user != null) {
            if ("like".equalsIgnoreCase(action)) {
                // --- LOGIC LIKE ---
                // Kiểm tra xem đã like chưa để tránh trùng lặp
                Favorite existFav = favDAO.findByUserAndVideo(user.getId(), videoId);

                if (existFav == null) {
                    Video video = videoDAO.findById(videoId);
                    if (video != null) {
                        Favorite newFav = new Favorite();
                        newFav.setUser(user);
                        newFav.setVideo(video);
                        newFav.setLikeDate(new Date()); // Ghi nhận ngày like hiện tại

                        // Gọi hàm create chuẩn của GenericDAO
                        favDAO.create(newFav);
                    }
                }
            } else if ("unlike".equalsIgnoreCase(action)) {
                // --- LOGIC UNLIKE ---
                // Tìm bản ghi Favorite cần xóa
                Favorite existFav = favDAO.findByUserAndVideo(user.getId(), videoId);

                if (existFav != null) {
                    // Gọi hàm delete chuẩn của GenericDAO (xóa theo ID của Favorite)
                    favDAO.delete(existFav.getId());
                }
            }
        }

        // 3. Chuyển hướng
        // Nếu có videoId, quay lại trang chi tiết của video đó để trải nghiệm tốt hơn
        if (videoId != null) {
            response.sendRedirect(request.getContextPath() + "/detail?videoId=" + videoId);
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}