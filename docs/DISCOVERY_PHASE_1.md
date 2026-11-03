\# Báo cáo Discovery – MotorbikeServices (read-only)



\*\*Phạm vi đã kiểm tra:\*\* 5 tài liệu bắt buộc, solution, 3 file `.csproj`, `AppDbContext`, 14 Model, 14 migration và snapshot, 13 Service trong BLL, phần code-behind chính của GUI, `App.config` (chỉ xem tên key) và cấu trúc `MotorbikeServices\_SeedData.sql`.



\*\*Chưa kiểm tra:\*\* các file `\*.Designer.cs` (chỉ dò vài dòng gắn sự kiện), nội dung từng DTO, chi tiết `UcAccount`, `FormNhapTaiKhoan`, `frmttcn`, `BieuDoThongKeControl`, phần dữ liệu seed từ dòng 140 đến 605, file PDF đề môn học và `tmp/`.



\*\*Chưa thực hiện:\*\* chưa build, chưa chạy ứng dụng, chưa kết nối SQL Server. Vì vậy mọi nhận định về hành vi lúc chạy chỉ ở mức INFERRED.



\---



\## 1. Executive Summary



\- \*\*VERIFIED:\*\* WinForms .NET 10 gồm 3 project: GUI → BLL → DAL. DAL dùng EF Core 9 (SqlServer), có 14 bảng và 14 migration.

\- \*\*VERIFIED:\*\* Có đủ 3 vai trò Admin, User, Nhân viên. Ngoài ra có các chức năng tài liệu chưa nhắc tới: chat AI (Gemini), gửi email khi duyệt đơn, xuất Excel, lịch bảo dưỡng riêng cho từng xe.

\- \*\*VERIFIED:\*\* Kiến trúc 3 lớp bị phá một phần. Năm màn hình Admin gọi thẳng `AppDbContext`, không qua BLL.

\- \*\*VERIFIED:\*\* Có 3 vấn đề logic nghiêm trọng:

&#x20; 1. Tồn kho bị trừ hai lần khi đặt đơn.

&#x20; 2. Trạng thái đơn không thống nhất: duyệt đơn ghi `"Đã duyệt"`, còn thống kê lại đếm `"Đã hoàn thành"`.

&#x20; 3. Seed SQL thiếu bảng `QuyChuanXeNguoiDungs`.

\- \*\*VERIFIED:\*\* Tài liệu lỗi thời ở nhiều chỗ: đường dẫn solution, migration mới nhất, cách tính ngày bảo dưỡng, menu "Thống kê".



\---



\## 2. Project Inventory



\### Solution và project (VERIFIED)



File solution: `MotorbikeServices.slnx` ở thư mục gốc.



| Project | Target | Tham chiếu | Package |

|---|---|---|---|

| `MotorbikeServices.DAL` | net10.0 | – | EFCore 9.0.0 (core, SqlServer, Design, Tools) |

| `MotorbikeServices.BLL` | net10.0 | DAL | Newtonsoft.Json 13.0.4, System.Configuration.ConfigurationManager 10.0.13 |

| `MotorbikeServices.GUI` | net10.0-windows (WinExe) | BLL \*\*và\*\* DAL | ClosedXML 0.105.1, ScottPlot.WinForms 5.0.56, EFCore.SqlServer/Design/Tools 9.0.0, Newtonsoft.Json |



Theo git status, thư mục cũ `DoAnQuanLyXeMay/` đang bị xóa (chưa commit) và `MotorbikeServices/` là thư mục mới chưa được track.



\### DAL – \[MotorbikeServices.DAL/Models](MotorbikeServices/MotorbikeServices.DAL/Models)

\- \*\*Account:\*\* `Admin`, `User`, `NhanVien`, `UserUse` (hồ sơ User)

\- \*\*Maintenance:\*\* `HangXe`, `DongXe`, `QuyChuanBaoDuong`, `QuyChuanXeNguoiDung`, `UserXe`, `DiaChi`

\- \*\*Store:\*\* `NhanVienUse` (hồ sơ cửa hàng), `SanPham`, `HoaDon`, `ChiTietHoaDon`

\- `AppDbContext`, 14 migration, `Class1.cs` (file trống còn sót lại)



\### BLL – Services (13)

`AuthService`, `UserService`, `UserXeService`, `QuanLyBaoDuongService`, `BaoDuongService`, `KiemTraDonService`, `CuaHangBaoDuongService`, `NhanVienUseService`, `SanPhamService`, `ThongKeNhanVienService`, `ThongKeTongQuanService`, `EmailService`, `GeminiService`.



\### BLL – DTOs (11)

`UserDTO`, `UserXeDTO`, `BaoDuongItemDTO`, `QuanLyBaoDuongDTO` (chứa `LichBaoDuongDTO`), `HoaDonKiemTraDTO` (chứa `ChiTietDichVuDTO`), `CuaHangBaoDuongDTO` (chứa `CuaHangChiTietDTO`), `NhanVienUseDTO`, `SanPhamDTO`, `ThongKeNhanVienDTO` (chứa `ThongKeTrangThaiDTO`), `ThongKeTongQuanDTO` (chứa `DuLieuBieuDoDTO`), `ChatDTO`.



Không có interface nào. Các service được tạo trực tiếp bằng `new`.



\### GUI

\- \*\*Form điều hướng theo vai trò:\*\* `frmlogin`, `frmaccountadmin`, `frmaccountuser`, `CuaHang/frmaccountnhanvien`

\- \*\*UserControl Admin:\*\* `UcDashboard`, `UcHangXe`, `UcQuyChuan`, `UcAccount`, `UcQuanLyCuaHang`, `BieuDoThongKeControl`

\- \*\*Form User:\*\* `frmttcn`, `formDangKyXe`, `AllUser/FormQuanLyBaoDuong`, `frmDangKyBaoDuongXe`, `FormKiemTraDonDaDat`, `FormAIChatUser`

\- \*\*Form Nhân viên:\*\* `FormThongTinCuaHang`, `FormQuanLySanPham`, `FormDanhSachBaoDuong`, `FormThongKeNhanVien`

\- \*\*Dialog dùng chung:\*\* `frmsignup`, `frmchangepassword`, `frmThemHangXe`, `frmThemDongXe`, `FormNhapQuyChuan`, `FormNhapTaiKhoan`

\- \*\*Cấu hình:\*\* `App.config` với các key `GeminiApiKey`, `SmtpEmail`, `SmtpPassword`. Hai key bí mật hiện để trống.



\---



\## 3. System Architecture



```mermaid

flowchart LR

&#x20; GUI\[GUI WinForms] -->|new XxxService| BLL\[BLL Services + DTOs]

&#x20; BLL -->|using var db = new AppDbContext| DAL\[DAL: AppDbContext + Models]

&#x20; GUI -.->|"gọi trực tiếp (vi phạm 3 lớp)"| DAL

&#x20; DAL -->|EF Core SqlServer| SQL\[(SQL Server localhost/MotorbikeServices)]

&#x20; BLL -->|SMTP gmail:587| Mail\[Gmail]

&#x20; BLL -->|HTTPS| Gemini\[Google Gemini API]

```



\- \*\*Kết nối (VERIFIED):\*\* Chuỗi kết nối được viết cứng trong `AppDbContext.OnConfiguring`: `Server=localhost;Database=MotorbikeServices;Trusted\_Connection=True;TrustServerCertificate=True`. Không đọc từ file cấu hình và không dùng Dependency Injection.

\- \*\*Vòng đời DbContext (VERIFIED):\*\* Mỗi method trong service mở một `using (var db = new AppDbContext())` riêng. Đây là kiểu "short-lived context", đơn giản và dễ trình bày khi vấn đáp.

\- \*\*Truy vấn (VERIFIED):\*\* LINQ to Entities với `Where`, `Include`/`ThenInclude`, `FirstOrDefault`, `Any`, `GroupBy`, cú pháp `join … group … into` (trong `ThongKeTongQuanService`) và `ToDictionary`.

\- \*\*Ghi dữ liệu (VERIFIED):\*\* Theo mẫu change tracking: `Add`/`Remove` hoặc sửa thuộc tính entity, rồi gọi `SaveChanges()`. Có transaction tường minh (`Database.BeginTransaction`) ở 3 chỗ: `BaoDuongService.DatHangBaoDuong`, `KiemTraDonService.HuyDonHang`, `CuaHangBaoDuongService.HuyDonHangPhiaCuaHang`.

\- \*\*Vi phạm 3 lớp (VERIFIED):\*\* `UcAccount`, `UcHangXe`, `UcQuyChuan`, `FormNhapQuyChuan`, `frmThemDongXe` gọi `new AppDbContext()` ngay trong GUI. Tổng số chỗ gọi lần lượt là 4 + 8 + 7 + 1 + 1.

\- \*\*Khởi động (VERIFIED):\*\* \[Program.cs](MotorbikeServices/MotorbikeServices.GUI/Program.cs) mở \*\*hai\*\* `frmlogin` trên hai luồng STA. Theo comment, việc này có chủ đích (INFERRED: để demo nhiều vai trò cùng lúc).



\---



\## 4. Functional Map



Ghi chú: mọi mục dưới đây chỉ là \*\*implementation evidence\*\*. Chưa có runtime verification.



\### Chức năng dùng chung

| Chức năng | GUI | Service | Bảng | Luồng chính |

|---|---|---|---|---|

| Đăng nhập | `frmlogin` | `AuthService.DangNhap` | Admins / Users / NhanViens | Chọn vai trò trong combobox → so khớp tài khoản và mật khẩu dạng plaintext → mở form theo vai trò bằng `ShowDialog` |

| Đăng ký | `frmsignup` | `DangKyAdmin` / `DangKyUser` / `DangKyNhanVien` | như trên | Admin cần key `ADMIN\_KEY`, Nhân viên cần `NHANVIEN\_KEY` (đều viết cứng trong code). Tên tài khoản được kiểm tra trùng trên cả 3 bảng |

| Quên mật khẩu | `frmchangepassword` | `LayCauHoiBaoMat`, `KiemTraDapAnBaoMat`, `DatLaiMatKhau` | Users, NhanViens | Dùng câu hỏi bảo mật. Admin không dùng được vì link bị tắt và bảng Admin không có câu hỏi |



\### Admin (`frmaccountadmin`)

| Chức năng | GUI | Xử lý | Bảng |

|---|---|---|---|

| Dashboard | `UcDashboard`, `BieuDoThongKeControl` | `ThongKeTongQuanService` (đếm hãng, dòng xe, quy chuẩn, tài khoản; dòng xe theo hãng (top 8); quy chuẩn theo chu kỳ; cửa hàng theo trạng thái) | nhiều bảng |

| Hãng xe / Dòng xe | `UcHangXe`, `frmThemHangXe`, `frmThemDongXe` | \*\*Không qua BLL\*\*, gọi trực tiếp DbContext | HangXes, DongXes |

| Quy chuẩn bảo dưỡng | `UcQuyChuan`, `FormNhapQuyChuan` | \*\*Không qua BLL\*\* | QuyChuanBaoDuongs |

| Tài khoản (xem, sửa, xóa User) | `UcAccount`, `FormNhapTaiKhoan` | \*\*Không qua BLL\*\*. Có `ThemUser` dùng transaction. `XoaUser` kiểm tra User còn xe hoặc hóa đơn trước khi xóa | Admins, Users, NhanViens, UserUses |

| Quản lý cửa hàng (đổi trạng thái) | `UcQuanLyCuaHang` | `NhanVienUseService.GetDanhSachCuaHang`, `CapNhatTrangThaiCuaHang` | NhanVienUses |

| Nút "Hỏi AI" | `btnHoiAI` | Handler trống, bấm không có tác dụng | – |



\### User (`frmaccountuser`)

| Chức năng | GUI | Service / DTO | Bảng |

|---|---|---|---|

| Thông tin cá nhân + địa chỉ | `frmttcn` | `UserService.SaveOrUpdateProfile` (thêm mới nếu chưa có, ngược lại cập nhật) | UserUses, DiaChis |

| Đăng ký xe | `formDangKyXe` | `UserXeService` (CRUD), `UserXeDTO` | UserXes |

| Lịch bảo dưỡng | `FormQuanLyBaoDuong` | `QuanLyBaoDuongService.GetLichBaoDuongByXe`: lần đầu xem sẽ copy quy chuẩn của dòng xe sang `QuyChuanXeNguoiDungs`. Ngày tiếp theo = `NgayBaoDuongLanCuoi.AddMonths(SoThang)`. Cảnh báo: quá hạn / ≤ 5 ngày / còn hạn. Hàm `CapNhatNgayBaoDuong` dùng để cập nhật ngày | QuyChuanXeNguoiDungs, QuyChuanBaoDuongs |

| Đăng ký bảo dưỡng (giỏ hàng) | `frmDangKyBaoDuongXe` | `BaoDuongService`: lọc cửa hàng `"Đang hoạt động"` có \*\*cùng Tỉnh/TP và Phường/Xã\*\*, giữ hàng (`TruKhoTamThoi`), đặt hàng (`DatHangBaoDuong`), `BaoDuongItemDTO` | HoaDons, ChiTietHoaDons, SanPhams |

| Kiểm tra / hủy đơn | `FormKiemTraDonDaDat` | `KiemTraDonService`: chỉ cho hủy khi đơn đang `"Chờ xác nhận"` và có hoàn trả kho | HoaDons |

| Chat AI | `FormAIChatUser` | `GeminiService` + `QuanLyBaoDuongService.GetThongTinBaoDuongUserForAI`: gửi thông tin xe, lịch và đơn của User vào prompt | – |



\### Nhân viên / Cửa hàng (`frmaccountnhanvien`)

| Chức năng | GUI | Service | Bảng |

|---|---|---|---|

| Thông tin cửa hàng | `FormThongTinCuaHang` | `NhanVienUseService.CapNhatThongTinCuaHang` | NhanVienUses, DiaChis |

| Sản phẩm | `FormQuanLySanPham` | `SanPhamService` (CRUD, `MaSP` không trùng trong cùng cửa hàng, không cho sửa `MaSP`) | SanPhams |

| Danh sách đơn, duyệt, hủy | `FormDanhSachBaoDuong` | `CuaHangBaoDuongService.DuyetDonHang` (đổi trạng thái → `"Đã duyệt"`) rồi `EmailService.SendEmailXacNhanDonAsync`. Hủy đơn có hoàn trả kho | HoaDons, UserUses |

| Thống kê | `FormThongKeNhanVien` (ScottPlot) | `ThongKeNhanVienService.LayThongKe` | HoaDons |

| Xuất Excel sản phẩm | menu `mnuThongKe` ("Thống kê") | `SanPhamService` + ClosedXML | SanPhams |



\---



\## 5. Database Map



```mermaid

erDiagram

&#x20; HangXes ||--o{ DongXes : HangXeId

&#x20; DongXes ||--o{ QuyChuanBaoDuongs : DongXeId

&#x20; DongXes ||--o{ UserXes : DongXeId

&#x20; Users ||--o{ UserXes : UserId

&#x20; Users ||--o{ UserUses : UserId

&#x20; DiaChis |o--o{ UserUses : DiaChiId

&#x20; UserXes ||--o{ QuyChuanXeNguoiDungs : UserXeId

&#x20; QuyChuanBaoDuongs ||--o{ QuyChuanXeNguoiDungs : QuyChuanBaoDuongId

&#x20; NhanViens ||--o| NhanVienUses : "NhanVienId (PK=FK)"

&#x20; DiaChis |o--o{ NhanVienUses : DiaChiId

&#x20; NhanVienUses ||--o{ SanPhams : NhanVienId

&#x20; NhanVienUses ||--o{ HoaDons : NhanVienId

&#x20; Users ||--o{ HoaDons : UserId

&#x20; HoaDons ||--o{ ChiTietHoaDons : HoaDonId

&#x20; SanPhams ||--o{ ChiTietHoaDons : SanPhamId

&#x20; Admins

```



\- \*\*Bảng (VERIFIED, 14):\*\* Admins, Users, NhanViens, UserUses, DiaChis, NhanVienUses, SanPhams, UserXes, HoaDons, ChiTietHoaDons, HangXes, DongXes, QuyChuanBaoDuongs, QuyChuanXeNguoiDungs.

\- \*\*Khóa chính:\*\* tất cả là `Id` kiểu identity, riêng `NhanVienUses` dùng `NhanVienId` vừa là PK vừa là FK nên tạo quan hệ 1-1 thật sự.

\- \*\*Quan hệ UserUses:\*\* `UserUses.UserId` chỉ có index thường, không có unique. Về schema đây là 1-n, còn ràng buộc 1-1 chỉ nằm trong logic code (INFERRED).

\- \*\*Unique index:\*\* chỉ có `Admins.TenTaiKhoan` và `Users.TenTaiKhoan`. \*\*`NhanViens.TenTaiKhoan` không có unique index.\*\*

\- \*\*Kiểu tiền:\*\* `decimal(18,2)` cho `DonGia` và `TongTien`.

\- \*\*Hành vi xóa theo snapshot (VERIFIED):\*\*



| Quan hệ | OnDelete |

|---|---|

| DongXes → HangXes | Cascade |

| QuyChuanBaoDuongs → DongXes | Restrict |

| UserXes → DongXes, UserXes → Users | Cascade |

| QuyChuanXeNguoiDungs → UserXes | NoAction |

| QuyChuanXeNguoiDungs → QuyChuanBaoDuongs | Cascade |

| ChiTietHoaDons → SanPhams | Restrict |

| Các quan hệ còn lại | Cascade |



\- \*\*Cách EF Core mapping:\*\* kết hợp Data Annotations (`\[Key]`, `\[Required]`, `\[StringLength]`, `\[ForeignKey]`) với Fluent API trong `OnModelCreating`. Cấu hình `QuyChuanBaoDuong → DongXe` bị khai báo \*\*hai lần\*\* (trùng lặp nhưng không gây lỗi).

\- \*\*Lịch sử migration (VERIFIED):\*\* StartUpOne (20/10) → HangXe/DongXe → LoaiXe → UserUse → UserXe → QuyChuan → RebuildQuyChuan (bỏ `LoaiXe`, thêm FK `DongXeId`) → NhanVien → DiaChi + NhanVienUse → SanPham → địa chỉ người dùng → HoaDon/ChiTiet → DoiQuyChuanTheoThang (bỏ `SoKm`/`ChiPhi`, thêm `SoThang`) → \*\*AddQuyChuanXeNguoiDung (03/11)\*\*.



\### Vai trò của `MotorbikeServices\_SeedData.sql` (VERIFIED)

\- Script 605 dòng làm các việc sau, có kiểm tra tồn tại nên chạy lặp lại được: tạo database nếu chưa có, tạo bảng bằng `IF OBJECT\_ID … IS NULL`, tạo index/FK bằng `IF NOT EXISTS`, ghi 13 dòng vào `\_\_EFMigrationsHistory`, sau đó seed dữ liệu.

\- Script \*\*không tạo bảng `QuyChuanXeNguoiDungs`\*\* và \*\*không ghi migration `20261103075103`\*\*. File `tmp/sql/MotorbikeServices\_Migrations\_Idempotent.sql` cũng không có bảng này.

\- FK `DongXes → HangXes` trong seed \*\*không có ON DELETE CASCADE\*\*, khác với snapshot. Seed còn dùng `WITH NOCHECK`, nên ràng buộc không được kiểm tra với dữ liệu đã có sẵn.

\- Hóa đơn mẫu có các trạng thái `Đã hoàn thành` ×2, `Chờ xác nhận`, `Đã hủy`, đặt ngày trong tháng hiện tại.



\*\*Giới hạn:\*\* chưa đối chiếu được schema thật trên SQL Server. Hiện không biết database local đang được tạo từ migration hay từ seed, và đã có bảng `QuyChuanXeNguoiDungs` hay chưa.



\---



\## 6. Documentation Gap Analysis



\### Chính xác (VERIFIED khớp code)

\- Kiến trúc 3 project, EF Core 9, chuỗi kết nối localhost.

\- `QuyChuanBaoDuong` gồm `DongXeId`, `TenQuyChuan`, `SoThang`, `MoTa`.

\- Hai trạng thái cửa hàng `Đang hoạt động` / `Tạm ngừng hoạt động`.

\- `HoaDon`/`ChiTietHoaDon` là luồng đăng ký bảo dưỡng.

\- `ThongKeNhanVienService` tồn tại và đếm đơn theo 3 trạng thái.



\### Lỗi thời hoặc mâu thuẫn với source

| Tài liệu nói | Source thực tế |

|---|---|

| Solution `DoAnQuanLyXeMay/DoAnQuanLyXeMay.slnx`, lệnh build `DoAnQuanLyXeMay/MotorbikeServices.GUI/...` | `MotorbikeServices.slnx` ở gốc, project nằm trong `MotorbikeServices/`. Lệnh build trong `AI\_HANDOVER` §7 trỏ sai đường dẫn |

| Project DAL tên là `MotorbikeServices` | Tên thật là `MotorbikeServices.DAL` |

| Migration mới nhất là `DoiQuyChuanTheoThang` | Đã có thêm `20261103075103\_AddQuyChuanXeNguoiDung` |

| Ngày bảo dưỡng = `NgayBatDauSuDung.AddMonths(SoThang)` (cả 3 tài liệu) | Không có trường `NgayBatDauSuDung`. Code dùng `QuyChuanXeNguoiDung.NgayBaoDuongLanCuoi` (giá trị ban đầu lấy từ `UserXe.NgayMuaXe`) |

| "Chọn menu \*\*Thống Kê\*\*" để xem thống kê | Menu `mnuThongKe` ("Thống kê") thực ra \*\*xuất file Excel sản phẩm\*\*. Màn hình thống kê mở khi đăng nhập và khi bấm "Trang Chủ" (\[frmaccountnhanvien.cs:25](MotorbikeServices/MotorbikeServices.GUI/Setup/CuaHang/frmaccountnhanvien.cs:25), \[:48](MotorbikeServices/MotorbikeServices.GUI/Setup/CuaHang/frmaccountnhanvien.cs:48), \[:66](MotorbikeServices/MotorbikeServices.GUI/Setup/CuaHang/frmaccountnhanvien.cs:66)) |

| "Doanh thu tháng" | `TongDoanhThu` cộng \*\*mọi\*\* đơn `Đã hoàn thành`, không lọc theo tháng. Số liệu demo vẫn khớp chỉ vì seed đặt ngày trong tháng hiện tại |

| Trạng thái `HoaDon` gồm 3 giá trị | Code còn dùng thêm `"Đã duyệt"` (\[CuaHangBaoDuongService.cs:87](MotorbikeServices/MotorbikeServices.BLL/Services/CuaHangBaoDuongService.cs:87)) |

| Việc tiếp theo: danh sách hóa đơn cho NV, Dashboard Admin, User lọc cửa hàng | Cả ba đã có trong code, nhưng khác thiết kế: duyệt đơn → `Đã duyệt`; Dashboard thống kê danh mục chứ không phải doanh thu; lọc cửa hàng yêu cầu trùng hẳn phường, không ưu tiên phường rồi mới tới tỉnh |

| "Nhóm làm trực tiếp trên `main`" | Nhánh hiện tại là `DaoDuyKhanh` |



\### Có trong source nhưng tài liệu chưa ghi nhận

Chat AI (Gemini), gửi email xác nhận khi duyệt đơn, xuất Excel, lịch bảo dưỡng riêng cho từng xe (`QuyChuanXeNguoiDung`), User tự hủy đơn có hoàn kho, cơ chế giỏ hàng giữ hàng, Admin quản lý trạng thái cửa hàng, Admin Dashboard bằng ScottPlot, đăng ký tài khoản bằng key, quên mật khẩu bằng câu hỏi bảo mật, chế độ mở 2 cửa sổ đăng nhập.



\### Chưa đủ bằng chứng

\- Nút thêm User đã bị ẩn trong `UcAccount`: chưa xem Designer.

\- Số lượng seed (20 hãng, 50 dòng, 12 tài khoản…): REPORTED, chưa đếm.

\- Thẻ "tồn ≤ 5" lấy dữ liệu ở đâu: không thấy trong `ThongKeNhanVienService`, chưa đọc `FormThongKeNhanVien`.

\- "Build 0 lỗi": REPORTED, chưa build lại.



\---



\## 7. Initial Technical Findings



\### Nghiêm trọng – Business logic

1\. \*\*Tồn kho bị trừ hai lần (VERIFIED).\*\* Khi bấm "Thêm", \[frmDangKyBaoDuongXe.cs:276](MotorbikeServices/MotorbikeServices.GUI/Setup/frmDangKyBaoDuongXe.cs:276) đã gọi `TruKhoTamThoi` trừ kho trong DB. Sau đó `DatHangBaoDuong` lại kiểm tra `SoLuongTon < item.SoLuong` trên số tồn \*\*đã bị trừ\*\* và trừ thêm một lần nữa. Hệ quả (INFERRED):

&#x20;  - Tồn kho giảm gấp đôi số lượng đặt.

&#x20;  - Đặt hết số hàng còn lại sẽ bị báo "không đủ số lượng".

&#x20;  - Nếu ứng dụng tắt đột ngột, hàng đã giữ không được trả lại kho.

2\. \*\*Vòng đời trạng thái đơn không khép kín (VERIFIED).\*\* Không có chỗ nào ghi `"Đã hoàn thành"`. Duyệt đơn chỉ ghi `"Đã duyệt"`. Vì vậy với đơn tạo thật lúc chạy, doanh thu và số đơn hoàn thành luôn bằng 0, và đơn đã duyệt không xuất hiện trên biểu đồ. Ngoài ra `HuyDonHangPhiaCuaHang` cho phép hủy cả đơn đã duyệt hoặc đã hoàn thành.

3\. \*\*Seed thiếu bảng `QuyChuanXeNguoiDungs` (VERIFIED).\*\* Nếu database chỉ được tạo bằng seed, màn hình lịch bảo dưỡng và chat AI sẽ lỗi khi truy vấn bảng này (INFERRED).



\### Database design

\- \*\*Có thể không xóa được xe (INFERRED).\*\* Sau khi User mở lịch bảo dưỡng, xe đã có bản ghi trong `QuyChuanXeNguoiDungs`. FK sang `UserXes` là `NoAction`, nên `UserXeService.XoaXe` sẽ gặp lỗi FK, và lỗi này không được bắt.

\- \*\*Xóa dòng xe có thể kéo theo xóa xe của người dùng (INFERRED).\*\* `btnXoaDongXe` không kiểm tra ràng buộc trước khi xóa. FK `UserXes → DongXes` là Cascade, nên xóa dòng xe có thể xóa luôn xe của người dùng. Tình huống này chỉ xảy ra khi dòng xe không có quy chuẩn (vì FK quy chuẩn là Restrict).

\- \*\*Xóa quy chuẩn gốc làm mất lịch sử bảo dưỡng.\*\* FK sang `QuyChuanXeNguoiDungs` là Cascade nên các bản ghi lịch sử bảo dưỡng của người dùng bị xóa theo.

\- \*\*Trạng thái lưu dạng chuỗi tự do.\*\* Không có CHECK constraint hay enum nên dễ lệch chính tả.

\- \*\*Đặt tên dễ gây nhầm.\*\* `HoaDon.NhanVienId` thực chất trỏ tới cửa hàng (`NhanVienUse`). `ChiTietHoaDon.TenXe` được ghép từ `HangXe` và `LoaiXe`, nhưng trên GUI `LoaiXe` lại chứa tên dòng xe.

\- \*\*Ba bảng tài khoản tách rời.\*\* Tên tài khoản chỉ được giữ không trùng nhau nhờ code (`KiemTraTonTaiTaiKhoan`), DB không có ràng buộc. `NhanViens` còn thiếu cả unique index riêng.

\- \*\*Schema lệch giữa seed và snapshot\*\* (FK `DongXes → HangXes`, `WITH NOCHECK`).



\### Kiến trúc và tổ chức code

\- GUI tham chiếu thẳng DAL, và 5 màn hình Admin viết truy vấn ngay trong code-behind.

\- Không dùng interface hay DI. Chuỗi kết nối, `ADMIN\_KEY`/`NHANVIEN\_KEY` và email gửi mặc định đều viết cứng trong code.

\- `QuanLyBaoDuongService` lặp lại logic tính tình trạng bảo dưỡng ở hai method. `UserService` và `NhanVienUseService` trùng nhau phần lấy địa chỉ.

\- Còn code thừa: `Class1.cs` ở cả DAL và BLL, nhiều handler trống, một menu item không có chữ (`thốngKêToolStripMenuItem1`), comment `//hello` trong `AppDbContext`.

\- Namespace không đồng nhất: `HangXe`/`DongXe` nằm trong thư mục `Maintenance` nhưng namespace lại là `MotorbikeServices.DAL.Models`.



\### Bảo mật

\- Mật khẩu và đáp án bảo mật lưu dạng plaintext.

\- API key Gemini được gửi qua query string.

\- Dữ liệu cá nhân của User (xe, đơn) được gửi lên Google. Cần nêu rõ khi trình bày.

\- Tên model `gemini-3.5-flash-lite` chưa xác minh được là có tồn tại.



\### Khả năng giải thích khi vấn đáp

\- \*\*Điểm mạnh:\*\*

&#x20; - Service ngắn gọn, đặt tên tiếng Việt, đúng quy ước của nhóm.

&#x20; - Có transaction kèm rollback.

&#x20; - Có `Include`/`ThenInclude`, `GroupBy`, tách DTO, ScottPlot, ClosedXML, gọi async cho email và AI.

&#x20; - Lịch sử migration rõ ràng.

\- \*\*Rủi ro:\*\* giảng viên có thể hỏi về chỗ GUI gọi thẳng DbContext, trừ kho hai lần, trạng thái `Đã duyệt`/`Đã hoàn thành`, hoặc yêu cầu demo menu "Thống kê".



\---



\## 8. Recommended Next Steps (RECOMMENDED)



1\. \*\*Xác minh runtime (cần anh duyệt):\*\* build solution và dùng `sqlcmd` (đã có trên máy) chạy các truy vấn \*\*chỉ đọc\*\* để xem schema thật, `\_\_EFMigrationsHistory` và đã có bảng `QuyChuanXeNguoiDungs` hay chưa.

2\. Đọc phần còn lại chưa kiểm tra: Designer, `UcAccount`, `FormThongKeNhanVien`, `frmttcn`, phần dữ liệu seed, file PDF đề môn học (để đối chiếu với yêu cầu môn).

3\. Nhóm quyết định về 3 lỗi nghiêm trọng ở §7 (sửa hay chỉ giải thích khi bảo vệ), và về vòng đời trạng thái đơn chuẩn.

4\. Cập nhật lại tài liệu theo §6, sau khi được duyệt.

5\. Deep-dive từng module để làm tài liệu giảng giải và chuẩn bị câu hỏi vấn đáp.



Trong giai đoạn này tôi không tạo hay sửa file nào, không đụng Git và database.



\---

\*RevidAPI: hội thoại này đã dài \~128k token — mỗi câu hỏi đang tính lại toàn bộ lịch sử nên tốn nhiều credit. Gõ /compact để nén lịch sử, hoặc mở cuộc trò chuyện mới khi sang việc khác.\*

