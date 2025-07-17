<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%--<div class="container-fluid pb-5 mb-5 hero-header">--%>
<%--    <div class="container pb-5">--%>
<%--        <div class="row g-5 align-items-center">--%>
<%--            <div class="col-md-12 col-lg-7">--%>
<%--                <h4 class="mb-3 text-secondary">Công nghệ hàng đầu</h4>--%>
<%--                <h1 class="mb-5 display-3 text-primary">Laptop Gaming & Văn phòng cao cấp</h1>--%>
<%--                <div class="position-relative mx-auto">--%>
<%--                    <input class="form-control border-2 border-secondary w-75 py-3 px-4 rounded-pill" type="text" placeholder="Tìm kiếm laptop...">--%>
<%--                    <button type="submit" class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute rounded-pill text-white h-100" style="top: 0; right: 25%;">Tìm kiếm</button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-md-12 col-lg-5">--%>
<%--                <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">--%>
<%--                    <div class="carousel-inner" role="listbox">--%>
<%--                        <div class="carousel-item active rounded">--%>
<%--                            <img src="client/images/laptop-gaming.jpg" class="img-fluid w-100 h-100 bg-secondary rounded" alt="Laptop Gaming" style="object-fit: cover; height: 350px;">--%>
<%--                            <a href="#" class="btn px-4 py-2 text-white rounded" style="position: absolute; bottom: 20px; left: 20px; background: rgba(0,0,0,0.7);">Gaming</a>--%>
<%--                        </div>--%>
<%--                        <div class="carousel-item rounded">--%>
<%--                            <img src="client/images/laptop-office.jpg" class="img-fluid w-100 h-100 rounded" alt="Laptop Văn phòng" style="object-fit: cover; height: 350px;">--%>
<%--                            <a href="#" class="btn px-4 py-2 text-white rounded" style="position: absolute; bottom: 20px; left: 20px; background: rgba(0,0,0,0.7);">Văn phòng</a>--%>
<%--                        </div>--%>
<%--                        <div class="carousel-item rounded">--%>
<%--                            <img src="client/images/laptop-design.jpg" class="img-fluid w-100 h-100 rounded" alt="Laptop Thiết kế" style="object-fit: cover; height: 350px;">--%>
<%--                            <a href="#" class="btn px-4 py-2 text-white rounded" style="position: absolute; bottom: 20px; left: 20px; background: rgba(0,0,0,0.7);">Thiết kế</a>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselId" data-bs-slide="prev">--%>
<%--                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>--%>
<%--                        <span class="visually-hidden">Previous</span>--%>
<%--                    </button>--%>
<%--                    <button class="carousel-control-next" type="button" data-bs-target="#carouselId" data-bs-slide="next">--%>
<%--                        <span class="carousel-control-next-icon" aria-hidden="true"></span>--%>
<%--                        <span class="visually-hidden">Next</span>--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<div class="container-fluid pt-5 mt-5">
    <div id="carouselExample" class="carousel slide mt-100" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="client/images/hssv.png" class="d-block w-100" style="height: auto; object-fit: cover;" alt="Slide 1">
            </div>
            <div class="carousel-item">
                <img src="client/images/hieuthuhai.png" class="d-block w-100" style="height: auto; object-fit: cover;" alt="Slide 2">
            </div>
        </div>

        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>

        <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>

        <div class="carousel-indicators">
            <button type="button" data-bs-target="#carouselExample" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#carouselExample" data-bs-slide-to="1" aria-label="Slide 2"></button>
<%--            <button type="button" data-bs-target="#carouselExample" data-bs-slide-to="2" aria-label="Slide 3"></button>--%>
        </div>
    </div>
</div>


<%--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>--%>
