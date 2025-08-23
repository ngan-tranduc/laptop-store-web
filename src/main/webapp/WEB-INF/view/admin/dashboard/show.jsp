<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.ZoneId, java.util.Date" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="author" content="Admin"/>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet"/>
    <link href="/css/styles.css" rel="stylesheet"/>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

<body class="sb-nav-fixed">
<jsp:include page="../layout/header.jsp"/>
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <jsp:include page="../layout/sidebar.jsp"/>
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Dashboard Admin</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">Dashboard</li>
                </ol>

                <!-- Statistics Cards -->
                <div class="row" style="display: flex; flex-wrap: nowrap; gap: 5px;">
                    <div class="col-xl-3 col-md-6" style="flex: 1; min-width: 250px;">
                        <div class="card bg-primary text-white mb-4" style="border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <div class="small">Tổng Đơn Hàng</div>
                                        <div class="h5">${totalOrders}</div>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-shopping-cart fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a class="small text-white stretched-link" href="/admin/orders">Xem Chi Tiết</a>
                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6" style="flex: 1; min-width: 250px;">
                        <div class="card bg-success text-white mb-4" style="border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <div class="small">Doanh Thu</div>
                                        <div class="h5">
                                            <fmt:formatNumber value="${totalRevenue}" type="currency"
                                                              currencySymbol="₫" groupingUsed="true"/>
                                        </div>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-dollar-sign fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a class="small text-white stretched-link" href="/admin/revenue">Xem Chi Tiết</a>
                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6" style="flex: 1; min-width: 250px;">
                        <div class="card bg-info text-white mb-4" style="border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <div class="small">Sản Phẩm</div>
                                        <div class="h5">${totalProducts}</div>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-box fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a class="small text-white stretched-link" href="/admin/products">Quản Lý Sản Phẩm</a>
                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6" style="flex: 1; min-width: 250px;">
                        <div class="card bg-warning text-white mb-4" style="border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <div class="small">Người Dùng</div>
                                        <div class="h5">${totalUsers}</div>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-users fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer d-flex align-items-center justify-content-between">
                                <a class="small text-white stretched-link" href="/admin/users">Quản Lý Người Dùng</a>
                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts Row -->
                <div class="row" style="display: flex;">
                    <div class="col-xl-6" style="flex: 1; padding-right: 10px;">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-chart-area me-1"></i>
                                Doanh Thu Theo Tuần (7 Ngày Gần Đây)
                            </div>
                            <div class="card-body">
                                <canvas id="revenueChart" width="100%" height="40"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6" style="flex: 1; padding-left: 10px;">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-chart-bar me-1"></i>
                                Đơn Hàng Theo Trạng Thái
                            </div>
                            <div class="card-body">
                                <canvas id="orderStatusChart" width="100%" height="40"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Orders Table -->
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-table me-1"></i>
                        Đơn Hàng Gần Đây
                        <div class="float-end">
                            <a href="/admin/orders" class="btn btn-primary btn-sm">Xem Tất Cả</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Khách Hàng</th>
                                <th>Tổng Tiền</th>
                                <th>Trạng Thái</th>
                                <th>Ngày Tạo</th>
                                <th>Thao Tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="order" items="${recentOrders}" varStatus="status">
                                <tr>
                                    <td>#${order.id}</td>
                                    <td>
                                        <div class="fw-bold">${order.receiverName}</div>
                                        <div class="small text-muted">${order.receiverPhone}</div>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${order.totalPrice}" type="currency"
                                                          currencySymbol="₫" groupingUsed="true"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.status == 'PENDING'}">
                                                <span class="badge bg-warning">Chờ Xử Lý</span>
                                            </c:when>
                                            <c:when test="${order.status == 'CONFIRMED'}">
                                                <span class="badge bg-info">Đã Xác Nhận</span>
                                            </c:when>
                                            <c:when test="${order.status == 'SHIPPING'}">
                                                <span class="badge bg-primary">Đang Giao</span>
                                            </c:when>
                                            <c:when test="${order.status == 'COMPLETED'}">
                                                <span class="badge bg-success">Hoàn Thành</span>
                                            </c:when>
                                            <c:when test="${order.status == 'CANCELLED'}">
                                                <span class="badge bg-danger">Đã Hủy</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${order.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>${order.formattedCreatedAtWithTime}</td>

                                    <td>
                                        <a href="/admin/orders/${order.id}" class="btn btn-outline-primary btn-sm">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="/admin/orders/${order.id}/edit" class="btn btn-outline-secondary btn-sm">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Top Selling Products -->
                <div class="row">
                    <div class="col-xl-6">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-fire me-1"></i>
                                Sản Phẩm Bán Chạy
                            </div>
                            <div class="card-body">
                                <c:forEach var="product" items="${topSellingProducts}" varStatus="status">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="me-3">
                                            <img src="/images/product/${product.image}" alt="${product.name}"
                                                 class="rounded" style="width: 50px; height: 50px; object-fit: cover;">
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-bold">${product.name}</div>
                                            <div class="small text-muted"><fmt:formatNumber value="${product.price}" type="currency"
                                                                                            currencySymbol="₫" groupingUsed="true"/></div>
                                        </div>
                                        <div class="text-end">
                                            <div class="fw-bold">
                                                Đã bán: ${product.sold} sản phẩm
                                            </div>
                                        </div>
                                    </div>
                                    <c:if test="${!status.last}">
                                        <hr class="my-2">
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-6">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-exclamation-triangle me-1"></i>
                                Sản Phẩm Sắp Hết Hàng
                            </div>
                            <div class="card-body">
                                <c:forEach var="product" items="${lowStockProducts}" varStatus="status">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="me-3">
                                            <img src="/images/product/${product.image}" alt="${product.name}"
                                                 class="rounded" style="width: 50px; height: 50px; object-fit: cover;">
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-bold">${product.name}</div>
                                            <div class="small text-muted">Nhà sản xuất: ${product.factory}</div>
                                        </div>
                                        <div class="text-end">
                                            <div class="badge ${product.quantity == 0 ? 'bg-danger' : 'bg-warning'} fs-6">
                                                    ${product.quantity} còn lại
                                            </div>
                                        </div>
                                    </div>
                                    <c:if test="${!status.last}">
                                        <hr class="my-2">
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp"/>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>

<script>
    // Revenue Chart - 7 ngày gần đây
    var ctx = document.getElementById("revenueChart");
    var myLineChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ["6 ngày trước", "5 ngày trước", "4 ngày trước", "3 ngày trước", "2 ngày trước", "Hôm qua", "Hôm nay"],
            datasets: [{
                label: "Doanh Thu",
                lineTension: 0.3,
                backgroundColor: "rgba(2,117,216,0.2)",
                borderColor: "rgba(2,117,216,1)",
                pointRadius: 5,
                pointBackgroundColor: "rgba(2,117,216,1)",
                pointBorderColor: "rgba(255,255,255,0.8)",
                pointHoverRadius: 5,
                pointHoverBackgroundColor: "rgba(2,117,216,1)",
                pointHitRadius: 50,
                pointBorderWidth: 2,
                data: ${weeklyRevenue},
            }],
        },
        options: {
            scales: {
                xAxes: [{
                    gridLines: {
                        display: false
                    },
                    ticks: {
                        maxTicksLimit: 7
                    }
                }],
                yAxes: [{
                    ticks: {
                        min: 0,
                        maxTicksLimit: 5,
                        callback: function(value, index, values) {
                            return value.toLocaleString('vi-VN') + ' ₫';
                        }
                    },
                    gridLines: {
                        color: "rgba(0, 0, 0, .125)",
                    }
                }],
            },
            legend: {
                display: false
            },
            tooltips: {
                callbacks: {
                    label: function(tooltipItem, data) {
                        return data.datasets[tooltipItem.datasetIndex].label + ': ' +
                            tooltipItem.yLabel.toLocaleString('vi-VN') + ' ₫';
                    }
                }
            }
        }
    });

    // Order Status Chart
    var ctx2 = document.getElementById("orderStatusChart");
    var myBarChart = new Chart(ctx2, {
        type: 'bar',
        data: {
            labels: ["Chờ Xử Lý", "Đã Xác Nhận", "Đang Giao", "Hoàn Thành", "Đã Hủy"],
            datasets: [{
                label: "Số Đơn Hàng",
                backgroundColor: [
                    "rgba(255, 193, 7, 0.8)",  // Warning - Chờ xử lý
                    "rgba(13, 202, 240, 0.8)", // Info - Đã xác nhận
                    "rgba(13, 110, 253, 0.8)", // Primary - Đang giao
                    "rgba(25, 135, 84, 0.8)",  // Success - Hoàn thành
                    "rgba(220, 53, 69, 0.8)"   // Danger - Đã hủy
                ],
                borderColor: [
                    "rgba(255, 193, 7, 1)",
                    "rgba(13, 202, 240, 1)",
                    "rgba(13, 110, 253, 1)",
                    "rgba(25, 135, 84, 1)",
                    "rgba(220, 53, 69, 1)"
                ],
                borderWidth: 1,
                data: ${orderStatusData},
            }],
        },
        options: {
            scales: {
                xAxes: [{
                    gridLines: {
                        display: false
                    }
                }],
                yAxes: [{
                    ticks: {
                        min: 0,
                        maxTicksLimit: 5,
                        stepSize: 1
                    },
                    gridLines: {
                        display: true
                    }
                }],
            },
            legend: {
                display: false
            },
            tooltips: {
                callbacks: {
                    label: function(tooltipItem, data) {
                        return data.datasets[tooltipItem.datasetIndex].label + ': ' +
                            tooltipItem.yLabel + ' đơn hàng';
                    }
                }
            }
        }
    });
</script>

</body>
</html>