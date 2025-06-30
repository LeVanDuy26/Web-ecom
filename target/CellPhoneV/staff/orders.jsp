<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đơn hàng</title>
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
                    <h2><i class="fas fa-shopping-cart me-3"></i>Quản lý đơn hàng</h2>
                </div>
                
                <c:if test="${not empty sessionScope.orderStatusMessage}">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>${sessionScope.orderStatusMessage}
                    </div>
                    <c:remove var="orderStatusMessage" scope="session"/>
                </c:if>
                
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle me-2"></i>Lỗi: ${errorMessage}
                    </div>
                </c:if>
                
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-list me-2"></i>Danh sách đơn hàng</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>Mã đơn</th>
                                        <th>Khách hàng</th>
                                        <th>Ngày đặt</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orders}" var="order">
                                        <tr>
                                            <td><strong>#${order[0]}</strong></td>
                                            <td>${order[1]}</td>
                                            <td>${order[2]}</td>
                                            <td><strong class="text-danger">${order[3]}₫</strong></td>
                                            <td>
                                                <span class="badge bg-info">${order[4]}</span>
                                            </td>
                                            <td>
                                                <form method="post" action="${pageContext.request.contextPath}/staff/orders/update-status" class="staff-status-form d-flex align-items-center">
                                                    <input type="hidden" name="orderId" value="${order[0]}" />
                                                    <select name="status" class="form-select form-select-sm staff-status-select">
                                                        <c:forEach var="st" items="${['Chờ xác nhận','Đang xử lý','Đang giao','Hoàn thành','Đã hủy']}">
                                                            <option value="${st}" ${order[4] == st ? 'selected' : ''}>${st}</option>
                                                        </c:forEach>
                                                    </select>
                                                    <button type="submit" class="btn btn-sm btn-success ms-2">
                                                        <i class="fas fa-check me-1"></i>Cập nhật
                                                    </button>
                                                </form>
                                                <a href="${pageContext.request.contextPath}/staff/orders/view?id=${order[0]}" class="btn btn-sm btn-primary ms-1">
                                                    <i class="fas fa-eye me-1"></i>Chi tiết
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
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