<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo Người Dùng Mới</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="form-container">
                <!-- Header -->
                <div class="form-header p-4 text-center">
                    <h2 class="mb-0">
                        <i class="bi bi-person-plus-fill me-2"></i>
                        Tạo Người Dùng Mới
                    </h2>
                    <p class="mb-0 mt-2 opacity-75">Vui lòng điền đầy đủ thông tin bên dưới</p>
                </div>

                <!-- Form -->
                <div class="p-4">
                    <form action="createUser" method="post" id="createUserForm" novalidate>
                        <div class="row">
                            <!-- Email -->
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label required">Email</label>
                                <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-envelope"></i>
                                        </span>
                                    <input type="email"
                                           class="form-control"
                                           id="email"
                                           name="email"
                                           placeholder="example@email.com"
                                           required>
                                    <div class="invalid-feedback">
                                        Vui lòng nhập email hợp lệ.
                                    </div>
                                </div>
                            </div>

                            <!-- Password -->
                            <div class="col-md-6 mb-3">
                                <label for="password" class="form-label required">Mật khẩu</label>
                                <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-lock"></i>
                                        </span>
                                    <input type="password"
                                           class="form-control"
                                           id="password"
                                           name="password"
                                           placeholder="Nhập mật khẩu"
                                           minlength="6"
                                           required>
                                    <div class="invalid-feedback">
                                        Mật khẩu phải có ít nhất 6 ký tự.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Full Name -->
                        <div class="mb-3">
                            <label for="fullName" class="form-label required">Họ và tên</label>
                            <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-person"></i>
                                    </span>
                                <input type="text"
                                       class="form-control"
                                       id="fullName"
                                       name="fullName"
                                       placeholder="Nhập họ và tên đầy đủ"
                                       required>
                                <div class="invalid-feedback">
                                    Vui lòng nhập họ và tên.
                                </div>
                            </div>
                        </div>

                        <!-- Address -->
                        <div class="mb-3">
                            <label for="address" class="form-label required">Địa chỉ</label>
                            <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-geo-alt"></i>
                                    </span>
                                <textarea class="form-control"
                                          id="address"
                                          name="address"
                                          rows="3"
                                          placeholder="Nhập địa chỉ đầy đủ"
                                          required></textarea>
                                <div class="invalid-feedback">
                                    Vui lòng nhập địa chỉ.
                                </div>
                            </div>
                        </div>

                        <!-- Phone -->
                        <div class="mb-4">
                            <label for="phone" class="form-label required">Số điện thoại</label>
                            <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-telephone"></i>
                                    </span>
                                <input type="tel"
                                       class="form-control"
                                       id="phone"
                                       name="phone"
                                       placeholder="Nhập số điện thoại"
                                       pattern="[0-9]{10,11}"
                                       required>
                                <div class="invalid-feedback">
                                    Vui lòng nhập số điện thoại hợp lệ (10-11 số).
                                </div>
                            </div>
                        </div>

                        <!-- Buttons -->
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="userList" class="btn btn-outline-secondary me-md-2">
                                <i class="bi bi-arrow-left me-1"></i>
                                Quay lại
                            </a>
                            <button type="reset" class="btn btn-outline-warning me-md-2">
                                <i class="bi bi-arrow-clockwise me-1"></i>
                                Đặt lại
                            </button>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-circle me-1"></i>
                                Tạo người dùng
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Success/Error Messages -->
<% if(request.getAttribute("successMessage") != null) { %>
<div class="position-fixed top-0 end-0 p-3" style="z-index: 1050">
    <div class="toast show" role="alert">
        <div class="toast-header bg-success text-white">
            <i class="bi bi-check-circle-fill me-2"></i>
            <strong class="me-auto">Thành công</strong>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
            <%= request.getAttribute("successMessage") %>
        </div>
    </div>
</div>
<% } %>

<% if(request.getAttribute("errorMessage") != null) { %>
<div class="position-fixed top-0 end-0 p-3" style="z-index: 1050">
    <div class="toast show" role="alert">
        <div class="toast-header bg-danger text-white">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <strong class="me-auto">Lỗi</strong>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
            <%= request.getAttribute("errorMessage") %>
        </div>
    </div>
</div>
<% } %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Form Validation Script -->
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
    document.getElementById('createUserForm').addEventListener('submit', function(e) {
        const form = this;
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;
        const fullName = document.getElementById('fullName').value;
        const address = document.getElementById('address').value;
        const phone = document.getElementById('phone').value;

        let isValid = true;

        // Email validation
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            document.getElementById('email').classList.add('is-invalid');
            isValid = false;
        } else {
            document.getElementById('email').classList.remove('is-invalid');
            document.getElementById('email').classList.add('is-valid');
        }

        // Password validation
        if (password.length < 6) {
            document.getElementById('password').classList.add('is-invalid');
            isValid = false;
        } else {
            document.getElementById('password').classList.remove('is-invalid');
            document.getElementById('password').classList.add('is-valid');
        }

        // Full name validation
        if (fullName.trim().length < 2) {
            document.getElementById('fullName').classList.add('is-invalid');
            isValid = false;
        } else {
            document.getElementById('fullName').classList.remove('is-invalid');
            document.getElementById('fullName').classList.add('is-valid');
        }

        // Address validation
        if (address.trim().length < 5) {
            document.getElementById('address').classList.add('is-invalid');
            isValid = false;
        } else {
            document.getElementById('address').classList.remove('is-invalid');
            document.getElementById('address').classList.add('is-valid');
        }

        // Phone validation
        const phoneRegex = /^[0-9]{10,11}$/;
        if (!phoneRegex.test(phone)) {
            document.getElementById('phone').classList.add('is-invalid');
            isValid = false;
        } else {
            document.getElementById('phone').classList.remove('is-invalid');
            document.getElementById('phone').classList.add('is-valid');
        }

        if (!isValid) {
            e.preventDefault();
            e.stopPropagation();
        }
    });

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