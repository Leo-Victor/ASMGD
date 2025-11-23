package com.poly.servlet;

import com.poly.DAOImpl.VideoDAO;
import com.poly.entity.Video;
import com.poly.util.CookieUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/detail")
public class DetailServlet extends HttpServlet {
    private VideoDAO videoDAO = new VideoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String videoId = request.getParameter("videoId");
        if (videoId == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // 1. Hiển thị thông tin chi tiết của tiểu phẩm
        Video video = videoDAO.findById(videoId);
        if (video == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Video không tồn tại.");
            return;
        }
        request.setAttribute("video", video);

        // 2. Hiển thị các tiểu phẩm đã xem (lấy từ cookie)
        String history = CookieUtil.getCookieValue(request, "history");
        List<Video> historyVideos = new ArrayList<>();
        if (history != null && !history.isEmpty()) {
            // Tách các ID video đã xem, loại bỏ video hiện tại, và lấy thông tin
            List<String> videoIds = Arrays.asList(history.split(","));
            for (String id : videoIds) {
                if (!id.equals(videoId)) {
                    Video hisVideo = videoDAO.findById(id);
                    if (hisVideo != null) {
                        historyVideos.add(hisVideo);
                    }
                }
            }
        }
        request.setAttribute("historyVideos", historyVideos);

        request.getRequestDispatcher("/views/video/detail.jsp").forward(request, response);
    }
}
