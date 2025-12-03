package com.poly.servlet;

import com.poly.DAO.IFavoriteDAO;
import com.poly.DAO.IShareDAO;
import com.poly.DAO.IVideoDAO;
import com.poly.DAOImpl.FavoriteDAO;
import com.poly.DAOImpl.ShareDAO;
import com.poly.DAOImpl.VideoDAO;
import com.poly.entity.Favorite;
import com.poly.entity.Share;
import com.poly.entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/reports")
public class ReportServlet extends HttpServlet {
    // Sử dụng Interface và Impl chuẩn (package chữ thường)
    private IFavoriteDAO favDAO = new FavoriteDAO();
    private IVideoDAO videoDAO = new VideoDAO();
    private IShareDAO shareDAO = new ShareDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tab = request.getParameter("tab");
        if (tab == null) tab = "favorites"; // Tab mặc định

        request.setAttribute("tab", tab);

        // 1. Luôn load danh sách video để đổ vào Dropdown (Combobox) cho Tab 2 và 3
        List<Video> videoList = videoDAO.findAll();
        request.setAttribute("videos", videoList);

        // 2. Xử lý dữ liệu riêng cho từng Tab
        if (tab.equals("favorite-users")) {
            // --- TAB 2: Người yêu thích theo Video ---
            String videoId = request.getParameter("videoId");
            if (videoId != null && !videoId.isEmpty()) {
                List<Favorite> list = favDAO.findByVideoId(videoId);
                request.setAttribute("favUsers", list);
                request.setAttribute("videoId", videoId); // Giữ lại ID để selected combobox
            }
        }
        else if (tab.equals("share-friends")) {
            // --- TAB 3: Người chia sẻ theo Video ---
            String videoId = request.getParameter("videoId");
            if (videoId != null && !videoId.isEmpty()) {
                List<Share> list = shareDAO.findByVideoId(videoId);
                request.setAttribute("shareList", list);
                request.setAttribute("videoId", videoId);
            }
        }
        else {
            // --- TAB 1: Thống kê tổng hợp (MẶC ĐỊNH) ---
            // QUAN TRỌNG: Gọi hàm reportFavorites() trả về Object[] để tránh lỗi Lazy
            List<Object[]> list = videoDAO.reportFavorites();
            request.setAttribute("reportList", list);
        }

        request.getRequestDispatcher("/views/admin/reports.jsp").forward(request, response);
    }
}
