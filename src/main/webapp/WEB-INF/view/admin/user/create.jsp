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
    <title>Tạo Người Dùng Mới - Admin</title>
    <link href="/css/styles.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
        .toast {
            min-width: 350px;
        }

        /* Avatar Upload Styles */
        .avatar-upload {
            position: relative;
            display: inline-block;
        }

        .avatar-preview {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 3px solid #dee2e6;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .avatar-preview:hover {
            border-color: #0d6efd;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .avatar-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
            position: absolute;
            top: 0;
            left: 0;
        }

        .avatar-preview .placeholder {
            color: white;
            font-size: 2.5rem;
            font-weight: bold;
            z-index: 1;
        }

        .avatar-preview img[src=""] {
            display: none;
        }

        .avatar-edit {
            position: absolute;
            bottom: 0;
            right: 0;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: #0d6efd;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }

        .avatar-edit:hover {
            background: #0b5ed7;
            transform: scale(1.1);
        }

        .avatar-edit input[type="file"] {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }

        .avatar-edit i {
            font-size: 0.9rem;
            pointer-events: none;
        }

        .avatar-upload-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            opacity: 0;
            transition: opacity 0.3s ease;
            cursor: pointer;
        }

        .avatar-upload:hover .avatar-upload-overlay {
            opacity: 1;
        }

        .avatar-info {
            margin-top: 0.5rem;
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
                <!-- Breadcrumb -->
                <h1 class="mt-4">Tạo Người Dùng Mới</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/user">Người Dùng</a></li>
                    <li class="breadcrumb-item active">Tạo Mới</li>
                </ol>

                <!-- Header -->
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

                <!-- User Create Form Card -->
                <div class="row justify-content-center">
                    <div class="col-lg-9 col-md-10">
                        <div class="card detail-card">
                            <!-- Card Header -->
                            <div class="card-header bg-white py-3 border-bottom">
                                <h5 class="mb-0 text-dark">Tạo Người Dùng Mới</h5>
                            </div>

                            <!-- Card Body -->
                            <div class="card-body p-0">
                                <form:form method="post"
                                           action="/admin/user/create"
                                           modelAttribute="newUser"
                                           id="createUserForm"
                                           enctype="multipart/form-data">

                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label">Ảnh Đại Diện</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <div class="avatar-upload">
                                                    <div class="avatar-preview" onclick="document.getElementById('avatarFile').click()">
                                                        <i class="fas fa-user" style="color: white; font-size: 2rem;"></i>

                                                        <img id="avatarImage" alt="Avatar Preview" src="" />
                                                    </div>
                                                    <div class="avatar-edit">
                                                        <input type="file" id="avatarFile" name="avatarFile" accept=".jpg,.jpeg,.png,.gif" onchange="previewAvatar(this)" />
                                                        <i class="fas fa-camera"></i>
                                                    </div>
                                                    <div class="avatar-upload-overlay" onclick="document.getElementById('avatarFile').click()">
                                                        <i class="fas fa-camera"></i>
                                                    </div>
                                                </div>
                                                <div class="avatar-info">
                                                    <small class="text-muted">Nhấp vào ảnh để thay đổi. Chấp nhận: JPG, PNG, GIF (tối đa 5MB)</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Full Name -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label required">Họ và Tên</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <c:set var="errorFullName">
                                                    <form:errors path="fullName" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <form:input type="text"
                                                            class="form-control ${not empty errorFullName? 'is-invalid':''}"
                                                            path="fullName"
                                                />
                                                    ${errorFullName}
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Email -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label required">Email</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <c:set var="errorEmail">
                                                    <form:errors path="email" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <form:input type="email"
                                                            class="form-control ${not empty errorEmail? 'is-invalid':''}"
                                                            path="email"
                                                />
                                                    ${errorEmail}
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Phone and Role on same row -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label">Số Điện Thoại</label>
                                            </div>
                                            <div class="col-sm-4">
                                                <c:set var="errorPhone">
                                                    <form:errors path="phone" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <form:input type="tel"
                                                            class="form-control ${not empty errorPhone? 'is-invalid':''}"
                                                            path="phone"
                                                />
                                                    ${errorPhone}
                                            </div>
                                            <div class="col-sm-2">
                                                <label class="info-label required">Vai Trò</label>
                                            </div>
                                            <div class="col-sm-3">
                                                <c:set var="errorRole">
                                                    <form:errors path="role.id" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <form:select path="role.id" class="form-select ${not empty errorRole? 'is-invalid':''}">
                                                    <option value="">-- Chọn vai trò --</option>
                                                    <c:forEach items="${roles}" var="role">
                                                        <option value="${role.id}">
                                                                ${role.name}
                                                        </option>
                                                    </c:forEach>
                                                </form:select>
                                                    ${errorRole}
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
                                                <c:set var="errorAddress">
                                                    <form:errors path="address" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <form:textarea class="form-control ${not empty errorAddress? 'is-invalid':''}"
                                                               path="address"
                                                               rows="3"
                                                />
                                                    ${errorAddress}
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Password -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label required">Mật Khẩu</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <c:set var="errorPassword">
                                                    <form:errors path="password" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <form:password class="form-control ${not empty errorPassword? 'is-invalid':''}"
                                                               path="password"
                                                               placeholder="Nhập mật khẩu"
                                                />
                                                    ${errorPassword}
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Confirm Password -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label required">Xác Nhận Mật Khẩu</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <input type="password"
                                                       class="form-control"
                                                       name="confirmPassword"
                                                />
                                                <div class="invalid-feedback">
                                                    Mật khẩu xác nhận không khớp.
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Submit buttons inside form -->
                                    <div class="info-item">
                                        <div class="d-flex gap-2 justify-content-end">
                                            <button type="reset" class="btn btn-outline-warning">
                                                <i class="fas fa-redo me-1"></i>
                                                Đặt lại
                                            </button>
                                            <a href="/admin/user" class="btn btn-outline-danger">
                                                <i class="fas fa-times me-1"></i>
                                                Hủy bỏ
                                            </a>
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-check me-1"></i>
                                                Tạo người dùng
                                            </button>
                                        </div>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp"/>
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

<!-- Avatar Upload Script -->
<script>
    document.getElementById('avatarFile').addEventListener('change', function(e) {
        var file = e.target.files[0];
        if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
                var img = document.getElementById('avatarImage');
                var placeholder = document.getElementById('placeholder');
                img.src = e.target.result;
                img.style.display = 'block';
                placeholder.style.display = 'none';
            };
            reader.readAsDataURL(file);
        }
    });

    // Form validation
    document.getElementById('createUserForm').addEventListener('submit', function(e) {
        var password = document.querySelector('input[name="password"]').value;
        var confirmPassword = document.querySelector('input[name="confirmPassword"]').value;

        var confirmField = document.querySelector('input[name="confirmPassword"]');
        var errorMessage = confirmField.nextElementSibling;

        if (password !== confirmPassword) {
            e.preventDefault();
            confirmField.classList.add('is-invalid');
            if (errorMessage) {
                errorMessage.style.display = 'block';
                errorMessage.innerText = 'Mật khẩu xác nhận không khớp';
            }
        } else {
            confirmField.classList.remove('is-invalid');
            if (errorMessage) {
                errorMessage.style.display = 'none';
                errorMessage.innerText = '';
            }
        }
    });

</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="/js/scripts.js"></script>
</body>
</html>