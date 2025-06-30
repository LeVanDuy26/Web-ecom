package com.cellphone.servlet;

import com.cellphone.dao.DanhGiaDAO;
import com.cellphone.model.DanhGia;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/staff/reviews")
public class StaffReviewsServlet extends HttpServlet {
    private DanhGiaDAO dao = new DanhGiaDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<DanhGia> ds = dao.getAllReviews();
        System.out.println("Reviews list size in servlet: " + ds.size());
        req.setAttribute("reviews", ds);
        req.getRequestDispatcher("/staff/reviews.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String idStr = req.getParameter("idDanhGia");
        if (idStr == null || idStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/staff/reviews?msg=invalid_id");
            return;
        }
        int idDanhGia = Integer.parseInt(idStr);
        
        if ("reply".equals(action)) {
            String reply = req.getParameter("reply");
            if (dao.updateReply(idDanhGia, reply)) {
                resp.sendRedirect(req.getContextPath() + "/staff/reviews?msg=reply_success");
            } else {
                resp.sendRedirect(req.getContextPath() + "/staff/reviews?msg=reply_error");
            }
        } else if ("toggle".equals(action)) {
            boolean isHidden = Boolean.parseBoolean(req.getParameter("isHidden"));
            if (dao.toggleVisibility(idDanhGia, !isHidden)) {
                resp.sendRedirect(req.getContextPath() + "/staff/reviews?msg=toggle_success");
            } else {
                resp.sendRedirect(req.getContextPath() + "/staff/reviews?msg=toggle_error");
            }
        } else if ("delete".equals(action)) {
            if (dao.xoaDanhGia(idDanhGia)) {
                resp.sendRedirect(req.getContextPath() + "/staff/reviews?msg=delete_success");
            } else {
                resp.sendRedirect(req.getContextPath() + "/staff/reviews?msg=delete_error");
            }
        }
    }
} 