package com.cellphone.controller;
import com.cellphone.dao.NguoiDungDAO;
import com.cellphone.model.NguoiDung;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/dang-ky")
public class DangKyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        // Lấy thông tin từ form
        String ten = req.getParameter("fullname");
        String email = req.getParameter("email");
        String sdt = req.getParameter("phone");
        String pass = req.getParameter("password");
        
        // Kiểm tra thông tin đầu vào
        if (ten == null || ten.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập họ và tên");
            req.getRequestDispatcher("/views/auth/dang_ky.jsp").forward(req, resp);
            return;
        }
        
        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập email");
            req.getRequestDispatcher("/views/auth/dang_ky.jsp").forward(req, resp);
            return;
        }
        
        if (sdt == null || sdt.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập số điện thoại");
            req.getRequestDispatcher("/views/auth/dang_ky.jsp").forward(req, resp);
            return;
        }
        
        if (pass == null || pass.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập mật khẩu");
            req.getRequestDispatcher("/views/auth/dang_ky.jsp").forward(req, resp);
            return;
        }
        
        // Kiểm tra độ dài mật khẩu
        if (pass.length() < 6) {
            req.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự");
            req.getRequestDispatcher("/views/auth/dang_ky.jsp").forward(req, resp);
            return;
        }
        
        NguoiDungDAO dao = new NguoiDungDAO();
        
        // Kiểm tra email đã tồn tại
        if (dao.isEmailExists(email)) {
            req.setAttribute("error", "Email này đã được sử dụng. Vui lòng chọn email khác");
            req.getRequestDispatcher("/views/auth/dang_ky.jsp").forward(req, resp);
            return;
        }
        
        // Kiểm tra số điện thoại đã tồn tại
        if (dao.isPhoneExists(sdt)) {
            req.setAttribute("error", "Số điện thoại này đã được sử dụng. Vui lòng chọn số khác");
            req.getRequestDispatcher("/views/auth/dang_ky.jsp").forward(req, resp);
            return;
        }
        
        // Tạo đối tượng người dùng
        NguoiDung nd = new NguoiDung();
        nd.setTenDayDu(ten.trim());
        nd.setEmail(email.trim().toLowerCase());
        nd.setSdt(sdt.trim());
        nd.setMatKhau(pass);
        nd.setVaiTro("khach_hang");
        
        // Thực hiện đăng ký
        if (dao.insertNguoiDung(nd)) {
            resp.sendRedirect(req.getContextPath()+"/views/auth/dang_nhap.jsp?registered=success");
        } else {
            req.setAttribute("error", "Đăng ký không thành công. Vui lòng thử lại sau");
            req.getRequestDispatcher("/views/auth/dang_ky.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/dang_ky.jsp").forward(req, resp);
    }
}
