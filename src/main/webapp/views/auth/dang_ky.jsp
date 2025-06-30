<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký - Cellphone</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-custom.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
<jsp:include page="/views/includes/navbar.jsp"/>
<div class="register-container bg-white p-4 rounded shadow">
    <h2 class="mb-4 text-center">Đăng ký tài khoản</h2>
    
    <!-- Hiển thị thông báo lỗi -->
    <% String error = (String) request.getAttribute("error"); if (error != null) { %>
        <div class="alert alert-danger alert-dismissible fade show">
            <i class="bi bi-exclamation-triangle-fill me-2"></i><%= error %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>
    
    <!-- Hiển thị thông báo thành công từ URL parameter -->
    <% if (request.getParameter("registered") != null && request.getParameter("registered").equals("success")) { %>
        <div class="alert alert-success alert-dismissible fade show">
            <i class="bi bi-check-circle-fill me-2"></i>Đăng ký thành công! Vui lòng đăng nhập để tiếp tục.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>
    <form action="${pageContext.request.contextPath}/dang-ky" method="post" id="registerForm">
        <div class="mb-3">
            <label for="fullname" class="form-label"><i class="bi bi-person me-1"></i>Họ và tên</label>
            <input type="text" class="form-control" id="fullname" name="fullname" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label"><i class="bi bi-envelope me-1"></i>Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <div class="mb-3">
            <label for="phone" class="form-label"><i class="bi bi-telephone me-1"></i>Số điện thoại</label>
            <input type="text" class="form-control" id="phone" name="phone" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label"><i class="bi bi-lock me-1"></i>Mật khẩu</label>
            <div class="input-group">
                <input type="password" class="form-control" id="password" name="password" required>
                <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('password')">
                    <i class="bi bi-eye"></i>
                </button>
            </div>
            <div class="form-text">Mật khẩu nên có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số.</div>
        </div>
        <div class="mb-3">
            <label for="confirmPassword" class="form-label"><i class="bi bi-lock-fill me-1"></i>Xác nhận mật khẩu</label>
            <div class="input-group">
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('confirmPassword')">
                    <i class="bi bi-eye"></i>
                </button>
            </div>
            <div id="passwordFeedback" class="password-feedback mt-1">
                <i class="bi bi-x-circle me-1"></i>Mật khẩu không khớp
            </div>
        </div>
        <button type="submit" class="btn btn-success w-100" id="submitBtn">
            <i class="bi bi-person-plus me-2"></i>Đăng ký
        </button>
    </form>
    <div class="mt-3 text-center">
        <span>Đã có tài khoản? <a href="${pageContext.request.contextPath}/dang-nhap">Đăng nhập</a></span>
    </div>
</div>
<jsp:include page="/views/includes/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function togglePassword(inputId) {
        const input = document.getElementById(inputId);
        const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
        input.setAttribute('type', type);
        
        // Thay đổi icon
        const icon = event.currentTarget.querySelector('i');
        if (type === 'text') {
            icon.classList.remove('bi-eye');
            icon.classList.add('bi-eye-slash');
        } else {
            icon.classList.remove('bi-eye-slash');
            icon.classList.add('bi-eye');
        }
    }
    
    // Kiểm tra mật khẩu khớp nhau
    document.addEventListener('DOMContentLoaded', function() {
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        const feedback = document.getElementById('passwordFeedback');
        const form = document.getElementById('registerForm');
        
        function checkPasswordMatch() {
            if (confirmPassword.value === '') {
                feedback.classList.remove('show', 'password-match', 'password-mismatch');
                return;
            }
            
            if (password.value === confirmPassword.value) {
                feedback.classList.add('show', 'password-match');
                feedback.classList.remove('password-mismatch');
                feedback.innerHTML = '<i class="bi bi-check-circle me-1"></i>Mật khẩu khớp';
            } else {
                feedback.classList.add('show', 'password-mismatch');
                feedback.classList.remove('password-match');
                feedback.innerHTML = '<i class="bi bi-x-circle me-1"></i>Mật khẩu không khớp';
            }
        }
        
        password.addEventListener('input', checkPasswordMatch);
        confirmPassword.addEventListener('input', checkPasswordMatch);
        
        // Kiểm tra trước khi submit form
        form.addEventListener('submit', function(event) {
            if (password.value !== confirmPassword.value) {
                event.preventDefault();
                feedback.classList.add('show', 'password-mismatch');
                feedback.classList.remove('password-match');
                feedback.innerHTML = '<i class="bi bi-x-circle me-1"></i>Mật khẩu không khớp';
                confirmPassword.focus();
            }
        });
    });
</script>
</body>
</html>
