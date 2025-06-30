<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm</title>
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
                        <h2><i class="fas fa-box me-3"></i>Quản lý sản phẩm</h2>
                    </div>
                    <a href="${pageContext.request.contextPath}/staff/products/add" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Thêm sản phẩm mới
                    </a>
                </div>

                <%-- Hiển thị thông báo thành công/thất bại sau redirect --%>
                <c:if test="${not empty sessionScope.message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${sessionScope.message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="message" scope="session"/>
                </c:if>
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-list me-2"></i>Danh sách sản phẩm</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Hình ảnh</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Giá</th>
                                        <th>Tồn kho</th>
                                        <th>Nhà sản xuất</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${products}">
                                        <tr>
                                            <td><strong>${p.idSanPham}</strong></td>
                                            <td>
                                                <img src="${pageContext.request.contextPath}/img_Url/${p.urlAnh}" alt="${p.tenSanPham}" 
                                                     class="staff-product-thumb">
                                            </td>
                                            <td><strong>${p.tenSanPham}</strong></td>
                                            <td><strong class="text-danger"><fmt:formatNumber value="${p.gia}" type="number" groupingUsed="true"/>₫</strong></td>
                                            <td>
                                                <span>${p.soLuongTon}</span>
                                            </td>
                                            <td>${p.nhaSanXuat}</td>
                                            <td>
                                                <div class="btn-group">
                                                    <a href="${pageContext.request.contextPath}/staff/products/edit?id=${p.idSanPham}" 
                                                       class="btn btn-warning btn-sm" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-danger btn-sm delete-product" 
                                                            data-id="${p.idSanPham}" data-name="${p.tenSanPham}" title="Xóa">
                                                        <i class="fas fa-trash"></i>
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
            </div>
        </div>
    </div>

    <!-- Modal xác nhận xóa -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle me-2"></i>Xác nhận xóa
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa sản phẩm <strong id="productName"></strong>?</p>
                    <p class="text-muted small">Hành động này không thể hoàn tác.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>Hủy
                    </button>
                    <form id="deleteForm" method="post" class="staff-inline-form">
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-trash me-1"></i>Xóa
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Xử lý xóa sản phẩm
        document.querySelectorAll('.delete-product').forEach(btn => {
            btn.addEventListener('click', function() {
                const id = this.dataset.id;
                const name = this.dataset.name;
                document.getElementById('productName').textContent = name;
                document.getElementById('deleteForm').action = '${pageContext.request.contextPath}/staff/products/delete?id=' + id;
                new bootstrap.Modal(document.getElementById('deleteModal')).show();
            });
        });

        // Xử lý cập nhật tồn kho
        document.querySelectorAll('.update-stock').forEach(btn => {
            btn.addEventListener('click', function() {
                const id = this.dataset.id;
                const input = document.querySelector(`.stock-input[data-id="${id}"]`);
                const soLuong = input.value;
                
                // Hiển thị loading
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
                this.disabled = true;
                
                fetch('${pageContext.request.contextPath}/staff/products/update-stock', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `id=${id}&soLuong=${soLuong}`
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Hiển thị success
                        this.innerHTML = '<i class="fas fa-check"></i>';
                        this.classList.remove('btn-outline-primary');
                        this.classList.add('btn-success');
                        setTimeout(() => {
                            location.reload();
                        }, 1000);
                    } else {
                        // Hiển thị error
                        this.innerHTML = '<i class="fas fa-times"></i>';
                        this.classList.remove('btn-outline-primary');
                        this.classList.add('btn-danger');
                        setTimeout(() => {
                            this.innerHTML = '<i class="fas fa-check"></i>';
                            this.classList.remove('btn-danger');
                            this.classList.add('btn-outline-primary');
                            this.disabled = false;
                        }, 2000);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    this.innerHTML = '<i class="fas fa-times"></i>';
                    this.classList.remove('btn-outline-primary');
                    this.classList.add('btn-danger');
                    this.disabled = false;
                });
            });
        });
    </script>
</body>
</html> 