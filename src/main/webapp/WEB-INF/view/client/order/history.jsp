<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đặt hàng</title>

    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet">

    <style>
        .order-card {
            border: 1px solid #e9ecef;
            border-radius: 10px;
            margin-bottom: 20px;
            overflow: hidden;
            transition: box-shadow 0.3s ease;
        }
        .order-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .order-header {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 15px 20px;
            border-bottom: 1px solid #dee2e6;
        }
        .order-status {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-confirmed {
            background-color: #d1ecf1;
            color: #0c5460;
        }
        .status-shipping {
            background-color: #cce7ff;
            color: #004085;
        }
        .status-delivered {
            background-color: #d4edda;
            color: #155724;
        }
        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
        .order-body {
            padding: 20px;
        }
        .product-item {
            border-bottom: 1px solid #f1f1f1;
            padding-bottom: 15px;
            margin-bottom: 15px;
        }
        .product-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }
        .product-image {
            width: 70px;
            height: 70px;
            border-radius: 8px;
            object-fit: cover;
        }
        .order-total {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-top: 15px;
        }
        .btn-view-details {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border: none;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        .btn-view-details:hover {
            background: linear-gradient(135deg, #0056b3 0%, #004085 100%);
            color: white;
            transform: translateY(-1px);
        }
        .empty-orders {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }
        .empty-orders i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: #dee2e6;
        }
    </style>
</head>

<body>

<!-- Spinner Start -->
<div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<!-- Spinner End -->

<jsp:include page="../layout/header.jsp"/>

<div class="container" style="padding-top: 110px;">
    <ol class="breadcrumb mb-0">
        <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
        <li class="breadcrumb-item active">Lịch sử đặt hàng</li>
    </ol>
</div>

<div class="container-fluid pb-5">
    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0">
                <i class="fas fa-history text-primary me-2"></i>
                Lịch sử đặt hàng
            </h2>
            <div class="d-flex gap-2">
                <select class="form-select" style="width: auto;" onchange="filterOrdersByStatus(this.value)">
                    <option value="">Tất cả trạng thái</option>
                    <option value="PENDING">Chờ xác nhận</option>
                    <option value="CONFIRMED">Đã xác nhận</option>
                    <option value="SHIPPING">Đang giao hàng</option>
                    <option value="DELIVERED">Đã giao hàng</option>
                    <option value="CANCELLED">Đã hủy</option>
                </select>
            </div>
        </div>

        <!-- Check if orders list is empty -->
        <c:if test="${empty orders}">
            <div class="empty-orders">
                <i class="fas fa-shopping-bag"></i>
                <h3>Chưa có đơn hàng nào</h3>
                <p>Bạn chưa thực hiện đặt hàng nào. Hãy khám phá các sản phẩm của chúng tôi!</p>
                <a href="/" class="btn btn-primary btn-lg">
                    <i class="fas fa-shopping-cart me-2"></i>
                    Bắt đầu mua sắm
                </a>
            </div>
        </c:if>

        <!-- Orders List -->
        <c:if test="${not empty orders}">
            <div id="orders-container">
                <c:forEach var="order" items="${orders}">
                    <div class="order-card" data-status="${order.status}">
                        <div class="order-header">
                            <div class="row align-items-center">
                                <div class="col-md-6">
                                    <h5 class="mb-1">
                                        <i class="fas fa-receipt text-primary me-2"></i>
                                        Đơn hàng #${order.id}
                                    </h5>
                                    <small class="text-muted">
                                        <i class="far fa-calendar-alt me-1"></i>
                                            ${order.formattedCreatedAtWithTime}
                                    </small>
                                </div>
                                <div class="col-md-6 text-end">
                                    <span class="order-status
                                        <c:choose>
                                            <c:when test='${order.status == "PENDING"}'>status-pending</c:when>
                                            <c:when test='${order.status == "CONFIRMED"}'>status-confirmed</c:when>
                                            <c:when test='${order.status == "SHIPPING"}'>status-shipping</c:when>
                                            <c:when test='${order.status == "DELIVERED"}'>status-delivered</c:when>
                                            <c:when test='${order.status == "CANCELLED"}'>status-cancelled</c:when>
                                        </c:choose>">
                                        <c:choose>
                                            <c:when test='${order.status == "PENDING"}'>Chờ xác nhận</c:when>
                                            <c:when test='${order.status == "CONFIRMED"}'>Đã xác nhận</c:when>
                                            <c:when test='${order.status == "SHIPPING"}'>Đang giao hàng</c:when>
                                            <c:when test='${order.status == "DELIVERED"}'>Đã giao hàng</c:when>
                                            <c:when test='${order.status == "CANCELLED"}'>Đã hủy</c:when>
                                            <c:otherwise>${order.status}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="order-body">
                            <!-- Shipping Information -->
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <h6 class="text-primary mb-2">
                                        <i class="fas fa-user me-1"></i>
                                        Thông tin người nhận
                                    </h6>
                                    <p class="mb-1"><strong>${order.receiverName}</strong></p>
                                    <p class="mb-1 text-muted small">
                                        <i class="fas fa-phone me-1"></i>
                                            ${order.receiverPhone}
                                    </p>
                                    <p class="mb-0 text-muted small">
                                        <i class="fas fa-map-marker-alt me-1"></i>
                                            ${order.receiverAddress}
                                    </p>
                                </div>
                            </div>

                            <!-- Products List -->
                            <h6 class="text-primary mb-3">
                                <i class="fas fa-box me-1"></i>
                                Sản phẩm đã đặt
                            </h6>

                            <c:forEach var="orderDetail" items="${order.orderDetails}" varStatus="status">
                                <div class="product-item">
                                    <div class="row align-items-center">
                                        <div class="col-2 col-md-1">
                                            <img src="/images/product/${orderDetail.product.image}"
                                                 class="product-image"
                                                 alt="${orderDetail.product.name}"
                                                 onerror="this.src='/client/img/default-product.png'">
                                        </div>
                                        <div class="col-6 col-md-7">
                                            <h6 class="mb-1">${orderDetail.product.name}</h6>
                                            <small class="text-muted">
                                                Số lượng: ${orderDetail.quantity}
                                            </small>
                                        </div>
                                        <div class="col-4 text-end">
                                            <p class="mb-0 fw-bold">
                                                <fmt:formatNumber value="${orderDetail.price}" type="number"
                                                                  maxFractionDigits="0" groupingUsed="true" /> đ
                                            </p>
                                            <small class="text-muted">
                                                Tổng: <fmt:formatNumber value="${orderDetail.price * orderDetail.quantity}" type="number"
                                                                        maxFractionDigits="0" groupingUsed="true" /> đ
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <!-- Order Total -->
                            <div class="order-total">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="fw-bold">Tổng cộng:</span>
                                    <span class="fw-bold text-primary h5 mb-0" style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 1.5rem;">
                                        <fmt:formatNumber value="${order.totalPrice}" type="number"
                                                          maxFractionDigits="0" groupingUsed="true" /> đ
                                    </span>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <c:if test='${order.status == "PENDING"}'>
                                <div class="text-end mt-3">
                                    <button type="button" class="btn btn-outline-danger" onclick="cancelOrder(${order.id})">
                                        <i class="fas fa-times me-1"></i>
                                        Hủy đơn hàng
                                    </button>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Phân trang đơn hàng">
                    <ul class="pagination justify-content-center">
                        <c:if test="${currentPage > 0}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${currentPage - 1}&size=${pageSize}">Trước</a>
                            </li>
                        </c:if>

                        <c:forEach begin="0" end="${totalPages - 1}" var="page">
                            <li class="page-item ${page == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?page=${page}&size=${pageSize}">${page + 1}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages - 1}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${currentPage + 1}&size=${pageSize}">Sau</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
        </c:if>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>

<!-- JavaScript Libraries -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/easing/easing.min.js"></script>
<script src="/client/lib/waypoints/waypoints.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="/client/js/main.js"></script>

<script>
    // Filter orders by status
    function filterOrdersByStatus(status) {
        const orders = document.querySelectorAll('.order-card');

        orders.forEach(order => {
            if (status === '' || order.dataset.status === status) {
                order.style.display = 'block';
            } else {
                order.style.display = 'none';
            }
        });
    }

    // Cancel order
    function cancelOrder(orderId) {
        if (confirm('Bạn có chắc chắn muốn hủy đơn hàng này không?')) {
            $.ajax({
                url: `/api/orders/${orderId}/cancel`,
                type: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                success: function(response) {
                    alert('Đơn hàng đã được hủy thành công!');
                    location.reload();
                },
                error: function(xhr, status, error) {
                    alert('Có lỗi xảy ra khi hủy đơn hàng. Vui lòng thử lại!');
                }
            });
        }
    }

    // Auto-hide spinner when page loads
    $(document).ready(function() {
        $('#spinner').removeClass('show');
    });
</script>

</body>
</html>