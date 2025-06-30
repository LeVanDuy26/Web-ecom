# 📱 CellPhoneV - Hệ thống Quản lý Bán Điện thoại

## 📑 Mục lục

- [📋 Mô tả dự án](#-mô-tả-dự-án)
- [🚀 Tính năng chính](#-tính-năng-chính)
  - [👥 Dành cho Khách hàng](#-dành-cho-khách-hàng)
  - [👨‍💼 Dành cho Nhân viên (Staff)](#️-dành-cho-nhân-viên-staff)
- [🛠️ Công nghệ sử dụng](#️-công-nghệ-sử-dụng)
  - [Backend](#backend)
  - [Frontend](#frontend)
  - [Thư viện hỗ trợ](#thư-viện-hỗ-trợ)
- [📦 Cài đặt và Chạy dự án](#-cài-đặt-và-chạy-dự-án)
  - [Yêu cầu hệ thống](#yêu-cầu-hệ-thống)
  - [Bước 1: Clone dự án](#bước-1-clone-dự-án)
  - [Bước 2: Cấu hình cơ sở dữ liệu](#bước-2-cấu-hình-cơ-sở-dữ-liệu)
  - [Bước 3: Build dự án](#bước-3-build-dự-án)
  - [Bước 4: Deploy lên Tomcat](#bước-4-deploy-lên-tomcat)
  - [Bước 5: Tài khoản mặc định](#bước-5-tài-khoản-mặc-định)
- [📁 Cấu trúc dự án](#-cấu-trúc-dự-án)
- [🔗 Các URL chính](#-các-url-chính)
  - [Khách hàng](#khách-hàng)
  - [Nhân viên](#nhân-viên)
- [🗄️ Cấu trúc cơ sở dữ liệu](#️-cấu-trúc-cơ-sở-dữ-liệu)
- [🎨 Giao diện](#-giao-diện)
  - [Khách hàng](#khách-hàng-1)
  - [Nhân viên](#nhân-viên-1)
- [🔒 Bảo mật](#-bảo-mật)
- [🚀 Tính năng nổi bật](#-tính-năng-nổi-bật)
- [🐛 Xử lý lỗi](#-xử-lý-lỗi)
  - [Lỗi thường gặp](#lỗi-thường-gặp)
  - [Debug](#debug)
- [📝 Ghi chú phát triển](#-ghi-chú-phát-triển)
  - [Cải tiến có thể thực hiện](#cải-tiến-có-thể-thực-hiện)
  - [Best practices đã áp dụng](#best-practices-đã-áp-dụng)
- [📞 Hỗ trợ](#-hỗ-trợ)
- [📄 License](#-license)

---

## 📋 Mô tả dự án

CellPhoneV là một hệ thống web bán điện thoại di động được xây dựng bằng **Java Servlet/JSP** với kiến trúc MVC. Hệ thống hỗ trợ hai vai trò chính: **Khách hàng** và **Nhân viên**, cung cấp đầy đủ các chức năng từ mua sắm đến quản lý.

## 🚀 Tính năng chính

### 👥 Dành cho Khách hàng
- **Đăng ký/Đăng nhập**: Hệ thống xác thực người dùng an toàn
- **Xem sản phẩm**: Trang chủ với slider, danh sách sản phẩm nổi bật
- **Tìm kiếm & Lọc**: Tìm kiếm theo tên, lọc theo nhà sản xuất
- **Chi tiết sản phẩm**: Xem thông tin chi tiết, đánh giá
- **Giỏ hàng**: Thêm/xóa sản phẩm, cập nhật số lượng
- **Đặt hàng**: Quy trình đặt hàng hoàn chỉnh
- **Quản lý đơn hàng**: Xem lịch sử, hủy đơn hàng
- **Đánh giá sản phẩm**: Viết đánh giá và xếp hạng sao
- **Khiếu nại**: Gửi khiếu nại về đơn hàng
- **Quản lý tài khoản**: Cập nhật thông tin, đổi mật khẩu

### 👨‍💼 Dành cho Nhân viên (Staff)
- **Dashboard**: Tổng quan đơn hàng, sản phẩm sắp hết hàng
- **Quản lý đơn hàng**: Xem, cập nhật trạng thái đơn hàng
- **Quản lý sản phẩm**: Thêm, sửa, xóa sản phẩm
- **Quản lý đánh giá**: Duyệt, trả lời đánh giá khách hàng
- **Xử lý khiếu nại**: Phản hồi khiếu nại khách hàng
- **Thông báo**: Tạo và quản lý thông báo hệ thống
- **Báo cáo**: Thống kê doanh thu, đơn hàng

## 🛠️ Công nghệ sử dụng

### Backend
- **Java 8**
- **Servlet 4.0.1**
- **JSP 2.3.3**
- **JSTL 1.2**
- **MySQL 8.0**

### Frontend
- **Bootstrap 5.3.2**
- **Font Awesome 6.4.2**
- **jQuery**
- **CSS3/HTML5**

### Thư viện hỗ trợ
- **MySQL Connector 8.0.27**
- **JSON 20231013**
- **Gson 2.8.9**
- **Commons FileUpload 1.5**

## 📦 Cài đặt và Chạy dự án

### Yêu cầu hệ thống
- **Java JDK 8** trở lên
- **Apache Tomcat 9.0** trở lên
- **MySQL 8.0** trở lên
- **Maven 3.6** trở lên

### Bước 1: Clone dự án
```bash
git clone https://github.com/your-username/CellPhoneV.git
cd CellPhoneV
```

### Bước 2: Cấu hình cơ sở dữ liệu
1. **Tạo database MySQL**:
```sql
CREATE DATABASE cellphone CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. **Import dữ liệu**:
```bash
mysql -u root -p cellphone < src/main/SQL/DB.sql
```

3. **Cập nhật thông tin kết nối** trong file `src/main/java/com/cellphone/util/CSDLUtill.java`:
```java
private static final String URL = "jdbc:mysql://localhost:3306/cellphone?useSSL=false&serverTimezone=Asia/Ho_Chi_Minh&useUnicode=true&characterEncoding=UTF-8";
private static final String USER = "your_username";
private static final String PASS = "your_password";
```

### Bước 3: Build dự án
```bash
mvn clean install
```

### Bước 4: Deploy lên Tomcat
1. Copy file `target/CellPhoneV.war` vào thư mục `webapps` của Tomcat
2. Khởi động Tomcat server
3. Truy cập: `http://localhost:8080/CellPhoneV`

### Bước 5: Tài khoản mặc định
- **Staff**: `staff@cellphone.com` / `staff123`
- **Khách hàng**: Đăng ký tài khoản mới

## 📁 Cấu trúc dự án

```
CellPhoneV/
├── src/
│   ├── main/
│   │   ├── java/com/cellphone/
│   │   │   ├── controller/          # Servlet xử lý request
│   │   │   ├── dao/                 # Data Access Object
│   │   │   ├── model/               # Entity classes
│   │   │   ├── servlet/             # Staff servlets
│   │   │   └── util/                # Utility classes
│   │   ├── SQL/                     # Database scripts
│   │   └── webapp/
│   │       ├── css/                 # Stylesheets
│   │       ├── img_Url/             # Product images
│   │       ├── staff/               # Staff pages
│   │       ├── views/               # Customer pages
│   │       └── WEB-INF/
│   └── test/
├── target/                          # Compiled files
├── pom.xml                          # Maven configuration
└── README.md
```

## 🔗 Các URL chính

### Khách hàng
- **Trang chủ**: `/` hoặc `/trang-chu`
- **Đăng ký**: `/dang-ky`
- **Đăng nhập**: `/dang-nhap`
- **Danh sách sản phẩm**: `/danh-sach-san-pham`
- **Chi tiết sản phẩm**: `/san-pham?id=1`
- **Giỏ hàng**: `/gio-hang`
- **Đặt hàng**: `/dat-hang`
- **Tài khoản**: `/tai-khoan`

### Nhân viên
- **Dashboard**: `/staff/dashboard`
- **Đơn hàng**: `/staff/orders`
- **Sản phẩm**: `/staff/products`
- **Đánh giá**: `/staff/reviews`
- **Khiếu nại**: `/staff/complaints`
- **Thông báo**: `/staff/notifications`
- **Báo cáo**: `/staff/reports`

## 🗄️ Cấu trúc cơ sở dữ liệu

### Bảng chính
- **nguoi_dung**: Thông tin người dùng (customer/staff)
- **san_pham**: Danh sách sản phẩm
- **gio_hang**: Giỏ hàng khách hàng
- **don_hang**: Đơn hàng
- **danh_gia**: Đánh giá sản phẩm
- **khieu_nai**: Khiếu nại khách hàng
- **thong_bao**: Thông báo hệ thống

## 🎨 Giao diện

### Khách hàng
- **Responsive design** với Bootstrap 5
- **Slider banner** tự động chuyển
- **Card layout** cho sản phẩm
- **Form validation** client-side
- **Modal dialogs** cho các thao tác

### Nhân viên
- **Sidebar navigation** cố định
- **Dashboard widgets** thống kê
- **Data tables** với pagination
- **Form controls** cho quản lý
- **Alert notifications** real-time

## 🔒 Bảo mật

- **Session management** cho đăng nhập
- **Password hashing** với MD5
- **Input validation** server-side
- **SQL injection prevention** với PreparedStatement
- **XSS protection** với JSTL

## 🚀 Tính năng nổi bật

### 1. Hệ thống đánh giá
- Xếp hạng sao từ 1-5
- Viết đánh giá chi tiết
- Phản hồi từ nhân viên
- Hiển thị đánh giá trung bình

### 2. Quản lý kho hàng
- Kiểm tra tồn kho real-time
- Cảnh báo sản phẩm sắp hết hàng
- Cập nhật số lượng tự động

### 3. Hệ thống khiếu nại
- Gửi khiếu nại theo đơn hàng
- Yêu cầu trả hàng
- Phản hồi từ nhân viên
- Theo dõi trạng thái

### 4. Dashboard thống kê
- Đơn hàng gần đây
- Sản phẩm sắp hết hàng
- Thống kê doanh thu
- Biểu đồ trực quan

## 🐛 Xử lý lỗi

### Lỗi thường gặp
1. **Lỗi kết nối database**: Kiểm tra thông tin kết nối trong `CSDLUtill.java`
2. **Lỗi 404**: Kiểm tra URL mapping trong `web.xml`
3. **Lỗi encoding**: Đảm bảo UTF-8 trong database và application
4. **Lỗi Tomcat**: Kiểm tra version compatibility

### Debug
- Kiểm tra log Tomcat: `logs/catalina.out`
- Console output trong IDE
- Browser Developer Tools

## 📝 Ghi chú phát triển

### Cải tiến có thể thực hiện
- [ ] Thêm tính năng thanh toán online
- [ ] Tích hợp email notification
- [ ] Thêm tính năng wishlist
- [ ] Tối ưu hóa performance
- [ ] Thêm unit tests
- [ ] Docker containerization

### Best practices đã áp dụng
- ✅ MVC architecture
- ✅ DAO pattern
- ✅ Prepared statements
- ✅ Session management
- ✅ Input validation
- ✅ Responsive design

## 📞 Hỗ trợ

Nếu gặp vấn đề trong quá trình cài đặt hoặc sử dụng, vui lòng:
1. Kiểm tra phần "Xử lý lỗi" trong README
2. Tạo issue trên GitHub
3. Liên hệ qua email: levanduy2605204@gmail.com




