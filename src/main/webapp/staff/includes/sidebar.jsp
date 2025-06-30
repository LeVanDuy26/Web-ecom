<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="sidebar">
    <div class="sidebar-header">
        <a class="sidebar-brand" href="${pageContext.request.contextPath}/staff/dashboard">
            <i class="fas fa-mobile-alt me-2"></i>
            <span class="brand-text">Cellphone</span>
            <span class="badge bg-primary-light text-dark">Staff</span>
        </a>
    </div>
    <ul class="sidebar-nav">
        <li class="sidebar-item ${pageContext.request.servletPath.endsWith('/dashboard.jsp') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/dashboard" class="sidebar-link">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="sidebar-item ${pageContext.request.servletPath.endsWith('/orders.jsp') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/orders" class="sidebar-link">
                <i class="fas fa-shopping-cart"></i>
                <span>Đơn hàng</span>
            </a>
        </li>
        <li class="sidebar-item ${pageContext.request.servletPath.endsWith('/products.jsp') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/products" class="sidebar-link">
                <i class="fas fa-box"></i>
                <span>Sản phẩm</span>
            </a>
        </li>
        <li class="sidebar-item ${pageContext.request.servletPath.endsWith('/notifications.jsp') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/notifications" class="sidebar-link">
                <i class="fas fa-bell"></i>
                <span>Thông báo</span>
            </a>
        </li>
        <li class="sidebar-item ${pageContext.request.servletPath.contains('/quan-ly-danh-gia') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/reviews" class="sidebar-link">
                <i class="fas fa-star"></i>
                <span>Đánh giá</span>
            </a>
        </li>
        <li class="sidebar-item ${pageContext.request.servletPath.endsWith('/complaints.jsp') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/complaints" class="sidebar-link">
                <i class="fas fa-exclamation-circle"></i>
                <span>Khiếu nại</span>
            </a>
        </li>
        <li class="sidebar-item ${pageContext.request.servletPath.endsWith('/reports.jsp') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/reports" class="sidebar-link">
                <i class="fas fa-chart-bar"></i>
                <span>Báo cáo</span>
            </a>
        </li>
    </ul>
    <div class="sidebar-footer">
        <div class="sidebar-item">
             <a href="${pageContext.request.contextPath}/dang-xuat" class="sidebar-link logout-link">
                <i class="fas fa-sign-out-alt"></i>
                <span>Đăng xuất</span>
            </a>
        </div>
    </div>
</div> 