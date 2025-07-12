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
    <title>Tạo Sản Phẩm Mới - Admin</title>
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
        .image-upload {
            position: relative;
            max-width: 300px;
            margin: 0 auto;
        }
        .image-preview {
            width: 200px;
            height: 200px;
            border-radius: 8px;
            border: 3px solid #dee2e6;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            margin: 0 auto;
            position: relative;
        }
        .image-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none;
        }
        .image-preview .placeholder {
            color: #6c757d;
            font-size: 3rem;
        }
        .image-edit {
            position: absolute;
            bottom: 5px;
            right: 5px;
            background: #007bff;
            color: white;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: 2px solid white;
            transition: all 0.3s ease;
        }
        .image-edit:hover {
            background: #0056b3;
            transform: scale(1.1);
        }
        .image-edit input {
            position: absolute;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }
        .price-input {
            position: relative;
        }
        .price-input .input-group-text {
            background-color: #f8f9fa;
            border-right: none;
        }
        .price-input .form-control {
            border-left: none;
        }
        .price-input .form-control:focus {
            border-color: #86b7fe;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
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
                <h1 class="mt-4">Tạo Sản Phẩm Mới</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/product">Sản Phẩm</a></li>
                    <li class="breadcrumb-item active">Tạo Mới</li>
                </ol>

                <!-- Header -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="d-flex align-items-center justify-content-between">
                            <h2 class="mb-0 text-dark"></h2>
                            <a href="/admin/product" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i>
                                Quay lại
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Product Create Form Card -->
                <div class="row justify-content-center">
                    <div class="col-lg-10 col-md-10">
                        <div class="card detail-card">
                            <!-- Card Header -->
                            <div class="card-header bg-white py-3 border-bottom">
                                <h5 class="mb-0 text-dark">Thông Tin Sản Phẩm</h5>
                            </div>

                            <!-- Card Body -->
                            <div class="card-body p-0">
                                <form:form method="post"
                                           action="/admin/product/create"
                                           modelAttribute="newProduct"
                                           id="createProductForm"
                                           enctype="multipart/form-data">

                                    <!-- Product Image Upload -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label">Ảnh Sản Phẩm</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <div class="image-upload">
                                                    <div class="image-preview" id="imagePreview">
                                                        <i class="fas fa-image placeholder" id="placeholder"></i>
                                                        <img id="productImage" alt="Product Preview" />
                                                    </div>
                                                    <div class="image-edit">
                                                        <input type="file" id="imageFile" name="imageFile" accept=".jpg,.jpeg,.png,.gif" />
                                                        <i class="fas fa-camera"></i>
                                                    </div>
                                                </div>
                                                <div class="text-center mt-2">
                                                    <small class="text-muted">
                                                        Chọn ảnh JPG, PNG hoặc GIF (tối đa 5MB)
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Product Name -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label required">Tên Sản Phẩm</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <form:input type="text"
                                                            class="form-control"
                                                            path="name"
                                                            placeholder="Nhập tên sản phẩm"
                                                            required="true" />
                                                <div class="invalid-feedback">
                                                    Tên sản phẩm không được để trống.
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Price and Quantity on same row -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label required">Giá</label>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="price-input">
                                                    <div class="input-group">
                                                        <span class="input-group-text">₫</span>
                                                        <form:input type="number"
                                                                    class="form-control"
                                                                    path="price"
                                                                    placeholder="0"
                                                                    min="0"
                                                                    step="1000"
                                                                    required="true" />
                                                    </div>
                                                </div>
                                                <div class="invalid-feedback">
                                                    Vui lòng nhập giá hợp lệ.
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <label class="info-label required">Số Lượng</label>
                                            </div>
                                            <div class="col-sm-3">
                                                <form:input type="number"
                                                            class="form-control"
                                                            path="quantity"
                                                            placeholder="0"
                                                            min="0"
                                                            required="true" />
                                                <div class="invalid-feedback">
                                                    Vui lòng nhập số lượng hợp lệ.
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Factory and Target on same row -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label required">Nhà Sản Xuất</label>
                                            </div>
                                            <div class="col-sm-4">
                                                <form:select path="factory" class="form-select" required="true">
                                                    <option value="">-- Chọn nhà sản xuất --</option>
                                                    <option value="Apple">Apple</option>
                                                    <option value="Dell">Dell</option>
                                                    <option value="HP">HP</option>
                                                    <option value="Lenovo">Lenovo</option>
                                                    <option value="Asus">Asus</option>
                                                    <option value="Acer">Acer</option>
                                                    <option value="MSI">MSI</option>
                                                    <option value="Samsung">Samsung</option>
                                                    <option value="LG">LG</option>
                                                </form:select>
                                                <div class="invalid-feedback">
                                                    Vui lòng chọn nhà sản xuất.
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <label class="info-label required">Mục Đích Sử Dụng</label>
                                            </div>
                                            <div class="col-sm-3">
                                                <form:select path="target" class="form-select" required="true">
                                                    <option value="">-- Chọn mục đích --</option>
                                                    <option value="Gaming">Gaming</option>
                                                    <option value="Văn phòng">Văn phòng</option>
                                                    <option value="Đồ họa">Đồ họa</option>
                                                    <option value="Sinh viên">Sinh viên</option>
                                                    <option value="Doanh nhân">Doanh nhân</option>
                                                    <option value="Đa năng">Đa năng</option>
                                                </form:select>
                                                <div class="invalid-feedback">
                                                    Vui lòng chọn mục đích sử dụng.
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Short Description -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label required">Mô Tả Ngắn</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <form:textarea class="form-control"
                                                               path="shortDesc"
                                                               rows="3"
                                                               placeholder="Nhập mô tả ngắn gọn về sản phẩm"
                                                               required="true" />
                                                <div class="invalid-feedback">
                                                    Mô tả ngắn không được để trống.
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Detailed Description -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label required">Mô Tả Chi Tiết</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <form:textarea class="form-control"
                                                               path="detailDesc"
                                                               rows="6"
                                                               placeholder="Nhập mô tả chi tiết về sản phẩm, bao gồm thông số kỹ thuật, tính năng đặc biệt..."
                                                               required="true" />
                                                <div class="invalid-feedback">
                                                    Mô tả chi tiết không được để trống.
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
                                            <a href="/admin/product" class="btn btn-outline-danger">
                                                <i class="fas fa-times me-1"></i>
                                                Hủy bỏ
                                            </a>
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-check me-1"></i>
                                                Tạo sản phẩm
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

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="/js/scripts.js"></script>
<script>
    // Product image preview functionality
    document.getElementById('imageFile').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const img = document.getElementById('productImage');
                const placeholder = document.getElementById('placeholder');
                img.src = e.target.result;
                img.style.display = 'block';
                placeholder.style.display = 'none';
            };
            reader.readAsDataURL(file);
        }
    });

    // Form validation
    document.getElementById('createProductForm').addEventListener('submit', function(e) {
        const price = document.querySelector('input[name="price"]').value;
        const quantity = document.querySelector('input[name="quantity"]').value;

        if (price <= 0) {
            e.preventDefault();
            alert('Giá sản phẩm phải lớn hơn 0');
            return;
        }

        if (quantity < 0) {
            e.preventDefault();
            alert('Số lượng không được âm');
            return;
        }
    });
</script>
</body>
</html>