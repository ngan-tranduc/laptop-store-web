<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container-fluid fixed-top">
    <div class="container px-0">
        <nav class="navbar navbar-light bg-white navbar-expand-xl">
            <a href="/" class="navbar-brand"><h1 class="text-primary display-6">Nganj Shop</h1></a>
            <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="fa fa-bars text-primary"></span>
            </button>
            <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                <div class="navbar-nav mx-auto">
                    <a href="/" class="nav-item nav-link active">Trang chủ</a>
<%--                    <a href="shop.html" class="nav-item nav-link">Shop</a>--%>
<%--                    <a href="shop-detail.html" class="nav-item nav-link">Shop Detail</a>--%>
<%--                    <div class="nav-item dropdown">--%>
<%--                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>--%>
<%--                        <div class="dropdown-menu m-0 bg-secondary rounded-0">--%>
<%--                            <a href="cart.html" class="dropdown-item">Cart</a>--%>
<%--                            <a href="chackout.html" class="dropdown-item">Chackout</a>--%>
<%--                            <a href="testimonial.html" class="dropdown-item">Testimonial</a>--%>
<%--                            <a href="404.html" class="dropdown-item">404 Page</a>--%>
<%--                        </div>--%>
<%--                    </div>--%>
                    <a href="#" class="nav-item nav-link">Liên hệ</a>
                </div>
                <div class="d-flex m-3 me-0">
                    <c:if test="${not empty pageContext.request.userPrincipal}">
                    <a href="/cart" class="position-relative me-4 my-auto">
                        <i class="fa fa-shopping-bag fa-2x"></i>
                        <span class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1" style="top: -5px; left: 15px; height: 20px; min-width: 20px;">${sessionScope.sum}</span>
                    </a>
                    <div class="dropdown my-auto">
                        <a href="#" class="dropdown" role="button" id="dropdownMenuLink"
                           data-bs-toggle="dropdown" aria-expanded="false" data-bs-toggle="dropdown"
                           aria-expanded="false">
                            <i class="fas fa-user fa-2x"></i>
                        </a>

                        <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0" aria-labelledby="dropdownMenuLink" style="min-width: 280px; border-radius: 12px;">
                            <!-- User Profile Section -->
                            <li class="px-4 py-3 border-bottom">
                                <div class="d-flex flex-column align-items-center text-center">
                                    <div class="position-relative mb-3">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.avatar}">
                                                <img class="rounded-circle border border-2 border-light shadow-sm"
                                                     style="width: 80px; height: 80px; object-fit: cover;"
                                                     src="/images/avatar/${sessionScope.avatar}"
                                                     alt="User Avatar"
                                                     onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"/>
                                                <div class="d-none rounded-circle border border-2 border-light shadow-sm bg-light justify-content-center align-items-center"
                                                     style="width: 80px; height: 80px;">
                                                    <i class="fas fa-user text-muted" style="font-size: 2rem;"></i>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="rounded-circle border border-2 border-light shadow-sm bg-light d-flex justify-content-center align-items-center"
                                                     style="width: 80px; height: 80px;">
                                                    <i class="fas fa-user text-muted" style="font-size: 2rem;"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="position-absolute bottom-0 end-0 bg-success rounded-circle border border-2 border-white"
                                             style="width: 20px; height: 20px;"></div>
                                    </div>
                                    <h6 class="mb-1 fw-semibold text-dark">
                                        <c:out value="${sessionScope.fullName}" default="Guest"/>
                                    </h6>
                                    <small class="text-muted">Thành viên</small>
                                </div>
                            </li>

                            <!-- Menu Items -->
                            <li class="px-2 py-1">
                                <a class="dropdown-item rounded-3 px-3 py-2 d-flex align-items-center" href="#">
                                    <i class="fas fa-user-cog me-3 text-primary" style="width: 20px;"></i>
                                    <span>Quản lý tài khoản</span>
                                </a>
                            </li>

                            <li class="px-2 py-1">
                                <a class="dropdown-item rounded-3 px-3 py-2 d-flex align-items-center" href="/order-history">
                                    <i class="fas fa-shopping-bag me-3 text-primary" style="width: 20px;"></i>
                                    <span>Lịch sử mua hàng</span>
                                </a>
                            </li>

                            <!-- Divider -->
                            <li class="mx-3 my-2">
                                <hr class="dropdown-divider border-top border-1 opacity-25">
                            </li>

                            <!-- Logout Section -->
                            <li class="px-2 pb-2">
                                <form method="post" action="/logout" class="m-0">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="dropdown-item rounded-3 px-3 py-2 d-flex align-items-center text-danger border-0 bg-transparent w-100">
                                        <i class="fas fa-sign-out-alt me-3" style="width: 20px;"></i>
                                        <span>Đăng xuất</span>
                                    </button>
                                </form>
                            </li>
                        </ul>

                        <style>
                            /* Custom styles for better appearance */
                            .dropdown-menu {
                                --bs-dropdown-link-hover-bg: rgba(101, 153, 6, 0.1);
                                --bs-dropdown-link-hover-color: #659906;
                            }

                            .dropdown-item:hover {
                                background-color: var(--bs-dropdown-link-hover-bg) !important;
                                color: var(--bs-dropdown-link-hover-color) !important;
                                transform: translateX(2px);
                                transition: all 0.2s ease;
                            }

                            .dropdown-item.text-danger:hover {
                                background-color: rgba(220, 53, 69, 0.1) !important;
                                color: #dc3545 !important;
                            }

                            .dropdown-menu::before {
                                content: '';
                                position: absolute;
                                top: -8px;
                                right: 20px;
                                width: 0;
                                height: 0;
                                border-left: 8px solid transparent;
                                border-right: 8px solid transparent;
                                border-bottom: 8px solid white;
                                filter: drop-shadow(0 -2px 4px rgba(0,0,0,0.1));
                            }
                        </style>
                    </div>
                    </c:if>
                    <c:if test="${empty pageContext.request.userPrincipal}">
                        <a href="/login" class="position-relative me-4 my-auto">
                            <i class="fa fa-shopping-bag fa-2x"></i>
<%--                            <span class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1" style="top: -5px; left: 15px; height: 20px; min-width: 20px;">3</span>--%>
                        </a>
                        <a href="/login" class="position-relative me-4 my-auto">

                            Đăng nhập
                        </a>
                    </c:if>
                </div>
            </div>
        </nav>
    </div>
</div>
<!-- Navbar End -->