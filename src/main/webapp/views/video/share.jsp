<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Chia sẻ Video</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body style="background-color: #0f0f0f;">
    <jsp:include page="../layout/header.jsp"/>

    <div class="container mt-5 pt-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card bg-dark text-white border-secondary shadow-lg">
                    <div class="card-header border-secondary bg-black p-3">
                        <h4 class="mb-0"><i class="bi bi-share-fill text-primary me-2"></i> Chia sẻ Video</h4>
                    </div>
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center mb-4 bg-black p-3 rounded border border-secondary">
                            <div class="me-3">
                                <img src="${path}/images/${video.poster}" width="120" class="rounded"
                                     onerror="this.src='https://via.placeholder.com/120x68?text=Video'">
                            </div>
                            <div>
                                <h6 class="fw-bold text-white mb-1">${video.titile}</h6>
                                <small class="text-muted">Bạn đang chia sẻ video này</small>
                            </div>
                        </div>

                        <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
                        <c:if test="${not empty message}"><div class="alert alert-success">${message}</div></c:if>

                        <form action="${path}/share" method="post">
                            <input type="hidden" name="videoId" value="${video.id}"/>
                            <div class="mb-3">
                                <label class="form-label">Nhập Email người nhận</label>
                                <textarea name="friendEmails" class="form-control bg-black text-white border-secondary"
                                          rows="3" placeholder="Ví dụ: ban1@gmail.com, ban2@gmail.com..." required></textarea>
                                <div class="form-text text-secondary">Phân cách nhiều email bằng dấu phẩy (,)</div>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary fw-bold"><i class="bi bi-send"></i> Gửi Ngay</button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="text-center mt-3">
                    <a href="${path}/home" class="text-decoration-none text-secondary">Quay lại trang chủ</a>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../layout/footer.jsp"/>
</body>
</html>