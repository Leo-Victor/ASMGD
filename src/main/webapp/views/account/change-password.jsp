<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Đổi Mật Khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color: #0f0f0f; color: white;">
    <jsp:include page="/views/layout/header.jsp"/>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card bg-dark border-secondary">
                    <div class="card-header border-secondary fw-bold text-warning">ĐỔI MẬT KHẨU</div>
                    <div class="card-body">
                        <c:if test="${not empty message}"><div class="alert alert-success">${message}</div></c:if>
                        <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

                        <form action="${path}/change-password" method="post">
                            <div class="mb-3">
                                <label>Mật khẩu hiện tại</label>
                                <input type="password" name="currentPassword" class="form-control bg-black text-white border-secondary" required>
                            </div>
                            <div class="mb-3">
                                <label>Mật khẩu mới</label>
                                <input type="password" name="newPassword" class="form-control bg-black text-white border-secondary" required>
                            </div>
                            <div class="mb-3">
                                <label>Xác nhận mật khẩu mới</label>
                                <input type="password" name="confirmNewPassword" class="form-control bg-black text-white border-secondary" required>
                            </div>
                            <button class="btn btn-warning w-100">Đổi Mật Khẩu</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/views/layout/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>