<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Staff</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/staff/css/bootstrap-staff.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/staff/css/staff.css" rel="stylesheet">
</head>
<body>
    <div class="staff-container d-flex">
        <jsp:include page="/staff/includes/sidebar.jsp" />
        <div class="staff-content flex-grow-1">
            <div class="container-fluid">
                <div class="page-header">
                    <h2><i class="fas fa-tachometer-alt me-3"></i>Dashboard</h2>
                </div>

                <!-- Recent Orders -->
                <div class="row">
                    <div class="col-lg-8 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-clock me-2"></i>Đơn hàng gần đây</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Mã đơn</th>
                                                <th>Khách hàng</th>
                                                <th>Ngày đặt</th>
                                                <th>Tổng tiền</th>
                                                <th>Trạng thái</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${recentOrders}" var="order" varStatus="status">
                                                <c:if test="${status.index < 5}">
                                                    <tr>
                                                        <td>#${order[0]}</td>
                                                        <td>${order[1]}</td>
                                                        <td>${order[2]}</td>
                                                        <td>${order[3]}₫</td>
                                                        <td>
                                                            <span class="badge bg-info">${order[4]}</span>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="col-lg-4 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Thao tác nhanh</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/staff/orders" class="btn btn-primary">
                                        <i class="fas fa-list me-2"></i>Xem tất cả đơn hàng
                                    </a>
                                    <a href="${pageContext.request.contextPath}/staff/products/add" class="btn btn-success">
                                        <i class="fas fa-plus me-2"></i>Thêm sản phẩm mới
                                    </a>
                                    <a href="${pageContext.request.contextPath}/staff/notifications" class="btn btn-info">
                                        <i class="fas fa-bell me-2"></i>Xem thông báo
                                    </a>
                                    <a href="${pageContext.request.contextPath}/staff/reports" class="btn btn-warning">
                                        <i class="fas fa-chart-bar me-2"></i>Báo cáo
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Low Stock Products -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-exclamation-triangle me-2"></i>Sản phẩm sắp hết hàng</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Tồn kho</th>
                                                <th>Giá</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${lowStockProducts}" var="product" varStatus="status">
                                                <c:if test="${status.index < 5}">
                                                    <tr>
                                                        <td>${product.idSanPham}</td>
                                                        <td>${product.tenSanPham}</td>
                                                        <td>
                                                            <span class="badge bg-warning">${product.soLuongTon}</span>
                                                        </td>
                                                        <td><fmt:formatNumber value="${product.gia}" type="number" groupingUsed="true"/>₫</td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/staff/products/edit?id=${product.idSanPham}" 
                                                               class="btn btn-sm btn-warning">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 