<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head><title>Báo cáo Thống kê</title></head>
<body>
    <jsp:include page="../layout/header.jsp"/>

    <div class="container mt-4">
        <h2>REPORTS & STATISTICS</h2>

        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class="nav-link ${tab == 'favorites' ? 'active' : ''}" href="${path}/admin/reports?tab=favorites">Favorites</a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${tab == 'favorite-users' ? 'active' : ''}" href="${path}/admin/reports?tab=favorite-users">Favorite Users</a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${tab == 'share-friends' ? 'active' : ''}" href="${path}/admin/reports?tab=share-friends">Share Friends</a>
            </li>
        </ul>

        <div class="tab-content border p-3">
            <c:if test="${tab == 'favorites'}">
                <table class="table">
                    <thead><tr><th>Video Title</th><th>Favorite Count</th><th>Latest Date</th><th>Oldest Date</th></tr></thead>
                    <tbody>
                        <c:forEach var="item" items="${reportList}">
                            <tr>
                                <td>${item.titile}</td>
                                <td>${item.favorites.size()}</td> <td>--</td>
                                <td>--</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${tab == 'favorite-users'}">
                <form action="${path}/admin/reports" method="get">
                    <input type="hidden" name="tab" value="favorite-users">
                    <div class="row mb-3">
                        <div class="col-6">
                            <select name="videoId" class="form-control" onchange="this.form.submit()">
                                <option value="">-- Chọn Video --</option>
                                <c:forEach var="v" items="${videos}">
                                    <option value="${v.id}" ${v.id == videoId ? 'selected' : ''}>${v.titile}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </form>
                <table class="table">
                    <thead><tr><th>Username</th><th>Fullname</th><th>Email</th><th>Favorite Date</th></tr></thead>
                    <tbody>
                        <c:forEach var="fav" items="${favUsers}">
                            <tr>
                                <td>${fav.user.id}</td>
                                <td>${fav.user.fullname}</td>
                                <td>${fav.user.email}</td>
                                <td><fmt:formatDate value="${fav.likeDate}" pattern="dd/MM/yyyy"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${tab == 'share-friends'}">
                <form action="${path}/admin/reports" method="get">
                    <input type="hidden" name="tab" value="share-friends">
                    <div class="row mb-3">
                        <div class="col-6">
                            <select name="videoId" class="form-control" onchange="this.form.submit()">
                                <option value="">-- Chọn Video --</option>
                                <c:forEach var="v" items="${videos}">
                                    <option value="${v.id}" ${v.id == videoId ? 'selected' : ''}>${v.titile}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </form>
                <table class="table">
                    <thead><tr><th>Sender Name</th><th>Sender Email</th><th>Receiver Email</th><th>Sent Date</th></tr></thead>
                    <tbody>
                        <c:forEach var="share" items="${shareList}">
                            <tr>
                                <td>${share.user.fullname}</td>
                                <td>${share.user.email}</td>
                                <td>${share.emails}</td>
                                <td><fmt:formatDate value="${share.shareDate}" pattern="dd/MM/yyyy"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>
    <jsp:include page="../layout/footer.jsp"/>
</body>
</html>