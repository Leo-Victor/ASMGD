<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập - OE Entertainment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #0f0f0f; color: white; display: flex; align-items: center; justify-content: center; height: 100vh; }
        .login-card { background-color: #1e1e1e; border: 1px solid #333; border-radius: 15px; padding: 40px; width: 100%; max-width: 450px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        .form-control { background-color: #121212; border: 1px solid #333; color: white; }
        .form-control:focus { background-color: #121212; color: white; border-color: #dc3545; box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25); }
        .btn-primary { background-color: #cc0000; border: none; font-weight: bold; }
        .btn-primary:hover { background-color: #ff0000; }
    </style>
</head>
<body>
    <div class="login-card">
        <div class="text-center mb-4">
            <h2 class="fw-bold text-danger">OE LOGIN</h2>
            <p class="text-secondary">Đăng nhập để trải nghiệm đầy đủ tính năng</p>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-danger text-center p-2 mb-3">${message}</div>
        </c:if>

        <form action="${path}/login" method="post">
            <div class="mb-3">
                <label class="form-label">Tên đăng nhập</label>
                <input type="text" name="username" class="form-control py-2" value="${username}" required placeholder="Nhập username">
            </div>
            <div class="mb-3">
                <label class="form-label">Mật khẩu</label>
                <input type="password" name="password" class="form-control py-2" value="${password}" required placeholder="Nhập password">
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" name="remember" id="remember">
                <label class="form-check-label text-secondary" for="remember">Ghi nhớ đăng nhập</label>
            </div>
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary py-2">ĐĂNG NHẬP</button>
            </div>
        </form>

        <div class="text-center mt-4 text-secondary small">
            <a href="${path}/forgot-password" class="text-decoration-none text-secondary me-3">Quên mật khẩu?</a>
            <a href="${path}/home" class="text-decoration-none text-secondary">Về trang chủ</a>
            <hr class="border-secondary">
            Chưa có tài khoản? <a href="${path}/registration" class="text-danger fw-bold text-decoration-none">Đăng ký ngay</a>
        </div>
    </div>
</body>
</html>