IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020032936_StartUpOne'
)
BEGIN
    CREATE TABLE [Admins] (
        [Id] int NOT NULL IDENTITY,
        [TenTaiKhoan] nvarchar(50) NOT NULL,
        [MatKhau] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Admins] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020032936_StartUpOne'
)
BEGIN
    CREATE TABLE [Users] (
        [Id] int NOT NULL IDENTITY,
        [TenTaiKhoan] nvarchar(50) NOT NULL,
        [MatKhau] nvarchar(max) NOT NULL,
        [CauHoiBaoMat] nvarchar(max) NOT NULL,
        [DapAnBaoMat] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Users] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020032936_StartUpOne'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Admins_TenTaiKhoan] ON [Admins] ([TenTaiKhoan]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020032936_StartUpOne'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Users_TenTaiKhoan] ON [Users] ([TenTaiKhoan]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261020032936_StartUpOne'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20261020032936_StartUpOne', N'9.0.0');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261021083019_AddHangXeDongXe'
)
BEGIN
    CREATE TABLE [HangXes] (
        [Id] int NOT NULL IDENTITY,
        [TenHang] nvarchar(100) NOT NULL,
        [QuocGia] nvarchar(100) NULL,
        CONSTRAINT [PK_HangXes] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261021083019_AddHangXeDongXe'
)
BEGIN
    CREATE TABLE [DongXes] (
        [Id] int NOT NULL IDENTITY,
        [HangXeId] int NOT NULL,
        [TenDongXe] nvarchar(100) NOT NULL,
        CONSTRAINT [PK_DongXes] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_DongXes_HangXes_HangXeId] FOREIGN KEY ([HangXeId]) REFERENCES [HangXes] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261021083019_AddHangXeDongXe'
)
BEGIN
    CREATE INDEX [IX_DongXes_HangXeId] ON [DongXes] ([HangXeId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261021083019_AddHangXeDongXe'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20261021083019_AddHangXeDongXe', N'9.0.0');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261022081626_AddLoaiXeToDongXe'
)
BEGIN
    ALTER TABLE [DongXes] ADD [LoaiXe] nvarchar(20) NOT NULL DEFAULT N'Xe số';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261022081626_AddLoaiXeToDongXe'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20261022081626_AddLoaiXeToDongXe', N'9.0.0');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261030032738_AddUserUseTable'
)
BEGIN
    CREATE TABLE [UserUses] (
        [Id] int NOT NULL IDENTITY,
        [UserId] int NOT NULL,
        [HoTen] nvarchar(100) NULL,
        [NgaySinh] datetime2 NULL,
        [GioiTinh] nvarchar(10) NULL,
        [SoDienThoai] nvarchar(15) NULL,
        [Email] nvarchar(100) NULL,
        CONSTRAINT [PK_UserUses] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_UserUses_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261030032738_AddUserUseTable'
)
BEGIN
    CREATE INDEX [IX_UserUses_UserId] ON [UserUses] ([UserId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261030032738_AddUserUseTable'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20261030032738_AddUserUseTable', N'9.0.0');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261030041400_AddUserXeTable1'
)
BEGIN
    CREATE TABLE [UserXes] (
        [Id] int NOT NULL IDENTITY,
        [UserId] int NOT NULL,
        [DongXeId] int NOT NULL,
        [BienSoXe] nvarchar(20) NOT NULL,
        [NgayMuaXe] datetime2 NOT NULL,
        CONSTRAINT [PK_UserXes] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_UserXes_DongXes_DongXeId] FOREIGN KEY ([DongXeId]) REFERENCES [DongXes] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_UserXes_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261030041400_AddUserXeTable1'
)
BEGIN
    CREATE INDEX [IX_UserXes_DongXeId] ON [UserXes] ([DongXeId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261030041400_AddUserXeTable1'
)
BEGIN
    CREATE INDEX [IX_UserXes_UserId] ON [UserXes] ([UserId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261030041400_AddUserXeTable1'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20261030041400_AddUserXeTable1', N'9.0.0');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261030053810_AddQuyChuanBaoDuong'
)
BEGIN
    CREATE TABLE [QuyChuanBaoDuongs] (
        [Id] int NOT NULL IDENTITY,
        [LoaiXe] nvarchar(50) NOT NULL,
        [TenQuyChuan] nvarchar(150) NOT NULL,
        [SoKm] int NOT NULL,
        [ChiPhi] decimal(18,2) NOT NULL,
        [MoTa] nvarchar(500) NULL,
        CONSTRAINT [PK_QuyChuanBaoDuongs] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261030053810_AddQuyChuanBaoDuong'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20261030053810_AddQuyChuanBaoDuong', N'9.0.0');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261030072319_RebuildQuyChuanBaoDuong'
)
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[QuyChuanBaoDuongs]') AND [c].[name] = N'LoaiXe');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [QuyChuanBaoDuongs] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [QuyChuanBaoDuongs] DROP COLUMN [LoaiXe];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261030072319_RebuildQuyChuanBaoDuong'
)
BEGIN
    ALTER TABLE [QuyChuanBaoDuongs] ADD [DongXeId] int NOT NULL DEFAULT 0;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261030072319_RebuildQuyChuanBaoDuong'
)
BEGIN
    CREATE INDEX [IX_QuyChuanBaoDuongs_DongXeId] ON [QuyChuanBaoDuongs] ([DongXeId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261030072319_RebuildQuyChuanBaoDuong'
)
BEGIN
    ALTER TABLE [QuyChuanBaoDuongs] ADD CONSTRAINT [FK_QuyChuanBaoDuongs_DongXes_DongXeId] FOREIGN KEY ([DongXeId]) REFERENCES [DongXes] ([Id]) ON DELETE NO ACTION;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261030072319_RebuildQuyChuanBaoDuong'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20261030072319_RebuildQuyChuanBaoDuong', N'9.0.0');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261101065239_AddNhanVien'
)
BEGIN
    CREATE TABLE [NhanViens] (
        [Id] int NOT NULL IDENTITY,
        [TenTaiKhoan] nvarchar(50) NOT NULL,
        [MatKhau] nvarchar(max) NOT NULL,
        [CauHoiBaoMat] nvarchar(max) NOT NULL,
        [DapAnBaoMat] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_NhanViens] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261101065239_AddNhanVien'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20261101065239_AddNhanVien', N'9.0.0');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261101115906_AddDiChiCuaHang'
)
BEGIN
    CREATE TABLE [DiaChis] (
        [Id] int NOT NULL IDENTITY,
        [TinhTP] nvarchar(100) NOT NULL,
        [PhuongXa] nvarchar(100) NOT NULL,
        CONSTRAINT [PK_DiaChis] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261101115906_AddDiChiCuaHang'
)
BEGIN
    CREATE TABLE [NhanVienUses] (
        [NhanVienId] int NOT NULL,
        [TenCuaHang] nvarchar(150) NULL,
        [TrangThai] nvarchar(50) NULL,
        [DiaChiId] int NULL,
        [TenDuong] nvarchar(150) NULL,
        [SoCuaHang] nvarchar(50) NULL,
        CONSTRAINT [PK_NhanVienUses] PRIMARY KEY ([NhanVienId]),
        CONSTRAINT [FK_NhanVienUses_DiaChis_DiaChiId] FOREIGN KEY ([DiaChiId]) REFERENCES [DiaChis] ([Id]),
        CONSTRAINT [FK_NhanVienUses_NhanViens_NhanVienId] FOREIGN KEY ([NhanVienId]) REFERENCES [NhanViens] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261101115906_AddDiChiCuaHang'
)
BEGIN
    CREATE INDEX [IX_NhanVienUses_DiaChiId] ON [NhanVienUses] ([DiaChiId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261101115906_AddDiChiCuaHang'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20261101115906_AddDiChiCuaHang', N'9.0.0');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261101124146_AddSanPhamCuaHang'
)
BEGIN
    CREATE TABLE [SanPhams] (
        [Id] int NOT NULL IDENTITY,
        [NhanVienId] int NOT NULL,
        [MaSP] nvarchar(20) NOT NULL,
        [TenSanPham] nvarchar(150) NOT NULL,
        [DonGia] decimal(18,2) NOT NULL,
        [SoLuongTon] int NOT NULL,
        CONSTRAINT [PK_SanPhams] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_SanPhams_NhanVienUses_NhanVienId] FOREIGN KEY ([NhanVienId]) REFERENCES [NhanVienUses] ([NhanVienId]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261101124146_AddSanPhamCuaHang'
)
BEGIN
    CREATE INDEX [IX_SanPhams_NhanVienId] ON [SanPhams] ([NhanVienId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261101124146_AddSanPhamCuaHang'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20261101124146_AddSanPhamCuaHang', N'9.0.0');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261101134427_AddTaoThemDiaChiCuaNguoiDung'
)
BEGIN
    ALTER TABLE [UserUses] ADD [DiaChiId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261101134427_AddTaoThemDiaChiCuaNguoiDung'
)
BEGIN
    ALTER TABLE [UserUses] ADD [SoNha] nvarchar(50) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261101134427_AddTaoThemDiaChiCuaNguoiDung'
)
BEGIN
    ALTER TABLE [UserUses] ADD [TenDuong] nvarchar(150) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261101134427_AddTaoThemDiaChiCuaNguoiDung'
)
BEGIN
    CREATE INDEX [IX_UserUses_DiaChiId] ON [UserUses] ([DiaChiId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261101134427_AddTaoThemDiaChiCuaNguoiDung'
)
BEGIN
    ALTER TABLE [UserUses] ADD CONSTRAINT [FK_UserUses_DiaChis_DiaChiId] FOREIGN KEY ([DiaChiId]) REFERENCES [DiaChis] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261101134427_AddTaoThemDiaChiCuaNguoiDung'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20261101134427_AddTaoThemDiaChiCuaNguoiDung', N'9.0.0');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261102074623_DoiQuyChuanTheoThang'
)
BEGIN
    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[QuyChuanBaoDuongs]') AND [c].[name] = N'ChiPhi');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [QuyChuanBaoDuongs] DROP CONSTRAINT [' + @var1 + '];');
    ALTER TABLE [QuyChuanBaoDuongs] DROP COLUMN [ChiPhi];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261102074623_DoiQuyChuanTheoThang'
)
BEGIN
    DECLARE @var2 sysname;
    SELECT @var2 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[QuyChuanBaoDuongs]') AND [c].[name] = N'SoKm');
    IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [QuyChuanBaoDuongs] DROP CONSTRAINT [' + @var2 + '];');
    ALTER TABLE [QuyChuanBaoDuongs] DROP COLUMN [SoKm];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261102074623_DoiQuyChuanTheoThang'
)
BEGIN
    ALTER TABLE [QuyChuanBaoDuongs] ADD [SoThang] int NOT NULL DEFAULT 1;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261102074623_DoiQuyChuanTheoThang'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20261102074623_DoiQuyChuanTheoThang', N'9.0.0');
END;

COMMIT;
GO

