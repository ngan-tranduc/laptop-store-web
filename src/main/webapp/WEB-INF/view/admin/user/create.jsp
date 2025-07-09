<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="author" content="Nganj"/>
    <title>Admin - Tạo Người Dùng Mới</title>
    <link href="/css/styles.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#avatarPreview").attr("src", imgURL);
                $("#avatarPreview").css({ "display": "block" });
            });
        });
    </script>

    <style>
        .detail-card {
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            border: 1px solid #dee2e6;
        }
        .form-control, .form-select {
            border: 1px solid #dee2e6;
            border-radius: 0.375rem;
        }
        .form-control:focus, .form-select:focus {
            border-color: #86b7fe;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }
        .required::after {
            content: " *";
            color: #dc3545;
        }
        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 0.5rem;
        }
        .avatar-upload {
            position: relative;
            max-width: 200px;
            margin: 0 auto;
        }
        .avatar-preview {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 3px solid #dee2e6;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            margin: 0 auto;
            position: relative;
        }
        .avatar-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none; /* Ẩn ảnh khi chưa chọn */
        }
        .avatar-preview .placeholder {
            color: #6c757d;
            font-size: 4rem;
        }
        .avatar-edit {
            position: absolute;
            bottom: 0;
            right: 0;
            background: #007bff;
            color: white;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: 3px solid white;
            transition: all 0.3s ease;
        }
        .avatar-edit:hover {
            background: #0056b3;
            transform: scale(1.1);
        }
        .avatar-edit input {
            position: absolute;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }
        .form-section {
            background: white;
            padding: 1.5rem;
            border-radius: 0.375rem;
            margin-bottom: 1.5rem;
            border: 1px solid #dee2e6;
        }
        .section-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #495057;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #e9ecef;
        }
        .password-strength {
            height: 4px;
            background: #e9ecef;
            border-radius: 2px;
            margin-top: 0.5rem;
            overflow: hidden;
        }
        .password-strength-bar {
            height: 100%;
            transition: all 0.3s ease;
            border-radius: 2px;
        }
        .strength-weak { background: #dc3545; width: 25%; }
        .strength-fair { background: #ffc107; width: 50%; }
        .strength-good { background: #28a745; width: 75%; }
        .strength-strong { background: #20c997; width: 100%; }
        .password-requirements {
            font-size: 0.875rem;
            color: #6c757d;
            margin-top: 0.5rem;
        }
        .requirement {
            display: flex;
            align-items: center;
            margin-bottom: 0.25rem;
        }
        .requirement i {
            margin-right: 0.5rem;
            width: 12px;
        }
        .requirement.met {
            color: #28a745;
        }
        .requirement.unmet {
            color: #dc3545;
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
                <h1 class="mt-4">Quản Lý Người Dùng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/user">Người Dùng</a></li>
                    <li class="breadcrumb-item active">Tạo Người Dùng Mới</li>
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

                <!-- Create User Form -->
                <form:form action="/admin/user/create" method="post" modelAttribute="newUser"
                           id="createUserForm" enctype="multipart/form-data">

                    <!-- Avatar Upload Section -->
                    <div class="form-section">
                        <h5 class="section-title">
                            <i class="fas fa-user-circle me-2"></i>
                            Ảnh Đại Diện
                        </h5>
                        <div class="row justify-content-center">
                            <div class="col-md-4">
                                <div class="avatar-upload">
                                    <div class="avatar-preview" id="avatarPreview">
                                        <i class="fas fa-user placeholder" id="placeholder"></i>
                                        <img id="avatarImage" alt="Avatar Preview" />
                                    </div>
                                    <div class="avatar-edit">
                                        <input type="file" id="avatarFile" name="avatarFile" accept=".jpg,.jpeg,.png,.gif" />
                                        <i class="fas fa-camera"></i>
                                    </div>
                                </div>
                                <div class="text-center mt-2">
                                    <small class="text-muted">
                                        Chọn ảnh JPG, PNG hoặc GIF (tối đa 2MB)
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Personal Information Section -->
                    <div class="form-section">
                        <h5 class="section-title">
                            <i class="fas fa-id-card me-2"></i>
                            Thông Tin Cá Nhân
                        </h5>
                        <div class="row">
                            <!-- Full Name -->
                            <div class="col-md-6 mb-3">
                                <label for="fullName" class="form-label required">Họ và Tên</label>
                                <form:input type="text"
                                            class="form-control"
                                            path="fullName"
                                            placeholder="Nhập họ và tên đầy đủ"
                                            required="true" />
                                <div class="invalid-feedback">
                                    Vui lòng nhập họ và tên (ít nhất 2 ký tự).
                                </div>
                            </div>

                            <!-- Email -->
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label required">Email</label>
                                <form:input type="email"
                                            class="form-control"
                                            path="email"
                                            placeholder="example@email.com"
                                            required="true" />
                                <div class="invalid-feedback">
                                    Vui lòng nhập email hợp lệ.
                                </div>
                            </div>

                            <!-- Phone -->
                            <div class="col-md-6 mb-3">
                                <label for="phone" class="form-label required">Số Điện Thoại</label>
                                <form:input type="tel"
                                            class="form-control"
                                            path="phone"
                                            placeholder="0123456789"
                                            required="true" />
                                <div class="invalid-feedback">
                                    Vui lòng nhập số điện thoại hợp lệ (10-11 số).
                                </div>
                            </div>

                            <!-- Role -->
                            <div class="col-md-6 mb-3">
                                <label for="role" class="form-label required">Vai Trò</label>
                                <form:select path="role.id" class="form-select" required="true">
                                    <option value="">-- Chọn vai trò --</option>
                                    <c:forEach items="${roles}" var="role">
                                        <option value="${role.id}">
                                                ${role.name}
                                        </option>
                                    </c:forEach>
                                </form:select>
                                <div class="invalid-feedback">
                                    Vui lòng chọn vai trò cho người dùng.
                                </div>
                            </div>

                            <!-- Address -->
                            <div class="col-12 mb-3">
                                <label for="address" class="form-label required">Địa Chỉ</label>
                                <form:textarea class="form-control"
                                               path="address"
                                               rows="3"
                                               placeholder="Nhập địa chỉ đầy đủ"
                                               required="true" />
                                <div class="invalid-feedback">
                                    Vui lòng nhập địa chỉ (ít nhất 5 ký tự).
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Security Information Section -->
                    <div class="form-section">
                        <h5 class="section-title">
                            <i class="fas fa-lock me-2"></i>
                            Thông Tin Bảo Mật
                        </h5>
                        <div class="row">
                            <!-- Password -->
                            <div class="col-md-6 mb-3">
                                <label for="password" class="form-label required">Mật Khẩu</label>
                                <div class="position-relative">
                                    <form:password class="form-control"
                                                   path="password"
                                                   placeholder="Nhập mật khẩu"
                                                   required="true"
                                                   id="passwordInput" />
<%--                                    <button type="button" class="btn btn-outline-secondary position-absolute end-0 top-0 h-100 px-3"--%>
<%--                                            id="togglePassword">--%>
<%--                                        <i class="fas fa-eye"></i>--%>
<%--                                    </button>--%>
                                </div>
<%--                                <div class="password-strength">--%>
<%--                                    <div class="password-strength-bar" id="strengthBar"></div>--%>
<%--                                </div>--%>

                            </div>

                            <!-- Confirm Password -->
                            <div class="col-md-6 mb-3">
                                <label for="confirmPassword" class="form-label required">Xác Nhận Mật Khẩu</label>
                                <input type="password"
                                       class="form-control"
                                       name="confirmPassword"
                                       placeholder="Nhập lại mật khẩu"
                                       required
                                       id="confirmPasswordInput" />
                                <div class="invalid-feedback">
                                    Mật khẩu xác nhận không khớp.
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="form-section">
                        <div class="d-flex gap-2 justify-content-end">
                            <button type="reset" class="btn btn-outline-secondary">
                                <i class="fas fa-redo me-2"></i>
                                Đặt Lại
                            </button>
                            <a href="/admin/user" class="btn btn-outline-danger">
                                <i class="fas fa-times me-2"></i>
                                Hủy Bỏ
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-check me-2"></i>
                                Tạo Người Dùng
                            </button>
                        </div>
                    </div>
                </form:form>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
    $(document).ready(() => {
        const avatarFile = $("#avatarFile");
        const avatarImage = $("#avatarImage");
        const placeholder = $("#placeholder");

        avatarFile.change(function (e) {
            const file = e.target.files[0];

            if (file) {
                // Kiểm tra kích thước file (2MB = 2 * 1024 * 1024 bytes)
                if (file.size > 2 * 1024 * 1024) {
                    alert("Kích thước file quá lớn. Vui lòng chọn file nhỏ hơn 2MB.");
                    return;
                }

                // Kiểm tra định dạng file
                const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
                if (!allowedTypes.includes(file.type)) {
                    alert("Định dạng file không hợp lệ. Vui lòng chọn file JPG, PNG hoặc GIF.");
                    return;
                }

                const imgURL = URL.createObjectURL(file);
                avatarImage.attr("src", imgURL);
                avatarImage.show(); // Hiện ảnh
                placeholder.hide(); // Ẩn placeholder

                // Giải phóng bộ nhớ khi không cần thiết
                avatarImage.on('load', function() {
                    URL.revokeObjectURL(imgURL);
                });
            }
        });
    });
</script>
<script>
    // Password visibility toggle
    document.getElementById('togglePassword').addEventListener('click', function() {
        const passwordInput = document.getElementById('passwordInput');
        const icon = this.querySelector('i');

        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    });

    // Password strength checker
    document.getElementById('passwordInput').addEventListener('input', function() {
        const password = this.value;
        const strengthBar = document.getElementById('strengthBar');

        // Check requirements
        const requirements = {
            length: password.length >= 8,
            uppercase: /[A-Z]/.test(password),
            lowercase: /[a-z]/.test(password),
            number: /\d/.test(password)
        };

        // Update requirement indicators
        updateRequirement('lengthReq', requirements.length);
        updateRequirement('uppercaseReq', requirements.uppercase);
        updateRequirement('lowercaseReq', requirements.lowercase);
        updateRequirement('numberReq', requirements.number);

        // Calculate strength
        const metRequirements = Object.values(requirements).filter(Boolean).length;

        // Update strength bar
        strengthBar.className = 'password-strength-bar';
        if (metRequirements === 1) {
            strengthBar.classList.add('strength-weak');
        } else if (metRequirements === 2) {
            strengthBar.classList.add('strength-fair');
        } else if (metRequirements === 3) {
            strengthBar.classList.add('strength-good');
        } else if (metRequirements === 4) {
            strengthBar.classList.add('strength-strong');
        }
    });

    function updateRequirement(id, met) {
        const element = document.getElementById(id);
        const icon = element.querySelector('i');

        if (met) {
            element.classList.remove('unmet');
            element.classList.add('met');
            icon.classList.remove('fa-times');
            icon.classList.add('fa-check');
        } else {
            element.classList.remove('met');
            element.classList.add('unmet');
            icon.classList.remove('fa-check');
            icon.classList.add('fa-times');
        }
    }

    // Form validation
    document.getElementById('createUserForm').addEventListener('submit', function(e) {
        let isValid = true;

        // Get form elements
        const fullName = document.querySelector('input[name="fullName"]');
        const email = document.querySelector('input[name="email"]');
        const phone = document.querySelector('input[name="phone"]');
        const address = document.querySelector('textarea[name="address"]');
        const password = document.querySelector('input[name="password"]');
        const confirmPassword = document.querySelector('input[name="confirmPassword"]');
        const role = document.querySelector('select[name="role.id"]');

        // Validate full name
        if (fullName.value.trim().length < 2) {
            setInvalid(fullName);
            isValid = false;
        } else {
            setValid(fullName);
        }

        // Validate email
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email.value)) {
            setInvalid(email);
            isValid = false;
        } else {
            setValid(email);
        }

        // Validate phone
        const phoneRegex = /^[0-9]{10,11}$/;
        if (!phoneRegex.test(phone.value)) {
            setInvalid(phone);
            isValid = false;
        } else {
            setValid(phone);
        }

        // Validate address
        if (address.value.trim().length < 5) {
            setInvalid(address);
            isValid = false;
        } else {
            setValid(address);
        }

        // Validate role
        if (!role.value) {
            setInvalid(role);
            isValid = false;
        } else {
            setValid(role);
        }

        // Validate password
        const passwordValue = password.value;
        const passwordValid = passwordValue.length >= 8 &&
            /[A-Z]/.test(passwordValue) &&
            /[a-z]/.test(passwordValue) &&
            /\d/.test(passwordValue);

        if (!passwordValid) {
            setInvalid(password);
            isValid = false;
        } else {
            setValid(password);
        }

        // Validate confirm password
        if (confirmPassword.value !== passwordValue) {
            setInvalid(confirmPassword);
            isValid = false;
        } else {
            setValid(confirmPassword);
        }

        if (!isValid) {
            e.preventDefault();
            e.stopPropagation();
        }
    });

    function setValid(element) {
        element.classList.remove('is-invalid');
        element.classList.add('is-valid');
    }

    function setInvalid(element) {
        element.classList.remove('is-valid');
        element.classList.add('is-invalid');
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