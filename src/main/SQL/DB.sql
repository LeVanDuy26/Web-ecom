-- Tạo database và chọn sử dụng
CREATE DATABASE IF NOT EXISTS cellphone
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE cellphone;

-- Cấu hình timezone cho database
SET time_zone = '+07:00';

-- Bảng người dùng chung, phân vai trò bằng cột vai_tro
CREATE TABLE nguoi_dung (
  id_nguoi_dung INT AUTO_INCREMENT PRIMARY KEY,
  ten_day_du    VARCHAR(100) NOT NULL,
  email         VARCHAR(100) NOT NULL UNIQUE,
  mat_khau      VARCHAR(64)  NOT NULL,
  sdt           VARCHAR(15)  NOT NULL,
  vai_tro       VARCHAR(20)  NOT NULL COMMENT 'customer|staff',
  trang_thai    TINYINT      NOT NULL DEFAULT 1  COMMENT '1=hoat dong,0=vo hieu hoa',
  ngay_tao      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bảng sản phẩm
DROP TABLE IF EXISTS san_pham;
CREATE TABLE san_pham (
  id_san_pham    INT AUTO_INCREMENT PRIMARY KEY,
  ten_san_pham   VARCHAR(150) NOT NULL,
  mo_ta          TEXT         NOT NULL,
  gia            DECIMAL(10,2) NOT NULL,
  url_anh        VARCHAR(255) NOT NULL,
  so_luong_ton   INT          NOT NULL DEFAULT 0,
  nha_san_xuat   VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Thêm 20 sản phẩm mẫu điện thoại
INSERT INTO san_pham (ten_san_pham, mo_ta, gia, url_anh, so_luong_ton, nha_san_xuat) VALUES
('iPhone 14 Pro Max', 'Điện thoại cao cấp của Apple với màn hình Super Retina XDR.', 29990000.00, 'phone1.jpg', 50, 'Apple'),
('iPhone 13', 'Thiết kế sang trọng, chip A15 Bionic, camera kép.', 21990000.00, 'phone2.jpg', 40, 'Apple'),
('iPhone SE 2022', 'Nhỏ gọn, hiệu năng mạnh mẽ, giá hợp lý.', 11990000.00, 'phone3.jpg', 30, 'Apple'),
('iPhone 12 Mini', 'Màn hình OLED, Face ID, thiết kế nhỏ.', 15990000.00, 'phone4.jpg', 25, 'Apple'),
('iPhone 11', 'Camera kép, pin tốt, nhiều màu sắc.', 10990000.00, 'phone5.jpg', 20, 'Apple'),
('Samsung Galaxy S23 Ultra', 'Flagship Android với camera 200MP và bút S Pen.', 24990000.00, 'phone6.jpg', 45, 'Samsung'),
('Samsung Galaxy S22', 'Màn hình Dynamic AMOLED, sạc nhanh.', 18990000.00, 'phone7.jpg', 35, 'Samsung'),
('Samsung Galaxy A54', 'Pin lớn, camera 50MP, giá tầm trung.', 8990000.00, 'phone8.jpg', 60, 'Samsung'),
('Samsung Galaxy Z Flip4', 'Điện thoại gập thời trang, nhỏ gọn.', 21990000.00, 'phone9.jpg', 15, 'Samsung'),
('Samsung Galaxy M34', 'Pin 6000mAh, màn hình 120Hz.', 5990000.00, 'phone10.jpg', 25, 'Samsung'),
('Xiaomi 13 Pro', 'Điện thoại hiệu năng cao, camera Leica, sạc nhanh 120W.', 18990000.00, 'phone11.jpg', 30, 'Xiaomi'),
('Xiaomi Redmi Note 12', 'Pin trâu, màn hình AMOLED, giá rẻ.', 5990000.00, 'phone12.jpg', 50, 'Xiaomi'),
('Xiaomi 12T', 'Camera 108MP, sạc nhanh 120W.', 12990000.00, 'phone13.jpg', 20, 'Xiaomi'),
('Xiaomi Poco F5', 'Hiệu năng mạnh, giá tốt cho game thủ.', 8990000.00, 'phone14.jpg', 40, 'Xiaomi'),
('Xiaomi Redmi 10C', 'Pin 5000mAh, màn hình lớn.', 3990000.00, 'phone15.jpg', 60, 'Xiaomi'),
('OPPO Find X5 Pro', 'Thiết kế sang trọng, camera AI, sạc siêu nhanh.', 20990000.00, 'phone16.jpg', 18, 'OPPO'),
('OPPO Reno8', 'Camera chân dung, sạc nhanh 80W.', 10990000.00, 'phone17.jpg', 22, 'OPPO'),
('OPPO A57', 'Pin lớn, loa kép, giá rẻ.', 3990000.00, 'phone18.jpg', 55, 'OPPO'),
('OPPO A78', 'Pin 5000mAh, sạc nhanh 67W, màn hình AMOLED.', 7490000.00, 'phone19.jpg', 30, 'OPPO'),
('OPPO Reno7 Z', 'Thiết kế mỏng nhẹ, camera AI, giá hợp lý.', 8990000.00, 'phone20.jpg', 25, 'OPPO'),
('Vivo X90 Pro', 'Camera ZEISS, pin lớn, màn hình AMOLED.', 17990000.00, 'phone21.jpg', 28, 'Vivo'),
('Vivo V25', 'Camera selfie 50MP, thiết kế đổi màu.', 8490000.00, 'phone22.jpg', 35, 'Vivo'),
('Vivo Y36', 'Pin lớn, camera 50MP, thiết kế trẻ trung.', 5990000.00, 'phone23.jpg', 40, 'Vivo'),
('Vivo V27e', 'Camera OIS, màn hình AMOLED, sạc nhanh.', 7990000.00, 'phone24.jpg', 32, 'Vivo'),
('Vivo Y22s', 'Pin 5000mAh, camera kép, giá rẻ.', 4990000.00, 'phone25.jpg', 38, 'Vivo');

-- Bảng giỏ hàng
CREATE TABLE gio_hang (
  id_gio_hang    INT AUTO_INCREMENT PRIMARY KEY,
  id_nguoi_dung  INT NOT NULL,
  ngay_tao       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_nguoi_dung) REFERENCES nguoi_dung(id_nguoi_dung)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Các mặt hàng trong giỏ
CREATE TABLE san_pham_trong_gio (
  id_gio_hang    INT NOT NULL,
  id_san_pham    INT NOT NULL,
  so_luong       INT NOT NULL,
  PRIMARY KEY (id_gio_hang, id_san_pham),
  FOREIGN KEY (id_gio_hang) REFERENCES gio_hang(id_gio_hang) ON DELETE CASCADE,
  FOREIGN KEY (id_san_pham) REFERENCES san_pham(id_san_pham)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bảng đơn hàng
CREATE TABLE don_hang (
  id_don_hang    INT AUTO_INCREMENT PRIMARY KEY,
  id_nguoi_dung  INT NOT NULL,
  ngay_dat       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  trang_thai     VARCHAR(20) NOT NULL,
  tong_tien      DECIMAL(12,2) NOT NULL,
  dia_chi        VARCHAR(255) NOT NULL,
  sdt_nguoi_nhan VARCHAR(15)  NOT NULL,
  FOREIGN KEY (id_nguoi_dung) REFERENCES nguoi_dung(id_nguoi_dung)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Chi tiết sản phẩm trong đơn hàng
CREATE TABLE san_pham_trong_don (
  id_don_hang    INT NOT NULL,
  id_san_pham    INT NOT NULL,
  so_luong       INT NOT NULL,
  don_gia        DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_don_hang, id_san_pham),
  FOREIGN KEY (id_don_hang) REFERENCES don_hang(id_don_hang) ON DELETE CASCADE,
  FOREIGN KEY (id_san_pham) REFERENCES san_pham(id_san_pham)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bảng đánh giá
CREATE TABLE danh_gia (
  id_danh_gia    INT AUTO_INCREMENT PRIMARY KEY,
  id_san_pham    INT NOT NULL,
  id_nguoi_dung  INT NOT NULL,
  so_sao         INT NOT NULL CHECK (so_sao BETWEEN 1 AND 5),
  noi_dung       TEXT NOT NULL,
  tra_loi        TEXT,
  ngay_danh_gia  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  trang_thai     TINYINT NOT NULL DEFAULT 1 COMMENT '1=hien,0=an',
  FOREIGN KEY (id_san_pham)   REFERENCES san_pham(id_san_pham),
  FOREIGN KEY (id_nguoi_dung) REFERENCES nguoi_dung(id_nguoi_dung)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bảng khiếu nại
CREATE TABLE khieu_nai (
  id_khieu_nai   INT AUTO_INCREMENT PRIMARY KEY,
  id_nguoi_dung  INT NOT NULL,
  id_don_hang    INT,
  noi_dung       TEXT NOT NULL,
  phan_hoi       TEXT,
  trang_thai     VARCHAR(20) NOT NULL DEFAULT 'Dang cho',
  ngay_gui       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  yeu_cau_tra_hang BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY (id_nguoi_dung) REFERENCES nguoi_dung(id_nguoi_dung),
  FOREIGN KEY (id_don_hang)   REFERENCES don_hang(id_don_hang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bảng thông báo
CREATE TABLE thong_bao (
  id_thong_bao   INT AUTO_INCREMENT PRIMARY KEY,
  tieu_de        VARCHAR(150) NOT NULL,
  noi_dung       TEXT NOT NULL,
  ngay_tao       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ngay_ket_thuc  TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

);
-- Thêm tài khoản staff mẫu
INSERT INTO nguoi_dung (ten_day_du, email, mat_khau, sdt, vai_tro, trang_thai) VALUES
('Staff Account', 'staff@cellphone.com', 'staff123', '0123456789', 'staff', 1);
