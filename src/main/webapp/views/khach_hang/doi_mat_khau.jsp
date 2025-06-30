<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.cellphone.model.NguoiDung" %>
<%
    NguoiDung nguoiDung = (NguoiDung) session.getAttribute("nguoiDung");
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Đổi mật khẩu - Cellphone</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-custom.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/khachhang.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/views/includes/navbar.jsp"/>
    
    <div class="container">
        <div class="password-container">
            <div class="d-flex align-items-center page-header">
                <h2 class="mb-0">Đổi mật khẩu</h2>
            </div>
            
            <% if (error != null) { %>
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <%= error %>
                </div>
            <% } %>
            
            <% if (success != null) { %>
                <div class="alert alert-success">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    <%= success %>
                </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/doi-mat-khau" method="post" id="changePasswordForm">
                <div class="mb-3">
                    <label for="matKhauCu" class="form-label">
                        <i class="bi bi-key me-1"></i> Mật khẩu hiện tại
                    </label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="matKhauCu" name="matKhauCu" required>
                        <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('matKhauCu')">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="matKhauMoi" class="form-label">
                        <i class="bi bi-key-fill me-1"></i> Mật khẩu mới
                    </label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="matKhauMoi" name="matKhauMoi" required>
                        <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('matKhauMoi')">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                    <div class="form-text">Mật khẩu nên có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số.</div>
                </div>
                
                <div class="mb-4">
                    <label for="xacNhanMatKhau" class="form-label">
                        <i class="bi bi-check2-circle me-1"></i> Xác nhận mật khẩu mới
                    </label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="xacNhanMatKhau" name="xacNhanMatKhau" required>
                        <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('xacNhanMatKhau')">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                    <div id="passwordFeedback" class="password-feedback mt-1">
                        <i class="bi bi-x-circle me-1"></i>Mật khẩu không khớp
                    </div>
                </div>
                
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        <i class="bi bi-check-lg me-2"></i>Đổi mật khẩu
                    </button>
                    <a href="${pageContext.request.contextPath}/tai-khoan" class="btn btn-secondary">
                        <i class="bi bi-arrow-left me-2"></i>Quay lại trang tài khoản
                    </a>
                </div>
            </form>
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
            const matKhauMoi = document.getElementById('matKhauMoi');
            const xacNhanMatKhau = document.getElementById('xacNhanMatKhau');
            const feedback = document.getElementById('passwordFeedback');
            const form = document.getElementById('changePasswordForm');
            
            function checkPasswordMatch() {
                if (xacNhanMatKhau.value === '') {
                    feedback.classList.remove('show', 'password-match', 'password-mismatch');
                    return;
                }
                
                if (matKhauMoi.value === xacNhanMatKhau.value) {
                    feedback.classList.add('show', 'password-match');
                    feedback.classList.remove('password-mismatch');
                    feedback.innerHTML = '<i class="bi bi-check-circle me-1"></i>Mật khẩu khớp';
                } else {
                    feedback.classList.add('show', 'password-mismatch');
                    feedback.classList.remove('password-match');
                    feedback.innerHTML = '<i class="bi bi-x-circle me-1"></i>Mật khẩu không khớp';
                }
            }
            
            matKhauMoi.addEventListener('input', checkPasswordMatch);
            xacNhanMatKhau.addEventListener('input', checkPasswordMatch);
            
            // Kiểm tra trước khi submit form
            form.addEventListener('submit', function(event) {
                if (matKhauMoi.value !== xacNhanMatKhau.value) {
                    event.preventDefault();
                    feedback.classList.add('show', 'password-mismatch');
                    feedback.classList.remove('password-match');
                    feedback.innerHTML = '<i class="bi bi-x-circle me-1"></i>Mật khẩu không khớp';
                    xacNhanMatKhau.focus();
                }
            });
        });
    </script>
</body>
</html>

