<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký - OE Entertainment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #0f0f0f; color: white; display: flex; align-items: center; justify-content: center; min-height: 100vh; }
        .register-card { background-color: #1e1e1e; border: 1px solid #333; border-radius: 15px; padding: 40px; width: 100%; max-width: 500px; }
        .form-control { background-color: #121212; border: 1px solid #333; color: white; }
        .form-control:focus { background-color: #121212; color: white; border-color: #198754; box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.25); }
    </style>
</head>
<body>
    <div class="register-card">
        <div class="text-center mb-4">
            <h2 class="fw-bold text-success">TẠO TÀI KHOẢN</h2>
            <p class="text-secondary">Tham gia cộng đồng OE Entertainment</p>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-info text-center p-2 mb-3">${message}</div>
        </c:if>

        <form action="${path}/registration" method="post">
            <div class="mb-3">
                <label class="form-label">Tên đăng nhập</label>
                <input type="text" name="id" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Họ và Tên</label>
                <input type="text" name="fullname" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Mật khẩu</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <div class="d-grid gap-2 mt-4">
                <button type="submit" class="btn btn-success fw-bold py-2">ĐĂNG KÝ</button>
                <a href="${path}/login" class="btn btn-outline-secondary">Đã có tài khoản? Đăng nhập</a>
            </div>
        </form>
    </div>
</body>
</html>