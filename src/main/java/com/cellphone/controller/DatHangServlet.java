package com.cellphone.controller;

import com.cellphone.dao.DonHangDAO;
import com.cellphone.model.DonHang;
import com.cellphone.model.GioHang;
import com.cellphone.model.ChiTietGioHang;
import com.cellphone.model.ChiTietDonHang;
import com.cellphone.model.NguoiDung;
import com.cellphone.dao.GioHangDAO;
import com.cellphone.model.SanPham;
import com.cellphone.dao.SanPhamDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/dat-hang")
public class DatHangServlet extends HttpServlet {
    private GioHangDAO ghDao = new GioHangDAO();
    private SanPhamDAO spDao = new SanPhamDAO();
    private DonHangDAO dhDao = new DonHangDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        NguoiDung nd = (NguoiDung) session.getAttribute("nguoiDung");
        GioHang gh = null;
        
        // Xử lý chức năng "Mua ngay"
        String action = req.getParameter("action");
        if ("buynow".equals(action)) {
            String idSanPhamStr = req.getParameter("idSanPham");
            String soLuongStr = req.getParameter("soLuong");
            
            if (idSanPhamStr != null && soLuongStr != null) {
                try {
                    int idSanPham = Integer.parseInt(idSanPhamStr);
                    int soLuong = Integer.parseInt(soLuongStr);
                    
                    // Lấy thông tin sản phẩm
                    SanPham sp = spDao.getById(idSanPham);
                    
                    if (sp != null && sp.getSoLuongTon() >= soLuong) {
                        // Tạo giỏ hàng tạm thời cho mua ngay
                        GioHang tempCart = new GioHang();
                        tempCart.setItems(new ArrayList<>());
                        
                        // Thêm sản phẩm vào giỏ hàng tạm thời
                        ChiTietGioHang ctgh = new ChiTietGioHang();
                        ctgh.setIdSanPham(idSanPham);
                        ctgh.setSoLuong(soLuong);
                        ctgh.setSanPham(sp);
                        tempCart.getItems().add(ctgh);
                        
                        // Lưu giỏ hàng tạm thời vào session
                        session.setAttribute("tempCart", tempCart);
                        
                        // Chuyển hướng đến trang thanh toán với giỏ hàng tạm thời
                        req.setAttribute("cart", tempCart);
                        req.setAttribute("isBuyNow", true);
                        req.getRequestDispatcher("/views/khach_hang/thanh_toan.jsp").forward(req, resp);
                        return;
                    } else {
                        // Sản phẩm không tồn tại hoặc không đủ số lượng
                        resp.sendRedirect(req.getContextPath() + "/san-pham?id=" + idSanPham + "&msg=outofstock");
                        return;
                    }
                } catch (NumberFormatException e) {
                    resp.sendRedirect(req.getContextPath() + "/");
                    return;
                }
            }
        }
        
        // Xử lý thanh toán bình thường từ giỏ hàng
        if (nd != null) {
            gh = ghDao.getByUserId(nd.getIdNguoiDung());
        } else {
            gh = (GioHang) session.getAttribute("cart");
        }

        if (gh == null || gh.getItems() == null || gh.getItems().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/gio-hang");
            return;
        }

        req.setAttribute("cart", gh);
        req.getRequestDispatcher("/views/khach_hang/thanh_toan.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);
        NguoiDung nd = null;
        GioHang gh = null;
        if (session != null) {
            nd = (NguoiDung) session.getAttribute("nguoiDung");
        }
        if (nd != null) {
            gh = ghDao.getByUser(nd.getIdNguoiDung());
        } else if (session != null) {
            gh = (GioHang) session.getAttribute("cart");
        }
        // kiểm tra tồn kho trước khi đặt hàng
        boolean outOfStock = false;
        StringBuilder outMsg = new StringBuilder();
        if (gh != null && gh.getItems() != null) {
            for (ChiTietGioHang ctp : gh.getItems()) {
                SanPham sp = ctp.getSanPham();
                if (ctp.getSoLuong() > sp.getSoLuongTon()) {
                    outOfStock = true;
                    outMsg.append("❌ Sản phẩm **").append(sp.getTenSanPham()).append("** chỉ còn **").append(sp.getSoLuongTon()).append("** sản phẩm trong kho!\n");
                }
            }
        }
        if (outOfStock) {
            req.setAttribute("cart", gh);
            req.setAttribute("error", outMsg.toString());
            req.getRequestDispatcher("/views/khach_hang/gio_hang.jsp").forward(req, resp);
            return;
        }
        // build DonHang
        DonHang dh = new DonHang();
        if (nd != null) {
        dh.setIdNguoiDung(nd.getIdNguoiDung());
        dh.setDiaChi(req.getParameter("diaChiNhan"));
            String sdtNhan = req.getParameter("sdtNhan");
            if (sdtNhan == null || sdtNhan.trim().isEmpty()) sdtNhan = nd.getSdt();
            dh.setSdtNguoiNhan(sdtNhan);
        } else {
            // Lấy thông tin khách vãng lai
            String tenDayDu = req.getParameter("tenDayDu");
            String email = req.getParameter("email");
            String sdt = req.getParameter("sdtNhan");

            // Tạo đối tượng NguoiDung mới
            NguoiDung khachMoi = new NguoiDung();
            khachMoi.setTenDayDu(tenDayDu);
            khachMoi.setEmail(email);
            khachMoi.setSdt(sdt);
            khachMoi.setVaiTro("KHACH_VANG_LAI");
            khachMoi.setTrangThai(1);
            khachMoi.setMatKhau(""); // Khách vãng lai không có mật khẩu

            // Lưu vào database, lấy idNguoiDung mới
            com.cellphone.dao.NguoiDungDAO nguoiDungDAO = new com.cellphone.dao.NguoiDungDAO();
            int idNguoiDungMoi = nguoiDungDAO.insertAndGetId(khachMoi);

            dh.setIdNguoiDung(idNguoiDungMoi);
            dh.setDiaChi(req.getParameter("diaChiNhan"));
            dh.setSdtNguoiNhan(sdt);
        }
        List<ChiTietDonHang> items = new ArrayList<>();
        double tong = 0;
        if (gh != null && gh.getItems() != null) {
        for (ChiTietGioHang ctp : gh.getItems()) {
            ChiTietDonHang ctd = new ChiTietDonHang();
            ctd.setIdSanPham(ctp.getIdSanPham());
            ctd.setSoLuong(ctp.getSoLuong());
            ctd.setDonGia(ctp.getSanPham().getGia());
            tong += ctd.getDonGia() * ctd.getSoLuong();
            items.add(ctd);
            }
        }
        dh.setItems(items);
        dh.setTongTien(tong);
        if (dhDao.createOrder(dh)) {
            // clear cart
            if (nd != null) {
            for (ChiTietGioHang ctp : gh.getItems()) {
                ghDao.removeFromCart(gh.getIdGioHang(), ctp.getIdSanPham());
                }
            } else if (session != null) {
                session.removeAttribute("cart");
            }
            resp.sendRedirect(req.getContextPath() + "/views/khach_hang/order-success.jsp");
        } else {
            req.setAttribute("error", "Thanh toán thất bại");
            req.getRequestDispatcher("/views/khach_hang/thanh_toan.jsp").forward(req, resp);
        }
    }
}

