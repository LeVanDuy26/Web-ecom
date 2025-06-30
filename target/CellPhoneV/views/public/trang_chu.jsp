<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cellphone.model.SanPham" %>
<%
    List<SanPham> dsSanPham = (List<SanPham>) request.getAttribute("dsSanPham");
    String msg = request.getParameter("msg");
    Object userLogin = session.getAttribute("nguoiDung");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Cellphone - Trang chủ</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-custom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
<jsp:include page="/views/includes/navbar.jsp"/>
<div class="container mt-4">
    <% if ("outofstock".equals(msg)) { %>
        <div class="alert alert-danger">Số lượng vượt quá tồn kho hoặc sản phẩm không còn hàng!</div>
    <% } %>
    
    <!-- Slider/banner -->
    <div id="mainSlider" class="carousel slide mb-4" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#mainSlider" data-bs-slide-to="0" class="active"></button>
            <button type="button" data-bs-target="#mainSlider" data-bs-slide-to="1"></button>
            <button type="button" data-bs-target="#mainSlider" data-bs-slide-to="2"></button>
            <button type="button" data-bs-target="#mainSlider" data-bs-slide-to="3"></button>
            <button type="button" data-bs-target="#mainSlider" data-bs-slide-to="4"></button>
        </div>
        <div class="carousel-inner rounded-4 shadow">
            <div class="carousel-item active">
                <img src="${pageContext.request.contextPath}/img_Url/banner1.png" class="d-block w-100" class="d-block w-100 carousel-img" alt="Banner 1">
            </div>
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/img_Url/banner2.png" class="d-block w-100" class="d-block w-100 carousel-img" alt="Banner 2">
            </div>
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/img_Url/banner3.png" class="d-block w-100" class="d-block w-100 carousel-img" alt="Banner 3">
            </div>
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/img_Url/banner4.png" class="d-block w-100" class="d-block w-100 carousel-img" alt="Banner 4">
            </div>
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/img_Url/banner5.png" class="d-block w-100" class="d-block w-100 carousel-img" alt="Banner 5">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#mainSlider" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#mainSlider" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>
    
    <!-- Form tìm kiếm sản phẩm -->
    <form action="danh-sach-san-pham" method="GET" class="row g-3 search-form">
        <div class="col-md-6">
            <input type="text" class="form-control" name="keyword" placeholder="Tìm kiếm theo tên sản phẩm...">
        </div>
        <div class="col-md-3">
            <select class="form-select" name="nhaSanXuat">
                <option value="">Tất cả nhà sản xuất</option>
                <option value="Apple">Apple</option>
                <option value="Samsung">Samsung</option>
                <option value="Xiaomi">Xiaomi</option>
                <option value="OPPO">OPPO</option>
                <option value="Vivo">Vivo</option>
            </select>
        </div>
        <div class="col-md-3">
            <button type="submit" class="btn btn-outline-danger w-100">
                <i class="fas fa-search"></i> <span>Tìm kiếm</span>
            </button>
        </div>
    </form>
    
    
    <!-- Sản phẩm nổi bật -->
    <h2 class="section-title mt-5">Sản phẩm nổi bật</h2>
    <div class="row">
        <% if (dsSanPham != null) for (SanPham sp : dsSanPham) { %>
            <div class="col-md-3 mb-4">
                <div class="card product-card h-100">
                    <img src="${pageContext.request.contextPath}/img_Url/<%= sp.getUrlAnh() %>" class="card-img-top" alt="<%= sp.getTenSanPham() %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= sp.getTenSanPham() %></h5>
                        <p class="card-text min-height-40"><%= sp.getMoTa() %></p>
                        <p class="card-text text-danger fw-bold"><%= String.format("%,.0f₫", sp.getGia()) %></p>
                        <div class="d-flex flex-wrap gap-2">
                            <a href="${pageContext.request.contextPath}/gio-hang?action=add&idSanPham=<%= sp.getIdSanPham() %>&soLuong=1" class="btn btn-main flex-fill">
                                <i class="fas fa-cart-plus"></i> <span>Thêm vào giỏ hàng</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/san-pham?id=<%= sp.getIdSanPham() %>" class="btn btn-outline-danger flex-fill">
                                <i class="fas fa-eye"></i> <span>Xem chi tiết</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        <% } %>
    </div>
    
</div>
<jsp:include page="/views/includes/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


<!-- <script>
// Ẩn các sản phẩm nổi bật vượt quá 10 sản phẩm
window.addEventListener('DOMContentLoaded', function() {
    var productCards = document.querySelectorAll('.row .product-card');
    for (let i = 10; i < productCards.length; i++) {
        productCards[i].parentElement.style.display = 'none';
    }
});
</script> -->
</body>
</html>





