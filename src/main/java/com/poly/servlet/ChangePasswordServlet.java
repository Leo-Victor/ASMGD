package com.poly.servlet;

import com.poly.DAO.IUserDAO;
import com.poly.DAOImpl.UserDAO;
import com.poly.entity.User;
import com.poly.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {
    private IUserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!SessionUtil.isLogin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.getRequestDispatcher("/views/account/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = SessionUtil.getLoggedInUser(request);
        String currentPass = request.getParameter("currentPassword");
        String newPass = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmNewPassword");

        String message = "";
        String error = "";

        if (!user.getPassword().equals(currentPass)) {
            error = "Mật khẩu hiện tại không đúng!";
        } else if (!newPass.equals(confirmPass)) {
            error = "Mật khẩu mới không khớp!";
        } else {
            user.setPassword(newPass);
            userDAO.update(user);
            message = "Đổi mật khẩu thành công!";
            SessionUtil.setSession(request, SessionUtil.AUTH_USER, user);
        }

        request.setAttribute("message", message);
        request.setAttribute("error", error);
        request.getRequestDispatcher("/views/account/change-password.jsp").forward(request, response);
    }
}