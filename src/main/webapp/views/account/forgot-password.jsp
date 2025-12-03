<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu - OE Entertainment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        /* Căn giữa màn hình */
        body {
            background-color: #0f0f0f;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            font-family: sans-serif;
        }

        /* Thẻ Card chứa form */
        .auth-card {
            background-color: #1e1e1e;
            border: 1px solid #333;
            border-radius: 15px;
            padding: 40px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }

        /* Input tối màu */
        .form-control {
            background-color: #121212;
            border: 1px solid #333;
            color: white;
        }
        .form-control:focus {
            background-color: #121212;
            color: white;
            border-color: #ffc107; /* Màu vàng */
            box-shadow: 0 0 0 0.25rem rgba(255, 193, 7, 0.25);
        }

        /* Nút bấm */
        .btn-warning { font-weight: bold; color: #000; }
        .btn-warning:hover { background-color: #ffca2c; }
    </style>
</head>
<body>
    <div class="auth-card">
        <div class="text-center mb-4">
            <h2 class="fw-bold text-warning"><i class="bi bi-shield-lock"></i> KHÔI PHỤC MẬT KHẨU</h2>
            <p class="text-secondary small">Nhập thông tin tài khoản để nhận lại mật khẩu qua email.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center p-2 mb-3" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i> ${error}
            </div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="alert alert-success text-center p-2 mb-3" role="alert">
                <i class="bi bi-check-circle-fill"></i> ${message}
            </div>
        </c:if>

        <form action="${path}/forgot-password" method="post">
            <div class="mb-3">
                <label class="form-label text-secondary">Tên đăng nhập</label>
                <div class="input-group">
                    <span class="input-group-text bg-dark border-secondary text-secondary"><i class="bi bi-person-fill"></i></span>
                    <input type="text" name="username" class="form-control py-2" required placeholder="Ví dụ: admin">
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label text-secondary">Email đăng ký</label>
                <div class="input-group">
                    <span class="input-group-text bg-dark border-secondary text-secondary"><i class="bi bi-envelope-fill"></i></span>
                    <input type="email" name="email" class="form-control py-2" required placeholder="Ví dụ: email@domain.com">
                </div>
            </div>

            <div class="d-grid gap-2 mt-4">
                <button type="submit" class="btn btn-warning py-2">
                    <i class="bi bi-send-fill me-2"></i> LẤY LẠI MẬT KHẨU
                </button>
            </div>
        </form>

        <div class="text-center mt-4 pt-3 border-top border-secondary">
            <a href="${path}/login" class="text-decoration-none text-light small hover-link">
                <i class="bi bi-arrow-left"></i> Quay lại Đăng nhập
            </a>
        </div>
    </div>
</body>
</html>