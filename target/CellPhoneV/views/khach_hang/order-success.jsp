<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt hàng thành công</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-custom.css">
    <link href="${pageContext.request.contextPath}/css/khachhang.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/views/includes/navbar.jsp"/>
    <div class="container mt-5 text-center">
        <div class="alert alert-success">
            <h2>🎉 Đặt hàng thành công!</h2>
            <p>Cảm ơn bạn đã mua hàng tại Cellphone.</p>
        </div>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg">
            Tiếp tục mua sắm
        </a>
    </div>
    <jsp:include page="/views/includes/footer.jsp"/>
</body>
</html> 
