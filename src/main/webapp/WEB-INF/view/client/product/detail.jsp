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
                        <h4 class="fw-bold mb-3">${product.name}</h4>
                        <p class="mb-3">Nhà sản xuất: ${product.factory}</p>
                        <p class="mb-3">Đối tượng sử dụng: ${product.target}</p>
                        <h5 class="fw-bold mb-3"><fmt:formatNumber value="${product.price}" pattern="#,### "/> VND</h5>
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
                        <div class="input-group w-100 mx-auto d-flex mb-4">
                            <input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                            <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                        </div>
                        <div class="mb-4">
                            <h4>Sản phẩm</h4>
                            <ul class="list-unstyled fruite-categorie">
                                <li>
                                    <div class="d-flex justify-content-between fruite-name">
                                        <a href="#"><i class="fas fa-apple-alt me-2"></i>Apple</a>
                                    </div>
                                </li>
                                <li>
                                    <div class="d-flex justify-content-between fruite-name">
                                        <a href="#"><i class="fas fa-apple-alt me-2"></i>Dell</a>
                                    </div>
                                </li>
                                <li>
                                    <div class="d-flex justify-content-between fruite-name">
                                        <a href="#"><i class="fas fa-apple-alt me-2"></i>Acer</a>
                                    </div>
                                </li>
                                <li>
                                    <div class="d-flex justify-content-between fruite-name">
                                        <a href="#"><i class="fas fa-apple-alt me-2"></i>MSI</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <h4 class="mb-4">Featured products</h4>
                        <c:forEach items="${products}" var="product" begin="0" end="5">
                            <div class="d-flex align-items-center justify-content-start">
                                <div class="rounded" style="width: 100px; height: 100px;">
                                    <img src="/images/product/${product.image}" class="img-fluid rounded" alt="${product.name}" style="width: 100%; height: 100%; object-fit: cover;">
                                </div>
                                <div>
                                    <h6 class="mb-2">${product.name}</h6>
                                    <div class="d-flex mb-2">
                                        <i class="fa fa-star text-secondary"></i>
                                        <i class="fa fa-star text-secondary"></i>
                                        <i class="fa fa-star text-secondary"></i>
                                        <i class="fa fa-star text-secondary"></i>
                                        <i class="fa fa-star text-secondary"></i>
                                    </div>
                                    <div class="d-flex mb-2">
                                        <h5 class="fw-bold me-2">
                                            <fmt:formatNumber value="${product.price}" pattern="#,###"/> VNĐ
                                        </h5>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <div class="d-flex justify-content-center my-4">
                            <a href="/" class="btn border border-secondary px-4 py-3 rounded-pill text-primary w-100">Vew More</a>
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
        <h1 class="fw-bold mb-0">Related products</h1>
        <div class="vesitable">
            <div class="owl-carousel vegetable-carousel justify-content-center" style="display: flex; flex-wrap: wrap; gap: 20px;">
                <c:forEach items="${products}" var="product">
                    <a href="/product/${product.id}" style="text-decoration: none; color: inherit; display: block;">
                        <div class="border border-primary rounded position-relative vesitable-item" style="flex: 1; min-width: 250px; max-width: 300px; display: flex; flex-direction: column; height: 450px; cursor: pointer; transition: transform 0.2s ease;">
                            <div class="vesitable-img" style="flex-shrink: 0; height: 170px; overflow: hidden; display: flex; align-items: center; justify-content: center;">
                                <img src="/images/product/${product.image}"
                                     class="rounded-top"
                                     alt="${product.name}"
                                     style="width: 100%; height: 100%; object-fit: cover; display: block;">
                            </div>

                            <div class="text-white bg-primary px-3 py-1 rounded position-absolute"
                                 style="top: 10px; right: 10px;">
                                    ${product.target}
                            </div>

                            <div class="p-4 pb-0 rounded-bottom" style="flex: 1; display: flex; flex-direction: column; justify-content: space-between; min-height: 0;">
                                <div style="flex: 1; display: flex; flex-direction: column; overflow: hidden;">
                                    <h4 style="margin-bottom: 10px; font-size: 1.1rem; line-height: 1.3; height: 2.6rem; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">${product.name}</h4>
                                    <p style="margin-bottom: 15px; font-size: 0.9rem; line-height: 1.4; height: 4.2rem; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; color: #666;">${product.shortDesc}</p>
                                </div>

                                <div class="d-flex justify-content-between flex-lg-wrap align-items-center" style="margin-top: auto; padding-top: 10px; margin-bottom: 20px;">
                                    <p class="text-dark fs-5 fw-bold" style="margin-bottom: 0;">
                                        <fmt:formatNumber value="${product.price}" pattern="#,###"/>
                                    </p>
                                    <span class="btn border border-secondary rounded-pill px-3 py-1 text-primary"
                                          style="white-space: nowrap; flex-shrink: 0; pointer-events: none;">
                                <i class="fa fa-shopping-bag me-2 text-primary"></i>
                                Add
                            </span>
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