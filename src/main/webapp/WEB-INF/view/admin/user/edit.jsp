<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="author" content="Nganj"/>
    <title>Chỉnh Sửa Người Dùng - Admin</title>
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
        .readonly-field {
            background-color: #f8f9fa !important;
            border-color: #dee2e6 !important;
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
            background-color: #764ba2; /* hoặc gradient */
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
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

        .avatar-placeholder {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2.5rem;
            font-weight: bold;
            border: 3px solid #dee2e6;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
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

        .id-display {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            padding: 0.375rem 0.75rem;
            border-radius: 0.375rem;
            font-weight: 500;
            color: #6c757d;
        }

        /* Avatar color classes */
        .avatar-color-0 { background: linear-gradient(135deg, #0d6efd 0%, #0b5ed7 100%); }
        .avatar-color-1 { background: linear-gradient(135deg, #198754 0%, #157347 100%); }
        .avatar-color-2 { background: linear-gradient(135deg, #dc3545 0%, #b02a37 100%); }
        .avatar-color-3 { background: linear-gradient(135deg, #ffc107 0%, #ffca2c 100%); color: #212529 !important; }
        .avatar-color-4 { background: linear-gradient(135deg, #0dcaf0 0%, #3dd5f3 100%); color: #212529 !important; }
        .avatar-color-5 { background: linear-gradient(135deg, #6c757d 0%, #5c636a 100%); }
        .avatar-color-6 { background: linear-gradient(135deg, #212529 0%, #000 100%); }
        .avatar-color-7 { background: linear-gradient(135deg, #6f42c1 0%, #5a32a3 100%); }
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
                <h1 class="mt-4">Chỉnh Sửa Người Dùng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/user">Người Dùng</a></li>
                    <li class="breadcrumb-item active">Chỉnh Sửa #${currentUser.id}</li>
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

                <!-- Avatar Color Helper Functions -->
                <c:set var="colorIndex" value="${currentUser.id % 8}" />
                <c:choose>
                    <c:when test="${colorIndex == 0}">
                        <c:set var="avatarColorClass" value="avatar-color-0" />
                    </c:when>
                    <c:when test="${colorIndex == 1}">
                        <c:set var="avatarColorClass" value="avatar-color-1" />
                    </c:when>
                    <c:when test="${colorIndex == 2}">
                        <c:set var="avatarColorClass" value="avatar-color-2" />
                    </c:when>
                    <c:when test="${colorIndex == 3}">
                        <c:set var="avatarColorClass" value="avatar-color-3" />
                    </c:when>
                    <c:when test="${colorIndex == 4}">
                        <c:set var="avatarColorClass" value="avatar-color-4" />
                    </c:when>
                    <c:when test="${colorIndex == 5}">
                        <c:set var="avatarColorClass" value="avatar-color-5" />
                    </c:when>
                    <c:when test="${colorIndex == 6}">
                        <c:set var="avatarColorClass" value="avatar-color-6" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="avatarColorClass" value="avatar-color-7" />
                    </c:otherwise>
                </c:choose>

                <!-- User Edit Form Card -->
                <div class="row justify-content-center">
                    <div class="col-lg-9 col-md-10">
                        <div class="card detail-card">
                            <!-- Card Header -->
                            <div class="card-header bg-white py-3 border-bottom">
                                <h5 class="mb-0 text-dark">Chỉnh Sửa Thông Tin Người Dùng</h5>
                            </div>

                            <!-- Card Body -->
                            <div class="card-body p-0">
                                <form:form method="post"
                                           action="/admin/user/edit"
                                           modelAttribute="currentUser"
                                           id="editUserForm"
                                           enctype="multipart/form-data">

                                    <!-- Hidden field cho ID -->
                                    <form:input type="hidden" path="id" />

                                    <!-- Avatar Upload -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label">Ảnh Đại Diện</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <div class="avatar-upload">
                                                    <div class="avatar-preview" onclick="document.getElementById('avatarFile').click()">
                                                        <c:choose>
                                                            <c:when test="${not empty currentUser.avatar}">
                                                                <img src="/images/avatar/${currentUser.avatar}"
                                                                     alt="Avatar của ${currentUser.fullName}"
                                                                     class="avatar-img"
                                                                     id="avatarImage"
                                                                     onerror="handleImageError(this)">
                                                                <div class="avatar-placeholder ${avatarColorClass}" id="avatarPlaceholder" style="display: none;">
                                                                    <c:choose>
                                                                        <c:when test="${not empty currentUser.fullName}">
                                                                            ${currentUser.fullName.substring(0,1).toUpperCase()}${currentUser.fullName.indexOf(' ') > 0 ? currentUser.fullName.substring(currentUser.fullName.indexOf(' ') + 1, currentUser.fullName.indexOf(' ') + 2).toUpperCase() : ''}
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            ${currentUser.email.substring(0,1).toUpperCase()}
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="avatar-placeholder ${avatarColorClass}" id="avatarPlaceholder">
                                                                    <c:choose>
                                                                        <c:when test="${not empty currentUser.fullName}">
                                                                            ${currentUser.fullName.substring(0,1).toUpperCase()}${currentUser.fullName.indexOf(' ') > 0 ? currentUser.fullName.substring(currentUser.fullName.indexOf(' ') + 1, currentUser.fullName.indexOf(' ') + 2).toUpperCase() : ''}
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            ${currentUser.email.substring(0,1).toUpperCase()}
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                                <img class="avatar-img" id="avatarImage" src="" style="display: none;">
                                                            </c:otherwise>
                                                        </c:choose>
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

                                    <!-- User ID (Read-only) -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label">ID</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <div class="id-display">${currentUser.id}</div>
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
                                                    <form:option value="">-- Chọn vai trò --</form:option>
                                                    <form:options items="${roles}" itemValue="id" itemLabel="name"/>
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

                                    <!-- Password Note -->
                                    <div class="info-item">
                                        <div class="alert alert-info d-flex align-items-center mb-0" role="alert">
                                            <i class="fas fa-info-circle me-2"></i>
                                            <div>
                                                <strong>Lưu ý:</strong> Mật khẩu không được hiển thị và sẽ không bị thay đổi khi cập nhật thông tin.
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Submit buttons inside form -->
                                    <div class="info-item">
                                        <div class="d-flex gap-2 justify-content-end">
                                            <button type="button" class="btn btn-outline-warning" onclick="resetForm()">
                                                <i class="fas fa-redo me-1"></i>
                                                Đặt lại
                                            </button>
                                            <a href="/admin/user" class="btn btn-outline-danger">
                                                <i class="fas fa-times me-1"></i>
                                                Hủy bỏ
                                            </a>
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-save me-1"></i>
                                                Cập nhật
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
    function previewAvatar(input) {
        if (input.files && input.files[0]) {
            const file = input.files[0];

            // Validate file size (5MB max)
            if (file.size > 5 * 1024 * 1024) {
                alert('Kích thước file quá lớn. Vui lòng chọn file nhỏ hơn 5MB.');
                input.value = '';
                return;
            }

            // Validate file type
            const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
            if (!allowedTypes.includes(file.type)) {
                alert('Định dạng file không được hỗ trợ. Vui lòng chọn file JPG, PNG hoặc GIF.');
                input.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                const avatarImage = document.getElementById('avatarImage');
                const placeholder = document.getElementById('avatarPlaceholder');

                if (avatarImage) {
                    avatarImage.src = e.target.result;
                    avatarImage.style.display = 'block';
                }

                if (placeholder) {
                    placeholder.style.display = 'none';
                }
            };
            reader.readAsDataURL(file);
        }
    }

    function handleImageError(img) {
        img.style.display = 'none';
        const placeholder = document.getElementById('avatarPlaceholder');
        if (placeholder) {
            placeholder.style.display = 'flex';
        }
    }

    function resetForm() {
        // Reset form fields
        document.getElementById('editUserForm').reset();

        // Reset validation classes
        document.querySelectorAll('.is-invalid').forEach(el => el.classList.remove('is-invalid'));

        // Reset avatar preview
        const avatarImage = document.getElementById('avatarImage');
        const placeholder = document.getElementById('avatarPlaceholder');
        const originalAvatar = '${currentUser.avatar}';

        if (originalAvatar && originalAvatar.trim() !== '') {
            if (avatarImage) {
                avatarImage.src = '/images/avatar/' + originalAvatar;
                avatarImage.style.display = 'block';
            }
            if (placeholder) {
                placeholder.style.display = 'none';
            }
        } else {
            if (avatarImage) {
                avatarImage.src = '';
                avatarImage.style.display = 'none';
            }
            if (placeholder) {
                placeholder.style.display = 'flex';
            }
        }
    }

    // Auto-hide toasts
    setTimeout(function() {
        document.querySelectorAll('.toast').forEach(function(toast) {
            if (typeof bootstrap !== 'undefined' && bootstrap.Toast) {
                const bsToast = new bootstrap.Toast(toast);
                bsToast.hide();
            }
        });
    }, 5000);
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="/js/scripts.js"></script>
</body>
</html>