# Bàn giao dự án cho AI mới

## 1. Mục tiêu dự án

Đây là đồ án WinForms môn Lập trình Windows của Hutech, đề tài **Quản lý và bảo dưỡng xe máy tiện ích cho người dùng**. Ứng dụng giúp người dùng quản lý xe, xem quy chuẩn bảo dưỡng theo dòng xe, biết ngày nên bảo dưỡng và tìm cửa hàng đang mở.

## 2. Công nghệ và kiến trúc

- C#, .NET 10, WinForms, Visual Studio 2022.
- SQL Server/SSMS; database mặc định: `MotorbikeServices` trên `localhost`.
- EF Core 9, LINQ, kiến trúc 3 lớp:
  - `MotorbikeServices`: DAL, Models, `AppDbContext`, Migrations.
  - `MotorbikeServices.BLL`: DTOs và Services.
  - `MotorbikeServices.GUI`: Form, UserControl và giao diện WinForms.
- Solution: `DoAnQuanLyXeMay/DoAnQuanLyXeMay.slnx`.
- File dựng database và seed: `MotorbikeServices_SeedData.sql`.

## 3. Các vai trò và dữ liệu chính

- **Admin**: quản lý hãng xe, dòng xe, quy chuẩn bảo dưỡng, xem/quản lý tài khoản.
- **User**: đăng ký, quản lý thông tin/xe và xem quy chuẩn bảo dưỡng.
- **Nhân viên**: thông tin cửa hàng, trạng thái `Đang hoạt động` / `Tạm ngừng hoạt động`, sản phẩm và thống kê cửa hàng.
- `HoaDon` và `ChiTietHoaDon` là luồng đăng ký bảo dưỡng hiện tại của User. Không tạo bảng `PhieuBaoDuong` trùng lặp khi chưa có quyết định thay đổi kiến trúc.
- `HoaDon` có User, cửa hàng/nhân viên, ngày tạo, tổng tiền và trạng thái `Chờ xác nhận`, `Đã hoàn thành`, `Đã hủy`.
- Quy chuẩn `QuyChuanBaoDuong` thuộc một `DongXe` qua `DongXeId`; gồm `TenQuyChuan`, `SoThang`, `MoTa`.
- Cách tính ngày cần bảo dưỡng: `NgayBatDauSuDung.AddMonths(SoThang)`.
- Cửa hàng dùng `NhanVienUse`, liên kết nhân viên bằng `NhanVienId`; địa chỉ dùng `DiaChiId`; trạng thái hiện là chuỗi `Đang hoạt động` hoặc `Tạm ngừng hoạt động`.

## 4. Quy tắc bắt buộc khi hỗ trợ dự án

1. Trước khi sửa code: đọc file liên quan, giải thích vấn đề, phương án và danh sách file sẽ đổi; **chờ Khánh xác nhận**.
2. Chỉ sửa đúng phạm vi đã được xác nhận. Nếu phát hiện lỗi hoặc xung đột ngoài phạm vi, báo lại và chờ quyết định.
3. Không xóa file, bảng, cột hoặc dữ liệu khi chưa được xác nhận riêng.
4. Giữ kiến trúc hiện tại, ưu tiên KISS và “make it work”. Code phải cơ bản, bám kiến thức môn học để nhóm dễ trình bày vấn đáp.
5. Tên class, biến, hàm dùng **tiếng Việt không dấu**. Chú thích, nhãn giao diện và MessageBox dùng tiếng Việt có dấu.
6. Không tự commit/push. Nhóm đang làm trực tiếp nhánh `main`; kiểm tra thay đổi hiện có để không đè code người khác.
7. Mỗi chặng có liên quan dữ liệu phải cập nhật `MotorbikeServices_SeedData.sql`, dùng tiếng Việt có dấu, chạy lặp lại không tạo bản ghi trùng.
8. Khi hoàn thành chặng: build, nêu checklist test thủ công và cập nhật `docs/PROGRESS.md`; nếu liên quan Admin thì cập nhật `docs/ADMIN_GUIDE.md`.

## 5. Trạng thái đã hoàn thành

- Quy chuẩn bảo dưỡng đã đổi từ `SoKm`/`ChiPhi` sang `SoThang`.
- Admin đã hiển thị/thêm/sửa quy chuẩn theo tháng; nút thêm User trên quản lý tài khoản Admin đã ẩn.
- Migration: `20261102074623_DoiQuyChuanTheoThang`.
- SQL seed có thể tạo database mới hoặc đồng bộ database tạo dở; có hãng, dòng xe, quy chuẩn riêng theo dòng xe, địa chỉ, 12 tài khoản demo, cửa hàng, sản phẩm, hóa đơn và chi tiết hóa đơn mẫu.
- Tài khoản demo: `hao_admin`, `khanh_admin`, `vu_admin`, `tung_admin`; tương tự hậu tố `_user` và `_emp`. Mật khẩu tất cả là `12345678`.
- Đã có màn hình **Thống kê** cho Nhân viên: đơn chờ xác nhận, đơn đã hoàn thành, doanh thu tháng, số sản phẩm tồn `<= 5` và biểu đồ cột theo trạng thái. Service: `ThongKeNhanVienService`.

## 6. Việc ưu tiên tiếp theo

1. Hoàn thiện Nhân viên: danh sách hóa đơn bảo dưỡng, xác nhận/hoàn thành đơn và có thể bổ sung top sản phẩm theo số lượng dùng.
2. Tái sử dụng truy vấn thống kê để làm Dashboard Admin: tổng đơn, đơn theo trạng thái, doanh thu tháng và top cửa hàng.
3. Hoàn thiện User để xem/lọc các cửa hàng có trạng thái `Đang hoạt động`, ưu tiên cùng phường/xã rồi cùng tỉnh/thành.
4. Khi thêm bảng/cột: cập nhật Model, `AppDbContext`, migration EF Core, seed SQL, BLL, GUI theo đúng luồng.

## 7. Cách kiểm tra nhanh

1. Chạy `MotorbikeServices_SeedData.sql` bằng SSMS.
2. Mở solution bằng Visual Studio 2022 hoặc build GUI:
   `dotnet build DoAnQuanLyXeMay/MotorbikeServices.GUI/MotorbikeServices.GUI.csproj --no-restore -m:1`.
3. Đăng nhập theo đúng vai trò tương ứng bằng một trong các tài khoản demo.
4. Đăng nhập `khanh_emp` / `12345678`, chọn menu **Thống Kê** và kiểm tra: 1 đơn chờ, 2 đơn hoàn thành, 1 đơn hủy, doanh thu tháng 245.000 đ.

## 8. Lưu ý để vấn đáp

- EF Core mapping Model thành bảng, `DbSet` để truy vấn và migration để lưu lịch sử đổi schema.
- Khóa ngoại: một hãng có nhiều dòng xe; một dòng xe có nhiều quy chuẩn; một nhân viên có một hồ sơ cửa hàng, nhiều sản phẩm và nhiều hóa đơn.
- LINQ dùng `Where`, `OrderBy`, `Any`, `FirstOrDefault` để lọc/kiểm tra/truy vấn dữ liệu.
- Thống kê Nhân viên dùng `Count` để đếm đơn theo trạng thái/tồn kho thấp, `Where` để lọc và `Sum` để tính doanh thu của các đơn hoàn thành trong tháng.
- Cần giải thích luồng UI → Service (BLL) → `AppDbContext` (DAL) → SQL Server.
