package com.cellphone.servlet;

import com.cellphone.dao.SanPhamDAO;
import com.cellphone.model.SanPham;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/staff/products/*")
public class StaffProductsServlet extends HttpServlet {
    private SanPhamDAO sanPhamDAO = new SanPhamDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Cấu hình encoding UTF-8
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        
        String action = req.getPathInfo();
        
        if (action == null || action.equals("/")) {
            // Hiển thị danh sách sản phẩm
            List<SanPham> products = sanPhamDAO.getAllSanPham();
            req.setAttribute("products", products);
            req.getRequestDispatcher("/staff/products.jsp").forward(req, resp);
        } else if (action.equals("/edit")) {
            // Hiển thị form sửa sản phẩm
            int id = Integer.parseInt(req.getParameter("id"));
            SanPham product = sanPhamDAO.getSanPhamById(id);
            req.setAttribute("sanPham", product);
            req.getRequestDispatcher("/staff/product-edit.jsp").forward(req, resp);
        } else if (action.equals("/add")) {
            // Hiển thị form thêm sản phẩm
            req.getRequestDispatcher("/staff/product-add.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Cấu hình encoding UTF-8
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        
        String pathAction = req.getPathInfo();
        if (pathAction != null && pathAction.endsWith("/")) {
            pathAction = pathAction.substring(0, pathAction.length() - 1);
        }
        String formAction = req.getParameter("action");

        if ("add".equals(formAction) || (formAction == null && (pathAction == null || pathAction.equals("/")))) {
            // Xử lý thêm sản phẩm mới
            String tenSanPham = req.getParameter("tenSanPham");
            String moTa = req.getParameter("moTa");
            String giaStr = req.getParameter("gia");
            String urlAnh = req.getParameter("urlAnh");
            String soLuongStr = req.getParameter("soLuongTon");
            String nhaSanXuat = req.getParameter("nhaSanXuat");
            String errorMsg = null;
            double gia = 0;
            int soLuong = 0;
            // Validate các trường bắt buộc
            if (tenSanPham == null || tenSanPham.trim().isEmpty() ||
                moTa == null || moTa.trim().isEmpty() ||
                giaStr == null || giaStr.trim().isEmpty() ||
                urlAnh == null || urlAnh.trim().isEmpty() ||
                soLuongStr == null || soLuongStr.trim().isEmpty() ||
                nhaSanXuat == null || nhaSanXuat.trim().isEmpty()) {
                errorMsg = "Vui lòng nhập đầy đủ thông tin sản phẩm!";
            } else {
                try {
                    gia = Double.parseDouble(giaStr.trim());
                    if (gia <= 0) errorMsg = "Giá sản phẩm phải lớn hơn 0!";
                } catch (NumberFormatException e) {
                    errorMsg = "Giá sản phẩm không hợp lệ!";
                }
                try {
                    soLuong = Integer.parseInt(soLuongStr.trim());
                    if (soLuong < 0) errorMsg = "Số lượng tồn kho không hợp lệ!";
                } catch (NumberFormatException e) {
                    errorMsg = "Số lượng tồn kho không hợp lệ!";
                }
            }
            if (errorMsg != null) {
                // Lưu lại dữ liệu cũ dạng chuỗi để form giữ lại đúng giá trị nhập vào
                Map<String, String> oldSanPham = new HashMap<>();
                oldSanPham.put("tenSanPham", tenSanPham != null ? tenSanPham : "");
                oldSanPham.put("moTa", moTa != null ? moTa : "");
                oldSanPham.put("gia", giaStr != null ? giaStr : "");
                oldSanPham.put("urlAnh", urlAnh != null ? urlAnh : "");
                oldSanPham.put("soLuongTon", soLuongStr != null ? soLuongStr : "");
                oldSanPham.put("nhaSanXuat", nhaSanXuat != null ? nhaSanXuat : "");
                req.getSession().setAttribute("oldSanPham", oldSanPham);
                req.getSession().setAttribute("error", errorMsg);
                resp.sendRedirect(req.getContextPath() + "/staff/products/add");
                return;
            }
            SanPham sp = new SanPham();
            sp.setTenSanPham(tenSanPham);
            sp.setMoTa(moTa);
            sp.setGia(gia);
            sp.setUrlAnh(urlAnh);
            sp.setSoLuongTon(soLuong);
            sp.setNhaSanXuat(nhaSanXuat);
            if (sanPhamDAO.themSanPham(sp)) {
                req.getSession().setAttribute("message", "Thêm sản phẩm thành công!");
            } else {
                // Lưu lại dữ liệu cũ để hiển thị lại nếu cần
                Map<String, String> oldSanPham = new HashMap<>();
                oldSanPham.put("tenSanPham", tenSanPham != null ? tenSanPham : "");
                oldSanPham.put("moTa", moTa != null ? moTa : "");
                oldSanPham.put("gia", giaStr != null ? giaStr : "");
                oldSanPham.put("urlAnh", urlAnh != null ? urlAnh : "");
                oldSanPham.put("soLuongTon", soLuongStr != null ? soLuongStr : "");
                oldSanPham.put("nhaSanXuat", nhaSanXuat != null ? nhaSanXuat : "");
                req.getSession().setAttribute("oldSanPham", oldSanPham);
                req.getSession().setAttribute("error", "Thêm sản phẩm thất bại! Vui lòng kiểm tra lại dữ liệu hoặc thử lại sau.");
                resp.sendRedirect(req.getContextPath() + "/staff/products/add");
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/staff/products");
        } else if ("edit".equals(formAction) || (pathAction != null && pathAction.equals("/edit"))) {
            // Xử lý cập nhật sản phẩm
            String idStr = req.getParameter("id");
            String tenSanPham = req.getParameter("tenSanPham");
            String moTa = req.getParameter("moTa");
            String giaStr = req.getParameter("gia");
            String urlAnh = req.getParameter("urlAnh");
            String soLuongStr = req.getParameter("soLuongTon");
            String nhaSanXuat = req.getParameter("nhaSanXuat");
            String errorMsg = null;
            int id = 0;
            double gia = 0;
            int soLuong = 0;
            // Validate các trường bắt buộc
            if (idStr == null || idStr.trim().isEmpty() ||
                tenSanPham == null || tenSanPham.trim().isEmpty() ||
                moTa == null || moTa.trim().isEmpty() ||
                giaStr == null || giaStr.trim().isEmpty() ||
                urlAnh == null || urlAnh.trim().isEmpty() ||
                soLuongStr == null || soLuongStr.trim().isEmpty() ||
                nhaSanXuat == null || nhaSanXuat.trim().isEmpty()) {
                errorMsg = "Vui lòng nhập đầy đủ thông tin sản phẩm!";
            } else {
                try {
                    id = Integer.parseInt(idStr.trim());
                } catch (NumberFormatException e) {
                    errorMsg = "ID sản phẩm không hợp lệ!";
                }
                try {
                    gia = Double.parseDouble(giaStr.trim());
                    if (gia <= 0) errorMsg = "Giá sản phẩm phải lớn hơn 0!";
                } catch (NumberFormatException e) {
                    errorMsg = "Giá sản phẩm không hợp lệ!";
                }
                try {
                    soLuong = Integer.parseInt(soLuongStr.trim());
                    if (soLuong < 0) errorMsg = "Số lượng tồn kho không hợp lệ!";
                } catch (NumberFormatException e) {
                    errorMsg = "Số lượng tồn kho không hợp lệ!";
                }
            }
            if (errorMsg != null) {
                req.getSession().setAttribute("error", errorMsg);
                // Lưu lại dữ liệu cũ để hiển thị lại nếu cần
                req.getSession().setAttribute("oldSanPham", new com.cellphone.model.SanPham(id, tenSanPham, moTa, gia, soLuong, urlAnh, nhaSanXuat));
                resp.sendRedirect(req.getContextPath() + "/staff/products/edit?id=" + idStr);
                return;
            }
            SanPham sp = new SanPham();
            sp.setIdSanPham(id);
            sp.setTenSanPham(tenSanPham);
            sp.setMoTa(moTa);
            sp.setGia(gia);
            sp.setUrlAnh(urlAnh);
            sp.setSoLuongTon(soLuong);
            sp.setNhaSanXuat(nhaSanXuat);
            boolean updateResult = sanPhamDAO.capNhatSanPham(sp);
            if (updateResult) {
                req.getSession().setAttribute("message", "Cập nhật sản phẩm thành công!");
            } else {
                req.getSession().setAttribute("error", "Cập nhật sản phẩm thất bại!");
            }
            resp.sendRedirect(req.getContextPath() + "/staff/products");
        } else if (pathAction.equals("/delete")) {
            // Xử lý xóa sản phẩm
            int id = Integer.parseInt(req.getParameter("id"));
            if (sanPhamDAO.xoaSanPham(id)) {
                req.getSession().setAttribute("message", "Xóa sản phẩm thành công!");
            } else {
                req.getSession().setAttribute("error", "Xóa sản phẩm thất bại!");
            }
            resp.sendRedirect(req.getContextPath() + "/staff/products");
        } else if ("/update-stock".equals(pathAction)) {
            // Xử lý cập nhật tồn kho (AJAX)
            int id = Integer.parseInt(req.getParameter("id"));
            int soLuong = Integer.parseInt(req.getParameter("soLuong"));
            boolean success = sanPhamDAO.capNhatTonKho(id, soLuong);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"success\":" + success + "}");
        }
    }
} 