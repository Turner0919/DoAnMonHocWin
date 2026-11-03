/*
    MotorbikeServices - Cài đặt database và seed data

    Chức năng:
      1. Tạo database MotorbikeServices nếu chưa tồn tại.
      2. Đồng bộ schema hiện tại, kể cả database tạo dở.
      3. Seed dữ liệu mẫu tiếng Việt có dấu: hãng/dòng xe, quy chuẩn riêng,
         tài khoản demo, cửa hàng, sản phẩm và dữ liệu hóa đơn mẫu.

    Cách dùng: Mở file bằng SSMS và Execute (F5).
    Có thể chạy lại nhiều lần trên database trống, đầy đủ hoặc tạo dở.
*/

IF DB_ID(N'MotorbikeServices') IS NULL
BEGIN
    EXEC(N'CREATE DATABASE [MotorbikeServices]');
END;
GO

USE [MotorbikeServices];
GO

/* ==================== ĐỒNG BỘ CẤU TRÚC DATABASE ==================== */
/* Tạo bảng còn thiếu và bổ sung cột của schema hiện tại. */

IF OBJECT_ID(N'dbo.__EFMigrationsHistory', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.__EFMigrationsHistory
    (
        MigrationId NVARCHAR(150) NOT NULL CONSTRAINT PK___EFMigrationsHistory PRIMARY KEY,
        ProductVersion NVARCHAR(32) NOT NULL
    );
END;
GO

IF OBJECT_ID(N'dbo.Admins', N'U') IS NULL
    CREATE TABLE dbo.Admins (Id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Admins PRIMARY KEY, TenTaiKhoan NVARCHAR(50) NOT NULL, MatKhau NVARCHAR(MAX) NOT NULL);
IF OBJECT_ID(N'dbo.Users', N'U') IS NULL
    CREATE TABLE dbo.Users (Id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Users PRIMARY KEY, TenTaiKhoan NVARCHAR(50) NOT NULL, MatKhau NVARCHAR(MAX) NOT NULL, CauHoiBaoMat NVARCHAR(MAX) NOT NULL, DapAnBaoMat NVARCHAR(MAX) NOT NULL);
IF OBJECT_ID(N'dbo.NhanViens', N'U') IS NULL
    CREATE TABLE dbo.NhanViens (Id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_NhanViens PRIMARY KEY, TenTaiKhoan NVARCHAR(50) NOT NULL, MatKhau NVARCHAR(MAX) NOT NULL, CauHoiBaoMat NVARCHAR(MAX) NOT NULL, DapAnBaoMat NVARCHAR(MAX) NOT NULL);
IF OBJECT_ID(N'dbo.HangXes', N'U') IS NULL
    CREATE TABLE dbo.HangXes (Id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_HangXes PRIMARY KEY, TenHang NVARCHAR(100) NOT NULL, QuocGia NVARCHAR(100) NULL);
IF OBJECT_ID(N'dbo.DiaChis', N'U') IS NULL
    CREATE TABLE dbo.DiaChis (Id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_DiaChis PRIMARY KEY, TinhTP NVARCHAR(100) NOT NULL, PhuongXa NVARCHAR(100) NOT NULL);
IF OBJECT_ID(N'dbo.DongXes', N'U') IS NULL
    CREATE TABLE dbo.DongXes (Id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_DongXes PRIMARY KEY, HangXeId INT NOT NULL, TenDongXe NVARCHAR(100) NOT NULL, LoaiXe NVARCHAR(20) NOT NULL CONSTRAINT DF_DongXes_LoaiXe DEFAULT N'Xe số');
IF OBJECT_ID(N'dbo.UserUses', N'U') IS NULL
    CREATE TABLE dbo.UserUses (Id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_UserUses PRIMARY KEY, UserId INT NOT NULL, HoTen NVARCHAR(100) NULL, NgaySinh DATETIME2 NULL, GioiTinh NVARCHAR(10) NULL, SoDienThoai NVARCHAR(15) NULL, Email NVARCHAR(100) NULL, DiaChiId INT NULL, TenDuong NVARCHAR(150) NULL, SoNha NVARCHAR(50) NULL);
IF OBJECT_ID(N'dbo.NhanVienUses', N'U') IS NULL
    CREATE TABLE dbo.NhanVienUses (NhanVienId INT NOT NULL CONSTRAINT PK_NhanVienUses PRIMARY KEY, TenCuaHang NVARCHAR(150) NULL, TrangThai NVARCHAR(50) NULL, DiaChiId INT NULL, TenDuong NVARCHAR(150) NULL, SoCuaHang NVARCHAR(50) NULL);
IF OBJECT_ID(N'dbo.SanPhams', N'U') IS NULL
    CREATE TABLE dbo.SanPhams (Id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_SanPhams PRIMARY KEY, NhanVienId INT NOT NULL, MaSP NVARCHAR(20) NOT NULL, TenSanPham NVARCHAR(150) NOT NULL, DonGia DECIMAL(18,2) NOT NULL, SoLuongTon INT NOT NULL);
IF OBJECT_ID(N'dbo.UserXes', N'U') IS NULL
    CREATE TABLE dbo.UserXes (Id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_UserXes PRIMARY KEY, UserId INT NOT NULL, DongXeId INT NOT NULL, BienSoXe NVARCHAR(20) NOT NULL, NgayMuaXe DATETIME2 NOT NULL);
IF OBJECT_ID(N'dbo.QuyChuanBaoDuongs', N'U') IS NULL
    CREATE TABLE dbo.QuyChuanBaoDuongs (Id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_QuyChuanBaoDuongs PRIMARY KEY, DongXeId INT NOT NULL, TenQuyChuan NVARCHAR(150) NOT NULL, SoThang INT NOT NULL CONSTRAINT DF_QuyChuanBaoDuongs_SoThang DEFAULT 1, MoTa NVARCHAR(500) NULL);
IF OBJECT_ID(N'dbo.HoaDons', N'U') IS NULL
    CREATE TABLE dbo.HoaDons (Id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_HoaDons PRIMARY KEY, UserId INT NOT NULL, NhanVienId INT NOT NULL, NgayTao DATETIME2 NOT NULL, TongTien DECIMAL(18,2) NOT NULL, TrangThai NVARCHAR(50) NOT NULL);
IF OBJECT_ID(N'dbo.ChiTietHoaDons', N'U') IS NULL
    CREATE TABLE dbo.ChiTietHoaDons (Id INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_ChiTietHoaDons PRIMARY KEY, HoaDonId INT NOT NULL, SanPhamId INT NOT NULL, TenXe NVARCHAR(100) NOT NULL, BienSo NVARCHAR(20) NOT NULL, SoLuong INT NOT NULL, DonGia DECIMAL(18,2) NOT NULL);
GO

/* Bổ sung các cột còn thiếu cho database được tạo ở phiên bản cũ. */
IF COL_LENGTH(N'dbo.HangXes', N'QuocGia') IS NULL ALTER TABLE dbo.HangXes ADD QuocGia NVARCHAR(100) NULL;
IF COL_LENGTH(N'dbo.DongXes', N'LoaiXe') IS NULL ALTER TABLE dbo.DongXes ADD LoaiXe NVARCHAR(20) NOT NULL CONSTRAINT DF_DongXes_LoaiXe_DongBo DEFAULT N'Xe số';
IF COL_LENGTH(N'dbo.Users', N'CauHoiBaoMat') IS NULL ALTER TABLE dbo.Users ADD CauHoiBaoMat NVARCHAR(MAX) NOT NULL CONSTRAINT DF_Users_CauHoiBaoMat DEFAULT N'';
IF COL_LENGTH(N'dbo.Users', N'DapAnBaoMat') IS NULL ALTER TABLE dbo.Users ADD DapAnBaoMat NVARCHAR(MAX) NOT NULL CONSTRAINT DF_Users_DapAnBaoMat DEFAULT N'';
IF COL_LENGTH(N'dbo.NhanViens', N'CauHoiBaoMat') IS NULL ALTER TABLE dbo.NhanViens ADD CauHoiBaoMat NVARCHAR(MAX) NOT NULL CONSTRAINT DF_NhanViens_CauHoiBaoMat DEFAULT N'';
IF COL_LENGTH(N'dbo.NhanViens', N'DapAnBaoMat') IS NULL ALTER TABLE dbo.NhanViens ADD DapAnBaoMat NVARCHAR(MAX) NOT NULL CONSTRAINT DF_NhanViens_DapAnBaoMat DEFAULT N'';
IF COL_LENGTH(N'dbo.UserUses', N'DiaChiId') IS NULL ALTER TABLE dbo.UserUses ADD DiaChiId INT NULL;
IF COL_LENGTH(N'dbo.UserUses', N'TenDuong') IS NULL ALTER TABLE dbo.UserUses ADD TenDuong NVARCHAR(150) NULL;
IF COL_LENGTH(N'dbo.UserUses', N'SoNha') IS NULL ALTER TABLE dbo.UserUses ADD SoNha NVARCHAR(50) NULL;
IF COL_LENGTH(N'dbo.NhanVienUses', N'DiaChiId') IS NULL ALTER TABLE dbo.NhanVienUses ADD DiaChiId INT NULL;
IF COL_LENGTH(N'dbo.NhanVienUses', N'TenCuaHang') IS NULL ALTER TABLE dbo.NhanVienUses ADD TenCuaHang NVARCHAR(150) NULL;
IF COL_LENGTH(N'dbo.NhanVienUses', N'TrangThai') IS NULL ALTER TABLE dbo.NhanVienUses ADD TrangThai NVARCHAR(50) NULL;
IF COL_LENGTH(N'dbo.NhanVienUses', N'TenDuong') IS NULL ALTER TABLE dbo.NhanVienUses ADD TenDuong NVARCHAR(150) NULL;
IF COL_LENGTH(N'dbo.NhanVienUses', N'SoCuaHang') IS NULL ALTER TABLE dbo.NhanVienUses ADD SoCuaHang NVARCHAR(50) NULL;
IF COL_LENGTH(N'dbo.QuyChuanBaoDuongs', N'SoThang') IS NULL ALTER TABLE dbo.QuyChuanBaoDuongs ADD SoThang INT NOT NULL CONSTRAINT DF_QuyChuanBaoDuongs_SoThang_DongBo DEFAULT 1;
IF COL_LENGTH(N'dbo.QuyChuanBaoDuongs', N'ChiPhi') IS NOT NULL
BEGIN
    DECLARE @TenRangBuocChiPhi SYSNAME = (SELECT dc.name FROM sys.default_constraints dc INNER JOIN sys.columns c ON c.default_object_id = dc.object_id WHERE c.object_id = OBJECT_ID(N'dbo.QuyChuanBaoDuongs') AND c.name = N'ChiPhi');
    IF @TenRangBuocChiPhi IS NOT NULL EXEC(N'ALTER TABLE dbo.QuyChuanBaoDuongs DROP CONSTRAINT [' + @TenRangBuocChiPhi + N'];');
    ALTER TABLE dbo.QuyChuanBaoDuongs DROP COLUMN ChiPhi;
END;
IF COL_LENGTH(N'dbo.QuyChuanBaoDuongs', N'SoKm') IS NOT NULL
BEGIN
    DECLARE @TenRangBuocSoKm SYSNAME = (SELECT dc.name FROM sys.default_constraints dc INNER JOIN sys.columns c ON c.default_object_id = dc.object_id WHERE c.object_id = OBJECT_ID(N'dbo.QuyChuanBaoDuongs') AND c.name = N'SoKm');
    IF @TenRangBuocSoKm IS NOT NULL EXEC(N'ALTER TABLE dbo.QuyChuanBaoDuongs DROP CONSTRAINT [' + @TenRangBuocSoKm + N'];');
    ALTER TABLE dbo.QuyChuanBaoDuongs DROP COLUMN SoKm;
END;
GO

/* Tạo index và khóa ngoại nếu chưa có. */
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.Admins') AND name = N'IX_Admins_TenTaiKhoan') EXEC(N'CREATE UNIQUE INDEX IX_Admins_TenTaiKhoan ON dbo.Admins(TenTaiKhoan);');
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.Users') AND name = N'IX_Users_TenTaiKhoan') EXEC(N'CREATE UNIQUE INDEX IX_Users_TenTaiKhoan ON dbo.Users(TenTaiKhoan);');
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.DongXes') AND name = N'IX_DongXes_HangXeId') EXEC(N'CREATE INDEX IX_DongXes_HangXeId ON dbo.DongXes(HangXeId);');
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.UserUses') AND name = N'IX_UserUses_UserId') EXEC(N'CREATE INDEX IX_UserUses_UserId ON dbo.UserUses(UserId);');
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.UserUses') AND name = N'IX_UserUses_DiaChiId') EXEC(N'CREATE INDEX IX_UserUses_DiaChiId ON dbo.UserUses(DiaChiId);');
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.NhanVienUses') AND name = N'IX_NhanVienUses_DiaChiId') EXEC(N'CREATE INDEX IX_NhanVienUses_DiaChiId ON dbo.NhanVienUses(DiaChiId);');
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.SanPhams') AND name = N'IX_SanPhams_NhanVienId') EXEC(N'CREATE INDEX IX_SanPhams_NhanVienId ON dbo.SanPhams(NhanVienId);');
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.UserXes') AND name = N'IX_UserXes_UserId') EXEC(N'CREATE INDEX IX_UserXes_UserId ON dbo.UserXes(UserId);');
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.UserXes') AND name = N'IX_UserXes_DongXeId') EXEC(N'CREATE INDEX IX_UserXes_DongXeId ON dbo.UserXes(DongXeId);');
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.QuyChuanBaoDuongs') AND name = N'IX_QuyChuanBaoDuongs_DongXeId') EXEC(N'CREATE INDEX IX_QuyChuanBaoDuongs_DongXeId ON dbo.QuyChuanBaoDuongs(DongXeId);');
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.HoaDons') AND name = N'IX_HoaDons_UserId') EXEC(N'CREATE INDEX IX_HoaDons_UserId ON dbo.HoaDons(UserId);');
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.HoaDons') AND name = N'IX_HoaDons_NhanVienId') EXEC(N'CREATE INDEX IX_HoaDons_NhanVienId ON dbo.HoaDons(NhanVienId);');
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.ChiTietHoaDons') AND name = N'IX_ChiTietHoaDons_HoaDonId') EXEC(N'CREATE INDEX IX_ChiTietHoaDons_HoaDonId ON dbo.ChiTietHoaDons(HoaDonId);');
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.ChiTietHoaDons') AND name = N'IX_ChiTietHoaDons_SanPhamId') EXEC(N'CREATE INDEX IX_ChiTietHoaDons_SanPhamId ON dbo.ChiTietHoaDons(SanPhamId);');
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_DongXes_HangXes_HangXeId') EXEC(N'ALTER TABLE dbo.DongXes WITH NOCHECK ADD CONSTRAINT FK_DongXes_HangXes_HangXeId FOREIGN KEY (HangXeId) REFERENCES dbo.HangXes(Id);');
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_UserUses_Users_UserId') EXEC(N'ALTER TABLE dbo.UserUses WITH NOCHECK ADD CONSTRAINT FK_UserUses_Users_UserId FOREIGN KEY (UserId) REFERENCES dbo.Users(Id) ON DELETE CASCADE;');
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_UserUses_DiaChis_DiaChiId') EXEC(N'ALTER TABLE dbo.UserUses WITH NOCHECK ADD CONSTRAINT FK_UserUses_DiaChis_DiaChiId FOREIGN KEY (DiaChiId) REFERENCES dbo.DiaChis(Id);');
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_NhanVienUses_NhanViens_NhanVienId') EXEC(N'ALTER TABLE dbo.NhanVienUses WITH NOCHECK ADD CONSTRAINT FK_NhanVienUses_NhanViens_NhanVienId FOREIGN KEY (NhanVienId) REFERENCES dbo.NhanViens(Id) ON DELETE CASCADE;');
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_NhanVienUses_DiaChis_DiaChiId') EXEC(N'ALTER TABLE dbo.NhanVienUses WITH NOCHECK ADD CONSTRAINT FK_NhanVienUses_DiaChis_DiaChiId FOREIGN KEY (DiaChiId) REFERENCES dbo.DiaChis(Id);');
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_SanPhams_NhanVienUses_NhanVienId') EXEC(N'ALTER TABLE dbo.SanPhams WITH NOCHECK ADD CONSTRAINT FK_SanPhams_NhanVienUses_NhanVienId FOREIGN KEY (NhanVienId) REFERENCES dbo.NhanVienUses(NhanVienId) ON DELETE CASCADE;');
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_UserXes_Users_UserId') EXEC(N'ALTER TABLE dbo.UserXes WITH NOCHECK ADD CONSTRAINT FK_UserXes_Users_UserId FOREIGN KEY (UserId) REFERENCES dbo.Users(Id) ON DELETE CASCADE;');
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_UserXes_DongXes_DongXeId') EXEC(N'ALTER TABLE dbo.UserXes WITH NOCHECK ADD CONSTRAINT FK_UserXes_DongXes_DongXeId FOREIGN KEY (DongXeId) REFERENCES dbo.DongXes(Id) ON DELETE CASCADE;');
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_QuyChuanBaoDuongs_DongXes_DongXeId') EXEC(N'ALTER TABLE dbo.QuyChuanBaoDuongs WITH NOCHECK ADD CONSTRAINT FK_QuyChuanBaoDuongs_DongXes_DongXeId FOREIGN KEY (DongXeId) REFERENCES dbo.DongXes(Id);');
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_HoaDons_Users_UserId') EXEC(N'ALTER TABLE dbo.HoaDons WITH NOCHECK ADD CONSTRAINT FK_HoaDons_Users_UserId FOREIGN KEY (UserId) REFERENCES dbo.Users(Id) ON DELETE CASCADE;');
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_HoaDons_NhanVienUses_NhanVienId') EXEC(N'ALTER TABLE dbo.HoaDons WITH NOCHECK ADD CONSTRAINT FK_HoaDons_NhanVienUses_NhanVienId FOREIGN KEY (NhanVienId) REFERENCES dbo.NhanVienUses(NhanVienId) ON DELETE CASCADE;');
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_ChiTietHoaDons_HoaDons_HoaDonId') EXEC(N'ALTER TABLE dbo.ChiTietHoaDons WITH NOCHECK ADD CONSTRAINT FK_ChiTietHoaDons_HoaDons_HoaDonId FOREIGN KEY (HoaDonId) REFERENCES dbo.HoaDons(Id) ON DELETE CASCADE;');
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_ChiTietHoaDons_SanPhams_SanPhamId') EXEC(N'ALTER TABLE dbo.ChiTietHoaDons WITH NOCHECK ADD CONSTRAINT FK_ChiTietHoaDons_SanPhams_SanPhamId FOREIGN KEY (SanPhamId) REFERENCES dbo.SanPhams(Id);');
GO

/* Ghi nhận schema hiện tại để EF Core chỉ áp dụng migration mới trong tương lai. */
INSERT INTO dbo.__EFMigrationsHistory (MigrationId, ProductVersion)
SELECT v.MigrationId, N'9.0.0'
FROM (VALUES
    (N'20261020032936_StartUpOne'), (N'20261021083019_AddHangXeDongXe'),
    (N'20261022081626_AddLoaiXeToDongXe'), (N'20261030032738_AddUserUseTable'),
    (N'20261030041400_AddUserXeTable1'), (N'20261030053810_AddQuyChuanBaoDuong'),
    (N'20261030072319_RebuildQuyChuanBaoDuong'), (N'20261101065239_AddNhanVien'),
    (N'20261101115906_AddDiChiCuaHang'), (N'20261101124146_AddSanPhamCuaHang'),
    (N'20261101134427_AddTaoThemDiaChiCuaNguoiDung'), (N'20261102074623_DoiQuyChuanTheoThang'),
    (N'20261102064223_AddHoaDonVaChiTietHoaDon')
) AS v(MigrationId)
WHERE NOT EXISTS (SELECT 1 FROM dbo.__EFMigrationsHistory AS h WHERE h.MigrationId = v.MigrationId);
GO

/* ==================== SEED DATA ==================== */
SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;

    IF DB_NAME() <> N'MotorbikeServices'
        THROW 51000, N'Hãy chọn đúng database MotorbikeServices trước khi chạy script.', 1;

    IF OBJECT_ID(N'dbo.DiaChis', N'U') IS NULL
       OR OBJECT_ID(N'dbo.HangXes', N'U') IS NULL
       OR OBJECT_ID(N'dbo.DongXes', N'U') IS NULL
       OR OBJECT_ID(N'dbo.QuyChuanBaoDuongs', N'U') IS NULL
        THROW 51001, N'Không tìm thấy bảng cần thiết. Hãy chạy EF Core migrations trước.', 1;

    IF COL_LENGTH(N'dbo.QuyChuanBaoDuongs', N'SoThang') IS NULL
        THROW 51002, N'Chưa có cột SoThang. Hãy chạy migration DoiQuyChuanTheoThang trước.', 1;

    /* 1. Danh sách địa chỉ mẫu cho User và Cửa hàng */
    DECLARE @DiaChiSeed TABLE
    (
        TinhTP NVARCHAR(100) NOT NULL,
        PhuongXa NVARCHAR(100) NOT NULL,
        PRIMARY KEY (TinhTP, PhuongXa)
    );

    INSERT INTO @DiaChiSeed (TinhTP, PhuongXa)
    VALUES
        (N'Hồ Chí Minh', N'Phường Bến Nghé'),
        (N'Hồ Chí Minh', N'Phường Bến Thành'),
        (N'Hồ Chí Minh', N'Phường Linh Trung'),
        (N'Hồ Chí Minh', N'Phường Tân Phú'),
        (N'Hồ Chí Minh', N'Phường Thạnh Mỹ Lợi'),
        (N'Bình Dương', N'Phường Phú Cường'),
        (N'Bình Dương', N'Phường Lái Thiêu'),
        (N'Đồng Nai', N'Phường Trấn Biên'),
        (N'Đồng Nai', N'Phường Long Bình'),
        (N'Thành phố Hà Nội', N'Phường Cầu Giấy'),
        (N'Đà Nẵng', N'Phường Hải Châu'),
        (N'Cần Thơ', N'Phường Ninh Kiều');

    INSERT INTO dbo.DiaChis (TinhTP, PhuongXa)
    SELECT s.TinhTP, s.PhuongXa
    FROM @DiaChiSeed AS s
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM dbo.DiaChis AS d
        WHERE d.TinhTP = s.TinhTP
          AND d.PhuongXa = s.PhuongXa
    );

    /* 2. Danh sách 20 hãng xe */
    DECLARE @HangSeed TABLE
    (
        TenHang NVARCHAR(100) NOT NULL PRIMARY KEY,
        QuocGia NVARCHAR(100) NULL
    );

    INSERT INTO @HangSeed (TenHang, QuocGia)
    VALUES
(N'Honda', N'Nhật Bản'),
(N'Yamaha', N'Nhật Bản'),
(N'Suzuki', N'Nhật Bản'),
(N'Kawasaki', N'Nhật Bản'),
(N'Piaggio', N'Ý'),
(N'SYM', N'Đài Loan'),
(N'Kymco', N'Đài Loan'),
(N'VinFast', N'Việt Nam'),
(N'Dat Bike', N'Việt Nam'),
(N'Pega', N'Việt Nam'),
(N'Yadea', N'Trung Quốc'),
(N'BMW Motorrad', N'Đức'),
(N'Ducati', N'Ý'),
(N'Triumph', N'Vương quốc Anh'),
(N'KTM', N'Áo'),
(N'Harley-Davidson', N'Mỹ'),
(N'Royal Enfield', N'Ấn Độ'),
(N'Benelli', N'Ý'),
(N'Aprilia', N'Ý'),
(N'Vespa', N'Ý');

    INSERT INTO dbo.HangXes (TenHang, QuocGia)
    SELECT s.TenHang, s.QuocGia
    FROM @HangSeed AS s
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM dbo.HangXes AS h
        WHERE h.TenHang = s.TenHang
    );

    /* 3. Danh sách 50 dòng xe */
    DECLARE @DongSeed TABLE
    (
        TenHang NVARCHAR(100) NOT NULL,
        TenDongXe NVARCHAR(100) NOT NULL,
        LoaiXe NVARCHAR(20) NOT NULL,
        PRIMARY KEY (TenHang, TenDongXe)
    );

    INSERT INTO @DongSeed (TenHang, TenDongXe, LoaiXe)
    VALUES
(N'Honda', N'Wave Alpha', N'Xe số'),
(N'Honda', N'Future 125 FI', N'Xe số'),
(N'Honda', N'Vision', N'Xe tay ga'),
(N'Honda', N'Air Blade 160', N'Xe tay ga'),
(N'Honda', N'Winner X', N'Xe côn tay'),
(N'Honda', N'SH Mode', N'Xe tay ga'),
(N'Yamaha', N'Sirius', N'Xe số'),
(N'Yamaha', N'Jupiter Finn', N'Xe số'),
(N'Yamaha', N'Janus', N'Xe tay ga'),
(N'Yamaha', N'Exciter 155 VVA', N'Xe côn tay'),
(N'Yamaha', N'Grande', N'Xe tay ga'),
(N'Suzuki', N'Raider R150', N'Xe côn tay'),
(N'Suzuki', N'Address', N'Xe tay ga'),
(N'Kawasaki', N'Ninja 400', N'Mô tô'),
(N'Kawasaki', N'Z650', N'Mô tô'),
(N'Piaggio', N'Liberty', N'Xe tay ga'),
(N'Piaggio', N'Medley', N'Xe tay ga'),
(N'SYM', N'Attila', N'Xe tay ga'),
(N'SYM', N'Galaxy 50', N'Xe số'),
(N'Kymco', N'Like 125', N'Xe tay ga'),
(N'Kymco', N'AK 550', N'Mô tô'),
(N'VinFast', N'Klara S', N'Xe điện'),
(N'VinFast', N'Feliz S', N'Xe điện'),
(N'VinFast', N'Evo200', N'Xe điện'),
(N'VinFast', N'Theon S', N'Xe điện'),
(N'Dat Bike', N'Weaver 200', N'Xe điện'),
(N'Dat Bike', N'Quantum', N'Xe điện'),
(N'Pega', N'Aura', N'Xe điện'),
(N'Pega', N'NewTech', N'Xe điện'),
(N'Yadea', N'G5', N'Xe điện'),
(N'Yadea', N'Xmen Neo', N'Xe điện'),
(N'BMW Motorrad', N'G 310 R', N'Mô tô'),
(N'BMW Motorrad', N'R 1250 GS', N'Mô tô'),
(N'Ducati', N'Monster', N'Mô tô'),
(N'Ducati', N'Multistrada V4', N'Mô tô'),
(N'Triumph', N'Speed 400', N'Mô tô'),
(N'Triumph', N'Tiger 900', N'Mô tô'),
(N'KTM', N'390 Duke', N'Mô tô'),
(N'KTM', N'390 Adventure', N'Mô tô'),
(N'Harley-Davidson', N'Sportster S', N'Mô tô'),
(N'Harley-Davidson', N'Nightster', N'Mô tô'),
(N'Royal Enfield', N'Classic 350', N'Mô tô'),
(N'Royal Enfield', N'Himalayan 450', N'Mô tô'),
(N'Benelli', N'TNT 600i', N'Mô tô'),
(N'Benelli', N'Leoncino 500', N'Mô tô'),
(N'Aprilia', N'RS 660', N'Mô tô'),
(N'Aprilia', N'Tuono 660', N'Mô tô'),
(N'Vespa', N'Primavera', N'Xe tay ga'),
(N'Vespa', N'Sprint', N'Xe tay ga'),
(N'Vespa', N'GTS 300', N'Xe tay ga');

    INSERT INTO dbo.DongXes (HangXeId, TenDongXe, LoaiXe)
    SELECT h.Id, s.TenDongXe, s.LoaiXe
    FROM @DongSeed AS s
    INNER JOIN dbo.HangXes AS h
        ON h.TenHang = s.TenHang
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM dbo.DongXes AS d
        WHERE d.HangXeId = h.Id
          AND d.TenDongXe = s.TenDongXe
    );

    /*
       4. Năm quy chuẩn riêng cho từng dòng xe.
       Tên quy chuẩn chứa tên dòng xe để Admin và User biết chính xác quy chuẩn
       thuộc xe nào. Nội dung thay đổi theo loại xe: xe số, tay ga, mô tô, xe điện.
    */
    ;WITH MocBaoDuongTheoDongXe AS
    (
        SELECT d.Id AS DongXeId, q.SoThang, q.TenQuyChuan, q.MoTa
        FROM @DongSeed AS s
        INNER JOIN dbo.HangXes AS h ON h.TenHang = s.TenHang
        INNER JOIN dbo.DongXes AS d
            ON d.HangXeId = h.Id AND d.TenDongXe = s.TenDongXe
        CROSS APPLY
        (
            VALUES
            (1,
             N'Kiểm tra sau khi nhận xe - ' + d.TenDongXe,
             N'Kiểm tra tổng quát lần đầu cho ' + s.TenHang + N' ' + d.TenDongXe +
             N': phanh, lốp, đèn, còi và các ốc vít.'),
            (3,
             CASE
                 WHEN d.LoaiXe = N'Xe điện' THEN N'Kiểm tra pin và bộ sạc - ' + d.TenDongXe
                 WHEN d.LoaiXe = N'Xe tay ga' THEN N'Thay dầu máy định kỳ - ' + d.TenDongXe
                 WHEN d.LoaiXe = N'Xe số' THEN N'Thay dầu máy và kiểm tra xích - ' + d.TenDongXe
                 ELSE N'Thay dầu máy và kiểm tra truyền động - ' + d.TenDongXe
             END,
             CASE
                 WHEN d.LoaiXe = N'Xe điện' THEN N'Kiểm tra dung lượng pin, cổng sạc, dây điện và bộ điều khiển.'
                 WHEN d.LoaiXe = N'Xe tay ga' THEN N'Thay dầu máy, kiểm tra lọc gió và tình trạng dây cu-roa CVT.'
                 WHEN d.LoaiXe = N'Xe số' THEN N'Thay dầu máy, kiểm tra độ căng và bôi trơn xích tải.'
                 ELSE N'Thay dầu máy, kiểm tra nhông xích hoặc truyền động của xe mô tô.'
             END),
            (6,
             CASE
                 WHEN d.LoaiXe = N'Xe điện' THEN N'Kiểm tra phanh và lốp - ' + d.TenDongXe
                 WHEN d.LoaiXe = N'Xe tay ga' THEN N'Vệ sinh nồi và kiểm tra phanh - ' + d.TenDongXe
                 WHEN d.LoaiXe = N'Xe số' THEN N'Kiểm tra phanh, lốp và nhông xích - ' + d.TenDongXe
                 ELSE N'Kiểm tra phanh, lốp và hệ thống lái - ' + d.TenDongXe
             END,
             N'Bảo dưỡng 6 tháng cho ' + s.TenHang + N' ' + d.TenDongXe +
             N': kiểm tra hệ thống phanh, lốp, đèn và các chi tiết an toàn.'),
            (9,
             CASE
                 WHEN d.LoaiXe = N'Xe điện' THEN N'Kiểm tra hệ thống điện chuyên sâu - ' + d.TenDongXe
                 WHEN d.LoaiXe = N'Xe tay ga' THEN N'Kiểm tra dây cu-roa và bugi - ' + d.TenDongXe
                 WHEN d.LoaiXe = N'Xe số' THEN N'Kiểm tra bugi và lọc gió - ' + d.TenDongXe
                 ELSE N'Kiểm tra bugi, lọc gió và nước làm mát - ' + d.TenDongXe
             END,
             N'Kiểm tra các chi tiết hao mòn theo đặc điểm vận hành của dòng ' + d.TenDongXe + N'.'),
            (12,
             N'Bảo dưỡng tổng quát hằng năm - ' + d.TenDongXe,
             N'Bảo dưỡng tổng thể sau 12 tháng cho ' + s.TenHang + N' ' + d.TenDongXe +
             N'; thay thế vật tư khi cần sau khi kiểm tra thực tế.')
        ) AS q(SoThang, TenQuyChuan, MoTa)
    )
    INSERT INTO dbo.QuyChuanBaoDuongs
        (DongXeId, TenQuyChuan, SoThang, MoTa)
    SELECT
        m.DongXeId,
        m.TenQuyChuan,
        m.SoThang,
        m.MoTa
    FROM MocBaoDuongTheoDongXe AS m
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM dbo.QuyChuanBaoDuongs AS q
        WHERE q.DongXeId = m.DongXeId
          AND q.SoThang = m.SoThang
          AND q.TenQuyChuan = m.TenQuyChuan
    );

    /* 5. Mười hai tài khoản demo: Hào, Khánh, Vũ, Tùng ở ba vai trò. */
    DECLARE @TaiKhoanAdminSeed TABLE (TenTaiKhoan NVARCHAR(50) NOT NULL PRIMARY KEY);
    INSERT INTO @TaiKhoanAdminSeed VALUES
        (N'hao_admin'), (N'khanh_admin'), (N'vu_admin'), (N'tung_admin');

    INSERT INTO dbo.Admins (TenTaiKhoan, MatKhau)
    SELECT TenTaiKhoan, N'12345678'
    FROM @TaiKhoanAdminSeed AS s
    WHERE NOT EXISTS (SELECT 1 FROM dbo.Admins AS a WHERE a.TenTaiKhoan = s.TenTaiKhoan);

    DECLARE @TaiKhoanCoBaoMatSeed TABLE
    (
        TenTaiKhoan NVARCHAR(50) NOT NULL PRIMARY KEY,
        CauHoiBaoMat NVARCHAR(200) NOT NULL,
        DapAnBaoMat NVARCHAR(100) NOT NULL
    );
    INSERT INTO @TaiKhoanCoBaoMatSeed VALUES
        (N'hao_user', N'Tên thành viên của bạn là gì?', N'hào'),
        (N'khanh_user', N'Tên thành viên của bạn là gì?', N'khánh'),
        (N'vu_user', N'Tên thành viên của bạn là gì?', N'vũ'),
        (N'tung_user', N'Tên thành viên của bạn là gì?', N'tùng');

    INSERT INTO dbo.Users (TenTaiKhoan, MatKhau, CauHoiBaoMat, DapAnBaoMat)
    SELECT TenTaiKhoan, N'12345678', CauHoiBaoMat, DapAnBaoMat
    FROM @TaiKhoanCoBaoMatSeed AS s
    WHERE NOT EXISTS (SELECT 1 FROM dbo.Users AS u WHERE u.TenTaiKhoan = s.TenTaiKhoan);

    DECLARE @TaiKhoanNhanVienSeed TABLE
    (
        TenTaiKhoan NVARCHAR(50) NOT NULL PRIMARY KEY,
        CauHoiBaoMat NVARCHAR(200) NOT NULL,
        DapAnBaoMat NVARCHAR(100) NOT NULL
    );
    INSERT INTO @TaiKhoanNhanVienSeed VALUES
        (N'hao_emp', N'Tên thành viên của bạn là gì?', N'hào'),
        (N'khanh_emp', N'Tên thành viên của bạn là gì?', N'khánh'),
        (N'vu_emp', N'Tên thành viên của bạn là gì?', N'vũ'),
        (N'tung_emp', N'Tên thành viên của bạn là gì?', N'tùng');

    INSERT INTO dbo.NhanViens (TenTaiKhoan, MatKhau, CauHoiBaoMat, DapAnBaoMat)
    SELECT TenTaiKhoan, N'12345678', CauHoiBaoMat, DapAnBaoMat
    FROM @TaiKhoanNhanVienSeed AS s
    WHERE NOT EXISTS (SELECT 1 FROM dbo.NhanViens AS n WHERE n.TenTaiKhoan = s.TenTaiKhoan);

    /* 6. Bốn cửa hàng demo gắn với bốn tài khoản nhân viên. */
    DECLARE @CuaHangSeed TABLE
    (
        TenTaiKhoan NVARCHAR(50) NOT NULL PRIMARY KEY,
        TenCuaHang NVARCHAR(150) NOT NULL,
        TrangThai NVARCHAR(50) NOT NULL,
        TinhTP NVARCHAR(100) NOT NULL,
        PhuongXa NVARCHAR(100) NOT NULL,
        TenDuong NVARCHAR(150) NOT NULL,
        SoCuaHang NVARCHAR(50) NOT NULL
    );
    INSERT INTO @CuaHangSeed VALUES
        (N'hao_emp', N'Cửa hàng xe máy Hào', N'Đang hoạt động', N'Hồ Chí Minh', N'Phường Bến Nghé', N'Đường Lê Thánh Tôn', N'25'),
        (N'khanh_emp', N'Cửa hàng xe máy Khánh', N'Đang hoạt động', N'Hồ Chí Minh', N'Phường Linh Trung', N'Đường Võ Văn Ngân', N'475'),
        (N'vu_emp', N'Cửa hàng xe máy Vũ', N'Tạm ngừng hoạt động', N'Tỉnh Bình Dương', N'Phường Lái Thiêu', N'Đường Nguyễn Văn Tiết', N'86'),
        (N'tung_emp', N'Cửa hàng xe máy Tùng', N'Đang hoạt động', N'Tỉnh Đồng Nai', N'Phường Trấn Biên', N'Đường Phạm Văn Thuận', N'210');

    INSERT INTO dbo.NhanVienUses (NhanVienId, TenCuaHang, TrangThai, DiaChiId, TenDuong, SoCuaHang)
    SELECT n.Id, s.TenCuaHang, s.TrangThai, d.Id, s.TenDuong, s.SoCuaHang
    FROM @CuaHangSeed AS s
    INNER JOIN dbo.NhanViens AS n ON n.TenTaiKhoan = s.TenTaiKhoan
    INNER JOIN dbo.DiaChis AS d ON d.TinhTP = s.TinhTP AND d.PhuongXa = s.PhuongXa
    WHERE NOT EXISTS (SELECT 1 FROM dbo.NhanVienUses AS c WHERE c.NhanVienId = n.Id);

    /* Đồng bộ hai trạng thái tên cũ sang quy ước đang dùng trong source của Hào. */
    UPDATE c
    SET c.TrangThai = CASE
        WHEN c.TrangThai = N'Đang mở cửa' THEN N'Đang hoạt động'
        WHEN c.TrangThai = N'Tạm đóng cửa' THEN N'Tạm ngừng hoạt động'
        ELSE c.TrangThai
    END
    FROM dbo.NhanVienUses AS c
    WHERE c.TrangThai IN (N'Đang mở cửa', N'Tạm đóng cửa');

    /* 7. Sản phẩm mẫu để nhân viên có dữ liệu quản lý. */
    DECLARE @SanPhamSeed TABLE
    (
        TenTaiKhoan NVARCHAR(50) NOT NULL,
        MaSP NVARCHAR(20) NOT NULL,
        TenSanPham NVARCHAR(150) NOT NULL,
        DonGia DECIMAL(18,2) NOT NULL,
        SoLuongTon INT NOT NULL,
        PRIMARY KEY (TenTaiKhoan, MaSP)
    );
    INSERT INTO @SanPhamSeed VALUES
        (N'hao_emp', N'DN001', N'Dầu nhớt động cơ 10W-40', 120000, 30),
        (N'hao_emp', N'LP001', N'Lốp xe máy trước 80/90-17', 350000, 12),
        (N'khanh_emp', N'BP001', N'Bố thắng đĩa trước', 180000, 20),
        (N'khanh_emp', N'BG001', N'Bugi đánh lửa tiêu chuẩn', 65000, 40),
        (N'khanh_emp', N'LT001', N'Lọc nhớt động cơ', 85000, 0),
        (N'vu_emp', N'AT001', N'Ắc quy xe máy 12V', 420000, 8),
        (N'vu_emp', N'DC001', N'Dây cu-roa xe tay ga', 280000, 15),
        (N'tung_emp', N'XS001', N'Nhông xích xe số', 250000, 18),
        (N'tung_emp', N'VS001', N'Dung dịch vệ sinh kim phun', 95000, 25),

        /* 30 sản phẩm bổ sung, phân bổ cho cả bốn cửa hàng. */
        (N'hao_emp', N'DN002', N'Dầu nhớt tổng hợp 5W-40', 185000, 16),
        (N'hao_emp', N'DN003', N'Dầu láp xe tay ga', 75000, 22),
        (N'hao_emp', N'LP002', N'Lốp xe máy sau 90/90-17', 420000, 9),
        (N'hao_emp', N'LP003', N'Ruột xe máy 17 inch', 85000, 14),
        (N'hao_emp', N'BP002', N'Bố thắng tang trống sau', 95000, 20),
        (N'hao_emp', N'BG002', N'Bugi iridium', 145000, 7),
        (N'hao_emp', N'RK001', N'Rơ le khởi động', 110000, 5),
        (N'hao_emp', N'GX001', N'Gương chiếu hậu xe máy', 125000, 0),

        (N'khanh_emp', N'BP002', N'Bố thắng đĩa sau', 165000, 13),
        (N'khanh_emp', N'BG002', N'Bugi platinum', 125000, 18),
        (N'khanh_emp', N'DN002', N'Dầu nhớt bán tổng hợp 10W-40', 98000, 26),
        (N'khanh_emp', N'LP002', N'Lốp không săm 90/90-14', 510000, 6),
        (N'khanh_emp', N'AT002', N'Ắc quy khô 12V 5Ah', 480000, 4),
        (N'khanh_emp', N'NS001', N'Nước làm mát động cơ', 65000, 30),
        (N'khanh_emp', N'PL001', N'Bộ lọc gió xe tay ga', 135000, 11),
        (N'khanh_emp', N'CD001', N'Cáp dây ga xe máy', 90000, 0),

        (N'vu_emp', N'DN002', N'Dầu nhớt xe số 20W-50', 105000, 19),
        (N'vu_emp', N'LP002', N'Lốp xe máy trước 70/90-17', 315000, 10),
        (N'vu_emp', N'BG002', N'Bugi xe máy chân dài', 78000, 24),
        (N'vu_emp', N'BP002', N'Bố thắng trước xe số', 88000, 17),
        (N'vu_emp', N'PL001', N'Lọc gió động cơ', 115000, 8),
        (N'vu_emp', N'CD001', N'Cáp phanh trước', 70000, 12),
        (N'vu_emp', N'NS001', N'Nước làm mát 1 lít', 85000, 0),

        (N'tung_emp', N'DN002', N'Dầu nhớt xe tay ga 10W-30', 145000, 21),
        (N'tung_emp', N'LP002', N'Lốp xe tay ga 100/90-10', 465000, 7),
        (N'tung_emp', N'BG002', N'Bugi chống bám muội', 92000, 16),
        (N'tung_emp', N'BP002', N'Bố thắng đĩa loại phổ thông', 155000, 9),
        (N'tung_emp', N'AT002', N'Ắc quy xe máy 12V 4Ah', 395000, 5),
        (N'tung_emp', N'PL001', N'Lọc gió xe số', 75000, 18),
        (N'tung_emp', N'GX001', N'Gương chiếu hậu chống rung', 160000, 0);

    INSERT INTO dbo.SanPhams (NhanVienId, MaSP, TenSanPham, DonGia, SoLuongTon)
    SELECT n.Id, s.MaSP, s.TenSanPham, s.DonGia, s.SoLuongTon
    FROM @SanPhamSeed AS s
    INNER JOIN dbo.NhanViens AS n ON n.TenTaiKhoan = s.TenTaiKhoan
    WHERE NOT EXISTS
    (
        SELECT 1 FROM dbo.SanPhams AS p
        WHERE p.NhanVienId = n.Id AND p.MaSP = s.MaSP
    );

    /* 8. Hóa đơn mẫu để demo danh sách đơn và thống kê của cửa hàng Khánh. */
    DECLARE @HoaDonSeed TABLE
    (
        TenTaiKhoanUser NVARCHAR(50) NOT NULL,
        TenTaiKhoanNhanVien NVARCHAR(50) NOT NULL,
        NgayTao DATETIME2 NOT NULL,
        TongTien DECIMAL(18,2) NOT NULL,
        TrangThai NVARCHAR(50) NOT NULL,
        MaSP NVARCHAR(20) NOT NULL,
        TenXe NVARCHAR(100) NOT NULL,
        BienSo NVARCHAR(20) NOT NULL,
        SoLuong INT NOT NULL,
        PRIMARY KEY (TenTaiKhoanUser, TenTaiKhoanNhanVien, NgayTao)
    );
    INSERT INTO @HoaDonSeed VALUES
        (N'hao_user', N'khanh_emp', DATEADD(HOUR, 9, CAST(DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1) AS DATETIME2)), 180000, N'Đã hoàn thành', N'BP001', N'Honda Vision', N'59A1-123.45', 1),
        (N'vu_user', N'khanh_emp', DATEADD(HOUR, 10, CAST(DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1) AS DATETIME2)), 65000, N'Đã hoàn thành', N'BG001', N'Yamaha Janus', N'61B2-234.56', 1),
        (N'tung_user', N'khanh_emp', DATEADD(HOUR, 11, CAST(DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1) AS DATETIME2)), 180000, N'Chờ xác nhận', N'BP001', N'Honda Wave Alpha', N'60C1-345.67', 1),
        (N'hao_user', N'khanh_emp', DATEADD(HOUR, 12, CAST(DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1) AS DATETIME2)), 65000, N'Đã hủy', N'BG001', N'Honda Air Blade 160', N'59X2-456.78', 1);

    INSERT INTO dbo.HoaDons (UserId, NhanVienId, NgayTao, TongTien, TrangThai)
    SELECT u.Id, n.Id, s.NgayTao, s.TongTien, s.TrangThai
    FROM @HoaDonSeed AS s
    INNER JOIN dbo.Users AS u ON u.TenTaiKhoan = s.TenTaiKhoanUser
    INNER JOIN dbo.NhanViens AS n ON n.TenTaiKhoan = s.TenTaiKhoanNhanVien
    WHERE NOT EXISTS
    (
        SELECT 1 FROM dbo.HoaDons AS h
        WHERE h.UserId = u.Id AND h.NhanVienId = n.Id AND h.NgayTao = s.NgayTao
    );

    INSERT INTO dbo.ChiTietHoaDons (HoaDonId, SanPhamId, TenXe, BienSo, SoLuong, DonGia)
    SELECT h.Id, sp.Id, s.TenXe, s.BienSo, s.SoLuong, sp.DonGia
    FROM @HoaDonSeed AS s
    INNER JOIN dbo.Users AS u ON u.TenTaiKhoan = s.TenTaiKhoanUser
    INNER JOIN dbo.NhanViens AS n ON n.TenTaiKhoan = s.TenTaiKhoanNhanVien
    INNER JOIN dbo.HoaDons AS h
        ON h.UserId = u.Id AND h.NhanVienId = n.Id AND h.NgayTao = s.NgayTao
    INNER JOIN dbo.SanPhams AS sp ON sp.NhanVienId = n.Id AND sp.MaSP = s.MaSP
    WHERE NOT EXISTS
    (
        SELECT 1 FROM dbo.ChiTietHoaDons AS ct
        WHERE ct.HoaDonId = h.Id AND ct.SanPhamId = sp.Id
    );

    COMMIT TRANSACTION;

    /* Báo cáo số lượng */
    SELECT N'DiaChis' AS Bang, COUNT_BIG(*) AS TongSoBanGhi
    FROM dbo.DiaChis
    UNION ALL
    SELECT N'HangXes', COUNT_BIG(*)
    FROM dbo.HangXes
    UNION ALL
    SELECT N'DongXes', COUNT_BIG(*)
    FROM dbo.DongXes
    UNION ALL
    SELECT N'QuyChuanBaoDuongs', COUNT_BIG(*)
    FROM dbo.QuyChuanBaoDuongs
    UNION ALL
    SELECT N'Admins', COUNT_BIG(*) FROM dbo.Admins
    UNION ALL
    SELECT N'Users', COUNT_BIG(*) FROM dbo.Users
    UNION ALL
    SELECT N'NhanViens', COUNT_BIG(*) FROM dbo.NhanViens
    UNION ALL
    SELECT N'NhanVienUses', COUNT_BIG(*) FROM dbo.NhanVienUses
    UNION ALL
    SELECT N'SanPhams', COUNT_BIG(*) FROM dbo.SanPhams
    UNION ALL
    SELECT N'HoaDons', COUNT_BIG(*) FROM dbo.HoaDons
    UNION ALL
    SELECT N'ChiTietHoaDons', COUNT_BIG(*) FROM dbo.ChiTietHoaDons;

    PRINT N'Đã hoàn tất đồng bộ database và seed data.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    THROW;
END CATCH;


