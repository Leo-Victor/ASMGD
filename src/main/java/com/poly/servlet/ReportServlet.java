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
    private IFavoriteDAO favDAO = new FavoriteDAO();
    private IVideoDAO videoDAO = new VideoDAO();
    private IShareDAO shareDAO = new ShareDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tab = request.getParameter("tab");
        if (tab == null) tab = "favorites"; // Tab mặc định

        request.setAttribute("tab", tab);

        // Load danh sách video để đổ vào combobox
        List<Video> videoList = videoDAO.findAll();
        request.setAttribute("videos", videoList);

        if (tab.equals("favorite-users")) {
            // Tab 2: Lọc người yêu thích theo Video
            String videoId = request.getParameter("videoId");
            if (videoId != null && !videoId.isEmpty()) {
                List<Favorite> list = favDAO.findByVideoId(videoId); // Cần thêm hàm này trong IFavoriteDAO và FavoriteDAO
                request.setAttribute("favUsers", list);
                request.setAttribute("videoId", videoId);
            }
        } else if (tab.equals("share-friends")) {
            // Tab 3: Lọc người chia sẻ theo Video
            String videoId = request.getParameter("videoId");
            if (videoId != null && !videoId.isEmpty()) {
                List<Share> list = shareDAO.findByVideoId(videoId); // Cần thêm hàm này trong IShareDAO và ShareDAO
                request.setAttribute("shareList", list);
                request.setAttribute("videoId", videoId);
            }
        } else {
            // Tab 1: Thống kê tổng hợp (Cần viết Procedure hoặc Query phức tạp, ở đây hiển thị list video tạm)
            request.setAttribute("reportList", videoList);
        }

        request.getRequestDispatcher("/views/admin/reports.jsp").forward(request, response);
    }
}
