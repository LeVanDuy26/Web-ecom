<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý thông báo</title>
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
                        <h2><i class="fas fa-bell me-3"></i>Quản lý thông báo</h2>
                    </div>
                    <a href="${pageContext.request.contextPath}/staff/notifications/add" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Thêm thông báo mới
                    </a>
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

                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-list me-2"></i>Danh sách thông báo</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tiêu đề</th>
                                        <th>Nội dung</th>
                                        <th>Ngày tạo</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="notification" items="${notifications}">
                                        <tr>
                                            <td><strong>${notification.idThongBao}</strong></td>
                                            <td><strong>${notification.tieuDe}</strong></td>
                                            <td>
                                                <div class="text-truncate" style="max-width: 300px;" title="${notification.noiDung}">
                                                    ${notification.noiDung}
                                                </div>
                                            </td>
                                            <td>${notification.ngayTao}</td>
                                            <td>
                                                <span class="badge ${notification.trangThai == 1 ? 'bg-success' : 'bg-secondary'}">
                                                    ${notification.trangThai == 1 ? 'Hiển thị' : 'Ẩn'}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="btn-group">
                                                    <a href="${pageContext.request.contextPath}/staff/notifications/edit?id=${notification.idThongBao}" 
                                                       class="btn btn-warning btn-sm" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-danger btn-sm delete-notification" 
                                                            data-id="${notification.idThongBao}" 
                                                            data-title="${notification.tieuDe}" title="Xóa">
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
                    <p>Bạn có chắc chắn muốn xóa thông báo <strong id="notificationTitle"></strong>?</p>
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
        // Xử lý xóa thông báo
        document.querySelectorAll('.delete-notification').forEach(btn => {
            btn.addEventListener('click', function() {
                const id = this.dataset.id;
                const title = this.dataset.title;
                document.getElementById('notificationTitle').textContent = title;
                document.getElementById('deleteForm').action = '${pageContext.request.contextPath}/staff/notifications/delete?id=' + id;
                new bootstrap.Modal(document.getElementById('deleteModal')).show();
            });
        });
    </script>
</body>
</html> 