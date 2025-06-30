package com.cellphone.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import com.cellphone.dao.NguoiDungDAO;
import com.cellphone.model.NguoiDung;

@WebServlet("/dang-xuat")
public class DangXuatServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate(); // Hủy session
        }
        resp.sendRedirect(req.getContextPath() + "/"); // Quay về trang chủ
    }
} 