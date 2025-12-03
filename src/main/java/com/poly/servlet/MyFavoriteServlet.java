package com.poly.servlet;

import com.poly.DAO.IFavoriteDAO;
import com.poly.DAOImpl.FavoriteDAO;
import com.poly.entity.Favorite;
import com.poly.entity.User;
import com.poly.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/my-favorites")
public class MyFavoriteServlet extends HttpServlet {

    private IFavoriteDAO favDAO = new FavoriteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Bắt buộc đăng nhập
        if (!SessionUtil.isLogin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Lấy User hiện tại
        User user = SessionUtil.getLoggedInUser(request);

        // 3. Lấy danh sách video đã thích của User này
        List<Favorite> list = favDAO.findByUser(user.getId());
        request.setAttribute("favorites", list);

        // 4. Forward sang giao diện
        request.getRequestDispatcher("/views/video/favorites.jsp").forward(request, response);
    }
}