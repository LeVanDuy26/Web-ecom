<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa sản phẩm</title>
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
                        <h2><i class="fas fa-edit me-3"></i>Chỉnh sửa sản phẩm</h2>
                    </div>
                    <a href="${pageContext.request.contextPath}/staff/products" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>
                
                <%-- Hiển thị thông báo lỗi --%>
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/staff/products" method="post" class="needs-validation" novalidate>
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" value="${not empty sessionScope.oldSanPham ? sessionScope.oldSanPham.idSanPham : sanPham.idSanPham}">
                    
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-info-circle me-2"></i>Thông tin sản phẩm
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="tenSanPham" class="form-label">
                                        <i class="fas fa-tag me-1"></i>Tên sản phẩm
                                    </label>
                                    <input type="text" class="form-control" id="tenSanPham" name="tenSanPham" value="${not empty sessionScope.oldSanPham ? sessionScope.oldSanPham.tenSanPham : sanPham.tenSanPham}" required>
                                    <div class="invalid-feedback">
                                        <i class="fas fa-exclamation-circle me-1"></i>Vui lòng nhập tên sản phẩm
                                    </div>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="nhaSanXuat" class="form-label">
                                        <i class="fas fa-industry me-1"></i>Nhà sản xuất
                                    </label>
                                    <input type="text" class="form-control" id="nhaSanXuat" name="nhaSanXuat" value="${not empty sessionScope.oldSanPham ? sessionScope.oldSanPham.nhaSanXuat : sanPham.nhaSanXuat}" required>
                                    <div class="invalid-feedback">
                                        <i class="fas fa-exclamation-circle me-1"></i>Vui lòng nhập nhà sản xuất
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="gia" class="form-label">
                                        <i class="fas fa-dollar-sign me-1"></i>Giá
                                    </label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="gia" name="gia" value="${not empty sessionScope.oldSanPham ? sessionScope.oldSanPham.gia : sanPham.gia.intValue()}" min="0" step="1" required>
                                        <span class="input-group-text">VNĐ</span>
                                    </div>
                                    <div class="invalid-feedback">
                                        <i class="fas fa-exclamation-circle me-1"></i>Vui lòng nhập giá sản phẩm
                                    </div>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="soLuongTon" class="form-label">
                                        <i class="fas fa-boxes me-1"></i>Số lượng tồn kho
                                    </label>
                                    <input type="number" class="form-control" id="soLuongTon" name="soLuongTon" value="${not empty sessionScope.oldSanPham ? sessionScope.oldSanPham.soLuongTon : sanPham.soLuongTon}" min="0" required>
                                    <div class="invalid-feedback">
                                        <i class="fas fa-exclamation-circle me-1"></i>Vui lòng nhập số lượng tồn kho
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="urlAnh" class="form-label">
                                    <i class="fas fa-image me-1"></i>URL hình ảnh hoặc tên file ảnh
                                </label>
                                <input type="text" class="form-control" id="urlAnh" name="urlAnh" value="${not empty sessionScope.oldSanPham ? sessionScope.oldSanPham.urlAnh : sanPham.urlAnh}" required>
                                <div class="invalid-feedback">
                                    <i class="fas fa-exclamation-circle me-1"></i>Vui lòng nhập tên file ảnh hoặc URL hình ảnh
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-eye me-1"></i>Xem trước hình ảnh
                                </label>
                                <div class="text-center">
                                    <img src="${pageContext.request.contextPath}/img_Url/${sanPham.urlAnh}" 
                                         alt="${sanPham.tenSanPham}" 
                                         class="staff-product-preview img-thumbnail">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="moTa" class="form-label">
                                    <i class="fas fa-align-left me-1"></i>Mô tả
                                </label>
                                <textarea class="form-control" id="moTa" name="moTa" rows="4" required>${not empty sessionScope.oldSanPham ? sessionScope.oldSanPham.moTa : sanPham.moTa}</textarea>
                                <div class="invalid-feedback">
                                    <i class="fas fa-exclamation-circle me-1"></i>Vui lòng nhập mô tả sản phẩm
                                </div>
                            </div>

                            <div class="text-end">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Lưu thay đổi
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })
        })()

        // Preview image when URL changes
        document.getElementById('urlAnh').addEventListener('input', function() {
            const preview = document.querySelector('.staff-product-preview');
            const newUrl = this.value;
            
            if (newUrl) {
                // Update preview image
                preview.src = newUrl;
                preview.style.display = 'block';
            } else {
                // Hide preview if no URL
                preview.style.display = 'none';
            }
        });
    </script>
    <c:remove var="oldSanPham" scope="session"/>
</body>
</html> 