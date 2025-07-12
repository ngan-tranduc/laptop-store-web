<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="author" content="Nganj"/>
    <title>Chi Tiết Sản Phẩm - Admin</title>
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
        .product-image-container {
            position: relative;
            display: inline-block;
        }
        .product-img {
            width: 200px;
            height: 200px;
            border-radius: 8px;
            object-fit: cover;
            border: 2px solid #dee2e6;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .product-placeholder {
            width: 200px;
            height: 200px;
            border-radius: 8px;
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
            border: 2px solid #dee2e6;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .price-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: #dc3545;
        }
        .stock-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .stock-in {
            background-color: #28a745;
            color: white;
        }
        .stock-low {
            background-color: #ffc107;
            color: #212529;
        }
        .stock-out {
            background-color: #dc3545;
            color: white;
        }
        .sold-count {
            background-color: #17a2b8;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .description-text {
            line-height: 1.6;
            max-height: 120px;
            overflow-y: auto;
            padding: 0.75rem;
            background-color: #f8f9fa;
            border-radius: 6px;
            border: 1px solid #e9ecef;
        }
        .factory-badge {
            background-color: #6f42c1;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
        }
        .target-badge {
            background-color: #fd7e14;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
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
                <h1 class="mt-4">Chi Tiết Sản Phẩm</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/product">Product</a></li>
                    <li class="breadcrumb-item active">View #${product.id}</li>
                </ol>

                <!-- Back Button -->
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

                <!-- Product Detail Card -->
                <div class="row justify-content-center">
                    <div class="col-lg-9 col-md-10">
                        <div class="card detail-card">
                            <!-- Card Header -->
                            <div class="card-header bg-white py-3 border-bottom">
                                <h5 class="mb-0 text-dark">Thông Tin Sản Phẩm</h5>
                            </div>

                            <!-- Card Body -->
                            <div class="card-body p-0">
                                <!-- Product Image -->
                                <div class="info-item">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label class="info-label">Hình Ảnh</label>
                                        </div>
                                        <div class="col-sm-9">
                                            <div class="product-image-container">
                                                <c:choose>
                                                    <c:when test="${not empty product.image}">
                                                        <img src="/images/product/${product.image}"
                                                             alt="Hình ảnh ${product.name}"
                                                             class="product-img"
                                                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                        <div class="product-placeholder" style="display: none;">
                                                            <i class="fas fa-image"></i>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="product-placeholder">
                                                            <i class="fas fa-image"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Product ID -->
                                <div class="info-item">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label class="info-label">ID</label>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="info-value mb-0">${product.id}</p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Product Name -->
                                <div class="info-item">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label class="info-label">Tên Sản Phẩm</label>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="info-value mb-0 fw-bold">${product.name}</p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Price -->
                                <div class="info-item">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label class="info-label">Giá</label>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="price-value mb-0">
                                                <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND"/>
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Quantity & Sold Count -->
                                <div class="info-item">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label class="info-label d-inline me-2">Số Lượng:</label>
                                            <c:choose>
                                                <c:when test="${product.quantity > 10}">
                                                    <span class="stock-badge stock-in">
                                                        <i class="bi bi-check-circle me-1"></i>
                                                        Còn hàng (${product.quantity})
                                                    </span>
                                                </c:when>
                                                <c:when test="${product.quantity > 0}">
                                                    <span class="stock-badge stock-low">
                                                        <i class="bi bi-exclamation-triangle me-1"></i>
                                                        Sắp hết (${product.quantity})
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="stock-badge stock-out">
                                                        <i class="bi bi-x-circle me-1"></i>
                                                        Hết hàng (${product.quantity})
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="col-sm-6">
                                            <label class="info-label d-inline me-2">Đã Bán:</label>
                                            <span class="sold-count">
                                                <i class="bi bi-cart-check me-1"></i>
                                                ${product.sold}
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Factory & Target -->
                                <div class="info-item">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label class="info-label d-inline me-2">Đối Tượng:</label>
                                            <span class="target-badge">
                                                <i class="bi bi-people me-1"></i>
                                                ${product.target}
                                            </span>
                                        </div>
                                        <div class="col-sm-6">
                                            <label class="info-label d-inline me-2">Nhà Sản Xuất:</label>
                                            <span class="factory-badge">
                                                <i class="bi bi-building me-1"></i>
                                                ${product.factory}
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Short Description -->
                                <div class="info-item">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label class="info-label">Mô Tả Ngắn</label>
                                        </div>
                                        <div class="col-sm-9">
                                            <div class="description-text">
                                                ${product.shortDesc}
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Detail Description -->
                                <div class="info-item">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label class="info-label">Mô Tả Chi Tiết</label>
                                        </div>
                                        <div class="col-sm-9">
                                            <div class="description-text">
                                                ${product.detailDesc}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Card Footer -->
                            <div class="card-footer bg-light">
                                <div class="d-flex gap-2 justify-content-end">
                                    <a href="/admin/product/edit/${product.id}" class="btn btn-primary">
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
                Bạn có chắc chắn muốn xóa sản phẩm "<strong>${product.name}</strong>" không? Hành động này không thể hoàn tác.
            </div>
            <div class="modal-footer">
                <form id="deleteForm" method="POST" action="">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-danger" onclick="deleteProduct(${product.id})">
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
    function deleteProduct(productId) {
        document.getElementById('deleteForm').action = '/admin/product/delete/' + productId;
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
    }

    // Add hover effect to info items
    document.addEventListener('DOMContentLoaded', function() {
        const infoItems = document.querySelectorAll('.info-item');
        infoItems.forEach(item => {
            item.addEventListener('mouseenter', function() {
                this.style.backgroundColor = '#f8f9fa';
            });
            item.addEventListener('mouseleave', function() {
                this.style.backgroundColor = '';
            });
        });
    });
</script>
</body>

</html>