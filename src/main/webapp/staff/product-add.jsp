<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm sản phẩm mới</title>
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
                        <h2><i class="fas fa-plus me-3"></i>Thêm sản phẩm mới</h2>
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
                    <input type="hidden" name="action" value="add">
                    
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
                                    <input type="text" class="form-control" id="tenSanPham" name="tenSanPham" value="${not empty sessionScope.oldSanPham ? sessionScope.oldSanPham['tenSanPham'] : ''}" required>
                                    <div class="invalid-feedback">
                                        <i class="fas fa-exclamation-circle me-1"></i>Vui lòng nhập tên sản phẩm
                                    </div>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="nhaSanXuat" class="form-label">
                                        <i class="fas fa-industry me-1"></i>Nhà sản xuất
                                    </label>
                                    <input type="text" class="form-control" id="nhaSanXuat" name="nhaSanXuat" value="${not empty sessionScope.oldSanPham ? sessionScope.oldSanPham['nhaSanXuat'] : ''}" required>
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
                                        <input type="number" class="form-control" id="gia" name="gia" min="0" step="1" required value="${not empty sessionScope.oldSanPham ? sessionScope.oldSanPham['gia'] : ''}">
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
                                    <input type="number" class="form-control" id="soLuongTon" name="soLuongTon" min="0" required value="${not empty sessionScope.oldSanPham ? sessionScope.oldSanPham['soLuongTon'] : ''}">
                                    <div class="invalid-feedback">
                                        <i class="fas fa-exclamation-circle me-1"></i>Vui lòng nhập số lượng tồn kho
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="urlAnh" class="form-label">
                                    <i class="fas fa-image me-1"></i>URL hình ảnh
                                </label>
                                <input type="text" class="form-control" id="urlAnh" name="urlAnh" required value="${not empty sessionScope.oldSanPham ? sessionScope.oldSanPham['urlAnh'] : ''}">
                                <div class="invalid-feedback">
                                    <i class="fas fa-exclamation-circle me-1"></i>Vui lòng nhập tên file ảnh hoặc URL hình ảnh
                                </div>
                                <div class="form-text">
                                    <i class="fas fa-info-circle me-1"></i>Nhập URL hình ảnh từ internet (ví dụ: https://example.com/image.jpg)
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="moTa" class="form-label">
                                    <i class="fas fa-align-left me-1"></i>Mô tả
                                </label>
                                <textarea class="form-control" id="moTa" name="moTa" rows="4" required>${not empty sessionScope.oldSanPham ? sessionScope.oldSanPham['moTa'] : ''}</textarea>
                                <div class="invalid-feedback">
                                    <i class="fas fa-exclamation-circle me-1"></i>Vui lòng nhập mô tả sản phẩm
                                </div>
                            </div>

                            <div class="text-end">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Lưu sản phẩm
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
            const url = this.value;
            if (url) {
                // You can add image preview functionality here if needed
                console.log('Image URL changed:', url);
            }
        });
    </script>
    <c:remove var="oldSanPham" scope="session"/>
</body>
</html> 