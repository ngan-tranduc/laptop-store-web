<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Users</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .btn-soft-view {
            background-color: #e0e7ff;
            border-color: #c7d2fe;
            color: #4338ca;
        }
        .btn-soft-view:hover {
            background-color: #c7d2fe;
            border-color: #a5b4fc;
            color: #3730a3;
        }

        .btn-soft-edit {
            background-color: #dcfce7;
            border-color: #bbf7d0;
            color: #166534;
        }
        .btn-soft-edit:hover {
            background-color: #bbf7d0;
            border-color: #86efac;
            color: #14532d;
        }

        .btn-soft-delete {
            background-color: #fee2e2;
            border-color: #fecaca;
            color: #dc2626;
        }
        .btn-soft-delete:hover {
            background-color: #fecaca;
            border-color: #fca5a5;
            color: #b91c1c;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center mb-4 mt-4">
                <h2 class="mb-0">
                    <i class="bi bi-people-fill me-2"></i>
                    Quản lý Users
                </h2>
                <a href="/admin/user/create" class="btn btn-primary">
                    <i class="bi bi-plus-circle me-1"></i>
                    Thêm User
                </a>
            </div>

            <!-- Users Table -->
            <div class="card">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover mb-0">
                            <thead class="table-light">
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Email</th>
                                <th scope="col">Full Name</th>
                                <th scope="col" class="text-center">Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>
                                        <i class="bi bi-envelope me-2"></i>
                                            ${user.email}
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                                <c:set var="colorIndex" value="${user.id % 8}" />
                                            <c:choose>
                                            <c:when test="${colorIndex == 0}">
                                                <c:set var="bgColor" value="bg-primary" />
                                            </c:when>
                                            <c:when test="${colorIndex == 1}">
                                                <c:set var="bgColor" value="bg-success" />
                                            </c:when>
                                            <c:when test="${colorIndex == 2}">
                                                <c:set var="bgColor" value="bg-danger" />
                                            </c:when>
                                            <c:when test="${colorIndex == 3}">
                                                <c:set var="bgColor" value="bg-warning" />
                                            </c:when>
                                            <c:when test="${colorIndex == 4}">
                                                <c:set var="bgColor" value="bg-info" />
                                            </c:when>
                                            <c:when test="${colorIndex == 5}">
                                                <c:set var="bgColor" value="bg-secondary" />
                                            </c:when>
                                            <c:when test="${colorIndex == 6}">
                                                <c:set var="bgColor" value="bg-dark" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="bgColor" value="bg-purple" />
                                            </c:otherwise>
                                            </c:choose>
                                            <div class="${bgColor} rounded-circle d-flex align-items-center justify-content-center me-2"
                                                 style="width: 32px; height: 32px; font-size: 12px; color: white; background-color: ${colorIndex == 7 ? '#6f42c1' : ''};">
                                                <c:choose>
                                                    <c:when test="${not empty user.fullName}">
                                                        ${user.fullName.substring(0,1).toUpperCase()}${user.fullName.indexOf(' ') > 0 ? user.fullName.substring(user.fullName.indexOf(' ') + 1, user.fullName.indexOf(' ') + 2).toUpperCase() : ''}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${user.email.substring(0,1).toUpperCase()}
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                                ${user.fullName}
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group" role="group">
                                            <a href="/admin/user/${user.id}" class="btn btn-sm btn-soft-view" title="Xem chi tiết">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                            <a href="/admin/user/edit/${user.id}" type="button" class="btn btn-sm btn-soft-edit" title="Sửa">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-soft-delete" onclick="deleteUser(${user.id})" title="Xóa">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="card-footer text-muted">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <small>Hiển thị ${users.size()} users</small>
                        </div>
                        <div class="col-md-6 text-end">
                            <nav aria-label="User pagination">
                                <ul class="pagination pagination-sm mb-0 justify-content-end">
                                    <li class="page-item disabled">
                                        <span class="page-link">Previous</span>
                                    </li>
                                    <li class="page-item active">
                                        <span class="page-link">1</span>
                                    </li>
                                    <li class="page-item disabled">
                                        <span class="page-link">Next</span>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">
                    <i class="bi bi-exclamation-triangle-fill text-danger me-2"></i>
                    Xác nhận xóa
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn xóa user này không? Hành động này không thể hoàn tác.
            </div>
            <div class="modal-footer">
                <form id="deleteForm" method="POST" action="" style="display: inline;">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-danger">
                        <i class="bi bi-trash me-1"></i>
                        Xóa
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    let userToDelete = null;

    // Delete user function
    function deleteUser(userId) {
        userToDelete = userId;
        // Update form action with user ID
        document.getElementById('deleteForm').action = '/admin/user/delete/' + userId;
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
    }

    // Add some interactive effects
    document.addEventListener('DOMContentLoaded', function() {
        // Add hover effect to table rows
        const tableRows = document.querySelectorAll('tbody tr');
        tableRows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.backgroundColor = '#f8f9fa';
            });
            row.addEventListener('mouseleave', function() {
                this.style.backgroundColor = '';
            });
        });
    });
</script>
</body>
</html>