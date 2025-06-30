<%@ page contentType="text/html; charset=UTF-8" %>
<%
    Object userLogin = session.getAttribute("nguoiDung");
%>
<nav class="navbar navbar-expand-lg modern-navbar">
    <div class="container">
        <!-- Logo/Brand -->
        <a class="navbar-brand modern-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-mobile-alt me-2"></i>
            <span class="brand-text">Cellphone</span>
        </a>
        
        <!-- Mobile Toggle Button -->
        <button class="navbar-toggler modern-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <!-- Navigation Menu -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto modern-nav">
                <% if (userLogin == null) { %>
                    <!-- Guest User Menu -->
                    <li class="nav-item">
                        <a class="nav-link modern-link" href="${pageContext.request.contextPath}/gio-hang">
                            <i class="fas fa-shopping-cart me-2"></i>
                            <span>Giỏ hàng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link modern-link" href="${pageContext.request.contextPath}/dang-nhap">
                            <i class="fas fa-sign-in-alt me-2"></i>
                            <span>Đăng nhập</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link modern-link btn-login" href="${pageContext.request.contextPath}/dang-ky">
                            <i class="fas fa-user-plus me-2"></i>
                            <span>Đăng ký</span>
                        </a>
                    </li>
                <% } else { %>
                    <!-- Logged In User Menu -->
                    <li class="nav-item">
                        <a class="nav-link modern-link" href="${pageContext.request.contextPath}/tai-khoan">
                            <i class="fas fa-user me-2"></i>
                            <span>Tài khoản</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link modern-link" href="${pageContext.request.contextPath}/don-hang">
                            <i class="fas fa-box me-2"></i>
                            <span>Đơn hàng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link modern-link" href="${pageContext.request.contextPath}/gio-hang">
                            <i class="fas fa-shopping-cart me-2"></i>
                            <span>Giỏ hàng</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link modern-link" href="${pageContext.request.contextPath}/doi-mat-khau">
                            <i class="fas fa-lock me-2"></i>
                            <span>Đổi mật khẩu</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link modern-link btn-logout" href="${pageContext.request.contextPath}/dang-xuat">
                            <i class="fas fa-sign-out-alt me-2"></i>
                            <span>Đăng xuất</span>
                        </a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<script>
// Navbar scroll effect
document.addEventListener('DOMContentLoaded', function() {
    const navbar = document.querySelector('.modern-navbar');
    
    window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
    
    // Add active class to current page link
    const currentPath = window.location.pathname;
    const navLinks = document.querySelectorAll('.modern-link');
    
    navLinks.forEach(link => {
        if (link.getAttribute('href') === currentPath) {
            link.classList.add('active');
        }
    });
});
</script>
