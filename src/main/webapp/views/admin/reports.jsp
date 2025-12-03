<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <title>Báo cáo Thống kê - OE Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        body { background-color: #0f0f0f; color: #e0e0e0; font-family: sans-serif; }

        .admin-card {
            background-color: #1e1e1e;
            border: 1px solid #333;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.3);
        }

        /* Menu Admin nhỏ */
        .admin-nav .nav-link { color: #aaa; font-weight: 500; transition: 0.2s; }
        .admin-nav .nav-link.active { color: #fff; background-color: #dc3545; border-radius: 5px; }
        .admin-nav .nav-link:hover { color: #fff; background-color: #333; border-radius: 5px; }

        /* Tabs giao diện */
        .nav-tabs .nav-link { color: #ccc; border: none; border-bottom: 3px solid transparent; }
        .nav-tabs .nav-link.active {
            color: #dc3545;
            background-color: transparent;
            border-color: #dc3545;
            font-weight: bold;
        }
        .nav-tabs .nav-link:hover { color: #fff; border-color: #444; }
        .nav-tabs { border-bottom: 1px solid #444; }

        /* Form Controls */
        .form-select, .form-control {
            background-color: #2b2b2b;
            border: 1px solid #444;
            color: white;
        }
        .form-select:focus {
            background-color: #2b2b2b;
            color: white;
            border-color: #dc3545;
            box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25);
        }

        /* Bảng tối */
        .table-dark { --bs-table-bg: #1e1e1e; --bs-table-striped-bg: #252525; }
    </style>
</head>
<body>
    <jsp:include page="/views/layout/header.jsp"/>

    <div class="container mt-4 mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-danger m-0"><i class="bi bi-bar-chart-line-fill"></i> REPORTS & STATISTICS</h3>
            <ul class="nav admin-nav bg-dark p-1 rounded-3 border border-secondary">
                <li class="nav-item"><a class="nav-link" href="${path}/admin/videos">Videos</a></li>
                <li class="nav-item"><a class="nav-link" href="${path}/admin/users">Users</a></li>
                <li class="nav-item"><a class="nav-link active" href="${path}/admin/reports">Reports</a></li>
            </ul>
        </div>

        <div class="card admin-card">
            <div class="card-header bg-dark border-bottom border-secondary pt-3">
                <ul class="nav nav-tabs card-header-tabs">
                    <li class="nav-item">
                        <a class="nav-link ${tab == 'favorites' ? 'active' : ''}"
                           href="${path}/admin/reports?tab=favorites">
                           <i class="bi bi-star-fill"></i> Favorites
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${tab == 'favorite-users' ? 'active' : ''}"
                           href="${path}/admin/reports?tab=favorite-users">
                           <i class="bi bi-people-fill"></i> Favorite Users
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${tab == 'share-friends' ? 'active' : ''}"
                           href="${path}/admin/reports?tab=share-friends">
                           <i class="bi bi-share-fill"></i> Share Friends
                        </a>
                    </li>
                </ul>
            </div>

            <div class="card-body p-4">
                <c:if test="${tab == 'favorites'}">
                    <div class="alert alert-secondary bg-dark text-white border-secondary mb-3">
                        <i class="bi bi-info-circle"></i> Thống kê tổng hợp lượt thích của từng video.
                    </div>
                    <div class="table-responsive">
                        <table class="table table-dark table-hover table-striped align-middle">
                            <thead class="table-secondary text-dark">
                                <tr>
                                    <th>Video Title</th>
                                    <th class="text-center">Favorite Count</th>
                                    <th>Oldest Date</th>
                                    <th>Latest Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="row" items="${reportList}">
                                    <tr>
                                        <td class="fw-bold text-danger">${row[0]}</td> <td class="text-center fs-5 fw-bold">${row[1]}</td> <td>
                                            <c:choose>
                                                <c:when test="${not empty row[2]}"><fmt:formatDate value="${row[2]}" pattern="dd/MM/yyyy"/></c:when>
                                                <c:otherwise>--</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty row[3]}"><fmt:formatDate value="${row[3]}" pattern="dd/MM/yyyy"/></c:when>
                                                <c:otherwise>--</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>

                <c:if test="${tab == 'favorite-users'}">
                    <div class="row mb-4">
                        <div class="col-md-8 mx-auto">
                            <form action="${path}/admin/reports" method="get" class="d-flex gap-2">
                                <input type="hidden" name="tab" value="favorite-users">
                                <div class="input-group">
                                    <span class="input-group-text bg-secondary text-white border-secondary">Chọn Video:</span>
                                    <select name="videoId" class="form-select" onchange="this.form.submit()">
                                        <option value="">-- Vui lòng chọn video để xem --</option>
                                        <c:forEach var="v" items="${videos}">
                                            <option value="${v.id}" ${v.id == videoId ? 'selected' : ''}>${v.titile}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-dark table-hover table-striped align-middle">
                            <thead class="table-secondary text-dark">
                                <tr>
                                    <th>Username</th>
                                    <th>Fullname</th>
                                    <th>Email</th>
                                    <th>Favorite Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty favUsers}">
                                    <tr><td colspan="4" class="text-center text-muted">Chưa có dữ liệu.</td></tr>
                                </c:if>
                                <c:forEach var="fav" items="${favUsers}">
                                    <tr>
                                        <td>${fav.user.id}</td>
                                        <td class="fw-bold">${fav.user.fullname}</td>
                                        <td>${fav.user.email}</td>
                                        <td><fmt:formatDate value="${fav.likeDate}" pattern="dd/MM/yyyy"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>

                <c:if test="${tab == 'share-friends'}">
                    <div class="row mb-4">
                        <div class="col-md-8 mx-auto">
                            <form action="${path}/admin/reports" method="get">
                                <input type="hidden" name="tab" value="share-friends">
                                <div class="input-group">
                                    <span class="input-group-text bg-secondary text-white border-secondary">Chọn Video:</span>
                                    <select name="videoId" class="form-select" onchange="this.form.submit()">
                                        <option value="">-- Vui lòng chọn video để xem --</option>
                                        <c:forEach var="v" items="${videos}">
                                            <option value="${v.id}" ${v.id == videoId ? 'selected' : ''}>${v.titile}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-dark table-hover table-striped align-middle">
                            <thead class="table-secondary text-dark">
                                <tr>
                                    <th>Sender Name</th>
                                    <th>Sender Email</th>
                                    <th>Receiver Email</th>
                                    <th>Sent Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty shareList}">
                                    <tr><td colspan="4" class="text-center text-muted">Chưa có dữ liệu.</td></tr>
                                </c:if>
                                <c:forEach var="share" items="${shareList}">
                                    <tr>
                                        <td class="fw-bold">${share.user.fullname}</td>
                                        <td>${share.user.email}</td>
                                        <td>${share.emails}</td>
                                        <td><fmt:formatDate value="${share.shareDate}" pattern="dd/MM/yyyy"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <jsp:include page="/views/layout/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>