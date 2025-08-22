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
        <div id="empty-cart-message" class="text-center py-5" style="display: none;">
            <h3>Giỏ hàng của bạn đang trống</h3>
            <p>Hãy thêm một số sản phẩm vào giỏ hàng để tiếp tục mua sắm.</p>
            <a href="/" class="btn btn-primary">Tiếp tục mua sắm</a>
        </div>

        <c:if test="${empty cart || empty cart.cartDetails}">
            <div class="text-center py-5">
                <h3>Giỏ hàng của bạn đang trống</h3>
                <p>Hãy thêm một số sản phẩm vào giỏ hàng để tiếp tục mua sắm.</p>
                <a href="/" class="btn btn-primary">Tiếp tục mua sắm</a>
            </div>
        </c:if>

        <div id="cart-content" <c:if test="${empty cart || empty cart.cartDetails}">style="display: none;"</c:if>>
            <div class="table-responsive">
                <table class="table" id="cart-table">
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
                    <tbody id="cart-items">
                    <c:set var="totalPrice" value="0" />
                    <c:forEach var="cartDetail" items="${cart.cartDetails}" varStatus="status">
                        <tr data-cart-detail-id="${cartDetail.id}">
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
                                <p class="mb-0 mt-4 item-price" data-price="${cartDetail.price}">
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
                                           class="form-control form-control-sm text-center border-0 item-quantity"
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
                                <p class="mb-0 mt-4 item-total">
                                    <fmt:formatNumber value="${cartDetail.price * cartDetail.quantity}"
                                                      type="number" maxFractionDigits="0" groupingUsed="true" /> ₫
                                </p>
                            </td>
                            <td>
                                <button class="btn btn-md rounded-circle bg-light border mt-4 btn-delete"
                                        data-cart-detail-id="${cartDetail.id}"
                                        onclick="deleteCartItemByButton(this)">
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
                <div id="couponError" class="text-danger mb-2" style="display: none;"></div>
                <input type="text" class="border-0 border-bottom rounded me-5 py-3 mb-4" placeholder="Mã giảm giá" id="couponCode">
                <button class="btn border-secondary rounded-pill px-4 py-3 text-primary" type="button" onclick="applyCoupon()">Áp dụng mã giảm giá</button>
<%--                <button class="btn border-danger rounded-pill px-4 py-3 text-danger ms-3" type="button" onclick="clearCart()">Xóa giỏ hàng</button>--%>
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
                                <h5 class="mb-0 me-4">Vận chuyển:</h5>
                                <div class="">
                                    <p class="mb-0">50,000 ₫</p>
                                </div>
                            </div>
<%--                            <p class="mb-0 text-end">Vận chuyển toàn quốc.</p>--%>
                        </div>
                        <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                            <h5 class="mb-0 ps-4 me-4">Tổng cộng:</h5>
                            <p class="mb-0 pe-4" id="total">
                                <fmt:formatNumber value="${totalPrice + 50000}" type="number"
                                                  maxFractionDigits="0" groupingUsed="true" /> ₫
                            </p>
                        </div>
                        <button class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4"
                                type="button" onclick="proceedToCheckout()">
                            Thanh toán
                        </button>
                    </div>
                </div>
            </div>
        </div>
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
    // Hàm format số tiền
    function formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN').format(amount) + ' ₫';
    }

    // Hàm tính lại tổng tiền
    function recalculateTotal() {
        let subtotal = 0;
        $('#cart-items tr').each(function() {
            const price = parseFloat($(this).find('.item-price').data('price'));
            const quantity = parseInt($(this).find('.item-quantity').val());
            const itemTotal = price * quantity;

            // Cập nhật giá tiền của từng sản phẩm
            $(this).find('.item-total').text(formatCurrency(itemTotal));

            subtotal += itemTotal;
        });

        const shipping = 50000;
        const total = subtotal + shipping;

        $('#subtotal').text(formatCurrency(subtotal));
        $('#total').text(formatCurrency(total));
    }

    function updateQuantity(cartDetailId, action) {
        $.ajax({
            url: '/cart/update',
            type: 'POST',
            data: {
                cartDetailId: cartDetailId,
                action: action
            },
            beforeSend: function() {
                $('button[data-cart-detail-id="' + cartDetailId + '"]').prop('disabled', true);
            },
            success: function(response) {
                console.log('Full response:', response);

                if (response.success) {
                    console.log('newQuantity from server:', response.newQuantity);

                    // XỬ LÝ TRƯỜNG HỢP newQuantity = undefined
                    if (response.newQuantity === undefined || response.newQuantity === null) {
                        console.log('newQuantity is undefined/null, checking input value...');

                        // Lấy giá trị hiện tại từ input
                        const $input = $(`tr[data-cart-detail-id="${cartDetailId}"] .item-quantity`);
                        const currentValue = $input.val();
                        console.log('Current input value:', currentValue);

                        if (currentValue == "0" || currentValue == 0) {
                            console.log('Input shows 0, reloading page...');
                            location.reload();
                            return;
                        }

                        // Hoặc reload page luôn vì server response lỗi
                        console.log('Server response invalid, reloading page...');
                        location.reload();
                        return;
                    }

                    // Kiểm tra bình thường nếu có newQuantity
                    if (response.newQuantity == 0) {
                        console.log('newQuantity = 0, reloading page...');
                        location.reload();
                        return;
                    }

                    // Code bình thường...
                    const $row = $(`tr[data-cart-detail-id="${cartDetailId}"]`);
                    const $quantityInput = $row.find('.item-quantity');
                    $quantityInput.val(response.newQuantity);
                    updateCartCounter(response.cartSum);
                    recalculateTotal();
                } else {
                    console.log('Response success = false, might need to reload');
                    // Nếu action = decrease và response thất bại, có thể item đã bị xóa
                    if (action === 'decrease') {
                        console.log('Decrease failed, reloading page...');
                        location.reload();
                    }
                }
            },
            error: function(xhr, status, error) {
                console.log('AJAX error, reloading page...');
                // Lỗi AJAX có thể do item đã bị xóa
                location.reload();
            },
            complete: function() {
                $('button[data-cart-detail-id="' + cartDetailId + '"]').prop('disabled', false);
            }
        });
    }

    function deleteCartItem(cartDetailId) {
        console.log('Deleting cart item:', cartDetailId);

        // CÁCH ĐƠN GIẢN NHẤT: Tìm button được click và lấy parent row
        const $button = $(`button[onclick*="deleteCartItem(${cartDetailId})"]`);
        console.log('Found button:', $button.length);

        if ($button.length > 0) {
            const $row = $button.closest('tr');
            console.log('Found parent row:', $row.length);

            if ($row.length > 0) {
                // XÓA NGAY LẬP TỨC
                $row.fadeOut(300, function() {
                    $(this).remove();
                    console.log('Row removed!');

                    // Check if cart is empty after removal
                    if ($('#cart-items tr').length === 0) {
                        console.log('Cart is empty now');
                        $('#cart-content').fadeOut(300, function() {
                            $('#empty-cart-message').fadeIn(300);
                        });
                        updateCartCounter(0);
                    } else {
                        console.log('Recalculating totals');
                        recalculateTotal();
                    }
                });
            }
        } else {
            // FALLBACK 2: Tìm bằng data attribute
            const $buttonFallback = $(`button[data-cart-detail-id="${cartDetailId}"]`);
            console.log('Fallback button found:', $buttonFallback.length);

            if ($buttonFallback.length > 0) {
                const $row = $buttonFallback.closest('tr');
                if ($row.length > 0) {
                    $row.fadeOut(300, function() {
                        $(this).remove();
                        if ($('#cart-items tr').length === 0) {
                            $('#cart-content').fadeOut(300, function() {
                                $('#empty-cart-message').fadeIn(300);
                            });
                            updateCartCounter(0);
                        } else {
                            recalculateTotal();
                        }
                    });
                }
            } else {
                console.error('Could not find button or row to delete!');
            }
        }

        // Gửi AJAX để update server (chạy song song)
        $.ajax({
            url: '/cart/delete/' + cartDetailId,
            type: 'POST',
            success: function(response) {
                console.log('Server delete success:', response);
                if (response && response.cartSum !== undefined) {
                    updateCartCounter(response.cartSum);
                }
            },
            error: function(xhr, status, error) {
                console.log('Server delete error:', error);
            }
        });
    }

    // Function xóa cart item bằng cách dùng button element trực tiếp
    function deleteCartItemByButton(buttonElement) {
        const cartDetailId = $(buttonElement).data('cart-detail-id');
        console.log('Deleting by button, cartDetailId:', cartDetailId);

        // Lấy parent row trực tiếp
        const $row = $(buttonElement).closest('tr');

        if ($row.length > 0) {
            // XÓA NGAY LẬP TỨC
            $row.fadeOut(300, function() {
                $(this).remove();
                console.log('Row removed!');

                // Check if cart is empty
                if ($('#cart-items tr').length === 0) {
                    $('#cart-content').fadeOut(300, function() {
                        $('#empty-cart-message').fadeIn(300);
                    });
                    updateCartCounter(0);
                } else {
                    recalculateTotal();
                }
            });
        }

        // Gửi AJAX để update server
        $.ajax({
            url: '/cart/delete/' + cartDetailId,
            type: 'POST',
            success: function(response) {
                console.log('Server delete success:', response);
                if (response && response.cartSum !== undefined) {
                    updateCartCounter(response.cartSum);
                }
            },
            error: function(xhr, status, error) {
                console.log('Server delete error:', error);
            }
        });
    }
    // Function to apply coupon
    function applyCoupon() {
        const couponCode = document.getElementById('couponCode').value;
        const errorDiv = document.getElementById('couponError');

        // Ẩn thông báo lỗi cũ
        errorDiv.style.display = 'none';

        if (couponCode.trim() === '') {
            errorDiv.textContent = 'Vui lòng nhập mã giảm giá';
            errorDiv.style.display = 'block';
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
                    // Ẩn lỗi và làm xanh input
                    errorDiv.style.display = 'none';
                    $('#couponCode').removeClass('border-danger').addClass('border-success');

                    // Update totals if discount info is provided
                    if (response.newSubtotal !== undefined) {
                        $('#subtotal').text(formatCurrency(response.newSubtotal));
                        $('#total').text(formatCurrency(response.newTotal));
                    } else {
                        // Fallback: recalculate
                        recalculateTotal();
                    }
                } else {
                    // Hiển thị lỗi màu đỏ
                    errorDiv.textContent = response.error || 'Mã giảm giá không hợp lệ';
                    errorDiv.style.display = 'block';
                    $('#couponCode').removeClass('border-success').addClass('border-danger');
                }
            },
            error: function(xhr, status, error) {
                let errorMessage = 'Mã giảm giá không hợp lệ hoặc đã hết hạn';
                if (xhr.responseJSON && xhr.responseJSON.error) {
                    errorMessage = xhr.responseJSON.error;
                }
                errorDiv.textContent = errorMessage;
                errorDiv.style.display = 'block';
                $('#couponCode').removeClass('border-success').addClass('border-danger');
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
        if ($('#cart-items tr').length === 0) {
            return; // Im lặng không làm gì
        }

        window.location.href = '/checkout';
    }

    // Function to clear entire cart (không confirm)
    function clearCart() {
        $.ajax({
            url: '/cart/clear',
            type: 'POST',
            beforeSend: function() {
                $('button:contains("Xóa giỏ hàng")').prop('disabled', true).text('Đang xóa...');
            },
            success: function(response) {
                console.log('Clear cart response:', response); // Debug log

                // Luôn luôn xóa toàn bộ giỏ hàng khỏi giao diện
                $('#cart-content').fadeOut(300, function() {
                    $('#empty-cart-message').fadeIn(300);
                });
                updateCartCounter(0);
            },
            error: function(xhr, status, error) {
                console.log('Clear cart error:', error); // Debug log

                // Vẫn xóa khỏi giao diện ngay cả khi có lỗi
                $('#cart-content').fadeOut(300, function() {
                    $('#empty-cart-message').fadeIn(300);
                });
                updateCartCounter(0);
            },
            complete: function() {
                $('button:contains("Đang xóa...")').prop('disabled', false).text('Xóa giỏ hàng');
            }
        });
    }

    // Function to update cart counter in header
    function updateCartCounter(newCount) {
        $('.cart-counter').text(newCount);
        $('.badge-cart').text(newCount);
        $('[data-cart-count]').text(newCount);
    }

    // Event listeners
    $(document).ready(function() {
        // Quantity decrease button
        $(document).on('click', '.btn-minus', function() {
            const cartDetailId = $(this).data('cart-detail-id');
            updateQuantity(cartDetailId, 'decrease');
        });

        // Quantity increase button
        $(document).on('click', '.btn-plus', function() {
            const cartDetailId = $(this).data('cart-detail-id');
            updateQuantity(cartDetailId, 'increase');
        });

        // Apply coupon on Enter key
        $('#couponCode').keypress(function(e) {
            if (e.which == 13) { // Enter key
                applyCoupon();
                return false;
            }
        });

        // Reset coupon error khi user gõ lại
        $('#couponCode').on('input', function() {
            const errorDiv = document.getElementById('couponError');
            errorDiv.style.display = 'none';
            $(this).removeClass('border-danger border-success');
        });

        // Continue shopping button
        $('#continueShopping').click(function() {
            window.location.href = '/';
        });

        // Initialize: Hide spinner when page is loaded
        $(window).on('load', function() {
            $('#spinner').fadeOut(500);
        });
    });
</script>

<style>
    /* Animation cho buttons khi hover */
    .btn-minus:hover, .btn-plus:hover, .btn-delete:hover {
        transform: scale(1.1);
        transition: transform 0.2s ease;
    }

    /* Loading state cho buttons */
    .btn:disabled {
        opacity: 0.6;
        cursor: not-allowed;
    }

    /* Custom styling cho coupon input */
    #couponCode.border-success {
        border-color: #28a745 !important;
    }

    #couponCode.border-danger {
        border-color: #dc3545 !important;
    }

    /* Animation cho table rows */
    #cart-items tr {
        transition: all 0.3s ease;
    }

    #cart-items tr:hover {
        background-color: #f8f9fa;
    }
</style>

</body>
</html>