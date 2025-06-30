package com.cellphone.dao;

import com.cellphone.model.DonHang;
import com.cellphone.model.ChiTietDonHang;
import com.cellphone.model.SanPham;
import com.cellphone.util.CSDLUtill;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

public class DonHangDAO {
    
    static {
        // Cấu hình timezone cho Java application
        TimeZone.setDefault(TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
    }

    public boolean createOrder(DonHang order) {
        String sqlOrder = "INSERT INTO don_hang(id_nguoi_dung, trang_thai, tong_tien, dia_chi, sdt_nguoi_nhan) VALUES(?,?,?,?,?)";
        String sqlItem = "INSERT INTO san_pham_trong_don(id_don_hang,id_san_pham,so_luong,don_gia) VALUES(?,?,?,?)";
        String sqlUpdateStock = "UPDATE san_pham SET so_luong_ton = so_luong_ton - ? WHERE id_san_pham = ? AND so_luong_ton >= ?";
        
        try (Connection conn = CSDLUtill.getConnection()) {
            conn.setAutoCommit(false);
            try {
                // 1. Tạo đơn hàng
                try (PreparedStatement psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS)) {
                    psOrder.setInt(1, order.getIdNguoiDung());
                    psOrder.setString(2, "Chờ xác nhận");
                    psOrder.setDouble(3, order.getTongTien());
                    psOrder.setString(4, order.getDiaChi());
                    psOrder.setString(5, order.getSdtNguoiNhan());
                    psOrder.executeUpdate();
                    
                    ResultSet rs = psOrder.getGeneratedKeys();
                    if (rs.next()) {
                        int idDon = rs.getInt(1);
                        
                        // 2. Thêm chi tiết đơn hàng và cập nhật tồn kho
                        try (PreparedStatement psItem = conn.prepareStatement(sqlItem);
                             PreparedStatement psUpdateStock = conn.prepareStatement(sqlUpdateStock)) {
                            
                            for (ChiTietDonHang it : order.getItems()) {
                                // Thêm chi tiết đơn hàng
                                psItem.setInt(1, idDon);
                                psItem.setInt(2, it.getIdSanPham());
                                psItem.setInt(3, it.getSoLuong());
                                psItem.setDouble(4, it.getDonGia());
                                psItem.addBatch();
                                
                                // Cập nhật tồn kho (trừ số lượng đã bán)
                                psUpdateStock.setInt(1, it.getSoLuong());
                                psUpdateStock.setInt(2, it.getIdSanPham());
                                psUpdateStock.setInt(3, it.getSoLuong()); // Kiểm tra đủ tồn kho
                                int affectedRows = psUpdateStock.executeUpdate();
                                
                                if (affectedRows == 0) {
                                    // Không đủ tồn kho, rollback
                                    conn.rollback();
                                    return false;
                                }
                            }
                            psItem.executeBatch();
                        }
                    }
                }
                conn.commit();
                return true;
            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<DonHang> getOrdersByUser(int idUser) {
        List<DonHang> list = new ArrayList<>();
        String sql = "SELECT * FROM don_hang WHERE id_nguoi_dung=? ORDER BY ngay_dat DESC";
        try (Connection conn = CSDLUtill.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUser);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DonHang dh = new DonHang();
                dh.setIdDonHang(rs.getInt("id_don_hang"));
                dh.setIdNguoiDung(idUser);
                dh.setNgayDat(rs.getTimestamp("ngay_dat"));
                dh.setTrangThai(rs.getString("trang_thai"));
                dh.setTongTien(rs.getDouble("tong_tien"));
                dh.setDiaChi(rs.getString("dia_chi"));
                dh.setSdtNguoiNhan(rs.getString("sdt_nguoi_nhan"));
                // load items
                List<ChiTietDonHang> items = new ArrayList<>();
                try (PreparedStatement psi = conn.prepareStatement(
                        "SELECT * FROM san_pham_trong_don WHERE id_don_hang=?")) {
                    psi.setInt(1, dh.getIdDonHang());
                    ResultSet ri = psi.executeQuery();
                    SanPhamDAO spDao = new SanPhamDAO();
                    while (ri.next()) {
                        ChiTietDonHang ctd = new ChiTietDonHang();
                        ctd.setIdDonHang(dh.getIdDonHang());
                        ctd.setIdSanPham(ri.getInt("id_san_pham"));
                        ctd.setSoLuong(ri.getInt("so_luong"));
                        ctd.setDonGia(ri.getDouble("don_gia"));
                        SanPham sp = spDao.getSanPhamById(ctd.getIdSanPham());
                        ctd.setSanPham(sp);
                        items.add(ctd);
                    }
                }
                dh.setItems(items);
                list.add(dh);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<DonHang> getAllOrders() {
        List<DonHang> list = new ArrayList<>();
        String sql = "SELECT * FROM don_hang ORDER BY ngay_dat DESC";
        try (Connection conn = CSDLUtill.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                DonHang dh = new DonHang();
                dh.setIdDonHang(rs.getInt("id_don_hang"));
                dh.setIdNguoiDung(rs.getInt("id_nguoi_dung"));
                dh.setNgayDat(rs.getTimestamp("ngay_dat"));
                dh.setTrangThai(rs.getString("trang_thai"));
                dh.setTongTien(rs.getDouble("tong_tien"));
                dh.setDiaChi(rs.getString("dia_chi"));
                dh.setSdtNguoiNhan(rs.getString("sdt_nguoi_nhan"));
                // load items
                List<ChiTietDonHang> items = new ArrayList<>();
                try (PreparedStatement psi = conn.prepareStatement(
                        "SELECT * FROM san_pham_trong_don WHERE id_don_hang=?")) {
                    psi.setInt(1, dh.getIdDonHang());
                    ResultSet ri = psi.executeQuery();
                    SanPhamDAO spDao = new SanPhamDAO();
                    while (ri.next()) {
                        ChiTietDonHang ctd = new ChiTietDonHang();
                        ctd.setIdDonHang(dh.getIdDonHang());
                        ctd.setIdSanPham(ri.getInt("id_san_pham"));
                        ctd.setSoLuong(ri.getInt("so_luong"));
                        ctd.setDonGia(ri.getDouble("don_gia"));
                        SanPham sp = spDao.getSanPhamById(ctd.getIdSanPham());
                        ctd.setSanPham(sp);
                        items.add(ctd);
                    }
                }
                dh.setItems(items);
                list.add(dh);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalOrders() throws SQLException {
        String sql = "SELECT COUNT(*) FROM don_hang";
        try (Connection conn = CSDLUtill.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public List<Object[]> getRecentOrders(int limit) throws SQLException {
        List<Object[]> orders = new ArrayList<>();
        String sql = "SELECT dh.id_don_hang, nd.ten_day_du, dh.ngay_dat, dh.tong_tien, dh.trang_thai " +
                     "FROM don_hang dh " +
                     "JOIN nguoi_dung nd ON dh.id_nguoi_dung = nd.id_nguoi_dung " +
                     "ORDER BY dh.ngay_dat DESC LIMIT ?";
        
        try (Connection conn = CSDLUtill.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Object[] order = new Object[5];
                    order[0] = rs.getInt("id_don_hang");
                    order[1] = rs.getString("ten_day_du");
                    order[2] = rs.getTimestamp("ngay_dat");
                    order[3] = rs.getBigDecimal("tong_tien");
                    order[4] = rs.getString("trang_thai");
                    orders.add(order);
                }
            }
        }
        return orders;
    }

    public List<Object[]> getAllOrdersWithCustomerInfo() throws SQLException {
        List<Object[]> orders = new ArrayList<>();
        String sql = "SELECT dh.id_don_hang, nd.ten_day_du, dh.ngay_dat, dh.tong_tien, dh.trang_thai " +
                "FROM don_hang dh JOIN nguoi_dung nd ON dh.id_nguoi_dung = nd.id_nguoi_dung " +
                "ORDER BY dh.ngay_dat DESC";
        
        try (Connection conn = CSDLUtill.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Object[] order = new Object[5];
                order[0] = rs.getInt("id_don_hang");
                order[1] = rs.getString("ten_day_du");
                order[2] = rs.getTimestamp("ngay_dat");
                order[3] = rs.getBigDecimal("tong_tien");
                order[4] = rs.getString("trang_thai");
                orders.add(order);
            }
        }
        return orders;
    }

    public List<Object[]> getOrdersByStatus(String status) throws SQLException {
        List<Object[]> orders = new ArrayList<>();
        String sql = "SELECT dh.id_don_hang, nd.ten_day_du, dh.ngay_dat, dh.tong_tien, dh.trang_thai " +
                "FROM don_hang dh JOIN nguoi_dung nd ON dh.id_nguoi_dung = nd.id_nguoi_dung " +
                "WHERE dh.trang_thai = ? " +
                "ORDER BY dh.ngay_dat DESC";
        
        try (Connection conn = CSDLUtill.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Object[] order = new Object[5];
                    order[0] = rs.getInt("id_don_hang");
                    order[1] = rs.getString("ten_day_du");
                    order[2] = rs.getTimestamp("ngay_dat");
                    order[3] = rs.getBigDecimal("tong_tien");
                    order[4] = rs.getString("trang_thai");
                    orders.add(order);
                }
            }
        }
        return orders;
    }

    /**
     * Hủy đơn hàng với điều kiện đơn hàng đang ở trạng thái "Chờ xác nhận" hoặc "Đang xử lý"
     * @param idDonHang ID của đơn hàng cần hủy
     * @param idNguoiDung ID của người dùng thực hiện hủy đơn (để kiểm tra quyền)
     * @return true nếu hủy thành công, false nếu có lỗi hoặc không đủ điều kiện
     */
    public boolean cancelOrder(int idDonHang, int idNguoiDung) {
        String checkSql = "SELECT trang_thai FROM don_hang WHERE id_don_hang = ? AND id_nguoi_dung = ?";
        String updateSql = "UPDATE don_hang SET trang_thai = N'Đã hủy' WHERE id_don_hang = ? AND id_nguoi_dung = ? AND (trang_thai = N'Chờ xác nhận' OR trang_thai = N'Đang xử lý')";
        String getItemsSql = "SELECT id_san_pham, so_luong FROM san_pham_trong_don WHERE id_don_hang = ?";
        String restoreStockSql = "UPDATE san_pham SET so_luong_ton = so_luong_ton + ? WHERE id_san_pham = ?";
        
        try (Connection conn = CSDLUtill.getConnection()) {
            conn.setAutoCommit(false);
            try {
                // Kiểm tra trạng thái đơn hàng
                try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                    checkStmt.setInt(1, idDonHang);
                    checkStmt.setInt(2, idNguoiDung);
                    ResultSet rs = checkStmt.executeQuery();
                    
                    if (rs.next()) {
                        String trangThai = rs.getString("trang_thai");
                        if (!trangThai.equals("Chờ xác nhận") && !trangThai.equals("Đang xử lý")) {
                            // Đơn hàng không ở trạng thái có thể hủy
                            return false;
                        }
                    } else {
                        // Không tìm thấy đơn hàng hoặc đơn hàng không thuộc về người dùng
                        return false;
                    }
                }
                
                // Lấy danh sách sản phẩm trong đơn hàng để hoàn trả tồn kho
                List<Object[]> orderItems = new ArrayList<>();
                try (PreparedStatement getItemsStmt = conn.prepareStatement(getItemsSql)) {
                    getItemsStmt.setInt(1, idDonHang);
                    ResultSet rs = getItemsStmt.executeQuery();
                    while (rs.next()) {
                        Object[] item = new Object[2];
                        item[0] = rs.getInt("id_san_pham");
                        item[1] = rs.getInt("so_luong");
                        orderItems.add(item);
                    }
                }
                
                // Cập nhật trạng thái đơn hàng thành "Đã hủy"
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setInt(1, idDonHang);
                    updateStmt.setInt(2, idNguoiDung);
                    int rowsAffected = updateStmt.executeUpdate();
                    if (rowsAffected == 0) {
                        return false;
                    }
                }
                
                // Hoàn trả số lượng tồn kho cho các sản phẩm
                try (PreparedStatement restoreStockStmt = conn.prepareStatement(restoreStockSql)) {
                    for (Object[] item : orderItems) {
                        int idSanPham = (Integer) item[0];
                        int soLuong = (Integer) item[1];
                        restoreStockStmt.setInt(1, soLuong);
                        restoreStockStmt.setInt(2, idSanPham);
                        restoreStockStmt.executeUpdate();
                    }
                }
                
                conn.commit();
                return true;
            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Cập nhật trạng thái đơn hàng
     * @param idDonHang ID của đơn hàng cần cập nhật
     * @param trangThai Trạng thái mới
     * @return true nếu cập nhật thành công, false nếu thất bại
     */
    public boolean updateOrderStatus(int idDonHang, String trangThai) {
        String sql = "UPDATE don_hang SET trang_thai = ? WHERE id_don_hang = ?";
        try (Connection conn = CSDLUtill.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, trangThai);
            ps.setInt(2, idDonHang);
            System.out.println("Updating order #" + idDonHang + " status to: " + trangThai); // Debug log
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error updating order status: " + e.getMessage()); // Debug log
            e.printStackTrace();
            return false;
        }
    }
}








