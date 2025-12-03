<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Người Dùng - OE Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        body { background-color: #0f0f0f; color: #e0e0e0; font-family: sans-serif; }
        .admin-card { background-color: #1e1e1e; border: 1px solid #333; border-radius: 12px; }
        .form-control, .form-select { background-color: #2b2b2b; border: 1px solid #444; color: white; }
        .form-control:focus { background-color: #2b2b2b; color: white; border-color: #0d6efd; box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25); }
        /* Style cho bảng */
        .table-dark { --bs-table-bg: #1e1e1e; --bs-table-striped-bg: #252525; }
        /* Thanh menu Admin nhỏ */
        .admin-nav .nav-link { color: #aaa; font-weight: 500; }
        .admin-nav .nav-link.active { color: #fff; background-color: #dc3545; border-radius: 5px; }
        .admin-nav .nav-link:hover { color: #fff; }
    </style>
</head>
<body>
    <jsp:include page="/views/layout/header.jsp"/>

    <div class="container mt-4 mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-danger m-0"><i class="bi bi-people-fill"></i> USER MANAGEMENT</h3>
            <ul class="nav admin-nav bg-dark p-1 rounded-3">
                <li class="nav-item"><a class="nav-link" href="${path}/admin/videos">Videos</a></li>
                <li class="nav-item"><a class="nav-link active" href="${path}/admin/users">Users</a></li>
                <li class="nav-item"><a class="nav-link" href="${path}/admin/reports">Reports</a></li>
            </ul>
        </div>

        <c:if test="${not empty message}"><div class="alert alert-success alert-dismissible fade show"><i class="bi bi-check-circle"></i> ${message}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
        <c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show"><i class="bi bi-exclamation-triangle"></i> ${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>

        <div class="card admin-card mb-4">
            <div class="card-header bg-primary text-white fw-bold"><i class="bi bi-person-lines-fill"></i> Cập nhật thông tin</div>
            <div class="card-body p-4">
                <form action="${path}/admin/users" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Tên đăng nhập</label>
                            <input name="id" value="${user.id}" class="form-control" readonly
                                   style="background-color: #222; cursor: not-allowed; color: #999;"
                                   placeholder="Username">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Họ và Tên</label>
                            <input name="fullname" value="${user.fullname}" class="form-control" required
                                   placeholder="Họ tên đầy đủ">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email</label>
                            <input name="email" value="${user.email}" class="form-control" required
                                   placeholder="Email">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Vai trò (Role)</label>
                            <div class="mt-2">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="admin" value="false"
                                           ${!user.admin ? 'checked' : ''}>
                                    <label class="form-check-label">Khách hàng (User)</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="admin" value="true"
                                           ${user.admin ? 'checked' : ''}>
                                    <label class="form-check-label text-danger fw-bold">Quản trị viên (Admin)</label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="border-top border-secondary pt-3 mt-2 text-end">
                        <button type="submit" formaction="${path}/admin/users/update" class="btn btn-warning px-4 fw-bold text-dark"><i class="bi bi-save"></i> Cập nhật</button>
                        <c:if test="${user.id != 'admin' && user.id != sessionScope.currentUser.id}">
                            <button type="submit" formaction="${path}/admin/users/delete"
                                    class="btn btn-danger px-4 fw-bold"
                                    onclick="return confirm('Xóa người dùng này?');">
                                <i class="bi bi-trash"></i> Xóa
                            </button>
                        </c:if>
                        <button type="submit" formaction="${path}/admin/users/reset" class="btn btn-secondary px-4 fw-bold"><i class="bi bi-arrow-counterclockwise"></i> Làm mới</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="card admin-card">
            <div class="card-header bg-dark text-white fw-bold border-bottom border-secondary"><i class="bi bi-list-ul"></i> Danh sách Khách hàng</div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-dark table-hover table-striped mb-0 align-middle">
                        <thead class="table-secondary text-dark">
                            <tr>
                                <th>Username</th>
                                <th>Họ và Tên</th>
                                <th>Email</th>
                                <th>Vai trò</th>
                                <th class="text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${items}">
                                <tr>
                                    <td>${item.id}</td>
                                    <td>${item.fullname}</td>
                                    <td>${item.email}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.admin}"><span class="badge bg-danger">Admin</span></c:when>
                                            <c:otherwise><span class="badge bg-secondary">User</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <a href="${path}/admin/users/edit?id=${item.id}" class="btn btn-sm btn-outline-info"><i class="bi bi-pencil-square"></i> Edit</a>
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