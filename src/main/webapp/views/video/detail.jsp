<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>${video.titile} - OE Entertainment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        body { background-color: #0f0f0f; color: white; font-family: sans-serif; }

        /* Style cho danh sách video bên phải */
        .history-card {
            background: transparent;
            border: none;
            cursor: pointer;
            transition: background 0.2s;
        }
        .history-card:hover { background-color: #272727; border-radius: 8px; }
        .history-img {
            width: 160px;
            height: 90px;
            object-fit: cover;
            border-radius: 8px;
        }
        .history-title {
            font-size: 0.9rem;
            font-weight: 600;
            color: white;
            margin-bottom: 4px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* Style cho phần mô tả video chính */
        .description-box {
            background-color: #272727;
            border-radius: 12px;
            padding: 15px;
            margin-top: 15px;
            font-size: 0.9rem;
        }

        /* Nút bấm chức năng */
        .btn-action {
            background-color: #272727;
            color: white;
            border-radius: 18px;
            font-weight: 500;
            border: none;
        }
        .btn-action:hover { background-color: #3f3f3f; color: white; }
    </style>
</head>
<body>
    <jsp:include page="/views/layout/header.jsp"/>

    <div class="container-fluid mt-4 px-4">
        <div class="row">
            <div class="col-lg-8">
                <div class="ratio ratio-16x9 mb-3 rounded-4 overflow-hidden shadow">
                    <iframe src="https://www.youtube.com/embed/${video.id}?rel=0&autoplay=1"
                            title="YouTube video player" allowfullscreen></iframe>
                </div>

                <h4 class="fw-bold mb-2">${video.titile}</h4>

                <div class="d-flex justify-content-between align-items-center flex-wrap">
                    <div class="d-flex align-items-center">
                        <img src="https://ui-avatars.com/api/?name=OE&background=random" class="rounded-circle me-2" width="40">
                        <div>
                            <h6 class="mb-0 fw-bold">OE Official Channel</h6>
                            <small class="text-secondary">1.2M người đăng ký</small>
                        </div>

                        <button id="subBtn" class="btn btn-light rounded-pill fw-bold ms-4 px-3"
                                onclick="toggleSubscribe()">
                            Đăng ký
                        </button>
                    </div>

                    <div class="d-flex gap-2 mt-2 mt-md-0">

                        <button id="likeBtnDetail" class="btn btn-action px-3" onclick="toggleLikeDetail('${video.id}')">
                            <i id="likeIconDetail" class="bi bi-hand-thumbs-up"></i> Thích
                        </button>

                        <button id="dislikeBtnDetail" class="btn btn-action px-3" onclick="toggleDislike()">
                            <i id="dislikeIconDetail" class="bi bi-hand-thumbs-down"></i>
                        </button>

                        <a href="${path}/share?videoId=${video.id}" class="btn btn-action px-3 text-decoration-none">
                            <i class="bi bi-share"></i> Chia sẻ
                        </a>
                    </div>
                </div>

                <div class="description-box">
                    <p class="mb-1 fw-bold">${video.views} lượt xem &bull; Đã phát hành 2025</p>
                    <p class="text-light mb-0">
                        ${video.description != null ? video.description : 'Chưa có mô tả cho video này.'}
                    </p>
                </div>

                <div class="mt-4">
                    <h5>Bình luận</h5>

                    <div class="d-flex mt-3">
                            <img src="https://ui-avatars.com/api/?name=${sessionScope.currentUser.fullname != null ? sessionScope.currentUser.fullname : 'Guest'}&background=random"
                                 class="rounded-circle me-3" width="40">

                            <form class="w-100" onsubmit="event.preventDefault(); alert('Tính năng bình luận đang phát triển!');">
                                <input type="text" class="form-control bg-transparent text-white border-0 border-bottom rounded-0"
                                       placeholder="Viết bình luận...">

                                <div class="d-flex justify-content-end mt-2">
                                    <button class="btn btn-secondary btn-sm rounded-pill me-2">Hủy</button>
                                    <button class="btn btn-primary btn-sm rounded-pill">Bình luận</button>
                                </div>
                            </form>
                        </div>
                </div>
            </div>

            <div class="col-lg-4 mt-4 mt-lg-0">
                <h5 class="mb-3 text-white">Video đã xem gần đây</h5>

                <c:if test="${empty historyVideos}">
                    <p class="text-muted small">Bạn chưa xem video nào khác.</p>
                </c:if>

                <div class="d-flex flex-column gap-2">
                    <c:forEach var="hisVideo" items="${historyVideos}">
                        <div class="card history-card">
                            <a href="${path}/detail?videoId=${hisVideo.id}" class="text-decoration-none text-white">
                                <div class="row g-0 align-items-center">
                                    <div class="col-5 p-2">
                                        <img src="${path}/images/${hisVideo.poster}"
                                             class="history-img"
                                             alt="${hisVideo.titile}"
                                             onerror="this.onerror=null; this.src='https://placehold.co/600x400/333/FFF?text=No+Image'">
                                    </div>
                                    <div class="col-7">
                                        <div class="card-body p-0 py-2 pe-2">
                                            <h6 class="history-title" title="${hisVideo.titile}">${hisVideo.titile}</h6>
                                            <small class="text-secondary d-block">OE Entertainment</small>
                                            <small class="text-secondary">${hisVideo.views} lượt xem</small>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/views/layout/footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Xử lý nút Đăng ký
        function toggleSubscribe() {
            var btn = document.getElementById("subBtn");
            if (btn.innerText === "Đăng ký") {
                btn.innerText = "Đã đăng ký";
                btn.classList.remove("btn-light");
                btn.classList.add("btn-secondary"); // Chuyển màu xám tối
                alert("Đã đăng ký kênh OE Official!");
            } else {
                btn.innerText = "Đăng ký";
                btn.classList.remove("btn-secondary");
                btn.classList.add("btn-light"); // Trở lại màu sáng
            }
        }

        // Xử lý Like (Có gọi Server ngầm)
        function toggleLikeDetail(videoId) {
            var btn = document.getElementById("likeBtnDetail");
            var icon = document.getElementById("likeIconDetail");

            // Kiểm tra xem đang like hay chưa (dựa vào class icon)
            if (icon.classList.contains("bi-hand-thumbs-up")) {
                // Chưa like -> Chuyển thành Like
                icon.classList.remove("bi-hand-thumbs-up");
                icon.classList.add("bi-hand-thumbs-up-fill"); // Ngón tay cái đặc
                btn.style.color = "#3ea6ff"; // Màu xanh (hoặc trắng sáng) để báo hiệu active

                // Nếu đang Dislike thì tắt Dislike đi (Logic Youtube)
                var dislikeIcon = document.getElementById("dislikeIconDetail");
                if(dislikeIcon.classList.contains("bi-hand-thumbs-down-fill")) {
                     toggleDislike();
                }

                // Gọi API
                fetch('${path}/favorite?action=like&videoId=' + videoId);
            } else {
                // Đã like -> Bỏ like
                icon.classList.remove("bi-hand-thumbs-up-fill");
                icon.classList.add("bi-hand-thumbs-up"); // Ngón tay rỗng
                btn.style.color = ""; // Về màu mặc định

                // Gọi API
                fetch('${path}/favorite?action=unlike&videoId=' + videoId);
            }
        }

        // Xử lý Dislike (Giả lập giao diện)
        function toggleDislike() {
            var btn = document.getElementById("dislikeBtnDetail");
            var icon = document.getElementById("dislikeIconDetail");

            if (icon.classList.contains("bi-hand-thumbs-down")) {
                // Chưa Dislike -> Dislike
                icon.classList.remove("bi-hand-thumbs-down");
                icon.classList.add("bi-hand-thumbs-down-fill");

                // Nếu đang Like thì tắt Like đi
                var likeIcon = document.getElementById("likeIconDetail");
                if(likeIcon.classList.contains("bi-hand-thumbs-up-fill")) {
                     // Gọi lại hàm like để nó tự tắt like và gọi API unlike
                     // Lưu ý: Cần truyền ID video vào nếu gọi hàm, ở đây ta thao tác DOM trực tiếp cho nhanh
                     likeIcon.classList.remove("bi-hand-thumbs-up-fill");
                     likeIcon.classList.add("bi-hand-thumbs-up");
                     document.getElementById("likeBtnDetail").style.color = "";
                     // Gọi API unlike vì đã bỏ like
                     var vidId = '${video.id}'; // Lấy ID từ EL
                     fetch('${path}/favorite?action=unlike&videoId=' + vidId);
                }
            } else {
                // Bỏ Dislike
                icon.classList.remove("bi-hand-thumbs-down-fill");
                icon.classList.add("bi-hand-thumbs-down");
            }
        }
    </script>
</body>
</html>