<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout - Thanh toán</title>

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
        .checkout-summary-card {
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            border: none;
        }

        .summary-item {
            padding: 1rem 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .summary-item:last-child {
            border-bottom: none;
        }

        .summary-total {
            background: linear-gradient(135deg, rgba(129, 196, 8, 0.1) 0%, rgba(129, 196, 8, 0.05) 100%);
            border-radius: 10px;
            padding: 1.5rem !important;
            margin-top: 1rem;
            border: 1px solid rgba(129, 196, 8, 0.2);
        }

        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .payment-card {
            border-radius: 12px;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .payment-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        .payment-card.selected {
            border-color: #81C408;
            background-color: rgba(129, 196, 8, 0.02);
        }

        .qr-container {
            background: white;
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .bank-info-card {
            background: linear-gradient(135deg, rgba(129, 196, 8, 0.1) 0%, rgba(129, 196, 8, 0.05) 100%);
            border-radius: 15px;
            color: #495057;
            padding: 1.5rem;
            border: 1px solid rgba(129, 196, 8, 0.2);
        }

        .form-control:focus {
            border-color: #81C408;
            box-shadow: 0 0 0 0.25rem rgba(129, 196, 8, 0.15);
        }

        .btn-checkout {
            background: linear-gradient(135deg, #81C408 0%, #6fa606 100%);
            border: none;
            border-radius: 12px;
            padding: 1rem 2rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }

        .btn-checkout:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(129, 196, 8, 0.3);
        }

        /* Responsive QR Code */
        @media (max-width: 768px) {
            .qr-code {
                max-width: 200px !important;
            }
        }

        @media (max-width: 576px) {
            .qr-code {
                max-width: 180px !important;
            }
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
        <li class="breadcrumb-item"><a href="/cart">Giỏ hàng</a></li>
        <li class="breadcrumb-item active">Thanh toán</li>
    </ol>
</div>

<!-- Checkout Page Start -->
<div class="container-fluid pb-5">
    <div class="container py-5">
        <form action="/place-order" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="row g-5">
                <!-- Thông tin khách hàng -->
                <div class="col-md-12 col-lg-6 col-xl-7">
                    <div class="card border-0 shadow-sm" style="border-radius: 15px;">
                        <div class="card-body p-4">
                            <h4 class="card-title text-primary mb-4">
                                <i class="fas fa-user-edit me-2"></i>Thông tin giao hàng
                            </h4>

                            <div class="form-item mb-4">
                                <label class="form-label fw-semibold">Họ và tên <sup class="text-danger">*</sup></label>
                                <input type="text" name="receiverName" class="form-control"
                                       value="${user.fullName}" required>
                            </div>

                            <div class="form-item mb-4">
                                <label class="form-label fw-semibold">Địa chỉ <sup class="text-danger">*</sup></label>
                                <input type="text" name="receiverAddress" class="form-control"
                                       value="${user.address}" required>
                            </div>

                            <div class="form-item mb-4">
                                <label class="form-label fw-semibold">Số điện thoại <sup class="text-danger">*</sup></label>
                                <input type="tel" name="receiverPhone" class="form-control"
                                       value="${user.phone}" required>
                            </div>

<%--                            <div class="form-item mb-4">--%>
<%--                                <label class="form-label fw-semibold">Email <sup class="text-danger">*</sup></label>--%>
<%--                                <input type="email" name="email" class="form-control"--%>
<%--                                       value="${user.email}" readonly style="background-color: #f8f9fa;">--%>
<%--                            </div>--%>

<%--                            <div class="form-item">--%>
<%--                                <label class="form-label fw-semibold">Ghi chú đơn hàng</label>--%>
<%--                                <textarea name="orderNotes" class="form-control" rows="4"--%>
<%--                                          placeholder="Ghi chú đặc biệt cho đơn hàng của bạn (Tùy chọn)"></textarea>--%>
<%--                            </div>--%>
                        </div>
                    </div>
                </div>

                <!-- Đơn hàng và thanh toán -->
                <div class="col-md-12 col-lg-6 col-xl-5">
                    <!-- Danh sách sản phẩm -->
                    <div class="card border-0 shadow-sm checkout-summary-card mb-4">
                        <div class="card-body p-4">
                            <h4 class="card-title text-primary mb-4">
                                <i class="fas fa-shopping-bag me-2"></i>Đơn hàng của bạn
                            </h4>

                            <c:set var="subTotal" value="0"/>
                            <c:forEach var="cartDetail" items="${cart.cartDetails}">
                                <div class="d-flex align-items-center mb-3 pb-3 border-bottom">
                                    <img src="/images/product/${cartDetail.product.image}"
                                         class="product-image me-3"
                                         alt="${cartDetail.product.name}">
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1 fw-semibold">${cartDetail.product.name}</h6>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="text-primary fw-bold">
                                                <fmt:formatNumber value="${cartDetail.product.price}"
                                                                  type="currency" currencyCode="VND"/>
                                            </span>
                                            <span class="badge bg-secondary">x${cartDetail.quantity}</span>
                                        </div>
                                        <div class="text-end mt-1">
                                            <c:set var="itemTotal" value="${cartDetail.product.price * cartDetail.quantity}"/>
                                            <c:set var="subTotal" value="${subTotal + itemTotal}"/>
                                            <strong class="text-primary">
                                                <fmt:formatNumber value="${itemTotal}" type="currency" currencyCode="VND"/>
                                            </strong>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Tóm tắt đơn hàng -->
                    <div class="card border-0 shadow-sm checkout-summary-card mb-4">
                        <div class="card-body p-4">
                            <h5 class="card-title text-primary mb-4">
                                <i class="fas fa-receipt me-2"></i>Tóm tắt đơn hàng
                            </h5>

                            <!-- Tạm tính -->
                            <div class="summary-item">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="text-muted">Tạm tính:</span>
                                    <span class="fw-semibold">
                                        <fmt:formatNumber value="${subTotal}" type="currency" currencyCode="VND"/>
                                    </span>
                                </div>
                            </div>

                            <!-- Giảm giá -->
                            <c:if test="${not empty discountAmount && discountAmount > 0}">
                                <div class="summary-item">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <span class="text-success">Giảm giá:</span>
                                            <small class="d-block text-muted">(${couponCode})</small>
                                        </div>
                                        <span class="fw-semibold text-success">
                                            -<fmt:formatNumber value="${discountAmount}" type="currency" currencyCode="VND"/>
                                        </span>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Phí vận chuyển -->
                            <div class="summary-item">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="text-muted">Phí vận chuyển:</span>
                                    <span class="fw-semibold text-warning">50.000đ</span>
                                </div>
                            </div>

                            <!-- Tổng cộng -->
                            <div class="summary-total">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="fw-bold text-success fs-5">TỔNG CỘNG:</span>
                                    <span class="fw-bold text-success fs-4">
                                        <c:set var="finalTotal" value="${subTotal + 50000 - (discountAmount != null ? discountAmount : 0)}"/>
                                        <fmt:formatNumber value="${finalTotal}" type="currency" currencyCode="VND"/>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Phương thức thanh toán -->
                    <div class="mb-4">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-credit-card me-2"></i>Phương thức thanh toán
                        </h5>

                        <!-- Chuyển khoản ngân hàng -->
                        <div class="card payment-card mb-3">
                            <div class="card-body p-3">
                                <div class="form-check">
                                    <input type="radio" class="form-check-input" id="bank_transfer"
                                           name="paymentMethod" value="bank_transfer" required>
                                    <label class="form-check-label fw-semibold d-flex align-items-center" for="bank_transfer">
                                        <i class="fas fa-university text-primary me-2"></i>
                                        Chuyển khoản ngân hàng
                                    </label>
                                </div>

                                <div class="payment-details mt-3" id="bank-details" style="display: none;">
                                    <div class="row g-4">
                                        <div class="col-lg-7">
                                            <div class="bank-info-card">
                                                <h6 class="fw-bold mb-3">
                                                    <i class="fas fa-credit-card me-2"></i>Thông tin chuyển khoản
                                                </h6>
                                                <div class="d-flex justify-content-between mb-2">
                                                    <span>Ngân hàng:</span>
                                                    <strong>TPBank</strong>
                                                </div>
                                                <div class="d-flex justify-content-between mb-2">
                                                    <span>Số TK:</span>
                                                    <strong>98888608888</strong>
                                                </div>
                                                <div class="d-flex justify-content-between mb-2">
                                                    <span>Chủ TK:</span>
                                                    <strong>TRAN DUC NGAN</strong>
                                                </div>
                                                <div class="d-flex justify-content-between mb-3">
                                                    <span>Chi nhánh:</span>
                                                    <strong>Khánh Hoà</strong>
                                                </div>
                                                <hr style="border-color: rgba(255,255,255,0.3);">
                                                <small class="d-block mb-2">
                                                    <strong>Nội dung:</strong> Thanh toán đơn hàng [Mã đơn hàng]
                                                </small>
                                                <div class="alert alert-light border-0 mb-0">
                                                    <small class="text-dark">
                                                        <i class="fas fa-info-circle me-2"></i>
                                                        Đơn hàng sẽ được xử lý sau khi xác nhận thanh toán
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-5">
                                            <div class="text-center">
                                                <h6 class="fw-bold mb-3 text-primary">
                                                    <i class="fas fa-qrcode me-2"></i>Quét mã QR
                                                </h6>
                                                <div class="qr-container d-inline-block">
                                                    <img src="https://api.vietqr.io/image/970422-98888608888-compact2.jpg?amount=${finalTotal}&addInfo=Thanh%20toan%20don%20hang&accountName=TRAN%20DUC%20NGAN"
                                                         alt="QR Code Chuyển khoản"
                                                         class="img-fluid rounded qr-code"
                                                         style="max-width: 220px; width: 100%; height: auto;">
                                                </div>
                                                <p class="text-muted mt-3 mb-0 small">
                                                    <i class="fas fa-mobile-alt me-2"></i>
                                                    Quét mã QR bằng app ngân hàng
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Thanh toán khi nhận hàng -->
                        <div class="card payment-card">
                            <div class="card-body p-3">
                                <div class="form-check mb-2">
                                    <input type="radio" class="form-check-input" id="cod"
                                           name="paymentMethod" value="cod" checked>
                                    <label class="form-check-label fw-semibold d-flex align-items-center" for="cod">
                                        <i class="fas fa-truck text-success me-2"></i>
                                        Thanh toán khi nhận hàng (COD)
                                    </label>
                                </div>
                                <div class="payment-details bg-light p-3 rounded">
                                    <p class="mb-0 text-muted small">
                                        <i class="fas fa-hand-holding-usd me-2 text-success"></i>
                                        Thanh toán bằng tiền mặt khi shipper giao hàng tới địa chỉ của bạn
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Nút đặt hàng -->
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-checkout">
                            <i class="fas fa-shopping-cart me-2"></i>
                            Đặt hàng ngay
                        </button>
                    </div>
                </div>
            </div>
        </form>
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
    $(document).ready(function() {
        // Handle payment method selection
        $('input[name="paymentMethod"]').change(function() {
            // Remove selected class from all payment cards
            $('.payment-card').removeClass('selected');

            // Hide all payment details
            $('.payment-details').hide();

            // Add selected class to current card and show details
            if ($(this).val() === 'bank_transfer') {
                $(this).closest('.payment-card').addClass('selected');
                $('#bank-details').slideDown(300);
            } else if ($(this).val() === 'cod') {
                $(this).closest('.payment-card').addClass('selected');
            }
        });

        // Initialize COD as selected by default
        $('#cod').closest('.payment-card').addClass('selected');

        // Hide bank details by default
        $('#bank-details').hide();

        // Smooth form validation
        $('form').on('submit', function(e) {
            let isValid = true;

            // Check required fields
            $(this).find('input[required]').each(function() {
                if ($(this).val().trim() === '') {
                    isValid = false;
                    $(this).addClass('is-invalid');
                } else {
                    $(this).removeClass('is-invalid');
                }
            });

            if (!isValid) {
                e.preventDefault();
                $('html, body').animate({
                    scrollTop: $('.is-invalid:first').offset().top - 100
                }, 500);
            }
        });

        // Remove validation classes on input
        $('input').on('input', function() {
            $(this).removeClass('is-invalid');
        });
    });
</script>

</body>
</html>