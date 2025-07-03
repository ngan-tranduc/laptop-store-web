<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Người Dùng</title>
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
        .info-item {
            padding: 1rem;
            border-bottom: 1px solid #f8f9fa;
        }
        .info-item:last-child {
            border-bottom: none;
        }
        .form-control:focus {
            border-color: #86b7fe;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        .required::after {
            content: " *";
            color: #dc3545;
        }
        .readonly-field {
            background-color: #f8f9fa;
            border-color: #dee2e6;
        }
        .toast {
            min-width: 350px;
        }
    </style>
</head>
<body class="bg-light">
<div class="container-fluid py-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex align-items-center justify-content-between">
                <h2 class="mb-0 text-dark">Chỉnh Sửa Người Dùng</h2>
                <a href="/admin/user" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>
                    Quay lại
                </a>
            </div>
        </div>
    </div>

    <!-- User Edit Form Card -->
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="card detail-card">
                <!-- Card Header -->
                <div class="card-header bg-white py-3 border-bottom">
                    <h5 class="mb-0 text-dark">Chỉnh Sửa Thông Tin Người Dùng</h5>
                </div>

                <!-- Card Body -->
                <div class="card-body p-0">
                    <form:form method="post" action="/admin/user/edit" modelAttribute="currentUser" class="needs-validation" novalidate="true">
                        <!-- Hidden field cho ID -->
                        <form:input type="hidden" path="id" />

                        <!-- User ID (Read-only) -->
                        <div class="info-item">
                            <div class="row">
                                <div class="col-sm-3">
                                    <label class="info-label">ID</label>
                                </div>
                                <div class="col-sm-9">
                                    <div class="form-control readonly-field" style="border: none; background-color: transparent; padding: 0;">
                                            ${currentUser.id}
                                    </div>
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
                                    <form:input type="text"
                                                class="form-control"
                                                path="fullName"
                                                placeholder="Nhập họ và tên đầy đủ"
                                                required="true" />
                                    <div class="invalid-feedback">
                                        Họ và tên quá ngắn.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Email (Read-only) -->
                        <div class="info-item">
                            <div class="row">
                                <div class="col-sm-3">
                                    <label class="info-label">Email</label>
                                </div>
                                <div class="col-sm-9">
                                    <form:input type="email"
                                                class="form-control readonly-field"
                                                path="email"
                                                readonly="true" />
                                    <small class="text-muted">Email không thể thay đổi</small>
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
                                    <form:input type="tel"
                                                class="form-control"
                                                path="phone"
                                                placeholder="Nhập số điện thoại"
                                                required="true" />
                                    <div class="invalid-feedback">
                                        Vui lòng nhập số điện thoại hợp lệ.
                                    </div>
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
                                    <form:textarea class="form-control"
                                                   path="address"
                                                   rows="3"
                                                   placeholder="Nhập địa chỉ đầy đủ"
                                                   required="true" />
                                    <div class="invalid-feedback">
                                        Địa chỉ quá ngắn.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Password Note -->
                        <div class="info-item">
                            <div class="alert alert-info d-flex align-items-center mb-0" role="alert">
                                <i class="fas fa-info-circle me-2"></i>
                                <div>
                                    <strong>Lưu ý:</strong> Mật khẩu không được hiển thị và sẽ không bị thay đổi khi cập nhật thông tin.
                                </div>
                            </div>
                        </div>
                    </form:form>
                </div>

                <!-- Card Footer -->
                <div class="card-footer bg-light">
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-warning" onclick="resetForm()">
                            <i class="fas fa-undo me-1"></i>
                            Hoàn tác
                        </button>
                        <button type="submit" form="userEditForm" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i>
                            Cập nhật
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Success/Error Messages -->
<c:if test="${not empty successMessage}">
    <div class="position-fixed top-0 end-0 p-3" style="z-index: 1050">
        <div class="toast show" role="alert">
            <div class="toast-header bg-success text-white">
                <i class="fas fa-check-circle me-2"></i>
                <strong class="me-auto">Thành công</strong>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body">
                    ${successMessage}
            </div>
        </div>
    </div>
</c:if>

<c:if test="${not empty errorMessage}">
    <div class="position-fixed top-0 end-0 p-3" style="z-index: 1050">
        <div class="toast show" role="alert">
            <div class="toast-header bg-danger text-white">
                <i class="fas fa-exclamation-triangle me-2"></i>
                <strong class="me-auto">Lỗi</strong>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body">
                    ${errorMessage}
            </div>
        </div>
    </div>
</c:if>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<script>
    // Bootstrap form validation
    (function() {
        'use strict';
        window.addEventListener('load', function() {
            var forms = document.getElementsByClassName('needs-validation');
            var validation = Array.prototype.filter.call(forms, function(form) {
                form.addEventListener('submit', function(event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();

    // Custom form validation
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.querySelector('form');
        if (form) {
            // Add ID to form for reference
            form.id = 'userEditForm';

            form.addEventListener('submit', function(e) {
                const fullName = document.querySelector('input[name="fullName"]').value;
                const address = document.querySelector('textarea[name="address"]').value;
                const phone = document.querySelector('input[name="phone"]').value;

                let isValid = true;

                // Full name validation
                if (fullName.trim().length < 2) {
                    document.querySelector('input[name="fullName"]').classList.add('is-invalid');
                    isValid = false;
                } else {
                    document.querySelector('input[name="fullName"]').classList.remove('is-invalid');
                    document.querySelector('input[name="fullName"]').classList.add('is-valid');
                }

                // Address validation
                if (address.trim().length < 5) {
                    document.querySelector('textarea[name="address"]').classList.add('is-invalid');
                    isValid = false;
                } else {
                    document.querySelector('textarea[name="address"]').classList.remove('is-invalid');
                    document.querySelector('textarea[name="address"]').classList.add('is-valid');
                }

                // Phone validation
                const phoneRegex = /^[0-9]{10,11}$/;
                if (!phoneRegex.test(phone)) {
                    document.querySelector('input[name="phone"]').classList.add('is-invalid');
                    isValid = false;
                } else {
                    document.querySelector('input[name="phone"]').classList.remove('is-invalid');
                    document.querySelector('input[name="phone"]').classList.add('is-valid');
                }

                if (!isValid) {
                    e.preventDefault();
                    e.stopPropagation();
                }
            });
        }

        // Phone number validation - only allow digits
        const phoneInput = document.querySelector('input[name="phone"]');
        if (phoneInput) {
            phoneInput.addEventListener('input', function(e) {
                this.value = this.value.replace(/[^0-9]/g, '');
            });
        }
    });

    // Reset form function
    function resetForm() {
        const form = document.getElementById('userEditForm');
        if (form) {
            form.reset();
            // Remove validation classes
            form.classList.remove('was-validated');
            const inputs = form.querySelectorAll('.form-control');
            inputs.forEach(input => {
                input.classList.remove('is-valid', 'is-invalid');
            });
        }
    }

    // Auto-hide toast messages
    setTimeout(function() {
        const toasts = document.querySelectorAll('.toast');
        toasts.forEach(function(toast) {
            const bsToast = new bootstrap.Toast(toast);
            bsToast.hide();
        });
    }, 5000);
</script>
</body>
</html>