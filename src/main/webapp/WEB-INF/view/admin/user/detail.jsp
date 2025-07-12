<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="author" content="Nganj"/>
    <title>Chi Tiết Người Dùng - Admin</title>
    <link href="/css/styles.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        .detail-card {
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            border: 1px solid #dee2e6;
        }
        .info-label {
            font-weight: 600;
            color: #6c757d;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .info-value {
            color: #212529;
            font-size: 1rem;
            margin-top: 0.25rem;
        }
        .info-item {
            padding: 1rem;
            border-bottom: 1px solid #f8f9fa;
        }
        .info-item:last-child {
            border-bottom: none;
        }
        .avatar-container {
            position: relative;
            display: inline-block;
        }
        .avatar-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #dee2e6;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .avatar-placeholder {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2.5rem;
            font-weight: bold;
            border: 3px solid #dee2e6;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .role-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .role-admin {
            background-color: #dc3545;
            color: white;
        }
        .role-user {
            background-color: #28a745;
            color: white;
        }
        .role-moderator {
            background-color: #fd7e14;
            color: white;
        }
        .role-default {
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>

<body class="sb-nav-fixed">
<jsp:include page="../layout/header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp"/>
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <!-- Header -->
                <h1 class="mt-4">Chi Tiết Người Dùng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/user">User</a></li>
                    <li class="breadcrumb-item active">View #${user.id}</li>
                </ol>

                <!-- Back Button -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="d-flex align-items-center justify-content-between">
                            <h2 class="mb-0 text-dark"></h2>
                            <a href="/admin/user" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i>
                                Quay lại
                            </a>
                        </div>
                    </div>
                </div>

                <!-- User Detail Card -->
                <div class="row justify-content-center">
                    <div class="col-lg-9 col-md-10">
                        <div class="card detail-card">
                            <!-- Card Header -->
                            <div class="card-header bg-white py-3 border-bottom">
                                <h5 class="mb-0 text-dark">Thông Tin Người Dùng</h5>
                            </div>

                            <!-- Card Body -->
                            <div class="card-body p-0">
                                <!-- Avatar -->
                                <div class="info-item">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label class="info-label">Ảnh Đại Diện</label>
                                        </div>
                                        <div class="col-sm-9">
                                            <div class="avatar-container">
                                                <c:choose>
                                                    <c:when test="${not empty user.avatar}">
                                                        <img src="/images/avatar/${user.avatar}"
                                                             alt="Avatar của ${user.fullName}"
                                                             class="avatar-img"
                                                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                        <div class="avatar-placeholder" style="display: none;">
                                                            <c:choose>
                                                                <c:when test="${not empty user.fullName}">
                                                                    ${user.fullName.substring(0,1).toUpperCase()}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="fas fa-user"></i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="avatar-placeholder">
                                                            <c:choose>
                                                                <c:when test="${not empty user.fullName}">
                                                                    ${user.fullName.substring(0,1).toUpperCase()}${user.fullName.indexOf(' ') > 0 ? user.fullName.substring(user.fullName.indexOf(' ') + 1, user.fullName.indexOf(' ') + 2).toUpperCase() : ''}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${user.email.substring(0,1).toUpperCase()}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- User ID -->
                                <div class="info-item">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label class="info-label">ID</label>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="info-value mb-0">${user.id}</p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Full Name -->
                                <div class="info-item">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label class="info-label">Họ và Tên</label>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="info-value mb-0">${user.fullName}</p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Email -->
                                <div class="info-item">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label class="info-label">Email</label>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="info-value mb-0">
                                                <a href="mailto:${user.email}" class="text-decoration-none text-dark">
                                                    ${user.email}
                                                </a>
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Phone -->
                                <div class="info-item">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label class="info-label">Số Điện Thoại</label>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="info-value mb-0">
                                                <a href="tel:${user.phone}" class="text-decoration-none text-dark">
                                                    ${user.phone}
                                                </a>
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Address -->
                                <div class="info-item">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label class="info-label">Địa Chỉ</label>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="info-value mb-0">
                                                ${user.address}
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Role -->
                                <div class="info-item">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label class="info-label">Vai Trò</label>
                                        </div>
                                        <div class="col-sm-9">
                                            <c:choose>
                                                <c:when test="${not empty user.role}">
                                                    <c:choose>
                                                        <c:when test="${user.role.name == 'ADMIN' || user.role.name == 'admin'}">
                                                            <c:set var="roleClass" value="role-admin" />
                                                            <c:set var="roleIcon" value="bi-shield-check" />
                                                        </c:when>
                                                        <c:when test="${user.role.name == 'USER' || user.role.name == 'user'}">
                                                            <c:set var="roleClass" value="role-user" />
                                                            <c:set var="roleIcon" value="bi-person" />
                                                        </c:when>
                                                        <c:when test="${user.role.name == 'MODERATOR' || user.role.name == 'moderator'}">
                                                            <c:set var="roleClass" value="role-moderator" />
                                                            <c:set var="roleIcon" value="bi-person-gear" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set var="roleClass" value="role-default" />
                                                            <c:set var="roleIcon" value="bi-question-circle" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <span class="role-badge ${roleClass}">
                        <i class="bi ${roleIcon} me-1"></i>
                        ${user.role.name}
                    </span>
                                                </c:when>
                                                <c:otherwise>
                    <span class="role-badge role-default">
                        <i class="bi bi-question-circle me-1"></i>
                        Chưa xác định
                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <!-- Card Footer -->
                            <div class="card-footer bg-light">
                                <div class="d-flex gap-2 justify-content-end">
                                    <a href="/admin/user/edit/${user.id}" class="btn btn-primary">
                                        <i class="fas fa-edit me-2"></i>
                                        Chỉnh Sửa
                                    </a>
                                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">
                                        <i class="fas fa-trash me-2"></i>
                                        Xóa
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp"/>
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
                Bạn có chắc chắn muốn xóa người dùng này không? Hành động này không thể hoàn tác.
            </div>
            <div class="modal-footer">
                <form id="deleteForm" method="POST" action="">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-danger" onclick="deleteUser(${user.id})">
                        <i class="bi bi-trash me-1"></i>Xóa
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/scripts.js"></script>

<script>
    function deleteUser(userId) {
        document.getElementById('deleteForm').action = '/admin/user/delete/' + userId;
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
    }

    // Add hover effect to table rows
    document.addEventListener('DOMContentLoaded', function() {
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