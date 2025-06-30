<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.cellphone.model.SanPham" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết sản phẩm - ${sanPham.tenSanPham}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-custom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css">
</head>
<body>
<jsp:include page="/views/includes/navbar.jsp"/>

<div class="container">
    <c:if test="${not empty param.msg}">
        <c:choose>
            <c:when test="${param.msg eq 'success'}">
                <div class="alert alert-success mt-4">
                    <i class="fas fa-check-circle me-2"></i> Đánh giá sản phẩm thành công!
                </div>
            </c:when>
            <c:when test="${param.msg eq 'error'}">
                <div class="alert alert-danger mt-4">
                    <i class="fas fa-exclamation-circle me-2"></i> Có lỗi xảy ra khi đánh giá sản phẩm!
                </div>
            </c:when>
            <c:when test="${param.msg eq 'empty'}">
                <div class="alert alert-warning mt-4">
                    <i class="fas fa-exclamation-triangle me-2"></i> Vui lòng nhập nội dung đánh giá!
                </div>
            </c:when>
        </c:choose>
    </c:if>
    
    <div class="product-container">
        <div class="row">
            <div class="col-md-6">
                <img src="${pageContext.request.contextPath}/img_Url/${sanPham.urlAnh}" class="product-image" alt="${sanPham.tenSanPham}">
            </div>
            <div class="col-md-6 product-info">
                <h1 class="product-title">${sanPham.tenSanPham}</h1>
                <p class="product-price"><fmt:formatNumber value="${sanPham.gia}" type="number" groupingUsed="true" maxFractionDigits="0"/>₫</p>
                
                <div class="product-description">
                    <h5 class="mb-3">Mô tả sản phẩm:</h5>
                    <p>${sanPham.moTa}</p>
                </div>
                
                <div class="product-meta">
                    <div class="row mb-3">
                        <div class="col-6">
                            <h5><i class="fas fa-industry me-2"></i> Nhà sản xuất:</h5>
                            <p>${sanPham.nhaSanXuat}</p>
                        </div>
                        <div class="col-6">
                            <h5><i class="fas fa-box me-2"></i> Số lượng còn lại:</h5>
                            <p>${sanPham.soLuongTon} sản phẩm</p>
                        </div>
                    </div>
                </div>
                
                <form method="get" action="${pageContext.request.contextPath}/gio-hang" class="add-to-cart-form">
                    <input type="hidden" name="action" value="add"/>
                    <input type="hidden" name="idSanPham" value="${sanPham.idSanPham}"/>
                    <input type="number" name="soLuong" value="1" min="1" max="${sanPham.soLuongTon}" class="form-control quantity-input"/>
                    <button type="submit" class="btn btn-main">
                        <i class="fas fa-cart-plus"></i> <span>Thêm vào giỏ hàng</span>
                    </button>
                </form>
                
                <!-- Nút Mua ngay -->
                <form method="get" action="${pageContext.request.contextPath}/dat-hang" class="mt-3">
                    <input type="hidden" name="action" value="buynow"/>
                    <input type="hidden" name="idSanPham" value="${sanPham.idSanPham}"/>
                    <input type="hidden" name="soLuong" id="soLuongMuaNgay" value="1"/>
                    <button type="submit" class="btn btn-success w-100" class="btn btn-success w-100">
                        <i class="fas fa-bolt"></i> <span>Mua ngay</span>
                    </button>
                </form>
                
                <!-- Script để đồng bộ số lượng giữa hai form -->
                <script>
                    document.addEventListener('DOMContentLoaded', function() {
                        const quantityInput = document.querySelector('.quantity-input');
                        const buyNowQuantity = document.getElementById('soLuongMuaNgay');
                        
                        quantityInput.addEventListener('change', function() {
                            buyNowQuantity.value = this.value;
                        });
                    });
                </script>
            </div>
        </div>
    </div>

    <div class="reviews-section">
        <h2 class="section-title">Đánh giá từ khách hàng</h2>
        
        <c:if test="${empty danhGiaList}">
            <div class="text-center py-4">
                <i class="fas fa-comment-slash fa-3x text-muted mb-3"></i>
                <p class="lead">Chưa có đánh giá nào cho sản phẩm này</p>
            </div>
        </c:if>
        
        <c:forEach var="dg" items="${danhGiaList}">
            <div class="review-item">
                <div class="review-header">
                    <div class="review-stars">
                        <c:forEach begin="1" end="${dg.soSao}">
                            <i class="fas fa-star"></i>
                        </c:forEach>
                        <c:forEach begin="${dg.soSao + 1}" end="5">
                            <i class="far fa-star"></i>
                        </c:forEach>
                    </div>
                    <div class="review-date">${dg.ngayDanhGia}</div>
                </div>
                <div class="review-content">${dg.noiDung}</div>
            </div>
        </c:forEach>
        
        <c:if test="${sessionScope.nguoiDung != null}">
            <h4 class="mt-5 mb-3">Viết đánh giá của bạn</h4>
            <form method="post" action="${pageContext.request.contextPath}/danh-gia" class="review-form">
                <input type="hidden" name="idSanPham" value="${sanPham.idSanPham}"/>
                
                <div class="form-group mb-3">
                    <label for="soSao">Đánh giá của bạn:</label>
                    <select name="soSao" id="soSao" class="form-control">
                        <c:forEach begin="1" end="5" var="i">
                            <option value="${i}">${i} sao</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group mb-3">
                    <label for="noiDung">Nhận xét của bạn:</label>
                    <textarea name="noiDung" id="noiDung" class="form-control" rows="4" placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này..." required></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-paper-plane"></i> <span>Gửi đánh giá</span>
                </button>
            </form>
        </c:if>
        
        <c:if test="${sessionScope.nguoiDung == null}">
            <div class="alert alert-info mt-4">
                <i class="fas fa-info-circle me-2"></i> Vui lòng <a href="${pageContext.request.contextPath}/dang-nhap" class="alert-link">đăng nhập</a> để viết đánh giá.
            </div>
        </c:if>
    </div>
</div>
<jsp:include page="/views/includes/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


