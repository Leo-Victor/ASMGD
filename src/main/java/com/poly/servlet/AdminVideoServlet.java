package com.poly.servlet;

import com.poly.DAO.IVideoDAO;
import com.poly.DAOImpl.VideoDAO;
import com.poly.entity.Video;
import com.poly.util.BeanUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet({"/admin/videos", "/admin/videos/create", "/admin/videos/update", "/admin/videos/delete", "/admin/videos/edit"})
public class AdminVideoServlet extends HttpServlet {
    private IVideoDAO videoDAO = new VideoDAO();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uri = request.getRequestURI();
        String message = "";
        String error = "";

        try {
            if (uri.contains("edit")) {
                String id = request.getParameter("id");
                Video video = videoDAO.findById(id);
                request.setAttribute("video", video); // Đẩy video lên form
            } else if (uri.contains("create")) {
                Video video = new Video();
                BeanUtil.fillForm(request, Video.class); // Map dữ liệu từ form vào entity (cần chỉnh lại BeanUtil để trả về object hoặc dùng populate)
                // Do BeanUtil.fillForm trả về object mới, ta cần gán lại các giá trị thủ công hoặc sửa BeanUtil
                // Ở đây giả sử BeanUtil.fillForm(req, Video.class) trả về Video
                video = BeanUtil.fillForm(request, Video.class);
                videoDAO.create(video);
                message = "Thêm mới thành công!";
                request.setAttribute("video", video); // Giữ lại dữ liệu
            } else if (uri.contains("update")) {
                Video video = BeanUtil.fillForm(request, Video.class);
                videoDAO.update(video);
                message = "Cập nhật thành công!";
                request.setAttribute("video", video);
            } else if (uri.contains("delete")) {
                String id = request.getParameter("id");
                videoDAO.delete(id);
                message = "Xóa thành công!";
                request.setAttribute("video", new Video()); // Reset form
            } else if (uri.contains("reset")) {
                request.setAttribute("video", new Video());
            }
        } catch (Exception e) {
            error = "Lỗi thực hiện: " + e.getMessage();
            e.printStackTrace();
        }

        request.setAttribute("message", message);
        request.setAttribute("error", error);

        // Hiển thị danh sách video (Có thể thêm phân trang sau này)
        List<Video> list = videoDAO.findAll();
        request.setAttribute("items", list);

        request.getRequestDispatcher("/views/admin/video-management.jsp").forward(request, response);
    }
}

