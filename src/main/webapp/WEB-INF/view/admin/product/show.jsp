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
    <title>Admin - Quản lý sản phẩm</title>
    <link href="/css/styles.css" rel="stylesheet"/>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .btn-soft-view {
            background-color: #e0e7ff;
            border-color: #c7d2fe;
            color: #4338ca;
        }
        .btn-soft-view:hover {
            background-color: #c7d2fe;
            border-color: #a5b4fc;
            color: #3730a3;
        }

        .btn-soft-edit {
            background-color: #dcfce7;
            border-color: #bbf7d0;
            color: #166534;
        }
        .btn-soft-edit:hover {
            background-color: #bbf7d0;
            border-color: #86efac;
            color: #14532d;
        }

        .btn-soft-delete {
            background-color: #fee2e2;
            border-color: #fecaca;
            color: #dc2626;
        }
        .btn-soft-delete:hover {
            background-color: #fecaca;
            border-color: #fca5a5;
            color: #b91c1c;
        }

        .product-image {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #e9ecef;
        }

        .product-name {
            font-weight: 600;
            color: #2d3748;
            text-decoration: none;
        }

        .product-name:hover {
            color: #0066cc;
        }

        .price-display {
            font-weight: 600;
            color: #dc3545;
        }

        .stock-badge {
            font-size: 0.75rem;
            padding: 0.25rem 0.5rem;
            border-radius: 0.375rem;
            font-weight: 500;
        }

        .stock-in {
            background-color: #d1fae5;
            color: #065f46;
        }

        .stock-low {
            background-color: #fef3c7;
            color: #92400e;
        }

        .stock-out {
            background-color: #fee2e2;
            color: #991b1b;
        }

        .description-preview {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            color: #6b7280;
        }

        .factory-badge {
            background-color: #f3f4f6;
            color: #374151;
            padding: 0.25rem 0.5rem;
            border-radius: 0.375rem;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .target-badge {
            background-color: #e0e7ff;
            color: #3730a3;
            padding: 0.25rem 0.5rem;
            border-radius: 0.375rem;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .sold-info {
            font-size: 0.875rem;
            color: #059669;
            font-weight: 500;
        }

        .table th {
            background-color: #f8fafc;
            border-bottom: 2px solid #e2e8f0;
            font-weight: 600;
            color: #1a202c;
        }

        .quantity-info {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .no-image-placeholder {
            width: 50px;
            height: 50px;
            background-color: #f3f4f6;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #9ca3af;
            font-size: 1.2rem;
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
                <h1 class="mt-4">
                    <i class="bi bi-box-seam me-2"></i>
                    Quản lý sản phẩm
                </h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Sản phẩm</li>
                </ol>

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h5 class="mb-0">Danh sách sản phẩm</h5>
                    </div>
                    <a href="/admin/product/create" class="btn btn-primary">
                        <i class="bi bi-plus-circle me-1"></i>
                        Thêm sản phẩm
                    </a>
                </div>

                <!-- Products Table -->
                <div class="card">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover mb-0">
                                <thead class="table-light">
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Hình ảnh</th>
                                    <th scope="col">Tên sản phẩm</th>
                                    <th scope="col">Giá</th>
                                    <th scope="col">Số lượng</th>
                                    <th scope="col">Nhà sản xuất</th>
                                    <th scope="col">Đối tượng</th>
                                    <th scope="col">Mô tả</th>
                                    <th scope="col" class="text-center">Hành động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="product" items="${products}">
                                    <tr>
                                        <td class="align-middle">${product.id}</td>
                                        <td class="align-middle">
                                            <c:choose>
                                                <c:when test="${not empty product.image}">
                                                    <img src="/images/product/${product.image}"
                                                         alt="${product.name}"
                                                         class="product-image"
                                                         onerror="this.src='https://via.placeholder.com/150x150/f8f9fa/6c757d?text=No+Image';">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="no-image-placeholder">
                                                        <i class="bi bi-box-seam"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="align-middle">
                                            <a href="/admin/product/${product.id}" class="product-name">
                                                    ${product.name}
                                            </a>
                                        </td>
                                        <td class="align-middle">
                                            <span class="price-display">
                                                <fmt:formatNumber value="${product.price}" pattern="#,### "/>đ
                                            </span>
                                        </td>
                                        <td class="align-middle">
                                            <div class="quantity-info">
                                                <div>
                                                    <c:choose>
                                                        <c:when test="${product.quantity == 0}">
                                                            <span class="stock-badge stock-out">Hết hàng</span>
                                                        </c:when>
                                                        <c:when test="${product.quantity < 10}">
                                                            <span class="stock-badge stock-low">Sắp hết</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="stock-badge stock-in">Còn hàng</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <small class="text-muted">Tồn kho: ${product.quantity}</small>
                                                <small class="sold-info">Đã bán: ${product.sold}</small>
                                            </div>
                                        </td>
                                        <td class="align-middle">
                                            <span class="factory-badge">
                                                <i class="bi bi-building me-1"></i>
                                                ${product.factory}
                                            </span>
                                        </td>
                                        <td class="align-middle">
                                            <span class="target-badge">
                                                <i class="bi bi-people me-1"></i>
                                                ${product.target}
                                            </span>
                                        </td>
                                        <td class="align-middle">
                                            <div class="description-preview" title="${product.shortDesc}">
                                                    ${product.shortDesc}
                                            </div>
                                        </td>
                                        <td class="text-center align-middle">
                                            <div class="action-buttons">
                                                <a href="/admin/product/${product.id}"
                                                   class="btn btn-sm btn-soft-view"
                                                   title="Xem chi tiết">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="/admin/product/edit/${product.id}"
                                                   class="btn btn-sm btn-soft-edit"
                                                   title="Chỉnh sửa">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <button type="button"
                                                        class="btn btn-sm btn-soft-delete"
                                                        onclick="deleteProduct(${product.id})"
                                                        title="Xóa">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="/admin/product?page=${currentPage - 1}">
                                        <i class="bi bi-chevron-left"></i>
                                    </a>
                                </li>
                            </c:if>

                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="/admin/product?page=${i}">${i}</a>
                                </li>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="/admin/product?page=${currentPage + 1}">
                                        <i class="bi bi-chevron-right"></i>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
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
                    Xác nhận xóa sản phẩm
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn xóa sản phẩm này không?</p>
                <p class="text-warning">
                    <i class="bi bi-exclamation-triangle me-1"></i>
                    Hành động này không thể hoàn tác và sẽ xóa tất cả dữ liệu liên quan.
                </p>
            </div>
            <div class="modal-footer">
                <form id="deleteForm" method="POST" action="">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-danger">
                        <i class="bi bi-trash me-1"></i>Xóa sản phẩm
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

    // Add hover effect to table rows
    document.addEventListener('DOMContentLoaded', function() {
        const tableRows = document.querySelectorAll('tbody tr');
        tableRows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.backgroundColor = '#f8f9fa';
            });
            row.addEventListener('mouseleave', function() {
                this.style.backgroundColor = '';
            });
        });

        // Add tooltip for long descriptions
        const descriptions = document.querySelectorAll('.description-preview');
        descriptions.forEach(desc => {
            if (desc.scrollWidth > desc.clientWidth) {
                desc.style.cursor = 'help';
            }
        });
    });
</script>
</body>
</html>