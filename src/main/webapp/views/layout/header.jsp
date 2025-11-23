<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-black border-bottom border-secondary sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold d-flex align-items-center" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-play-circle-fill text-danger fs-4 me-2"></i>
            OE ENTERTAINMENT
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Thịnh hành</a></li>
            </ul>

            <div class="d-flex">
                <c:if test="${sessionScope.currentUser == null}">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary rounded-pill px-4 btn-sm">
                        <i class="bi bi-person-circle"></i> Đăng nhập
                    </a>
                </c:if>
                <c:if test="${sessionScope.currentUser != null}">
                    <div class="dropdown">
                        <button class="btn btn-secondary dropdown-toggle btn-sm rounded-pill" type="button" data-bs-toggle="dropdown">
                            Xin chào, ${sessionScope.currentUser.fullname}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/my-favorites">Yêu thích</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/edit-profile">Hồ sơ</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/change-password">Đổi mật khẩu</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <c:if test="${sessionScope.currentUser.admin}">
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/admin/videos">Quản trị viên</a></li>
                            </c:if>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logoff">Đăng xuất</a></li>
                        </ul>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</nav>