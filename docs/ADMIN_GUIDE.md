# Hướng dẫn phần Admin - Quy chuẩn bảo dưỡng

## Mục đích

Admin tạo quy chuẩn bảo dưỡng cho từng dòng xe. Mỗi quy chuẩn cho biết sau bao nhiêu tháng kể từ ngày người dùng bắt đầu sử dụng xe thì cần bảo dưỡng.

Ví dụ: xe Honda Wave có quy chuẩn `Thay nhớt định kỳ`, số tháng là `3`. Nếu người dùng bắt đầu sử dụng xe ngày 02/11/2026, ngày cần bảo dưỡng là 02/02/2027.

## Luồng xử lý

1. Admin chọn hãng xe.
2. Hệ thống tải các dòng xe thuộc hãng đó.
3. Admin chọn dòng xe.
4. Hệ thống tải các quy chuẩn thuộc dòng xe.
5. Khi thêm hoặc sửa, Admin nhập tên quy chuẩn, số tháng và mô tả.
6. Khi người dùng cần xem lịch bảo dưỡng, ngày cần bảo dưỡng được tính bằng `NgayBatDauSuDung.AddMonths(SoThang)`.

## Kiến thức cần trình bày khi vấn đáp

- `QuyChuanBaoDuong` có khóa ngoại `DongXeId`, biểu diễn quan hệ một dòng xe có nhiều quy chuẩn.
- `AppDbContext` khai báo `DbSet<QuyChuanBaoDuong>` để EF Core làm việc với bảng dữ liệu.
- LINQ `Where` lọc quy chuẩn theo dòng xe và từ khóa tìm kiếm.
- LINQ `OrderBy` sắp xếp quy chuẩn theo số tháng.
- Migration giúp thay đổi cấu trúc database từ `SoKm`, `ChiPhi` sang `SoThang` mà vẫn được lưu thành lịch sử source code.
