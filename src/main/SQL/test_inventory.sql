-- File test kiểm tra luồng tồn kho
USE cellphone;

-- 1. Kiểm tra tồn kho hiện tại
SELECT id_san_pham, ten_san_pham, so_luong_ton FROM san_pham ORDER BY id_san_pham LIMIT 5;

-- 2. Tạo đơn hàng test để kiểm tra trừ tồn kho
-- (Chạy sau khi test đặt hàng trên web)

-- 3. Kiểm tra lại tồn kho sau khi đặt hàng
-- SELECT id_san_pham, ten_san_pham, so_luong_ton FROM san_pham ORDER BY id_san_pham LIMIT 5;

-- 4. Kiểm tra đơn hàng vừa tạo
-- SELECT * FROM don_hang ORDER BY ngay_dat DESC LIMIT 3;

-- 5. Kiểm tra chi tiết đơn hàng
-- SELECT dh.id_don_hang, sp.ten_san_pham, ctd.so_luong, ctd.don_gia
-- FROM don_hang dh
-- JOIN san_pham_trong_don ctd ON dh.id_don_hang = ctd.id_don_hang
-- JOIN san_pham sp ON ctd.id_san_pham = sp.id_san_pham
-- ORDER BY dh.ngay_dat DESC LIMIT 10;

-- 6. Test hủy đơn hàng và hoàn trả tồn kho
-- UPDATE don_hang SET trang_thai = 'Đã hủy' WHERE id_don_hang = [ID_DON_HANG_TEST];

-- 7. Kiểm tra tồn kho sau khi hủy đơn
-- SELECT id_san_pham, ten_san_pham, so_luong_ton FROM san_pham ORDER BY id_san_pham LIMIT 5;

-- 8. View tổng hợp để theo dõi tồn kho
CREATE OR REPLACE VIEW theo_doi_ton_kho AS
SELECT 
    sp.id_san_pham,
    sp.ten_san_pham,
    sp.nha_san_xuat,
    sp.so_luong_ton,
    sp.gia,
    (sp.so_luong_ton * sp.gia) AS gia_tri_ton_kho,
    CASE 
        WHEN sp.so_luong_ton = 0 THEN 'Hết hàng'
        WHEN sp.so_luong_ton <= 5 THEN 'Sắp hết'
        WHEN sp.so_luong_ton <= 20 THEN 'Còn ít'
        ELSE 'Đủ hàng'
    END AS trang_thai_ton_kho
FROM san_pham sp
ORDER BY sp.so_luong_ton ASC;

-- 9. View sản phẩm sắp hết hàng
CREATE OR REPLACE VIEW san_pham_sap_het AS
SELECT 
    id_san_pham,
    ten_san_pham,
    nha_san_xuat,
    so_luong_ton,
    gia
FROM san_pham 
WHERE so_luong_ton <= 10
ORDER BY so_luong_ton ASC;

-- 10. View thống kê bán hàng theo sản phẩm
CREATE OR REPLACE VIEW thong_ke_ban_hang_theo_san_pham AS
SELECT 
    sp.id_san_pham,
    sp.ten_san_pham,
    sp.nha_san_xuat,
    sp.so_luong_ton AS ton_kho_hien_tai,
    COALESCE(SUM(ctd.so_luong), 0) AS tong_so_luong_da_ban,
    COALESCE(SUM(ctd.so_luong * ctd.don_gia), 0) AS tong_doanh_thu
FROM san_pham sp
LEFT JOIN san_pham_trong_don ctd ON sp.id_san_pham = ctd.id_san_pham
LEFT JOIN don_hang dh ON ctd.id_don_hang = dh.id_don_hang AND dh.trang_thai = 'Hoàn thành'
GROUP BY sp.id_san_pham, sp.ten_san_pham, sp.nha_san_xuat, sp.so_luong_ton
ORDER BY tong_doanh_thu DESC; 