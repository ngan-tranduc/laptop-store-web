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
    <title>Chỉnh Sửa Sản Phẩm - Admin</title>
    <link href="/css/styles.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.5.1/css/all.css" />
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

        /* Product Image Upload Styles */
        .product-image-upload {
            position: relative;
            display: inline-block;
        }

        .product-image-preview {
            width: 200px;
            height: 200px;
            border: 3px dashed #dee2e6;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .product-image-preview:hover {
            border-color: #0d6efd;
            background: #e7f3ff;
        }

        .product-image-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 5px;
            display: block;
        }

        .product-image-preview .placeholder {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            font-size: 3rem;
            text-align: center;
            background: #f8f9fa;
        }

        .product-image-preview .placeholder-text {
            color: #6c757d;
            font-size: 0.875rem;
            margin-top: 0.5rem;
            text-align: center;
        }

        /* Hide placeholder when image is loaded */
        .product-image-preview.has-image .placeholder {
            display: none;
        }

        .product-image-preview.has-image img {
            display: block;
        }

        .product-image-edit {
            position: absolute;
            bottom: 10px;
            right: 10px;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #0d6efd;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
            z-index: 3;
        }

        .product-image-edit:hover {
            background: #0b5ed7;
            transform: scale(1.1);
        }

        .product-image-edit input[type="file"] {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }

        .product-image-edit i {
            font-size: 1rem;
            pointer-events: none;
        }

        .product-image-upload-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 200px;
            height: 200px;
            border-radius: 8px;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            opacity: 0;
            transition: opacity 0.3s ease;
            cursor: pointer;
            z-index: 4;
        }

        .product-image-upload:hover .product-image-upload-overlay {
            opacity: 1;
        }

        .image-info {
            margin-top: 0.5rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .number-input {
            max-width: 200px;
        }

        .price-input {
            max-width: 250px;
        }

        .current-image-info {
            font-size: 0.875rem;
            color: #6c757d;
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
                <h1 class="mt-4">Chỉnh Sửa Sản Phẩm</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/product">Sản Phẩm</a></li>
                    <li class="breadcrumb-item active">Chỉnh Sửa</li>
                </ol>

                <!-- Header -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="d-flex align-items-center justify-content-between">
                            <h2 class="mb-0 text-dark">ID: ${currentProduct.id}</h2>
                            <div class="d-flex gap-2">
                                <a href="/admin/product/${currentProduct.id}" class="btn btn-outline-info">
                                    <i class="fas fa-eye me-2"></i>
                                    Xem chi tiết
                                </a>
                                <a href="/admin/product" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>
                                    Quay lại
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Product Edit Form Card -->
                <div class="row justify-content-center">
                    <div class="col-lg-10 col-md-11">
                        <div class="card detail-card">
                            <!-- Card Header -->
                            <div class="card-header bg-white py-3 border-bottom">
                                <h5 class="mb-0 text-dark">Chỉnh Sửa Sản Phẩm: ${currentProduct.name}</h5>
                            </div>

                            <!-- Card Body -->
                            <div class="card-body p-0">
                                <form:form method="post"
                                           action="/admin/product/edit"
                                           modelAttribute="currentProduct"
                                           id="editProductForm"
                                           enctype="multipart/form-data">

                                    <!-- Hidden ID field -->
                                    <form:hidden path="id" />

                                    <!-- Product Image -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label">Hình Ảnh Sản Phẩm</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <div class="product-image-upload">
                                                    <div class="product-image-preview ${not empty currentProduct.image ? 'has-image' : ''}"
                                                         id="imagePreview"
                                                         onclick="document.getElementById('imageFile').click()">
                                                        <c:if test="${not empty currentProduct.image}">
                                                            <img id="productImage"
                                                                 src="/images/product/${currentProduct.image}"
                                                                 alt="Current Product Image"
                                                                 style="display: block;" />
                                                        </c:if>
                                                        <c:if test="${empty currentProduct.image}">
                                                            <img id="productImage" alt="Product Preview" style="display: none;" />
                                                        </c:if>
                                                        <div class="placeholder" id="imagePlaceholder">
                                                            <i class="fas fa-image"></i>
                                                            <div class="placeholder-text">Nhấp để chọn ảnh</div>
                                                        </div>
                                                    </div>
                                                    <div class="product-image-edit">
                                                        <input type="file" id="imageFile" name="imageFile" accept=".jpg,.jpeg,.png,.gif" onchange="previewProductImage(this)" />
                                                        <i class="fas fa-camera"></i>
                                                    </div>
                                                    <div class="product-image-upload-overlay" onclick="document.getElementById('imageFile').click()">
                                                        <i class="fas fa-camera"></i>
                                                    </div>
                                                </div>
                                                <c:if test="${not empty currentProduct.image}">
                                                    <div class="current-image-info">
                                                        <i class="fas fa-info-circle me-1"></i>
                                                        Ảnh hiện tại: ${currentProduct.image}
                                                    </div>
                                                </c:if>
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
                                                <c:set var="errorName">
                                                    <form:errors path="name" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <form:input type="text"
                                                            class="form-control ${not empty errorName? 'is-invalid':''}"
                                                            path="name"
                                                            placeholder="Nhập tên sản phẩm"
                                                            maxlength="100"
                                                />
                                                    ${errorName}
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Price and Quantity -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label required">Giá Sản Phẩm</label>
                                            </div>
                                            <div class="col-sm-4">
                                                <c:set var="errorPrice">
                                                    <form:errors path="price" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <div class="input-group price-input">
                                                    <form:input type="number"
                                                                class="form-control ${not empty errorPrice? 'is-invalid':''}"
                                                                path="price"
                                                                placeholder="0"
                                                                step="0.01"
                                                                min="0"
                                                    />
                                                    <span class="input-group-text">VND</span>
                                                </div>
                                                    ${errorPrice}
                                            </div>
                                            <div class="col-sm-2">
                                                <label class="info-label">Số Lượng</label>
                                            </div>
                                            <div class="col-sm-3">
                                                <c:set var="errorQuantity">
                                                    <form:errors path="quantity" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <form:input type="number"
                                                            class="form-control number-input ${not empty errorQuantity? 'is-invalid':''}"
                                                            path="quantity"
                                                            placeholder="0"
                                                            min="0"
                                                />
                                                    ${errorQuantity}
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Factory and Target -->
                                    <!-- Factory and Target -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label required">Nhà Sản Xuất</label>
                                            </div>
                                            <div class="col-sm-4">
                                                <c:set var="errorFactory">
                                                    <form:errors path="factory" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <form:select path="factory" class="form-select ${not empty errorFactory? 'is-invalid':''}">
                                                    <option value="">-- Chọn nhà sản xuất --</option>
                                                    <option value="Apple" ${currentProduct.factory == 'Apple' ? 'selected' : ''}>Apple</option>
                                                    <option value="Dell" ${currentProduct.factory == 'Dell' ? 'selected' : ''}>Dell</option>
                                                    <option value="Acer" ${currentProduct.factory == 'Acer' ? 'selected' : ''}>Acer</option>
                                                    <option value="MSI" ${currentProduct.factory == 'MSI' ? 'selected' : ''}>MSI</option>
                                                </form:select>
                                                    ${errorFactory}
                                            </div>
                                            <div class="col-sm-2">
                                                <label class="info-label required">Mục Đích Sử Dụng</label>
                                            </div>
                                            <div class="col-sm-3">
                                                <c:set var="errorTarget">
                                                    <form:errors path="target" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <form:select path="target" class="form-select ${not empty errorTarget? 'is-invalid':''}">
                                                    <option value="">-- Chọn mục đích --</option>
                                                    <option value="Gaming" ${currentProduct.target == 'Gaming' ? 'selected' : ''}>Gaming</option>
                                                    <option value="Văn phòng" ${currentProduct.target == 'Văn phòng' ? 'selected' : ''}>Văn phòng</option>
                                                    <option value="Đồ họa" ${currentProduct.target == 'Đồ họa' ? 'selected' : ''}>Đồ họa</option>
                                                    <option value="Sinh viên" ${currentProduct.target == 'Sinh viên' ? 'selected' : ''}>Sinh viên</option>
                                                    <option value="Doanh nhân" ${currentProduct.target == 'Doanh nhân' ? 'selected' : ''}>Doanh nhân</option>
                                                    <option value="Đa năng" ${currentProduct.target == 'Đa năng' ? 'selected' : ''}>Đa năng</option>
                                                </form:select>
                                                    ${errorTarget}
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
                                                <c:set var="errorShortDesc">
                                                    <form:errors path="shortDesc" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <form:textarea class="form-control ${not empty errorShortDesc? 'is-invalid':''}"
                                                               path="shortDesc"
                                                               rows="3"
                                                               placeholder="Nhập mô tả ngắn về sản phẩm (tối đa 500 ký tự)"
                                                               maxlength="500"
                                                />
                                                    ${errorShortDesc}
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Detail Description -->
                                    <div class="info-item">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <label class="info-label required">Mô Tả Chi Tiết</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <c:set var="errorDetailDesc">
                                                    <form:errors path="detailDesc" cssClass="invalid-feedback"/>
                                                </c:set>
                                                <form:textarea class="form-control ${not empty errorDetailDesc? 'is-invalid':''}"
                                                               path="detailDesc"
                                                               rows="6"
                                                               placeholder="Nhập mô tả chi tiết về sản phẩm (tối đa 2000 ký tự)"
                                                               maxlength="2000"
                                                />
                                                    ${errorDetailDesc}
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Sold (Keep the current value) -->
                                    <form:hidden path="sold" />

                                    <!-- Submit buttons -->
                                    <div class="info-item">
                                        <div class="d-flex gap-2 justify-content-end">
                                            <button type="button" class="btn btn-outline-warning" onclick="resetForm()">
                                                <i class="fas fa-redo me-1"></i>
                                                Khôi phục
                                            </button>
                                            <a href="/admin/product" class="btn btn-outline-danger">
                                                <i class="fas fa-times me-1"></i>
                                                Hủy bỏ
                                            </a>
                                            <button type="submit" class="btn btn-success">
                                                <i class="fas fa-save me-1"></i>
                                                Lưu thay đổi
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

<!-- Product Image Upload Script -->
<script>
    // Store original values for reset functionality
    const originalValues = {
        name: '${currentProduct.name}',
        price: '${currentProduct.price}',
        quantity: '${currentProduct.quantity}',
        factory: '${currentProduct.factory}',
        target: '${currentProduct.target}',
        shortDesc: '${currentProduct.shortDesc}',
        detailDesc: '${currentProduct.detailDesc}',
        image: '${currentProduct.image}'
    };

    // Product image preview
    function previewProductImage(input) {
        const img = document.getElementById('productImage');
        const placeholder = document.getElementById('imagePlaceholder');
        const preview = document.getElementById('imagePreview');

        if (input.files && input.files[0]) {
            const file = input.files[0];

            // Check file size (5MB limit)
            if (file.size > 5 * 1024 * 1024) {
                alert('Kích thước file quá lớn! Vui lòng chọn file nhỏ hơn 5MB.');
                input.value = '';
                return;
            }

            // Check file type
            const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
            if (!allowedTypes.includes(file.type)) {
                alert('Định dạng file không hỗ trợ! Vui lòng chọn file JPG, PNG hoặc GIF.');
                input.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                img.src = e.target.result;
                img.style.display = 'block';
                preview.classList.add('has-image');
            };
            reader.readAsDataURL(file);
        } else {
            // Reset to original image if no file selected
            if (originalValues.image) {
                img.src = '/images/product/' + originalValues.image;
                img.style.display = 'block';
                preview.classList.add('has-image');
            } else {
                img.src = '';
                img.style.display = 'none';
                preview.classList.remove('has-image');
            }
        }
    }

    // Reset form function
    function resetForm() {
        const form = document.getElementById('editProductForm');
        const img = document.getElementById('productImage');
        const preview = document.getElementById('imagePreview');
        const fileInput = document.getElementById('imageFile');

        // Reset to original values
        form.elements['name'].value = originalValues.name;
        form.elements['price'].value = originalValues.price;
        form.elements['quantity'].value = originalValues.quantity;
        form.elements['factory'].value = originalValues.factory;
        form.elements['target'].value = originalValues.target;
        form.elements['shortDesc'].value = originalValues.shortDesc;
        form.elements['detailDesc'].value = originalValues.detailDesc;

        // Reset image
        fileInput.value = '';
        if (originalValues.image) {
            img.src = '/images/product/' + originalValues.image;
            img.style.display = 'block';
            preview.classList.add('has-image');
        } else {
            img.src = '';
            img.style.display = 'none';
            preview.classList.remove('has-image');
        }

        // Clear validation errors
        const errorElements = form.querySelectorAll('.is-invalid');
        errorElements.forEach(element => {
            element.classList.remove('is-invalid');
        });
    }

    // Initialize on page load
    document.addEventListener('DOMContentLoaded', function() {
        const img = document.getElementById('productImage');
        const preview = document.getElementById('imagePreview');

        // Set initial image state
        if (originalValues.image) {
            preview.classList.add('has-image');
        } else {
            preview.classList.remove('has-image');
        }
    });
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="/js/scripts.js"></script>
</body>
</html>