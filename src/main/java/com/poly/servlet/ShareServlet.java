package com.poly.servlet;

import com.poly.DAO.IShareDAO;
import com.poly.DAO.IVideoDAO;
import com.poly.DAOImpl.ShareDAO;
import com.poly.DAOImpl.VideoDAO;
import com.poly.entity.User;
import com.poly.entity.Video;
import com.poly.util.EmailUtil;
import com.poly.util.SessionUtil;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet("/share")
public class ShareServlet extends HttpServlet {

    private IVideoDAO videoDAO = new VideoDAO();
    private IShareDAO shareDAO = new ShareDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ... (Code phần doGet giữ nguyên để hiển thị form)
        // Kiểm tra đăng nhập & lấy videoId để hiện form...
        if (!SessionUtil.isLogin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String videoId = request.getParameter("videoId");
        if (videoId == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        Video video = videoDAO.findById(videoId);
        request.setAttribute("video", video);
        request.getRequestDispatcher("/views/video/share.jsp").forward(request, response);
    }

    // 👇 ĐÂY LÀ CHỖ BẠN CẦN BỎ CODE VÀO 👇
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Lấy thông tin từ Form và Session
            String emailsString = request.getParameter("friendEmails"); // <-- Code bạn hỏi nằm ở đây
            String videoId = request.getParameter("videoId");
            User user = SessionUtil.getLoggedInUser(request);
            Video video = videoDAO.findById(videoId);

            if (user == null || video == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi dữ liệu.");
                return;
            }

            // 2. Chuẩn bị nội dung Email (Subject & Content)
            String videoUrl = request.getRequestURL().toString().replace(request.getRequestURI(), "")
                    + request.getContextPath() + "/detail?videoId=" + videoId;

            String subject = user.getFullname() + " đã chia sẻ video: " + video.getTitile();
            String content = "Xin chào,<br>"
                    + "Bạn của bạn là <b>" + user.getFullname() + "</b> muốn mời bạn xem video này: <br>"
                    + "<h3><a href='" + videoUrl + "'>" + video.getTitile() + "</a></h3>"
                    + "<br><i>Hãy click vào link trên để xem ngay nhé!</i>";

            // 3. Xử lý gửi mail (Tách chuỗi email và gửi từng cái)
            // Code này xử lý cho trường hợp nhập nhiều email cách nhau dấu phẩy
            String[] emailArray = emailsString.split("[,;\\s]+");

            for (String email : emailArray) {
                if (!email.isEmpty()) {
                    // 👇 Gọi hàm gửi mail từ EmailUtil bạn vừa viết
                    EmailUtil.sendEmail(email.trim(), subject, content);
                }
            }

            // 4. Ghi nhận vào Database
            shareDAO.recordShare(user, video, emailsString);

            // 5. Thông báo thành công
            request.setAttribute("message", "Đã gửi chia sẻ thành công!");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi gửi email: " + e.getMessage());
        }

        // Load lại video để hiển thị lại trang Share (tránh trang trắng)
        String videoId = request.getParameter("videoId");
        Video video = videoDAO.findById(videoId);
        request.setAttribute("video", video);

        request.getRequestDispatcher("/views/video/share.jsp").forward(request, response);
    }
}