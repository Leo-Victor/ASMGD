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
        /* Tùy chỉnh CSS thêm */
        body {
            background-color: #181818; /* Màu nền tối giống Youtube */
            color: #ffffff;
            font-family: sans-serif;
        }
        .video-card {
            background-color: #212121; /* Màu thẻ video */
            border: none;
            border-radius: 10px;
            transition: transform 0.2s;
            overflow: hidden;
        }
        .video-card:hover {
            transform: scale(1.03); /* Hiệu ứng phóng to khi di chuột */
            box-shadow: 0 4px 15px rgba(0,0,0,0.5);
            z-index: 10;
        }
        .poster-container {
            position: relative;
            width: 100%;
            padding-top: 56.25%; /* Tỷ lệ khung hình 16:9 */
            overflow: hidden;
        }
        .poster-img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .card-title a {
            color: #fff;
            text-decoration: none;
            font-weight: 600;
        }
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

    <div class="container mt-4">
        <div class="p-4 mb-4 bg-dark rounded-3 border border-secondary">
            <div class="container-fluid py-2">
                <h3 class="display-6 fw-bold text-danger"><i class="bi bi-fire"></i> Video Thịnh Hành</h3>
                <p class="col-md-8 fs-6 text-muted">Tuyển tập những tiểu phẩm hài hước nhất dành cho bạn.</p>
            </div>
        </div>

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
            <c:forEach var="video" items="${videos}">
                <div class="col">
                    <div class="card video-card h-100">
                        <a href="${path}/home?videoId=${video.id}">
                            <div class="poster-container">
                                <img src="${path}/images/${video.poster}"
                                     class="poster-img"
                                     alt="${video.titile}"
                                     onerror="this.src='https://via.placeholder.com/640x360?text=No+Image'">
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
                                <a href="${path}/favorite?action=like&videoId=${video.id}" class="btn btn-outline-danger btn-sm btn-custom">
                                    <i class="bi bi-heart"></i> Like
                                </a>
                                <a href="${path}/share?videoId=${video.id}" class="btn btn-outline-light btn-sm btn-custom">
                                    <i class="bi bi-share"></i> Share
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <nav aria-label="Page navigation" class="mt-5 d-flex justify-content-center">
            <ul class="pagination pagination-sm">
                <li class="page-item disabled"><a class="page-link bg-dark border-secondary text-white" href="#">Trước</a></li>
                <li class="page-item active"><a class="page-link bg-danger border-danger text-white" href="#">1</a></li>
                <li class="page-item"><a class="page-link bg-dark border-secondary text-white" href="#">2</a></li>
                <li class="page-item"><a class="page-link bg-dark border-secondary text-white" href="#">3</a></li>
                <li class="page-item"><a class="page-link bg-dark border-secondary text-white" href="#">Sau</a></li>
            </ul>
        </nav>
    </div>

    <jsp:include page="/views/layout/footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>