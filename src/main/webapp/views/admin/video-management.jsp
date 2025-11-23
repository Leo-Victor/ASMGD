<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Video</title>
</head>
<body>
    <jsp:include page="../layout/header.jsp"/>

    <div class="container mt-4">
        <h2>VIDEO MANAGEMENT</h2>

        <c:if test="${not empty message}"><div class="alert alert-success">${message}</div></c:if>
        <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

        <div class="card mb-4">
            <div class="card-body">
                <form action="${path}/admin/videos" method="post">
                    <div class="row">
                        <div class="col-4">
                            <div class="border p-3 text-center">
                                <img src="${path}/images/${video.poster != null ? video.poster : 'no-image.png'}"
                                     style="max-width: 100%; height: 200px;" alt="Poster">
                            </div>
                        </div>
                        <div class="col-8">
                            <div class="mb-3">
                                <label>YOUTUBE ID</label>
                                <input name="id" value="${video.id}" class="form-control" placeholder="Video ID" required>
                            </div>
                            <div class="mb-3">
                                <label>VIDEO TITLE</label>
                                <input name="titile" value="${video.titile}" class="form-control" placeholder="Title" required>
                            </div>
                            <div class="mb-3">
                                <label>VIEW COUNT</label>
                                <input name="views" value="${video.views}" class="form-control" readonly>
                            </div>
                            <div class="mb-3">
                                <label>ACTIVE</label> <br>
                                <input type="radio" name="active" value="true" ${video.active ? 'checked' : ''} checked> Active
                                <input type="radio" name="active" value="false" ${!video.active ? 'checked' : ''}> Inactive
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label>DESCRIPTION</label>
                        <textarea name="description" class="form-control" rows="3">${video.description}</textarea>
                    </div>
                    <div class="mb-3">
                        <label>POSTER FILENAME</label>
                        <input name="poster" value="${video.poster}" class="form-control" placeholder="filename.jpg">
                    </div>

                    <button type="submit" formaction="${path}/admin/videos/create" class="btn btn-primary">Create</button>
                    <button type="submit" formaction="${path}/admin/videos/update" class="btn btn-warning">Update</button>
                    <button type="submit" formaction="${path}/admin/videos/delete" class="btn btn-danger">Delete</button>
                    <button type="submit" formaction="${path}/admin/videos/reset" class="btn btn-info">Reset</button>
                </form>
            </div>
        </div>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Views</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${items}">
                    <tr>
                        <td>${item.id}</td>
                        <td>${item.titile}</td>
                        <td>${item.views}</td>
                        <td>${item.active ? 'Active' : 'Inactive'}</td>
                        <td>
                            <a href="${path}/admin/videos/edit?id=${item.id}">Edit</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <jsp:include page="../layout/footer.jsp"/>
</body>
</html>