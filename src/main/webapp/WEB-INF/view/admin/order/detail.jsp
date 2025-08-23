<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng #${order.id}</title>
    <link href="/css/styles.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        .status-badge {
            padding: 0.375rem 0.75rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
        }
        .status-pending { background-color: #fff3cd; color: #856404; border: 1px solid #ffeaa7; }
        .status-confirmed { background-color: #d1ecf1; color: #0c5460; border: 1px solid #bee5eb; }
        .status-shipping { background-color: #cff4fc; color: #055160; border: 1px solid #b3e5fc; }
        .status-delivered { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .status-cancelled { background-color: #f8d7da; color: #721c24; border: 1px solid #f1b0b7; }

        .order-header {
            color: black;
            margin-bottom: 2rem;
        }

        .info-card {
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            border: 1px solid rgba(0, 0, 0, 0.125);
            border-radius: 0.375rem;
        }

        .product-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 0.375rem;
        }

        .btn-soft-back {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            color: #495057;
            transition: all 0.2s;
        }

        .btn-soft-back:hover {
            background-color: #e9ecef;
            border-color: #adb5bd;
            color: #495057;
        }

        .table-order-details {
            background-color: #fff;
        }

        .table-order-details th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
            font-weight: 600;
            color: #495057;
        }

        .total-summary {
            background-color: #f8f9fa;
            border-radius: 0.375rem;
            padding: 1.5rem;
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
                <h1 class="mt-4">
                    <i class="bi bi-cart-check me-2"></i>
                    Chi tiết đặt hàng
                </h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/order">Order</a></li>
                    <li class="breadcrumb-item active">Chi tiết đơn hàng #${order.id}</li>
                </ol>

                <!-- Order Header -->
                <div class="order-header">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <h3 class="mb-2">
                                    <i class="bi bi-receipt me-2"></i>
                                    Đơn hàng #${order.id}
                                </h3>
                                <p class="mb-0 opacity-75">
                                    <i class="bi bi-calendar me-1"></i>
                                    Ngày đặt: ${order.formattedCreatedAtWithTime}
                                </p>
                            </div>
                            <div class="col-md-4 text-md-end">
                                <a href="/admin/order" class="btn btn-light btn-soft-back">
                                    <i class="bi bi-arrow-left me-1"></i>Quay lại
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Order Information -->
                <div class="row mb-4">
                    <!-- Customer Information -->
                    <div class="col-lg-6 mb-3">
                        <div class="card info-card h-100">
                            <div class="card-header bg-white">
                                <h5 class="card-title mb-0">
                                    <i class="bi bi-person-circle me-2"></i>Thông tin khách hàng
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <strong class="text-muted">Họ tên:</strong>
                                    <div class="mt-1">${order.user.fullName}</div>
                                </div>
                                <div class="mb-3">
                                    <strong class="text-muted">Email:</strong>
                                    <div class="mt-1">
                                        <i class="bi bi-envelope me-1"></i>${order.user.email}
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <strong class="text-muted">Số điện thoại:</strong>
                                    <div class="mt-1">
                                        <i class="bi bi-telephone me-1"></i>${order.receiverPhone}
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <strong class="text-muted">Người nhận:</strong>
                                    <div class="mt-1">
                                        <i class="bi bi-person me-1"></i>${order.receiverName}
                                    </div>
                                </div>
                                <div>
                                    <strong class="text-muted">Địa chỉ giao hàng:</strong>
                                    <div class="mt-1">
                                        <i class="bi bi-geo-alt me-1"></i>${order.receiverAddress}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order Status -->
                    <div class="col-lg-6 mb-3">
                        <div class="card info-card h-100">
                            <div class="card-header bg-white">
                                <h5 class="card-title mb-0">
                                    <i class="bi bi-info-circle me-2"></i>Thông tin đơn hàng
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <strong class="text-muted">Trạng thái:</strong>
                                    <div class="mt-2">
                                        <c:choose>
                                            <c:when test="${order.status == 'PENDING'}">
                                                    <span class="status-badge status-pending">
                                                        <i class="bi bi-clock me-1"></i>Chờ xác nhận
                                                    </span>
                                            </c:when>
                                            <c:when test="${order.status == 'CONFIRMED'}">
                                                    <span class="status-badge status-confirmed">
                                                        <i class="bi bi-check-circle me-1"></i>Đã xác nhận
                                                    </span>
                                            </c:when>
                                            <c:when test="${order.status == 'SHIPPING'}">
                                                    <span class="status-badge status-shipping">
                                                        <i class="bi bi-truck me-1"></i>Đang giao
                                                    </span>
                                            </c:when>
                                            <c:when test="${order.status == 'DELIVERED'}">
                                                    <span class="status-badge status-delivered">
                                                        <i class="bi bi-check2-all me-1"></i>Hoàn thành
                                                    </span>
                                            </c:when>
                                            <c:when test="${order.status == 'CANCELLED'}">
                                                    <span class="status-badge status-cancelled">
                                                        <i class="bi bi-x-circle me-1"></i>Đã hủy
                                                    </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-pending">${order.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <strong class="text-muted">Tổng số lượng:</strong>
                                    <div class="mt-1">
                                        <c:set var="totalItems" value="0"/>
                                        <c:forEach var="detail" items="${order.orderDetails}">
                                            <c:set var="totalItems" value="${totalItems + detail.quantity}"/>
                                        </c:forEach>
                                        <i class="bi bi-box me-1"></i>${totalItems} sản phẩm
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <strong class="text-muted">Tổng tiền:</strong>
                                    <div class="mt-1">
                                            <span class="h5 text-primary mb-0">
                                                <fmt:formatNumber value="${order.totalPrice}" pattern="#,### "/>đ
                                            </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Order Details -->
                <div class="row">
                    <div class="col-12">
                        <div class="card info-card">
                            <div class="card-header bg-white">
                                <h5 class="card-title mb-0">
                                    <i class="bi bi-list-check me-2"></i>Chi tiết sản phẩm
                                </h5>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-order-details table-hover mb-0">
                                        <thead>
                                        <tr>
                                            <th scope="col" style="width: 8%;">#</th>
                                            <th scope="col" style="width: 15%;">Hình ảnh</th>
                                            <th scope="col" style="width: 35%;">Sản phẩm</th>
                                            <th scope="col" style="width: 15%;" class="text-center">Đơn giá</th>
                                            <th scope="col" style="width: 12%;" class="text-center">Số lượng</th>
                                            <th scope="col" style="width: 15%;" class="text-end">Thành tiền</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="detail" items="${order.orderDetails}" varStatus="status">
                                            <tr>
                                                <td class="align-middle">
                                                    <span class="text-muted">${status.index + 1}</span>
                                                </td>
                                                <td class="align-middle">
                                                    <img src="/images/product/${detail.product.image}"
                                                         alt="${detail.product.name}"
                                                         class="product-image">
                                                </td>
                                                <td class="align-middle">
                                                    <div class="fw-medium">${detail.product.name}</div>
                                                </td>
                                                <td class="align-middle text-center">
                                                            <span class="fw-medium">
                                                                <fmt:formatNumber value="${detail.price}" pattern="#,### "/>đ
                                                            </span>
                                                </td>
                                                <td class="align-middle text-center">
                                                            <span class="badge bg-secondary rounded-pill">
                                                                    ${detail.quantity}
                                                            </span>
                                                </td>
                                                <td class="align-middle text-end">
                                                            <span class="fw-bold text-primary">
                                                                <fmt:formatNumber value="${detail.price * detail.quantity}" pattern="#,### "/>đ
                                                            </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Order Summary -->
                <div class="row mt-4">
                    <div class="col-lg-8"></div>
                    <div class="col-lg-4">
                        <div class="total-summary">
                            <h6 class="mb-3">Tóm tắt đơn hàng</h6>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Tạm tính:</span>
                                <span><fmt:formatNumber value="${order.totalPrice}" pattern="#,### "/>đ</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Phí vận chuyển:</span>
                                <span>Miễn phí</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between">
                                <strong>Tổng cộng:</strong>
                                <strong class="text-primary">
                                    <fmt:formatNumber value="${order.totalPrice}" pattern="#,### "/>đ
                                </strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp"/>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/scripts.js"></script>
</body>
</html>