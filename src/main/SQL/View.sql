USE cellphone;

####################################################
-- 1) Doanh thu theo tháng
--   total_revenue = SUM(tong_tien) của đơn hoàn thành
####################################################
CREATE OR REPLACE VIEW doanh_thu_theo_thang AS
SELECT
  DATE_FORMAT(ngay_dat, '%Y-%m')     AS thang,             -- '2024-05'
  SUM(tong_tien)                      AS tong_doanh_thu   -- tổng doanh thu
FROM don_hang
WHERE trang_thai = 'Hoàn thành'
GROUP BY DATE_FORMAT(ngay_dat, '%Y-%m');

####################################################
-- 2) Số lượng đơn theo tháng
--   order_count = COUNT(*) của đơn hoàn thành
####################################################
CREATE OR REPLACE VIEW so_luong_don_theo_thang AS
SELECT
  DATE_FORMAT(ngay_dat, '%Y-%m')     AS thang,
  COUNT(*)                           AS so_don          -- số đơn hoàn thành
FROM don_hang
WHERE trang_thai = 'Hoàn thành'
GROUP BY DATE_FORMAT(ngay_dat, '%Y-%m');

####################################################
-- 3) Sản phẩm bán ra theo tháng
--   total_sold = SUM(số lượng) của mỗi sản phẩm
####################################################
CREATE OR REPLACE VIEW san_pham_ban_ra_theo_thang AS
SELECT
  DATE_FORMAT(dh.ngay_dat, '%Y-%m')  AS thang,
  sp.id_san_pham                     AS ma_san_pham,
  sp.ten_san_pham                    AS ten_san_pham,
  SUM(ct.so_luong)                   AS tong_so_luong    -- tổng số lượng bán ra
FROM san_pham_trong_don ct
JOIN don_hang dh ON ct.id_don_hang = dh.id_don_hang
JOIN san_pham sp ON ct.id_san_pham = sp.id_san_pham
WHERE dh.trang_thai = 'Hoàn thành'
GROUP BY DATE_FORMAT(dh.ngay_dat, '%Y-%m'),
         sp.id_san_pham, sp.ten_san_pham;

####################################################
-- 4) Doanh số theo thương hiệu mỗi tháng
--   total_sold = SUM(số lượng) của mỗi hãng
####################################################
CREATE OR REPLACE VIEW doanh_so_theo_thuong_hieu AS
SELECT
  DATE_FORMAT(dh.ngay_dat, '%Y-%m')  AS thang,
  sp.nha_san_xuat                    AS thuong_hieu,
  SUM(ct.so_luong)                   AS tong_so_luong    -- tổng số lượng theo hãng
FROM san_pham_trong_don ct
JOIN don_hang dh ON ct.id_don_hang = dh.id_don_hang
JOIN san_pham sp ON ct.id_san_pham = sp.id_san_pham
WHERE dh.trang_thai = 'Hoàn thành'
GROUP BY DATE_FORMAT(dh.ngay_dat, '%Y-%m'),
         sp.nha_san_xuat;

####################################################
-- 5) Giá trị đơn hàng trung bình (AOV) theo tháng
--   aov = total_revenue / order_count
####################################################
CREATE OR REPLACE VIEW gia_tri_don_hang_trung_binh_theo_thang AS
SELECT
  dv.thang,
  ROUND(dv.tong_doanh_thu / sl.so_don, 2) AS aov  -- doanh thu / số đơn
FROM doanh_thu_theo_thang dv
JOIN so_luong_don_theo_thang sl USING(thang);

####################################################
-- 6) Tỷ lệ hủy đơn theo tháng (%)
--   cancel_rate = (số đơn hủy / tổng đơn) * 100
####################################################
CREATE OR REPLACE VIEW ty_le_huy_don_theo_thang AS
SELECT
  thang,
  ROUND(100 * so_huy / tong_don, 2) AS ty_le_huy  -- % hủy đơn
FROM (
  SELECT
    DATE_FORMAT(ngay_dat, '%Y-%m')         AS thang,
    SUM(trang_thai = 'Đã hủy')             AS so_huy,   -- MySQL TRUE=1
    COUNT(*)                               AS tong_don  -- tổng đơn
  FROM don_hang
  GROUP BY DATE_FORMAT(ngay_dat, '%Y-%m')
) t;

####################################################
-- 7) Tỷ lệ khách hàng trở lại theo tháng (%)
--   return_rate = (khách có ≥2 đơn / tổng khách) * 100
####################################################
CREATE OR REPLACE VIEW ty_le_khach_tro_lai_theo_thang AS
WITH thong_ke AS (
  SELECT
    DATE_FORMAT(ngay_dat, '%Y-%m') AS thang,
    id_nguoi_dung,
    COUNT(*)                       AS so_don      -- số đơn mỗi khách
  FROM don_hang
  GROUP BY DATE_FORMAT(ngay_dat, '%Y-%m'), id_nguoi_dung
)
SELECT
  thang,
  ROUND(100 * SUM(so_don >= 2) / COUNT(*), 2) AS ty_le_tro_lai  -- % khách ≥2 đơn
FROM thong_ke
GROUP BY thang;

####################################################
-- 8) Giá trị khách hàng trung bình theo tháng (CLV)
--   clv = total_revenue / distinct_customers
####################################################
CREATE OR REPLACE VIEW gia_tri_trung_binh_khach AS
WITH dt AS (
  SELECT
    DATE_FORMAT(ngay_dat, '%Y-%m') AS thang,
    SUM(tong_tien)                 AS tong_doanh_thu
  FROM don_hang
  WHERE trang_thai = 'Hoàn thành'
  GROUP BY DATE_FORMAT(ngay_dat, '%Y-%m')
),
kh AS (
  SELECT
    DATE_FORMAT(ngay_dat, '%Y-%m') AS thang,
    COUNT(DISTINCT id_nguoi_dung)  AS so_khach
  FROM don_hang
  WHERE trang_thai = 'Hoàn thành'
  GROUP BY DATE_FORMAT(ngay_dat, '%Y-%m')
)
SELECT
  dt.thang,
  ROUND(dt.tong_doanh_thu / kh.so_khach, 2) AS clv  -- trung bình trên mỗi khách
FROM dt
JOIN kh USING(thang);

####################################################
-- 9) Tổng hợp đơn hàng của khách theo tháng
--   COUNT đơn và SUM giá trị đơn cho mỗi khách
####################################################
CREATE OR REPLACE VIEW tong_hop_don_hang_khach_theo_thang AS
SELECT
  DATE_FORMAT(dh.ngay_dat, '%Y-%m') AS thang,
  nd.id_nguoi_dung                  AS ma_khach,
  nd.ten_day_du                     AS ten_khach,
  COUNT(dh.id_don_hang)             AS so_don      -- số đơn của khách
  ,SUM(dh.tong_tien)                AS tong_gia   -- tổng giá trị đơn
FROM don_hang dh
JOIN nguoi_dung nd ON dh.id_nguoi_dung = nd.id_nguoi_dung
WHERE dh.trang_thai = 'Hoàn thành'
GROUP BY thang, nd.id_nguoi_dung, nd.ten_day_du
ORDER BY thang;

####################################################
-- 10) Doanh thu tháng này vs tháng trước
--   Dùng LAG để lấy doanh thu tháng trước
####################################################
CREATE OR REPLACE VIEW doanh_thu_thang_nay_vs_thang_truoc AS
SELECT
  dt.thang                            AS thang,
  dt.tong_doanh_thu                   AS doanh_thu_hien_tai,  -- tháng hiện tại
  LAG(dt.tong_doanh_thu) OVER (ORDER BY dt.thang)
                                      AS doanh_thu_truoc     -- tháng trước
FROM doanh_thu_theo_thang dt;

CREATE OR REPLACE VIEW view_loi_nhuan_thang AS
SELECT
  YEAR(dh.ngay_tao) AS nam,
  MONTH(dh.ngay_tao) AS thang,
  ROUND(SUM((sp.gia - sp.gia_nhap) * sptd.so_luong), 2) AS tong_loi_nhuan
FROM don_hang AS dh
JOIN san_pham_trong_don AS sptd
  ON dh.id_don_hang = sptd.id_don_hang
JOIN san_pham AS sp
  ON sptd.id_san_pham = sp.id_san_pham
GROUP BY YEAR(dh.ngay_tao), MONTH(dh.ngay_tao);
