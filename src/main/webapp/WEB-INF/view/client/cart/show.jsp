<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng</title>

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
        <li class="breadcrumb-item active">Giỏ hàng</li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <c:if test="${empty cart || empty cart.cartDetails}">
            <div class="text-center py-5">
                <h3>Giỏ hàng của bạn đang trống</h3>
                <p>Hãy thêm một số sản phẩm vào giỏ hàng để tiếp tục mua sắm.</p>
                <a href="/" class="btn btn-primary">Tiếp tục mua sắm</a>
            </div>
        </c:if>

        <c:if test="${not empty cart && not empty cart.cartDetails}">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col">Sản phẩm</th>
                        <th scope="col">Tên</th>
                        <th scope="col">Giá</th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Tổng</th>
                        <th scope="col">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="totalPrice" value="0" />
                    <c:forEach var="cartDetail" items="${cart.cartDetails}" varStatus="status">
                        <tr>
                            <th scope="row">
                                <div class="d-flex align-items-center">
                                    <img src="/images/product/${cartDetail.product.image}"
                                         class="img-fluid me-5 rounded-circle"
                                         style="width: 80px; height: 80px;"
                                         alt="${cartDetail.product.name}"
                                         onerror="this.src='/client/img/default-product.png'">
                                </div>
                            </th>
                            <td>
                                <a href="/product/${cartDetail.product.id}">
                                    <p class="mb-0 mt-4">${cartDetail.product.name}</p>
                                </a>
                            </td>
                            <td>
                                <p class="mb-0 mt-4">
                                    <fmt:formatNumber value="${cartDetail.price}" type="number"
                                                      maxFractionDigits="0" groupingUsed="true" /> ₫
                                </p>
                            </td>
                            <td>
                                <div class="input-group quantity mt-4" style="width: 120px;">
                                    <div class="input-group-btn">
                                        <button class="btn btn-sm btn-minus rounded-circle bg-light border"
                                                data-cart-detail-id="${cartDetail.id}"
                                                data-action="decrease">
                                            <i class="fa fa-minus"></i>
                                        </button>
                                    </div>
                                    <input type="text"
                                           class="form-control form-control-sm text-center border-0"
                                           value="${cartDetail.quantity}"
                                           data-cart-detail-id="${cartDetail.id}"
                                           readonly>
                                    <div class="input-group-btn">
                                        <button class="btn btn-sm btn-plus rounded-circle bg-light border"
                                                data-cart-detail-id="${cartDetail.id}"
                                                data-action="increase">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <p class="mb-0 mt-4">
                                    <fmt:formatNumber value="${cartDetail.price * cartDetail.quantity}"
                                                      type="number" maxFractionDigits="0" groupingUsed="true" /> ₫
                                </p>
                            </td>
                            <td>
                                <button class="btn btn-md rounded-circle bg-light border mt-4"
                                        data-cart-detail-id="${cartDetail.id}"
                                        data-action="delete"
                                        onclick="confirmDelete(${cartDetail.id})">
                                    <i class="fa fa-times text-danger"></i>
                                </button>
                            </td>
                        </tr>
                        <c:set var="totalPrice" value="${totalPrice + (cartDetail.price * cartDetail.quantity)}" />
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="mt-5">
                <input type="text" class="border-0 border-bottom rounded me-5 py-3 mb-4" placeholder="Mã giảm giá" id="couponCode">
                <button class="btn border-secondary rounded-pill px-4 py-3 text-primary" type="button" onclick="applyCoupon()">Áp dụng mã giảm giá</button>
            </div>

            <div class="row g-4 justify-content-end">
                <div class="col-8"></div>
                <div class="col-sm-8 col-md-7 col-lg-6 col-xl-4">
                    <div class="bg-light rounded" style="font-family: 'Roboto', sans-serif;">
                        <div class="p-4">
                            <h1 class="display-6 mb-4"><span class="fw-normal">Tổng cộng</span></h1>
                            <div class="d-flex justify-content-between mb-4">
                                <h5 class="mb-0 me-4">Tạm tính:</h5>
                                <p class="mb-0" id="subtotal">
                                    <fmt:formatNumber value="${totalPrice}" type="number"
                                                      maxFractionDigits="0" groupingUsed="true" /> ₫
                                </p>
                            </div>
                            <div class="d-flex justify-content-between">
                                <h5 class="mb-0 me-4">Vận chuyển</h5>
                                <div class="">
                                    <p class="mb-0">Phí cố định: 50,000 ₫</p>
                                </div>
                            </div>
                            <p class="mb-0 text-end">Vận chuyển toàn quốc.</p>
                        </div>
                        <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                            <h5 class="mb-0 ps-4 me-4">Tổng cộng</h5>
                            <p class="mb-0 pe-4" id="total">
                                <fmt:formatNumber value="${totalPrice + 50000}" type="number"
                                                  maxFractionDigits="0" groupingUsed="true" /> ₫
                            </p>
                        </div>
                        <button class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4"
                                type="button" onclick="proceedToCheckout()">
                            Tiến hành thanh toán
                        </button>
                    </div>
                </div>
            </div>
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
    // Function to update cart item quantity
    function updateQuantity(cartDetailId, action) {
        $.ajax({
            url: '/cart/update',
            type: 'POST',
            data: {
                cartDetailId: cartDetailId,
                action: action
            },
            beforeSend: function() {
                // Disable buttons to prevent multiple clicks
                $('button[data-cart-detail-id="' + cartDetailId + '"]').prop('disabled', true);
            },
            success: function(response) {
                if (response.success) {
                    // Update quantity in UI
                    $('input[data-cart-detail-id="' + cartDetailId + '"]').val(response.newQuantity);

                    // Update cart counter in header
                    updateCartCounter(response.cartSum);

                    location.reload();
                } else {
                    alert(response.error || 'Có lỗi xảy ra');
                }
            },
            error: function(xhr, status, error) {
                var errorMessage = 'Có lỗi xảy ra khi cập nhật giỏ hàng.';
                if (xhr.responseJSON && xhr.responseJSON.error) {
                    errorMessage = xhr.responseJSON.error;
                }
                alert(errorMessage);
            },
            complete: function() {
                // Re-enable buttons
                $('button[data-cart-detail-id="' + cartDetailId + '"]').prop('disabled', false);
            }
        });
    }

    // Function to delete cart item
    function deleteCartItem(cartDetailId) {
        $.ajax({
            url: '/cart/delete/' + cartDetailId,
            type: 'POST',
            beforeSend: function() {
                $('button[data-cart-detail-id="' + cartDetailId + '"]').prop('disabled', true);
            },
            success: function(response) {
                if (response.success) {
                    // Remove the row from table
                    $('tr:has(button[data-cart-detail-id="' + cartDetailId + '"])').fadeOut(300, function() {
                        $(this).remove();

                        // Check if cart is empty
                        if ($('tbody tr').length === 0) {
                            location.reload(); // Reload to show empty cart message
                        } else {
                            // Update cart counter and totals
                            updateCartCounter(response.cartSum);
                            updateCartTotals();
                            location.reload();
                        }
                    });
                } else {
                    alert(response.error || 'Có lỗi xảy ra khi xóa sản phẩm');
                }
            },
            error: function(xhr, status, error) {
                var errorMessage = 'Có lỗi xảy ra khi xóa sản phẩm.';
                if (xhr.responseJSON && xhr.responseJSON.error) {
                    errorMessage = xhr.responseJSON.error;
                }
                alert(errorMessage);
            },
            complete: function() {
                $('button[data-cart-detail-id="' + cartDetailId + '"]').prop('disabled', false);
            }
        });
    }

    // Function to confirm deletion
    function confirmDelete(cartDetailId) {
        if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?')) {
            deleteCartItem(cartDetailId);
        }
    }

    // Function to apply coupon
    function applyCoupon() {
        var couponCode = document.getElementById('couponCode').value;
        if (couponCode.trim() === '') {
            alert('Vui lòng nhập mã giảm giá');
            return;
        }

        $.ajax({
            url: '/cart/apply-coupon',
            type: 'POST',
            data: {
                couponCode: couponCode
            },
            beforeSend: function() {
                $('#couponCode').prop('disabled', true);
                $('button:contains("Áp dụng mã giảm giá")').prop('disabled', true).text('Đang xử lý...');
            },
            success: function(response) {
                if (response.success) {
                    alert('Mã giảm giá "' + response.couponCode + '" đã được áp dụng thành công!\n' +
                        response.discountMessage);
                    location.reload(); // Reload to update prices
                } else {
                    alert(response.error || 'Có lỗi xảy ra');
                }
            },
            error: function(xhr, status, error) {
                var errorMessage = 'Mã giảm giá không hợp lệ hoặc đã hết hạn.';
                if (xhr.responseJSON && xhr.responseJSON.error) {
                    errorMessage = xhr.responseJSON.error;
                }
                alert(errorMessage);
            },
            complete: function() {
                $('#couponCode').prop('disabled', false);
                $('button:contains("Đang xử lý...")').prop('disabled', false).text('Áp dụng mã giảm giá');
            }
        });
    }

    // Function to proceed to checkout
    function proceedToCheckout() {
        // Check if cart has items
        if ($('tbody tr').length === 0) {
            alert('Giỏ hàng trống. Vui lòng thêm sản phẩm để tiếp tục.');
            return;
        }

        window.location.href = '/checkout';
    }

    // Function to clear entire cart
    function clearCart() {
        if (confirm('Bạn có chắc chắn muốn xóa tất cả sản phẩm trong giỏ hàng?')) {
            $.ajax({
                url: '/cart/clear',
                type: 'POST',
                success: function(response) {
                    if (response.success) {
                        alert('Đã xóa tất cả sản phẩm trong giỏ hàng');
                        location.reload();
                    } else {
                        alert(response.error || 'Có lỗi xảy ra');
                    }
                },
                error: function(xhr, status, error) {
                    alert('Có lỗi xảy ra khi xóa giỏ hàng.');
                }
            });
        }
    }

    // Function to update cart counter in header
    function updateCartCounter(newCount) {
        $('.cart-counter').text(newCount); // Assuming you have a cart counter element
        $('.badge-cart').text(newCount); // Alternative selector
    }

    // Function to update cart totals
    function updateCartTotals() {
        $.ajax({
            url: '/cart/total',
            type: 'GET',
            success: function(response) {
                if (response.success) {
                    // Update subtotal and total
                    var shipping = 50000;
                    var formattedSubtotal = new Intl.NumberFormat('vi-VN').format(response.totalPrice) + ' ₫';
                    var formattedTotal = new Intl.NumberFormat('vi-VN').format(response.totalPrice + shipping) + ' ₫';

                    $('#subtotal').text(formattedSubtotal);
                    $('#total').text(formattedTotal);

                    updateCartCounter(response.totalItems);
                }
            }
        });
    }

    // Event listeners
    $(document).ready(function() {
        // Quantity decrease button
        $('.btn-minus').click(function() {
            var cartDetailId = $(this).data('cart-detail-id');
            updateQuantity(cartDetailId, 'decrease');
        });

        // Quantity increase button
        $('.btn-plus').click(function() {
            var cartDetailId = $(this).data('cart-detail-id');
            updateQuantity(cartDetailId, 'increase');
        });

        // Delete item button
        $('.btn-delete').click(function() {
            var cartDetailId = $(this).data('cart-detail-id');
            confirmDelete(cartDetailId);
        });

        // Apply coupon on Enter key
        $('#couponCode').keypress(function(e) {
            if (e.which == 13) { // Enter key
                applyCoupon();
                return false;
            }
        });

        // Continue shopping button
        $('#continueShopping').click(function() {
            window.location.href = '/';
        });
    });
</script>

</body>
</html>