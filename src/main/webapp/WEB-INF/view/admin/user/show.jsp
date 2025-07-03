<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Người Dùng</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
<body class="bg-light">
<div class="container-fluid py-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex align-items-center justify-content-between">
                <h2 class="mb-0 text-dark">Chi Tiết Người Dùng</h2>
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
                                    <a
                                       class="text-decoration-none text-dark">
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
                                    <a
                                       class="text-decoration-none text-dark">
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
                            Chỉnh Sửa
                        </a>
                        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">
                            Xóa
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="deleteModalLabel">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Xác Nhận Xóa
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa người dùng <strong>${user.fullName}</strong> không?</p>
                    <p class="text-muted mb-0">Hành động này không thể hoàn tác!</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <form th:action="'/admin/user/delete/' + ${user.id}" method="post" class="d-inline">
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-trash me-2"></i>
                            Xóa
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>