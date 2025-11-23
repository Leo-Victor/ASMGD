<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head><title>Quản lý User</title></head>
<body>
    <jsp:include page="../layout/header.jsp"/>

    <div class="container mt-4">
        <h2>USER MANAGEMENT</h2>
        <c:if test="${not empty message}"><div class="alert alert-success">${message}</div></c:if>

        <div class="card mb-3">
            <div class="card-body">
                <form action="${path}/admin/users/update" method="post">
                    <div class="mb-3">
                        <label>Username</label>
                        <input name="id" value="${user.id}" class="form-control" readonly>
                    </div>
                    <div class="mb-3">
                        <label>Fullname</label>
                        <input name="fullname" value="${user.fullname}" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Email</label>
                        <input name="email" value="${user.email}" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Role</label><br>
                        <input type="radio" name="admin" value="true" ${user.admin ? 'checked' : ''}> Admin
                        <input type="radio" name="admin" value="false" ${!user.admin ? 'checked' : ''}> User
                    </div>
                    <button class="btn btn-warning">Update</button>
                    <button type="submit" formaction="${path}/admin/users/delete" class="btn btn-danger">Delete</button>
                </form>
            </div>
        </div>

        <table class="table table-striped">
            <thead>
                <tr><th>Username</th><th>Fullname</th><th>Email</th><th>Role</th><th>Action</th></tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${items}">
                    <tr>
                        <td>${u.id}</td>
                        <td>${u.fullname}</td>
                        <td>${u.email}</td>
                        <td>${u.admin ? 'Admin' : 'User'}</td>
                        <td><a href="${path}/admin/users/edit?id=${u.id}">Edit</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <jsp:include page="../layout/footer.jsp"/>
</body>
</html>