# Tiến độ đồ án

## 02/11/2026 - Chặng 1: Quy chuẩn bảo dưỡng và tài khoản Admin

### Đã hoàn thành

- Đổi quy chuẩn bảo dưỡng từ `Số km` và `Chi phí` sang `Số tháng`.
- Cập nhật màn hình Admin để thêm, sửa, tìm kiếm và hiển thị quy chuẩn theo số tháng.
- Ẩn nút thêm tài khoản User trong phần quản lý tài khoản Admin.
- Tạo migration `DoiQuyChuanTheoThang`.
- Chuyển seed data thành script tự tạo database, đồng bộ được cả database tạo dở và thêm dữ liệu mẫu tiếng Việt có dấu.
- Mở rộng seed data: 20 hãng, 50 dòng xe, 5 quy chuẩn riêng theo từng dòng xe (mốc 1, 3, 6, 9, 12 tháng), 12 tài khoản demo, 4 cửa hàng và 8 sản phẩm.
- Tạo `docs/AI_HANDOVER.md` để AI mới nắm bối cảnh, quy tắc làm việc và phần việc tiếp theo.
- Build GUI, BLL và DAL thành công: 0 lỗi.

### Lưu ý database

- Migration xóa hai cột cũ `SoKm` và `ChiPhi`.
- Với quy chuẩn cũ, migration tạo `SoThang = 1` để dữ liệu vẫn hợp lệ.
- Sau khi cập nhật database, Admin cần sửa lại số tháng thực tế cho từng quy chuẩn cũ.
- Chưa chạy `database update` trên SQL Server local để tránh tự ý thay đổi dữ liệu đang dùng.

## 02/11/2026 - Chặng 2: Thống kê Nhân viên

### Đã hoàn thành

- Đồng bộ theo source mới: dùng `HoaDon` và `ChiTietHoaDon` làm luồng đăng ký bảo dưỡng, không tạo bảng phiếu trùng lặp.
- Thêm `ThongKeNhanVienService` và DTO để thống kê theo đúng cửa hàng/nhân viên đăng nhập.
- Thêm màn hình Thống kê trong menu Nhân viên với bốn thẻ: đơn chờ xác nhận, đơn hoàn thành, doanh thu tháng và sản phẩm tồn `<= 5`.
- Thêm biểu đồ cột ScottPlot thể hiện số đơn `Chờ xác nhận`, `Đã hoàn thành`, `Đã hủy`.
- Thống nhất trạng thái cửa hàng theo source Hào: `Đang hoạt động` / `Tạm ngừng hoạt động`.
- Cập nhật `MotorbikeServices_SeedData.sql` tạo bảng, khóa ngoại, migration history và bốn hóa đơn mẫu cho thống kê.
- Build GUI thành công: 0 lỗi.

### Checklist kiểm tra thủ công

1. Chạy `MotorbikeServices_SeedData.sql` bằng SSMS.
2. Đăng nhập vai trò Nhân viên bằng `khanh_emp` / `12345678`.
3. Chọn menu **Thống Kê**.
4. Kiểm tra bốn thẻ và biểu đồ có số liệu: 1 chờ xác nhận, 2 hoàn thành, 1 hủy; doanh thu tháng 245.000 đ.

### Việc tiếp theo

- Hoàn thiện danh sách hóa đơn bảo dưỡng cho Nhân viên để xác nhận và hoàn thành đơn.
- Sau đó tái sử dụng logic thống kê cho Dashboard Admin.
