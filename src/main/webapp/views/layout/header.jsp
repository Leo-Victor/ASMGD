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
                <li class="nav-item">
                    <a class="nav-link ${empty currentType ? 'active text-danger fw-bold' : ''}"
                       href="${pageContext.request.contextPath}/home">
                       <i class="bi bi-house-door-fill"></i> Trang chủ
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link ${currentType == 'trending' ? 'active text-danger fw-bold' : ''}"
                       href="${pageContext.request.contextPath}/home?type=trending">
                       <i class="bi bi-fire"></i> Thịnh hành
                    </a>
                </li>
            </ul>

            <div class="d-flex align-items-center">
                <c:if test="${sessionScope.currentUser == null}">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary rounded-pill px-4 btn-sm">
                        <i class="bi bi-person-circle"></i> Đăng nhập
                    </a>
                </c:if>

                <c:if test="${sessionScope.currentUser != null}">

                    <c:if test="${sessionScope.currentUser.admin}">
                        <a href="${pageContext.request.contextPath}/admin/videos"
                           class="btn btn-danger btn-sm rounded-pill fw-bold me-3 shadow-sm">
                            <i class="bi bi-speedometer2"></i> TRANG QUẢN TRỊ
                        </a>
                    </c:if>

                    <div class="dropdown">
                        <button class="btn btn-secondary dropdown-toggle btn-sm rounded-pill d-flex align-items-center gap-2" type="button" data-bs-toggle="dropdown">
                            <img src="https://ui-avatars.com/api/?name=${sessionScope.currentUser.fullname}&background=random&size=24"
                                 class="rounded-circle" width="24" height="24">
                            <span>Xin chào, ${sessionScope.currentUser.fullname}</span>
                        </button>

                        <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end mt-2 shadow">
                            <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/my-favorites"><i class="bi bi-heart-fill text-danger me-2"></i> Yêu thích</a></li>
                            <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/edit-profile"><i class="bi bi-person-gear me-2"></i> Hồ sơ</a></li>
                            <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/change-password"><i class="bi bi-key me-2"></i> Đổi mật khẩu</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item py-2 text-warning" href="${pageContext.request.contextPath}/logoff"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a></li>
                        </ul>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</nav>