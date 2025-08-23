<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="author" content="Nganj"/>
    <title>Admin - Quản lý đơn hàng</title>
    <link href="/css/styles.css" rel="stylesheet"/>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .btn-soft-view {
            background-color: #e0e7ff;
            border-color: #c7d2fe;
            color: #4338ca;
        }
        .btn-soft-view:hover {
            background-color: #c7d2fe;
            border-color: #a5b4fc;
            color: #3730a3;
        }

        .btn-soft-edit {
            background-color: #dcfce7;
            border-color: #bbf7d0;
            color: #166534;
        }
        .btn-soft-edit:hover {
            background-color: #bbf7d0;
            border-color: #86efac;
            color: #14532d;
        }

        .order-id {
            font-weight: 600;
            color: #2d3748;
            font-family: 'Courier New', monospace;
        }

        .customer-info {
            font-weight: 500;
            color: #374151;
        }

        .customer-contact {
            font-size: 0.875rem;
            color: #6b7280;
        }

        .total-price {
            font-weight: 700;
            color: #dc3545;
            font-size: 1.1rem;
        }

        .status-badge {
            font-size: 0.75rem;
            padding: 0.4rem 0.8rem;
            border-radius: 0.5rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.025em;
        }

        .status-pending {
            background-color: #fef3c7;
            color: #92400e;
            border: 1px solid #f59e0b;
        }

        .status-confirmed {
            background-color: #dbeafe;
            color: #1e40af;
            border: 1px solid #3b82f6;
        }

        .status-shipping {
            background-color: #e0e7ff;
            color: #4338ca;
            border: 1px solid #6366f1;
        }

        .status-delivered {
            background-color: #d1fae5;
            color: #065f46;
            border: 1px solid #10b981;
        }

        .status-cancelled {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #ef4444;
        }

        .order-date {
            font-size: 0.875rem;
            color: #6b7280;
        }

        .items-count {
            background-color: #f3f4f6;
            color: #374151;
            padding: 0.25rem 0.6rem;
            border-radius: 0.375rem;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .table th {
            background-color: #f8fafc;
            border-bottom: 2px solid #e2e8f0;
            font-weight: 600;
            color: #1a202c;
        }

        .customer-details {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        /* Tối ưu hiệu suất table */
        .table {
            table-layout: fixed;
        }

        .table td {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            vertical-align: middle;
        }

        .table td:nth-child(3), .table td:nth-child(4) {
            white-space: normal;
            word-wrap: break-word;
        }

        /* Filter section */
        .filter-section {
            background-color: #f8fafc;
            border-radius: 0.5rem;
            padding: 1rem;
            margin-bottom: 1.5rem;
            border: 1px solid #e2e8f0;
        }

        .filter-title {
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.75rem;
        }

        /* Statistics cards */
        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 1rem;
            padding: 1.5rem;
            color: white;
            border: none;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .stats-card.pending {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
        }

        .stats-card.confirmed {
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
        }

        .stats-card.shipping {
            background: linear-gradient(135deg, #6366f1 0%, #4338ca 100%);
        }

        .stats-card.delivered {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        }

        .stats-number {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }

        .stats-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        /* Pagination improvements */
        .pagination {
            margin-bottom: 0;
        }

        .page-item.active .page-link {
            background-color: #0d6efd;
            border-color: #0d6efd;
        }

        /* Responsive improvements */
        @media (max-width: 768px) {
            .table-responsive {
                font-size: 0.875rem;
            }

            .stats-card {
                padding: 1rem;
            }

            .stats-number {
                font-size: 1.5rem;
            }
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
                <h1 class="mt-4">
                    <i class="bi bi-cart-check me-2"></i>
                    Quản lý đơn hàng
                </h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Đơn hàng</li>
                </ol>

                <!-- Statistics Cards -->
                <!-- Statistics Cards -->
                <div class="row mb-4" style="display: flex;">
                    <div class="col-xl-3 col-md-6" style="flex: 1; padding: 0 7.5px;">
                        <div class="card h-100" style="background-color: #fff3cd; border: 1px solid #ffc107; border-radius: 8px;">
                            <div class="card-body" style="padding: 1.5rem;">
                                <div style="font-size: 2rem; font-weight: 700; margin-bottom: 0.25rem; color: #856404;">${pendingOrders}</div>
                                <div style="font-size: 0.9rem; color: #856404;">
                                    <i class="bi bi-clock me-1"></i>Chờ xác nhận
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6" style="flex: 1; padding: 0 7.5px;">
                        <div class="card h-100" style="background-color: #d1ecf1; border: 1px solid #17a2b8; border-radius: 8px;">
                            <div class="card-body" style="padding: 1.5rem;">
                                <div style="font-size: 2rem; font-weight: 700; margin-bottom: 0.25rem; color: #0c5460;">${confirmedOrders}</div>
                                <div style="font-size: 0.9rem; color: #0c5460;">
                                    <i class="bi bi-check-circle me-1"></i>Đã xác nhận
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6" style="flex: 1; padding: 0 7.5px;">
                        <div class="card h-100" style="background-color: #e2e3ff; border: 1px solid #6f42c1; border-radius: 8px;">
                            <div class="card-body" style="padding: 1.5rem;">
                                <div style="font-size: 2rem; font-weight: 700; margin-bottom: 0.25rem; color: #493267;">${shippingOrders}</div>
                                <div style="font-size: 0.9rem; color: #493267;">
                                    <i class="bi bi-truck me-1"></i>Đang giao
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6" style="flex: 1; padding: 0 7.5px;">
                        <div class="card h-100" style="background-color: #d4edda; border: 1px solid #28a745; border-radius: 8px;">
                            <div class="card-body" style="padding: 1.5rem;">
                                <div style="font-size: 2rem; font-weight: 700; margin-bottom: 0.25rem; color: #155724;">${deliveredOrders}</div>
                                <div style="font-size: 0.9rem; color: #155724;">
                                    <i class="bi bi-check2-all me-1"></i>Hoàn thành
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Filter Section -->
                <div class="filter-section">
                    <form method="GET" action="/admin/order" class="row g-3">
                        <div class="col-md-3">
                            <label class="form-label filter-title">Trạng thái</label>
                            <select class="form-select" name="status">
                                <option value="">Tất cả trạng thái</option>
                                <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>Chờ xác nhận</option>
                                <option value="CONFIRMED" ${param.status == 'CONFIRMED' ? 'selected' : ''}>Đã xác nhận</option>
                                <option value="SHIPPING" ${param.status == 'SHIPPING' ? 'selected' : ''}>Đang giao</option>
                                <option value="DELIVERED" ${param.status == 'DELIVERED' ? 'selected' : ''}>Hoàn thành</option>
                                <option value="CANCELLED" ${param.status == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label filter-title">Từ ngày</label>
                            <input type="date" class="form-control" name="fromDate" value="${param.fromDate}">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label filter-title">Đến ngày</label>
                            <input type="date" class="form-control" name="toDate" value="${param.toDate}">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label filter-title">&nbsp;</label>
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-funnel me-1"></i>Lọc
                                </button>
                                <a href="/admin/order" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-clockwise me-1"></i>Reset
                                </a>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h5 class="mb-0">Danh sách đơn hàng</h5>
                        <small class="text-muted">Tổng cộng: ${totalOrders} đơn hàng</small>
                    </div>
                </div>

                <!-- Orders Table -->
                <div class="card">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover mb-0">
                                <thead class="table-light">
                                <tr>
                                    <th scope="col" style="width: 8%;">Mã ĐH</th>
                                    <th scope="col" style="width: 30%;">Khách hàng</th>
                                    <th scope="col" style="width: 7%;">Số SP</th>
                                    <th scope="col" style="width: 12%;">Tổng tiền</th>
                                    <th scope="col" style="width: 13%;">Trạng thái</th>
                                    <th scope="col" style="width: 10%;" class="text-center">Hành động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="order" items="${orders}" varStatus="status">
                                    <tr data-order-id="${order.id}">
                                        <td class="align-middle">
                                            <span class="order-id">#${order.id}</span>
                                        </td>
                                        <td class="align-middle">
                                            <div class="customer-details">
                                                <div class="customer-info">${order.user.fullName}</div>
                                                <div class="customer-contact">
                                                    <i class="bi bi-envelope me-1"></i>${order.user.email}
                                                </div>
                                            </div>
                                        </td>
                                        <td class="align-middle text-center">
                                            <span class="items-count">
                                                <c:set var="totalItems" value="0"/>
                                                <c:forEach var="detail" items="${order.orderDetails}">
                                                    <c:set var="totalItems" value="${totalItems + detail.quantity}"/>
                                                </c:forEach>
                                                ${totalItems} SP
                                            </span>
                                        </td>
                                        <td class="align-middle">
                                            <span class="total-price">
                                                <fmt:formatNumber value="${order.totalPrice}" pattern="#,### "/>đ
                                            </span>
                                        </td>
                                        <td class="align-middle">
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
                                        </td>
                                        <td class="text-center align-middle">
                                            <div class="btn-group" role="group">
                                                <a href="/admin/order/${order.id}"
                                                   class="btn btn-sm btn-soft-view"
                                                   title="Xem chi tiết">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <button type="button"
                                                        class="btn btn-sm btn-soft-edit"
                                                        onclick="editOrderStatus(${order.id}, '${order.status}')"
                                                        title="Cập nhật trạng thái">
                                                    <i class="bi bi-pencil-square"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <!-- Previous page -->
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="/admin/order?page=${currentPage - 1}&status=${param.status}&fromDate=${param.fromDate}&toDate=${param.toDate}" aria-label="Previous">
                                        <i class="bi bi-chevron-left"></i>
                                    </a>
                                </li>
                            </c:if>

                            <!-- Page numbers with smart pagination -->
                            <c:choose>
                                <c:when test="${totalPages <= 7}">
                                    <!-- Show all pages if total is 7 or less -->
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="/admin/order?page=${i}&status=${param.status}&fromDate=${param.fromDate}&toDate=${param.toDate}">${i}</a>
                                        </li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <!-- Smart pagination for more than 7 pages -->
                                    <c:choose>
                                        <c:when test="${currentPage <= 4}">
                                            <!-- Show first 5 pages, then ... and last page -->
                                            <c:forEach var="i" begin="1" end="5">
                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="/admin/order?page=${i}&status=${param.status}&fromDate=${param.fromDate}&toDate=${param.toDate}">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item disabled">
                                                <span class="page-link">...</span>
                                            </li>
                                            <li class="page-item">
                                                <a class="page-link" href="/admin/order?page=${totalPages}&status=${param.status}&fromDate=${param.fromDate}&toDate=${param.toDate}">${totalPages}</a>
                                            </li>
                                        </c:when>
                                        <c:when test="${currentPage >= totalPages - 3}">
                                            <!-- Show first page, then ... and last 5 pages -->
                                            <li class="page-item">
                                                <a class="page-link" href="/admin/order?page=1&status=${param.status}&fromDate=${param.fromDate}&toDate=${param.toDate}">1</a>
                                            </li>
                                            <li class="page-item disabled">
                                                <span class="page-link">...</span>
                                            </li>
                                            <c:forEach var="i" begin="${totalPages - 4}" end="${totalPages}">
                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="/admin/order?page=${i}&status=${param.status}&fromDate=${param.fromDate}&toDate=${param.toDate}">${i}</a>
                                                </li>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Show first page, current page with neighbors, and last page -->
                                            <li class="page-item">
                                                <a class="page-link" href="/admin/order?page=1&status=${param.status}&fromDate=${param.fromDate}&toDate=${param.toDate}">1</a>
                                            </li>
                                            <li class="page-item disabled">
                                                <span class="page-link">...</span>
                                            </li>
                                            <c:forEach var="i" begin="${currentPage - 2}" end="${currentPage + 2}">
                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="/admin/order?page=${i}&status=${param.status}&fromDate=${param.fromDate}&toDate=${param.toDate}">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item disabled">
                                                <span class="page-link">...</span>
                                            </li>
                                            <li class="page-item">
                                                <a class="page-link" href="/admin/order?page=${totalPages}&status=${param.status}&fromDate=${param.fromDate}&toDate=${param.toDate}">${totalPages}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>

                            <!-- Next page -->
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="/admin/order?page=${currentPage + 1}&status=${param.status}&fromDate=${param.fromDate}&toDate=${param.toDate}" aria-label="Next">
                                        <i class="bi bi-chevron-right"></i>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>

                    <!-- Pagination info -->
                    <div class="d-flex justify-content-center mt-2">
                        <small class="text-muted">
                            Trang ${currentPage} / ${totalPages}
                        </small>
                    </div>
                </c:if>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp"/>
    </div>
</div>

<!-- Edit Status Modal -->
<div class="modal fade" id="editStatusModal" tabindex="-1" aria-labelledby="editStatusModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editStatusModalLabel">
                    <i class="bi bi-pencil-square me-2"></i>
                    Cập nhật trạng thái đơn hàng
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="editStatusForm" method="POST" action="">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="orderStatus" class="form-label">Trạng thái mới:</label>
                        <select class="form-select" id="orderStatus" name="status" required>
                            <option value="">-- Chọn trạng thái --</option>
                            <option value="PENDING">Chờ xác nhận</option>
                            <option value="CONFIRMED">Xác nhận</option>
                            <option value="SHIPPING">Đang giao hàng</option>
                            <option value="DELIVERED">Hoàn thành</option>
                            <option value="CANCELLED">Huỷ</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="statusNote" class="form-label">Ghi chú (tùy chọn):</label>
                        <textarea class="form-control" id="statusNote" name="note" rows="3" placeholder="Nhập ghi chú về việc thay đổi trạng thái..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-check-lg me-1"></i>Cập nhật
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/scripts.js"></script>
// Fixed JavaScript section for the JSP
<script type="text/javascript">
    // Biến global để lưu thông tin đơn hàng đang edit
    let currentOrderId = null;
    let currentOrderStatus = null;

    // Mở modal edit trạng thái
    function editOrderStatus(orderId, currentStatus) {
        currentOrderId = orderId;
        currentOrderStatus = currentStatus;

        // Reset form
        document.getElementById('editStatusForm').reset();
        document.getElementById('statusNote').value = '';

        // FIXED: Set correct action URL for form (matches controller mapping)
        document.getElementById('editStatusForm').action = '/admin/order/' + orderId + '/update-status';

        // Set trạng thái hiện tại trong select
        document.getElementById('orderStatus').value = currentStatus;

        // Cập nhật title modal
        document.getElementById('editStatusModalLabel').innerHTML =
            '<i class="bi bi-pencil-square me-2"></i>Cập nhật trạng thái đơn hàng #' + orderId;

        // Hiển thị modal
        const modal = new bootstrap.Modal(document.getElementById('editStatusModal'));
        modal.show();
    }

    // Xử lý submit form cập nhật trạng thái qua AJAX
    function handleStatusUpdate(event) {
        event.preventDefault();

        const form = event.target;
        const formData = new FormData(form);
        const newStatus = formData.get('status');
        const note = formData.get('note');

        // Kiểm tra xác nhận cho trạng thái nguy hiểm
        if (newStatus === 'CANCELLED' && !confirm('Bạn có chắc chắn muốn HỦY đơn hàng này không?')) {
            return;
        }

        // Hiển thị loading state
        const submitBtn = form.querySelector('button[type="submit"]');
        const originalBtnText = submitBtn.innerHTML;
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Đang cập nhật...';

        // FIXED: Use correct endpoint that matches controller
        fetch('/admin/order/' + currentOrderId + '/status', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                // Add CSRF token if you're using Spring Security
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: 'status=' + encodeURIComponent(newStatus) + '&note=' + encodeURIComponent(note || '')
        })
            .then(function(response) {
                // Check if response is ok
                if (!response.ok) {
                    throw new Error('HTTP ' + response.status + ': ' + response.statusText);
                }
                return response.json();
            })
            .then(function(data) {
                if (data.success) {
                    // Cập nhật UI
                    updateOrderRowStatus(currentOrderId, newStatus);

                    // Hiển thị thông báo thành công
                    showAlert('success', data.message || 'Cập nhật trạng thái thành công!');

                    // Đóng modal
                    const modal = bootstrap.Modal.getInstance(document.getElementById('editStatusModal'));
                    modal.hide();

                    // Reload trang để cập nhật thống kê
                    setTimeout(function() {
                        window.location.reload();
                    }, 1500);

                } else {
                    // Hiển thị lỗi
                    showAlert('error', data.message || 'Có lỗi xảy ra khi cập nhật trạng thái');
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
                showAlert('error', 'Có lỗi kết nối: ' + error.message);
            })
            .finally(function() {
                // Reset button state
                submitBtn.disabled = false;
                submitBtn.innerHTML = originalBtnText;
            });
    }

    // Alternative: Handle form submit normally (non-AJAX) if AJAX fails
    function handleFormSubmitFallback(event) {
        const form = event.target;
        const newStatus = form.querySelector('select[name="status"]').value;

        // Kiểm tra xác nhận cho trạng thái nguy hiểm
        if (newStatus === 'CANCELLED' && !confirm('Bạn có chắc chắn muốn HỦY đơn hàng này không?\\nViệc này không thể hoàn tác!')) {
            event.preventDefault();
            return false;
        }

        // Let form submit normally
        return true;
    }

    // Rest of your existing functions remain the same...
    function updateOrderRowStatus(orderId, newStatus) {
        const row = document.querySelector('tr[data-order-id="' + orderId + '"]');
        if (!row) return;

        const statusCell = row.querySelector('td:nth-child(6)');
        if (!statusCell) return;

        const statusHtml = getStatusBadgeHtml(newStatus);
        statusCell.innerHTML = statusHtml;

        row.classList.add('table-success');
        setTimeout(function() {
            row.classList.remove('table-success');
        }, 2000);
    }

    function getStatusBadgeHtml(status) {
        const statusConfig = {
            'PENDING': {
                'class': 'status-pending',
                'icon': 'bi-clock',
                'text': 'Chờ xác nhận'
            },
            'CONFIRMED': {
                'class': 'status-confirmed',
                'icon': 'bi-check-circle',
                'text': 'Đã xác nhận'
            },
            'SHIPPING': {
                'class': 'status-shipping',
                'icon': 'bi-truck',
                'text': 'Đang giao'
            },
            'DELIVERED': {
                'class': 'status-delivered',
                'icon': 'bi-check2-all',
                'text': 'Hoàn thành'
            },
            'CANCELLED': {
                'class': 'status-cancelled',
                'icon': 'bi-x-circle',
                'text': 'Đã hủy'
            }
        };

        const config = statusConfig[status] || {
            'class': 'status-pending',
            'icon': 'bi-question-circle',
            'text': status
        };

        return '<span class="status-badge ' + config['class'] + '">' +
            '<i class="bi ' + config['icon'] + ' me-1"></i>' + config['text'] +
            '</span>';
    }

    function showAlert(type, message) {
        const existingAlert = document.querySelector('.alert-notification');
        if (existingAlert) {
            existingAlert.remove();
        }

        const alertClass = type === 'error' ? 'alert-danger' : 'alert-' + type;
        const iconMap = {
            'success': 'bi-check-circle-fill',
            'error': 'bi-exclamation-triangle-fill',
            'warning': 'bi-exclamation-triangle-fill',
            'info': 'bi-info-circle-fill'
        };
        const iconClass = iconMap[type] || 'bi-info-circle-fill';

        const alertHtml =
            '<div class="alert ' + alertClass + ' alert-dismissible fade show alert-notification" role="alert" style="position: fixed; top: 20px; right: 20px; z-index: 9999; min-width: 300px;">' +
            '<i class="bi ' + iconClass + ' me-2"></i>' +
            message +
            '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>' +
            '</div>';

        document.body.insertAdjacentHTML('beforeend', alertHtml);

        setTimeout(function() {
            const alert = document.querySelector('.alert-notification');
            if (alert) {
                alert.remove();
            }
        }, 5000);
    }

    function handleStatusSelectChange(event) {
        const newStatus = event.target.value;
        const noteField = document.getElementById('statusNote');

        const notePlaceholders = {
            'PENDING': 'Lý do trở về trạng thái chờ xác nhận...',
            'CONFIRMED': 'Ghi chú xác nhận đơn hàng...',
            'SHIPPING': 'Thông tin vận chuyển, mã đơn hàng...',
            'DELIVERED': 'Ghi chú hoàn thành đơn hàng...',
            'CANCELLED': 'Lý do hủy đơn hàng...'
        };

        noteField.placeholder = notePlaceholders[newStatus] || 'Nhập ghi chú...';

        if (newStatus === 'CANCELLED' || newStatus === 'DELIVERED') {
            noteField.classList.add('border-warning');
            setTimeout(function() {
                noteField.classList.remove('border-warning');
            }, 2000);
        }
    }

    // Khởi tạo khi DOM loaded
    document.addEventListener('DOMContentLoaded', function() {
        const editStatusForm = document.getElementById('editStatusForm');
        if (editStatusForm) {
            // Try AJAX first, fallback to normal form submit
            editStatusForm.addEventListener('submit', function(event) {
                // Check if we want to use AJAX or normal submit
                const useAjax = true; // Set to false to test normal form submission

                if (useAjax) {
                    handleStatusUpdate(event);
                } else {
                    handleFormSubmitFallback(event);
                }
            });
        }

        const statusSelect = document.getElementById('orderStatus');
        if (statusSelect) {
            statusSelect.addEventListener('change', handleStatusSelectChange);
        }

        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                const modal = bootstrap.Modal.getInstance(document.getElementById('editStatusModal'));
                if (modal) {
                    modal.hide();
                }
            }

            if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
                const form = document.getElementById('editStatusForm');
                if (form && document.getElementById('editStatusModal').classList.contains('show')) {
                    form.dispatchEvent(new Event('submit', { bubbles: true, cancelable: true }));
                }
            }
        });
    });
</script>