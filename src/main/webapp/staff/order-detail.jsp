<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng #${order.id}</title>
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
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="page-header">
                        <h2><i class="fas fa-file-invoice me-3"></i>Chi tiết đơn hàng #${order.id}</h2>
                    </div>
                    <a href="${pageContext.request.contextPath}/staff/orders" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                    </div>
                </c:if>

                <div class="row">
                    <!-- Thông tin đơn hàng -->
                    <div class="col-md-6 mb-4">
                        <div class="card">
                            <div class="card-header bg-primary">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-info-circle me-2"></i>Thông tin đơn hàng
                                </h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-borderless">
                                    <tr>
                                        <th width="40%">Trạng thái:</th>
                                        <td>
                                            <span class="badge bg-info">${order.status}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Ngày đặt:</th>
                                        <td>
                                            <i class="fas fa-calendar me-1"></i>
                                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Tổng tiền:</th>
                                        <td>
                                            <strong class="text-danger fs-5">
                                                <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>₫
                                            </strong>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Thông tin khách hàng và người nhận -->
                    <div class="col-md-6 mb-4">
                        <div class="card">
                            <div class="card-header bg-info">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-user me-2"></i>Thông tin khách hàng & người nhận
                                </h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-borderless">
                                    <tr>
                                        <th width="40%">Họ tên khách:</th>
                                        <td><strong>${order.customerName}</strong></td>
                                    </tr>
                                    <tr>
                                        <th>Email khách:</th>
                                        <td>
                                            <i class="fas fa-envelope me-1"></i>
                                            ${order.email}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>SĐT khách:</th>
                                        <td>
                                            <i class="fas fa-phone me-1"></i>
                                            ${order.customerPhone}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Địa chỉ nhận:</th>
                                        <td>
                                            <i class="fas fa-map-marker-alt me-1"></i>
                                            ${order.address}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>SĐT người nhận:</th>
                                        <td>
                                            <i class="fas fa-phone me-1"></i>
                                            ${order.receiverPhone}
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Chi tiết sản phẩm -->
                <div class="card mb-4">
                    <div class="card-header bg-success">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-shopping-bag me-2"></i>Chi tiết sản phẩm
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Đơn giá</th>
                                        <th>Số lượng</th>
                                        <th>Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orderItems}" var="item">
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <img src="${pageContext.request.contextPath}/img_Url/${item.image}" 
                                                         alt="${item.productName}" 
                                                         class="staff-order-item-thumb me-3">
                                                    <div>
                                                        <strong>${item.productName}</strong>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <strong>
                                                    <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/>₫
                                                </strong>
                                            </td>
                                            <td>
                                                <span class="badge bg-secondary">${item.quantity}</span>
                                            </td>
                                            <td>
                                                <strong class="text-danger">
                                                    <fmt:formatNumber value="${item.subtotal}" type="number" groupingUsed="true"/>₫
                                                </strong>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr class="table-active">
                                        <th colspan="3" class="text-end">Tổng cộng:</th>
                                        <th class="text-danger fs-5">
                                            <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>₫
                                        </th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 