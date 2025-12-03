<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Hồ Sơ Cá Nhân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color: #0f0f0f; color: white;">
    <jsp:include page="/views/layout/header.jsp"/>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card bg-dark border-secondary">
                    <div class="card-header border-secondary fw-bold text-primary">CẬP NHẬT HỒ SƠ</div>
                    <div class="card-body">
                        <c:if test="${not empty message}"><div class="alert alert-success">${message}</div></c:if>
                        <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

                        <form action="${path}/edit-profile" method="post">
                            <div class="mb-3">
                                <label>Tên đăng nhập</label>
                                <input value="${sessionScope.currentUser.id}" class="form-control bg-secondary text-white" readonly>
                            </div>
                            <div class="mb-3">
                                <label>Họ và Tên</label>
                                <input name="fullname" value="${sessionScope.currentUser.fullname}" class="form-control bg-black text-white border-secondary" required>
                            </div>
                            <div class="mb-3">
                                <label>Email</label>
                                <input name="email" value="${sessionScope.currentUser.email}" class="form-control bg-black text-white border-secondary" required>
                            </div>
                            <button class="btn btn-primary w-100">Lưu thay đổi</button>
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