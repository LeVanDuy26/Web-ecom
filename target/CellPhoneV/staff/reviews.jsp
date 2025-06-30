<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đánh giá</title>
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
                    <h2><i class="fas fa-star me-3"></i>Quản lý đánh giá</h2>
                </div>

                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Thông báo kết quả thao tác -->
                <c:if test="${not empty param.msg}">
                    <c:choose>
                        <c:when test="${param.msg eq 'delete_success'}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle me-2"></i> Xóa đánh giá thành công!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:when>
                        <c:when test="${param.msg eq 'delete_error'}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i> Xóa đánh giá thất bại!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:when>
                        <c:when test="${param.msg eq 'invalid_id'}">
                            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i> Không xác định được đánh giá cần thao tác!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:when>
                    </c:choose>
                </c:if>

                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <i class="fas fa-list me-2"></i>Danh sách đánh giá
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Sản phẩm</th>
                                        <th>Khách hàng</th>
                                        <th>Đánh giá</th>
                                        <th>Nội dung</th>
                                        <th>Ngày đánh giá</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="review" items="${reviews}">
                                        <tr>
                                            <td><strong>${review.idDanhGia}</strong></td>
                                            <td>
                                                <strong>${review.tenSanPham}</strong>
                                            </td>
                                            <td>${review.tenNguoiDung}</td>
                                            <td>
                                                <div class="text-warning">
                                                    <c:forEach begin="1" end="${review.soSao}">
                                                        <i class="fas fa-star"></i>
                                                    </c:forEach>
                                                    <c:forEach begin="${review.soSao + 1}" end="5">
                                                        <i class="far fa-star"></i>
                                                    </c:forEach>
                                                </div>
                                                <small class="text-muted">${review.soSao}/5 sao</small>
                                            </td>
                                            <td>
                                                <div class="text-truncate" style="max-width: 200px;" title="${review.noiDung}">
                                                    ${review.noiDung}
                                                </div>
                                            </td>
                                            <td>${review.ngayDanhGia}</td>
                                            <td>
                                                <span class="badge ${review.trangThai ? 'bg-success' : 'bg-secondary'}">
                                                    ${review.trangThai ? 'Hiển thị' : 'Ẩn'}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-info btn-sm view-review" 
                                                            data-id="${review.idDanhGia}" 
                                                            data-product="${review.tenSanPham}"
                                                            data-customer="${review.tenNguoiDung}"
                                                            data-rating="${review.soSao}"
                                                            data-content="${review.noiDung}"
                                                            data-date="${review.ngayDanhGia}"
                                                            data-status="${review.trangThai}"
                                                            title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-danger btn-sm delete-review" 
                                                            data-id="${review.idDanhGia}" 
                                                            data-product="${review.tenSanPham}" title="Xóa">
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

    <!-- Modal xem chi tiết đánh giá -->
    <div class="modal fade" id="viewReviewModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-star me-2"></i>Chi tiết đánh giá
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Sản phẩm:</strong> <span id="modalProduct"></span></p>
                            <p><strong>Khách hàng:</strong> <span id="modalCustomer"></span></p>
                            <p><strong>Ngày đánh giá:</strong> <span id="modalDate"></span></p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Đánh giá:</strong></p>
                            <div id="modalRating" class="text-warning mb-2"></div>
                            <p><strong>Trạng thái:</strong> <span id="modalStatus"></span></p>
                        </div>
                    </div>
                    <div class="mt-3">
                        <p><strong>Nội dung:</strong></p>
                        <div id="modalContent" class="border p-3 rounded bg-light"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>Đóng
                    </button>
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
                    <p>Bạn có chắc chắn muốn xóa đánh giá của sản phẩm <strong id="deleteProductName"></strong>?</p>
                    <p class="text-muted small">Hành động này không thể hoàn tác.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>Hủy
                    </button>
                    <form id="deleteForm" method="post" class="staff-inline-form">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="idDanhGia" id="deleteIdDanhGia">
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
        // Xem chi tiết đánh giá
        document.querySelectorAll('.view-review').forEach(btn => {
            btn.addEventListener('click', function() {
                const data = this.dataset;
                
                document.getElementById('modalProduct').textContent = data.product;
                document.getElementById('modalCustomer').textContent = data.customer;
                document.getElementById('modalDate').textContent = data.date;
                document.getElementById('modalContent').textContent = data.content;
                
                // Hiển thị sao
                const ratingContainer = document.getElementById('modalRating');
                ratingContainer.innerHTML = '';
                for (let i = 1; i <= 5; i++) {
                    const star = document.createElement('i');
                    star.className = i <= data.rating ? 'fas fa-star' : 'far fa-star';
                    ratingContainer.appendChild(star);
                }
                
                // Hiển thị trạng thái
                const status = data.status ? 'Hiển thị' : 'Ẩn';
                const statusClass = data.status ? 'text-success' : 'text-secondary';
                document.getElementById('modalStatus').innerHTML = `<span class="${statusClass}">${status}</span>`;
                
                new bootstrap.Modal(document.getElementById('viewReviewModal')).show();
            });
        });

        // Xóa đánh giá
        document.querySelectorAll('.delete-review').forEach(btn => {
            btn.addEventListener('click', function() {
                const id = this.dataset.id;
                const product = this.dataset.product;
                document.getElementById('deleteProductName').textContent = product;
                document.getElementById('deleteIdDanhGia').value = id;
                new bootstrap.Modal(document.getElementById('deleteModal')).show();
            });
        });
    </script>
</body>
</html> 