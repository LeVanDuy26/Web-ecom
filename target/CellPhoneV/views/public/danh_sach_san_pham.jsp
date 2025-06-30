<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cellphone.model.SanPham" %>
<%
    List<SanPham> danhSachSanPham = (List<SanPham>) request.getAttribute("danhSachSanPham");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kết quả tìm kiếm sản phẩm</title>
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
    <h2 class="section-title">Kết quả tìm kiếm sản phẩm</h2>
    <div class="row">
        <% if (danhSachSanPham != null && !danhSachSanPham.isEmpty()) { 
            for (SanPham sp : danhSachSanPham) { %>
            <div class="col-md-3 mb-4">
                <div class="card product-card h-100">
                    <img src="${pageContext.request.contextPath}/img_Url/<%= sp.getUrlAnh() %>" class="card-img-top" alt="<%= sp.getTenSanPham() %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= sp.getTenSanPham() %></h5>
                        <p class="card-text"><%= sp.getMoTa() %></p>
                        <p class="card-text text-danger fw-bold"><%= String.format("%,.0f₫", sp.getGia()) %></p>
                        <div class="d-flex flex-wrap gap-2">
                            <a href="${pageContext.request.contextPath}/gio-hang?action=add&idSanPham=<%= sp.getIdSanPham() %>&soLuong=1" class="btn btn-main flex-fill">
                                <i class="fas fa-cart-plus"></i> <span>Thêm vào giỏ</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/san-pham?id=<%= sp.getIdSanPham() %>" class="btn btn-outline-danger flex-fill">
                                <i class="fas fa-eye"></i> <span>Chi tiết</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        <% }} else { %>
            <div class="col-12">
                <div class="alert alert-warning">
                    <i class="fas fa-exclamation-triangle me-2"></i> Không tìm thấy sản phẩm phù hợp!
                </div>
            </div>
        <% } %>
    </div>
    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">
            <i class="fas fa-arrow-left me-2"></i> Quay lại trang chủ
        </a>
    </div>
</div>
<jsp:include page="/views/includes/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 
