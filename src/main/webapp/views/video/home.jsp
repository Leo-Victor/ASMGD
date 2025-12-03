<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - OE Entertainment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        body {
            background-color: #181818;
            color: #ffffff;
            font-family: sans-serif;
        }
        .video-card {
            background-color: #212121;
            border: none;
            border-radius: 10px;
            transition: transform 0.2s;
            overflow: hidden;
        }
        .video-card:hover {
            transform: scale(1.03);
            box-shadow: 0 4px 15px rgba(0,0,0,0.5);
            z-index: 10;
        }
        .poster-container {
            position: relative;
            width: 100%;
            padding-top: 56.25%; /* 16:9 Aspect Ratio */
            overflow: hidden;
            background-color: #333; /* Màu nền chờ ảnh */
            border-radius: 12px;
        }
        .poster-img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }
        .card-title a {
            color: #fff;
            text-decoration: none;
            font-weight: 600;
        }
        .card-title a:hover { color: #dc3545; }
        .card-text {
            color: #aaaaaa;
            font-size: 0.9rem;
        }
        .btn-custom {
            border-radius: 20px;
            font-size: 0.8rem;
            padding: 5px 15px;
        }
    </style>
</head>
<body>
    <jsp:include page="/views/layout/header.jsp"/>

    <div class="container mt-4 mb-5">

        <div class="p-4 mb-4 bg-dark rounded-3 border border-secondary">
            <div class="container-fluid py-2">
                <h3 class="display-6 fw-bold text-danger">
                    <i class="bi ${currentType == 'trending' ? 'bi-fire' : 'bi-stars'}"></i>
                    ${not empty pageTitle ? pageTitle : 'Video Mới Cập Nhật'}
                </h3>
                <p class="col-md-8 fs-6 text-muted">
                    <c:choose>
                        <c:when test="${currentType == 'trending'}">Những video đang gây bão cộng đồng mạng hiện nay.</c:when>
                        <c:otherwise>Khám phá những nội dung giải trí mới nhất vừa ra lò.</c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
            <c:if test="${empty videos}">
                <div class="col-12 text-center py-5">
                    <p class="text-muted">Chưa có video nào để hiển thị.</p>
                </div>
            </c:if>

            <c:forEach var="video" items="${videos}">
                <div class="col">
                    <div class="card video-card h-100">
                        <a href="${path}/home?videoId=${video.id}">
                            <div class="poster-container">
                                <img src="${path}/images/${video.poster}"
                                     class="poster-img"
                                     alt="${video.titile}"
                                     onerror="this.onerror=null; this.src='https://placehold.co/600x400/333/FFF?text=No+Image'">
                            </div>
                        </a>

                        <div class="card-body">
                            <h5 class="card-title text-truncate">
                                <a href="${path}/home?videoId=${video.id}" title="${video.titile}">${video.titile}</a>
                            </h5>
                            <p class="card-text mb-2">
                                <i class="bi bi-eye-fill"></i> ${video.views} lượt xem
                            </p>

                            <div class="d-flex justify-content-between mt-3">
                                <button onclick="toggleLike('${video.id}')"
                                        id="likeBtn-${video.id}"
                                        class="btn btn-outline-danger btn-sm btn-custom position-relative"
                                        style="z-index: 100;">
                                    <i class="bi bi-heart" id="likeIcon-${video.id}"></i> Like
                                </button>

                                <a href="${path}/share?videoId=${video.id}" class="btn btn-outline-light btn-sm btn-custom">
                                    <i class="bi bi-share"></i> Share
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation" class="mt-5 d-flex justify-content-center">
                <ul class="pagination pagination-sm">

                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link bg-dark border-secondary text-white"
                           href="${path}/home?page=${currentPage - 1}">Trước</a>
                    </li>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link ${currentPage == i ? 'bg-danger border-danger' : 'bg-dark border-secondary'} text-white"
                               href="${path}/home?page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link bg-dark border-secondary text-white"
                           href="${path}/home?page=${currentPage + 1}">Sau</a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>

    <jsp:include page="/views/layout/footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function toggleLike(videoId) {
            // Kiểm tra đăng nhập (đơn giản qua sessionAttribute JS, hoặc để Server chặn)
            // Ở đây ta gọi Server, nếu chưa đăng nhập Server sẽ redirect login, nhưng fetch sẽ không tự chuyển trang.
            // Để đơn giản, ta cứ đổi giao diện cho sướng tay.

            var btn = document.getElementById("likeBtn-" + videoId);
            var icon = document.getElementById("likeIcon-" + videoId);

            // Ngăn chặn sự kiện click lan ra thẻ cha (để không bị nhảy vào xem video)
            event.stopPropagation();
            event.preventDefault();

            // Hiệu ứng giao diện ngay lập tức (UX)
            if (btn.classList.contains("btn-outline-danger")) {
                // Đang chưa like -> Chuyển thành Like (Đỏ đặc)
                btn.classList.remove("btn-outline-danger");
                btn.classList.add("btn-danger");
                icon.classList.remove("bi-heart");
                icon.classList.add("bi-heart-fill");

                // Gọi API ngầm để lưu vào Database
                fetch('${path}/favorite?action=like&videoId=' + videoId).then(response => {
                    // Nếu server trả về url login (nghĩa là chưa đăng nhập)
                    if(response.redirected) window.location.href = response.url;
                });
            } else {
                // Đang like -> Bỏ like (Viền đỏ, rỗng)
                btn.classList.remove("btn-danger");
                btn.classList.add("btn-outline-danger");
                icon.classList.remove("bi-heart-fill");
                icon.classList.add("bi-heart");

                // Gọi API ngầm để xóa khỏi Database
                fetch('${path}/favorite?action=unlike&videoId=' + videoId).then(response => {
                    if(response.redirected) window.location.href = response.url;
                });
            }
        }
    </script>
</body>
</html>