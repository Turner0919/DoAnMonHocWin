# Quy tắc làm việc cho AI trong dự án MotorbikeServices

Đọc `docs/AI_HANDOVER.md` trước khi phân tích hoặc đề xuất thay đổi.

1. Trước mọi sửa đổi: đọc các file liên quan, giải thích nguyên nhân, phương án và file sẽ đổi; chờ Khánh xác nhận.
2. Không xóa file, dữ liệu, bảng hoặc cột nếu chưa có xác nhận rõ ràng riêng cho việc xóa.
3. Không tự sửa phần việc của Hào hoặc phần ngoài phạm vi được duyệt. Nếu có xung đột, báo và chờ quyết định.
4. Giữ kiến trúc 3 lớp hiện tại. Ưu tiên KISS và “make it work”; code đơn giản, bám nội dung môn Lập trình Windows, dễ giải thích khi vấn đáp.
5. Class, biến và hàm: tiếng Việt không dấu. Comment, label, MessageBox: tiếng Việt có dấu.
6. Không tự commit hoặc push. Không dùng thao tác Git phá hủy như reset/checkout để làm sạch source.
7. Khi thay đổi có ảnh hưởng database: cập nhật Model, `AppDbContext`, migration EF Core và `MotorbikeServices_SeedData.sql` theo phạm vi cần thiết. Seed phải chạy lặp lại được và không trùng dữ liệu.
8. Khi xong một chặng: build phần liên quan, nêu checklist test thủ công, cập nhật `docs/PROGRESS.md`; nếu liên quan Admin thì cập nhật `docs/ADMIN_GUIDE.md`.
9. Báo lỗi/phát hiện bất ngờ ngay khi thấy và chờ Khánh chọn hướng xử lý.
