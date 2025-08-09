<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Detail</title>

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

<!-- Modal Search Start -->
<div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen">
        <div class="modal-content rounded-0">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body d-flex align-items-center">
                <div class="input-group w-75 mx-auto d-flex">
                    <input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                    <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modal Search End -->


<%--<!-- Single Page Header start -->--%>
<%--&lt;%&ndash;<div class="container-fluid page-header py-5">&ndash;%&gt;--%>
<%--&lt;%&ndash;    <h1 class="text-center text-white display-6">Chi tiết sản phẩm</h1>&ndash;%&gt;--%>
<%--    <ol class="breadcrumb justify-content-center mb-0">--%>
<%--        <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>--%>
<%--        <li class="breadcrumb-item active text-white">Chi tiết sản phẩm</li>--%>
<%--    </ol>--%>
<%--&lt;%&ndash;</div>&ndash;%&gt;--%>
<%--<!-- Single Page Header end -->--%>

<!-- Single Product Start -->
<div class="container-fluid py-5 mt-5">
    <div class="container py-5">
        <div class="row g-4 mb-5">
            <div class="col-lg-8 col-xl-9">
                <div class="row g-4">
                    <div class="col-lg-6">
                        <div class="border rounded">
                            <a href="#">
                                <img src="/images/product/${product.image}" class="img-fluid rounded" alt="${product.name}">
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <h4 class="fw-bold mb-3" style="font-family: 'Segoe UI', 'Roboto', 'Noto Sans', 'Arial', sans-serif">${product.name}</h4>
                        <p class="mb-3">Nhà sản xuất: ${product.factory}</p>
                        <p class="mb-3">Đối tượng sử dụng: ${product.target}</p>
                        <h5 class="fw-bold mb-3" style="font-family: 'Segoe UI', 'Roboto', 'Noto Sans', 'Arial', sans-serif; color: red"><fmt:formatNumber value="${product.price}" pattern="#,### "/> VND</h5>
                        <div class="d-flex mb-4">
                            <i class="fa fa-star text-secondary"></i>
                            <i class="fa fa-star text-secondary"></i>
                            <i class="fa fa-star text-secondary"></i>
                            <i class="fa fa-star text-secondary"></i>
                            <i class="fa fa-star"></i>
                        </div>
                        <p class="mb-4">${product.shortDesc}</p>
                        <c:if test="${product.quantity > 0}">
                            <p class="mb-4 text-success">Còn hàng: ${product.quantity} sản phẩm</p>
                        </c:if>
                        <c:if test="${product.quantity <= 0}">
                            <p class="mb-4 text-danger">Hết hàng</p>
                        </c:if>
                        <c:if test="${product.sold > 0}">
                            <p class="mb-4 text-muted">Đã bán: ${product.sold} sản phẩm</p>
                        </c:if>

                        <div class="input-group quantity mb-5" style="width: 100px;">
                            <div class="input-group-btn">
                                <button class="btn btn-sm btn-minus rounded-circle bg-light border" >
                                    <i class="fa fa-minus"></i>
                                </button>
                            </div>
                            <input type="text" class="form-control form-control-sm text-center border-0" value="1">
                            <div class="input-group-btn">
                                <button class="btn btn-sm btn-plus rounded-circle bg-light border">
                                    <i class="fa fa-plus"></i>
                                </button>
                            </div>
                        </div>
                        <c:if test="${product.quantity > 0}">
                            <a href="#" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary">
                                <i class="fa fa-shopping-bag me-2 text-primary"></i> Thêm vào giỏ hàng
                            </a>
                        </c:if>
                        <c:if test="${product.quantity <= 0}">
                            <button class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-muted" disabled>
                                <i class="fa fa-shopping-bag me-2 text-muted"></i> Hết hàng
                            </button>
                        </c:if>
                    </div>
                    <div class="col-lg-12">
                        <nav>
                            <div class="nav nav-tabs mb-3">
                                <button class="nav-link active border-white border-bottom-0" type="button" role="tab"
                                        id="nav-about-tab" data-bs-toggle="tab" data-bs-target="#nav-about"
                                        aria-controls="nav-about" aria-selected="true">Mô tả chi tiết</button>
                                <button class="nav-link border-white border-bottom-0" type="button" role="tab"
                                        id="nav-mission-tab" data-bs-toggle="tab" data-bs-target="#nav-mission"
                                        aria-controls="nav-mission" aria-selected="false">Đánh giá</button>
                            </div>
                        </nav>
                        <div class="tab-content mb-5">
                            <div class="tab-pane active" id="nav-about" role="tabpanel" aria-labelledby="nav-about-tab">
                                <div class="mb-4">
                                    ${product.detailDesc}
                                </div>
                                <div class="px-2">
                                    <div class="row g-4">
                                        <div class="col-6">
                                            <div class="row bg-light align-items-center text-center justify-content-center py-2">
                                                <div class="col-6">
                                                    <p class="mb-0">Tên sản phẩm</p>
                                                </div>
                                                <div class="col-6">
                                                    <p class="mb-0">${product.name}</p>
                                                </div>
                                            </div>
                                            <div class="row text-center align-items-center justify-content-center py-2">
                                                <div class="col-6">
                                                    <p class="mb-0">Nhà sản xuất</p>
                                                </div>
                                                <div class="col-6">
                                                    <p class="mb-0">${product.factory}</p>
                                                </div>
                                            </div>
                                            <div class="row bg-light text-center align-items-center justify-content-center py-2">
                                                <div class="col-6">
                                                    <p class="mb-0">Đối tượng sử dụng</p>
                                                </div>
                                                <div class="col-6">
                                                    <p class="mb-0">${product.target}</p>
                                                </div>
                                            </div>
                                            <div class="row text-center align-items-center justify-content-center py-2">
                                                <div class="col-6">
                                                    <p class="mb-0">Giá</p>
                                                </div>
                                                <div class="col-6">
                                                    <p class="mb-0"><fmt:formatNumber value="${product.price}" pattern="#,### "/> VND</p>
                                                </div>
                                            </div>
                                            <div class="row bg-light text-center align-items-center justify-content-center py-2">
                                                <div class="col-6">
                                                    <p class="mb-0">Tồn kho</p>
                                                </div>
                                                <div class="col-6">
                                                    <p class="mb-0">${product.quantity}</p>
                                                </div>
                                            </div>
                                            <div class="row text-center align-items-center justify-content-center py-2">
                                                <div class="col-6">
                                                    <p class="mb-0">Đã bán</p>
                                                </div>
                                                <div class="col-6">
                                                    <p class="mb-0">${product.sold}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" id="nav-mission" role="tabpanel" aria-labelledby="nav-mission-tab">
                                <div class="d-flex">
                                    <img src="/client/images/avatar.jpg" class="img-fluid rounded-circle p-3" style="width: 100px; height: 100px;" alt="">
                                    <div class="">
                                        <p class="mb-2" style="font-size: 14px;">April 12, 2024</p>
                                        <div class="d-flex justify-content-between">
                                            <h5>Jason Smith</h5>
                                            <div class="d-flex mb-3">
                                                <i class="fa fa-star text-secondary"></i>
                                                <i class="fa fa-star text-secondary"></i>
                                                <i class="fa fa-star text-secondary"></i>
                                                <i class="fa fa-star text-secondary"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                        </div>
                                        <p>Sản phẩm rất tốt, chất lượng như mong đợi. Sẽ mua lại lần sau.</p>
                                    </div>
                                </div>
                                <div class="d-flex">
                                    <img src="/client/images/avatar.jpg" class="img-fluid rounded-circle p-3" style="width: 100px; height: 100px;" alt="">
                                    <div class="">
                                        <p class="mb-2" style="font-size: 14px;">April 12, 2024</p>
                                        <div class="d-flex justify-content-between">
                                            <h5>Sam Peters</h5>
                                            <div class="d-flex mb-3">
                                                <i class="fa fa-star text-secondary"></i>
                                                <i class="fa fa-star text-secondary"></i>
                                                <i class="fa fa-star text-secondary"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                        </div>
                                        <p class="text-dark">Giao hàng nhanh, đóng gói cẩn thận. Sản phẩm đúng như mô tả.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <form action="#">
                        <h4 class="mb-5 fw-bold">Để lại đánh giá</h4>
                        <div class="row g-4">
                            <div class="col-lg-6">
                                <div class="border-bottom rounded">
                                    <input type="text" class="form-control border-0 me-4" placeholder="Tên của bạn *">
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="border-bottom rounded">
                                    <input type="email" class="form-control border-0" placeholder="Email của bạn *">
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="border-bottom rounded my-4">
                                    <textarea name="" id="" class="form-control border-0" cols="30" rows="8" placeholder="Đánh giá của bạn *" spellcheck="false"></textarea>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="d-flex justify-content-between py-3 mb-5">
                                    <div class="d-flex align-items-center">
                                        <p class="mb-0 me-3">Xin vui lòng đánh giá:</p>
                                        <div class="d-flex align-items-center" style="font-size: 12px;">
                                            <i class="fa fa-star text-muted"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                        </div>
                                    </div>
                                    <a href="#" class="btn border border-secondary text-primary rounded-pill px-4 py-3">Gửi đánh giá</a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-lg-4 col-xl-3">
                <div class="row g-4 fruite">
                    <div class="col-lg-12">
                        <div class="mb-4">
                            <h4>Hãng sản xuất</h4>
                            <ul class="list-unstyled fruite-categorie">
                                <li>
                                    <div class="d-flex justify-content-between fruite-name">
                                        <a href="#"><i class="fab fa-apple me-2"></i>Apple</a>
                                    </div>
                                </li>
                                <li>
                                    <div class="d-flex justify-content-between fruite-name">
                                        <a href="#"><i class="fas fa-laptop me-2"></i>Dell</a>
                                    </div>
                                </li>
                                <li>
                                    <div class="d-flex justify-content-between fruite-name">
                                        <a href="#"><i class="fas fa-desktop me-2"></i>Acer</a>
                                    </div>
                                </li>
                                <li>
                                    <div class="d-flex justify-content-between fruite-name">
                                        <a href="#"><i class="fas fa-gamepad me-2"></i>MSI</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <h4 class="mb-4">Sản phẩm nổi bật</h4>
                        <c:forEach items="${products}" var="product" begin="0" end="7">
                            <div class="d-flex align-items-center justify-content-start mb-3 p-2 border-bottom">
                                <!-- Product Image -->
                                <div class="flex-shrink-0 me-3">
                                    <div class="rounded shadow-sm" style="width: 80px; height: 80px; overflow: hidden;">
                                        <img src="/images/product/${product.image}"
                                             class="img-fluid"
                                             alt="${product.name}"
                                             style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s ease;"
                                             onmouseover="this.style.transform='scale(1.05)'"
                                             onmouseout="this.style.transform='scale(1)'">
                                    </div>
                                </div>

                                <!-- Product Info -->
                                <div class="flex-grow-1">
                                    <!-- Product Name -->
                                    <h6 class="mb-2 fw-semibold">
                                        <a href="/product/${product.id}"
                                           class="text-decoration-none text-dark hover-text-primary"
                                           style="font-family: 'Segoe UI', 'Roboto', 'Noto Sans', 'Arial', sans-serif;line-height: 1.4; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                                ${product.name}
                                        </a>
                                    </h6>

                                    <!-- Rating Stars -->
                                    <div class="d-flex align-items-center mb-2">
                                        <div class="me-2">
                                            <i class="fa fa-star text-warning"></i>
                                            <i class="fa fa-star text-warning"></i>
                                            <i class="fa fa-star text-warning"></i>
                                            <i class="fa fa-star text-warning"></i>
                                            <i class="fa fa-star text-muted"></i>
                                        </div>

                                    </div>

                                    <!-- Price -->
                                    <div class="d-flex align-items-center">
                                        <h5 class="fw-bold text-danger mb-0"
                                            style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 1.1rem;">
                                            <fmt:formatNumber value="${product.price}" pattern="#,###"/> VND
                                        </h5>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <div class="d-flex justify-content-center my-4">
                            <a href="/" class="btn border border-secondary px-4 py-3 rounded-pill text-primary w-100">Xem thêm</a>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="position-relative">
                            <img src="/client/images/samplelaptop.jpg" class="img-fluid w-100 rounded" alt="">
                            <div class="position-absolute" style="top: 50%; right: 10px; transform: translateY(-50%);">
                                <h3 class="text-secondary fw-bold">Nganj <br> Laptop <br> </h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <h1 class="fw-bold mb-0">Sản phẩm đề xuất</h1>
        <div class="vesitable">
            <div class="owl-carousel vegetable-carousel justify-content-center" style="display: flex; flex-wrap: wrap; gap: 25px; padding: 20px;">
                <c:forEach items="${products}" var="product">
                    <a href="/product/${product.id}" style="text-decoration: none; color: inherit; display: block; flex: 1; min-width: 280px; max-width: 320px;">
                        <div class="border border-primary rounded position-relative vesitable-item" style="display: flex; flex-direction: column; height: 480px; cursor: pointer; transition: all 0.3s ease; box-shadow: 0 2px 8px rgba(0,0,0,0.1); margin-bottom: 10px;" onmouseover="this.style.transform='translateY(-5px)'; this.style.boxShadow='0 4px 15px rgba(0,0,0,0.15)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 2px 8px rgba(0,0,0,0.1)'">
                            <div class="vesitable-img" style="flex-shrink: 0; height: 180px; overflow: hidden; display: flex; align-items: center; justify-content: center; border-radius: 8px 8px 0 0;">
                                <img src="/images/product/${product.image}"
                                     class="rounded-top"
                                     alt="${product.name}"
                                     style="font-family: 'Segoe UI', 'Roboto', 'Noto Sans', 'Arial', sans-serif;width: 100%; height: 100%; object-fit: cover; display: block; transition: transform 0.3s ease;"
                                     onmouseover="this.style.transform='scale(1.05)'"
                                     onmouseout="this.style.transform='scale(1)'">
                            </div>

                            <div class="text-white bg-primary px-3 py-1 rounded position-absolute"
                                 style="top: 12px; right: 12px; font-size: 0.85rem; font-weight: 500;">
                                    ${product.target}
                            </div>

                            <div class="p-4 pb-0 rounded-bottom" style="flex: 1; display: flex; flex-direction: column; justify-content: space-between; min-height: 0; padding: 20px;">
                                <div style="flex: 1; display: flex; flex-direction: column; overflow: hidden;">
                                    <h4 style="margin-bottom: 12px; font-size: 1.2rem; line-height: 1.3; height: 3rem; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; font-weight: 600; color: #333;">${product.name}</h4>
                                    <p style="margin-bottom: 18px; font-size: 0.9rem; line-height: 1.5; height: 4.5rem; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; color: #666;">${product.shortDesc}</p>
                                </div>

                                <div class="d-flex justify-content-between flex-lg-wrap align-items-center" style="margin-top: auto; padding-top: 15px; margin-bottom: 20px; border-top: 1px solid #eee;">
                                    <p class="fs-5 fw-bold" style="margin-bottom: 0; color: #dc3545; font-size: 1.3rem !important; font-weight: 700 !important;">
                                        <fmt:formatNumber value="${product.price}" pattern="#,###"/> ₫
                                    </p>
                                </div>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<!-- Single Product End -->

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
</body>

</html>