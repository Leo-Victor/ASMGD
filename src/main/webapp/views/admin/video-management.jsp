<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Video - OE Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        body { background-color: #0f0f0f; color: #e0e0e0; font-family: sans-serif; }
        .admin-card { background-color: #1e1e1e; border: 1px solid #333; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.3); }
        .form-control, .form-select { background-color: #2b2b2b; border: 1px solid #444; color: white; }
        .form-control:focus { background-color: #2b2b2b; color: white; border-color: #dc3545; box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25); }
        .poster-preview { width: 100%; height: 250px; object-fit: cover; border-radius: 8px; border: 2px dashed #444; display: flex; align-items: center; justify-content: center; background-color: #121212; }
        .table-dark { --bs-table-bg: #1e1e1e; --bs-table-striped-bg: #252525; }

        /* CSS CHO MENU ADMIN (Mới thêm) */
        .admin-nav .nav-link { color: #aaa; font-weight: 500; transition: 0.2s; }
        .admin-nav .nav-link.active { color: #fff; background-color: #dc3545; border-radius: 5px; }
        .admin-nav .nav-link:hover { color: #fff; background-color: #333; border-radius: 5px; }
    </style>
</head>
<body>
    <jsp:include page="/views/layout/header.jsp"/>

    <div class="container mt-4 mb-5">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-danger m-0"><i class="bi bi-film"></i> VIDEO MANAGEMENT</h3>

            <ul class="nav admin-nav bg-dark p-1 rounded-3 border border-secondary">
                <li class="nav-item">
                    <a class="nav-link active" href="${path}/admin/videos">Videos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${path}/admin/users">Users</a> </li>
                <li class="nav-item">
                    <a class="nav-link" href="${path}/admin/reports">Reports</a>
                </li>
            </ul>
        </div>
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill"></i> ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="card admin-card mb-4">
            <div class="card-header bg-danger text-white fw-bold">
                <i class="bi bi-pencil-square"></i> Cập nhật thông tin Video
            </div>
            <div class="card-body p-4">
                <form action="${path}/admin/videos" method="post">
                    <div class="row">
                        <div class="col-md-4 text-center">
                            <div class="mb-3">
                                <label class="form-label text-secondary fw-bold">POSTER PREVIEW</label>
                                <div class="poster-preview">
                                    <img src="${path}/images/${video.poster}"
                                         alt="Poster"
                                         style="max-width: 100%; max-height: 100%; object-fit: contain;"
                                         onerror="this.src='https://placehold.co/600x400/222/999?text=No+Preview'">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Poster Filename</label>
                                <input name="poster" value="${video.poster}" class="form-control" placeholder="Ví dụ: image.jpg">
                            </div>
                        </div>

                        <div class="col-md-8">
                            <div class="mb-3">
                                <label class="form-label">Youtube ID</label>
                                <input name="id" value="${video.id}" class="form-control" placeholder="Mã video trên Youtube (VD: video1)">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Video Title</label>
                                <input name="titile" value="${video.titile}" class="form-control" placeholder="Tiêu đề video" required>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">View Count</label>
                                    <input name="views" value="${video.views}" class="form-control" readonly placeholder="0">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Status</label>
                                    <div class="d-flex align-items-center mt-2">
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="active" value="true" ${video.active ? 'checked' : ''} checked>
                                            <label class="form-check-label text-success"><i class="bi bi-check-circle"></i> Active</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="active" value="false" ${!video.active ? 'checked' : ''}>
                                            <label class="form-check-label text-secondary"><i class="bi bi-ban"></i> Inactive</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Description</label>
                                <textarea name="description" class="form-control" rows="4" placeholder="Mô tả nội dung video...">${video.description}</textarea>
                            </div>
                        </div>
                    </div>

                    <div class="border-top border-secondary pt-3 mt-2 text-end">
                        <button type="submit" formaction="${path}/admin/videos/create" class="btn btn-success px-4 fw-bold"><i class="bi bi-plus-lg"></i> Create</button>
                        <button type="submit" formaction="${path}/admin/videos/update" class="btn btn-warning px-4 fw-bold text-dark"><i class="bi bi-save"></i> Update</button>
                        <button type="submit" formaction="${path}/admin/videos/delete" class="btn btn-danger px-4 fw-bold" onclick="return confirm('Bạn có chắc chắn muốn xóa video này?');"><i class="bi bi-trash"></i> Delete</button>
                        <button type="submit" formaction="${path}/admin/videos/reset" class="btn btn-secondary px-4 fw-bold"><i class="bi bi-arrow-counterclockwise"></i> Reset</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="card admin-card">
            <div class="card-header bg-dark text-white fw-bold border-bottom border-secondary">
                <i class="bi bi-list-ul"></i> Danh sách Video
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-dark table-hover table-striped mb-0 align-middle">
                        <thead class="table-secondary text-dark">
                            <tr>
                                <th>Youtube ID</th>
                                <th>Video Title</th>
                                <th>Views</th>
                                <th>Status</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${items}">
                                <tr>
                                    <td>${item.id}</td>
                                    <td class="fw-bold text-truncate" style="max-width: 250px;">${item.titile}</td>
                                    <td>${item.views}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.active}"><span class="badge bg-success">Active</span></c:when>
                                            <c:otherwise><span class="badge bg-secondary">Inactive</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <a href="${path}/admin/videos/edit?id=${item.id}" class="btn btn-sm btn-outline-info">
                                            <i class="bi bi-pencil-square"></i> Edit
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/views/layout/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>