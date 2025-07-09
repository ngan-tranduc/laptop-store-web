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
                    <div class="col-lg-8 col-md-10">
                        <div class="card detail-card">
                            <!-- Card Header -->
                            <div class="card-header bg-white py-3 border-bottom">
                                <h5 class="mb-0 text-dark">Thông Tin Người Dùng</h5>
                            </div>

                            <!-- Card Body -->
                            <div class="card-body p-0">
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
                            </div>

                            <!-- Card Footer -->
                            <div class="card-footer bg-light">
                                <div class="d-flex gap-2">
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
                                    <button type="submit" class="btn btn-danger">
                                        <i class="bi bi-trash me-1"></i>Xóa
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Delete Confirmation Modal -->
<%--                <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">--%>
<%--                    <div class="modal-dialog">--%>
<%--                        <div class="modal-content">--%>
<%--                            <div class="modal-header bg-danger text-white">--%>
<%--                                <h5 class="modal-title" id="deleteModalLabel">--%>
<%--                                    <i class="fas fa-exclamation-triangle me-2"></i>--%>
<%--                                    Xác Nhận Xóa--%>
<%--                                </h5>--%>
<%--                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>--%>
<%--                            </div>--%>
<%--                            <div class="modal-body">--%>
<%--                                <p>Bạn có chắc chắn muốn xóa người dùng <strong>${user.fullName}</strong> không?</p>--%>
<%--                                <p class="text-muted mb-0">Hành động này không thể hoàn tác!</p>--%>
<%--                            </div>--%>
<%--                            <div class="modal-footer">--%>
<%--                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>--%>
<%--                                <form action="/admin/user/delete/${user.id}" method="post" class="d-inline">--%>
<%--                                    <button type="submit" class="btn btn-danger">--%>
<%--                                        <i class="fas fa-trash me-2"></i>--%>
<%--                                        Xóa--%>
<%--                                    </button>--%>
<%--                                </form>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp"/>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</body>

</html>