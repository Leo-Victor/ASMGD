package com.poly.servlet;

import com.poly.DAO.IVideoDAO;
import com.poly.DAOImpl.VideoDAO;
import com.poly.entity.Video;
import com.poly.util.CookieUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    // Sử dụng Interface để khai báo
    private IVideoDAO videoDAO = new VideoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- A. XỬ LÝ KHI NGƯỜI DÙNG CLICK VÀO POSTER ĐỂ XEM VIDEO ---
        String videoId = request.getParameter("videoId");

        if (videoId != null) {
            // 1. Tăng Views
            videoDAO.incrementViews(videoId);

            // 2. Ghi nhận lịch sử xem (Cookie)
            String history = CookieUtil.getCookieValue(request, "history");

            if (history == null) {
                history = videoId;
            } else {
                // Cộng dồn ID video vào cookie nếu chưa có
                if (!history.contains(videoId)) {
                    history += "," + videoId;
                }
            }
            // Lưu cookie trong 7 ngày
            CookieUtil.addCookie(response, "history", history, 60 * 60 * 24 * 7);

            // 3. Chuyển hướng sang trang chi tiết
            response.sendRedirect(request.getContextPath() + "/detail?videoId=" + videoId);
            return; // Dừng xử lý để không chạy phần load danh sách bên dưới
        }

        // --- B. XỬ LÝ HIỂN THỊ DANH SÁCH & PHÂN TRANG ---

        // 1. Lấy tham số từ URL
        String type = request.getParameter("type");
        String pageParam = request.getParameter("page");

        // 2. Thiết lập phân trang
        int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1; // Mặc định trang 1
        int pageSize = 6; // Mỗi trang hiện 6 video
        int totalPages = 1; // Mặc định là 1 trang

        List<Video> videos;
        String title;

        if ("trending".equals(type)) {
            // --- TAB THỊNH HÀNH ---
            // Lấy Top 6 xem nhiều nhất (Coi như chỉ có 1 trang)
            videos = videoDAO.findTopVideosByViews(6);
            title = "Video Thịnh Hành";
            totalPages = 1;
        } else {
            // --- TAB TRANG CHỦ (MẶC ĐỊNH) ---
            // Lấy video mới nhất CÓ PHÂN TRANG
            // (Bạn cần đảm bảo đã thêm hàm findAllActive(page, pageSize) vào VideoDAO)
            videos = videoDAO.findAllActive(page, pageSize);
            title = "Video Mới Cập Nhật";

            // Tính tổng số trang để hiển thị nút 1, 2, 3...
            long totalVideos = videoDAO.countActive();
            totalPages = (int) Math.ceil((double) totalVideos / pageSize);
        }

        // --- C. GỬI DỮ LIỆU SANG JSP ---
        request.setAttribute("videos", videos);         // Danh sách video
        request.setAttribute("pageTitle", title);       // Tiêu đề Banner
        request.setAttribute("currentType", type);      // Để Active menu (tô đậm tab)

        // Gửi thông tin phân trang
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // Forward ra View
        request.getRequestDispatcher("/views/video/home.jsp").forward(request, response);
    }
}
