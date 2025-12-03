<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Video Yêu Thích - OE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body { background-color: #0f0f0f; color: white; font-family: sans-serif; }
        .video-card { background-color: #212121; border: none; border-radius: 10px; overflow: hidden; transition: transform 0.2s; }
        .video-card:hover { transform: scale(1.02); z-index: 10; }
        .poster-img { width: 100%; aspect-ratio: 16/9; object-fit: cover; }
    </style>
</head>
<body>
    <jsp:include page="/views/layout/header.jsp"/>

    <div class="container mt-4 mb-5">
        <h3 class="text-danger fw-bold mb-4"><i class="bi bi-heart-fill"></i> VIDEO ĐÃ YÊU THÍCH</h3>

        <c:if test="${empty favorites}">
            <div class="alert alert-secondary text-center">Bạn chưa yêu thích video nào.</div>
        </c:if>

        <div class="row row-cols-1 row-cols-md-4 g-4">
            <c:forEach var="fav" items="${favorites}">
                <div class="col">
                    <div class="card video-card h-100">
                        <a href="${path}/detail?videoId=${fav.video.id}">
                            <img src="${path}/images/${fav.video.poster}" class="poster-img"
                                 onerror="this.src='https://placehold.co/600x400?text=No+Image'">
                        </a>
                        <div class="card-body">
                            <h6 class="card-title text-truncate">
                                <a href="${path}/detail?videoId=${fav.video.id}" class="text-white text-decoration-none">${fav.video.titile}</a>
                            </h6>
                            <small class="text-muted">Đã thích: <fmt:formatDate value="${fav.likeDate}" pattern="dd/MM/yyyy"/></small>
                            <div class="mt-2">
                                <a href="${path}/favorite?action=unlike&videoId=${fav.video.id}" class="btn btn-sm btn-outline-secondary w-100">
                                    <i class="bi bi-heart-break"></i> Bỏ thích
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <jsp:include page="/views/layout/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>