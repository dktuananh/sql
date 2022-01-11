USE master
GO
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'THUEXE_DB')
BEGIN
	CREATE DATABASE THUEXE_DB
END;
GO
USE THUEXE_DB
GO
IF NOT EXISTS(SELECT * FROM sysobjects WHERE name = 'tb_NhaCungCap' and xtype='U')
BEGIN
	CREATE TABLE tb_NhaCungCap
	(
		[MaNhaCC] [NVARCHAR] (8) PRIMARY KEY,
		[TenNhaCC] [NVARCHAR] (50) NOT NULL,
		[DiaChi] [NVARCHAR] (30) NOT NUll,
		[SoDT] [VARCHAR] (15) NULL,
		[MaSoThue] [NVARCHAR] (15) NOT NULL
	)
END;

GO
IF NOT EXISTS(SELECT * FROM sysobjects WHERE name = 'tb_LoaiDichVu' and xtype='U')
BEGIN
	CREATE TABLE tb_LoaiDichVu
	(
		[MaLoaiDV] [NVARCHAR] (6) PRIMARY KEY,
		[TenLoaiDV] [NVARCHAR] (50) NOT NUll	
	)
END;

GO
IF NOT EXISTS(SELECT * FROM sysobjects WHERE name = 'tb_MucPhi' and xtype='U')
BEGIN
	CREATE TABLE tb_MucPhi
	(
		[MaMP] [NVARCHAR] (5) PRIMARY KEY,
		[DonGia] [NVARCHAR] (7) NOT NULL,
		[MoTa] [NVARCHAR] (30) NULL
	)
END;

GO
IF NOT EXISTS(SELECT * FROM sysobjects WHERE name = 'tb_DongXe' and xtype='U')
BEGIN
	CREATE TABLE tb_DongXe
	(
		[DongXe] [NVARCHAR] (15) PRIMARY KEY,
		[HangXe] [NVARCHAR] (10) NOT NULL,
		[SoChoNgoi] [INT] NOT NULL
	)
END;

GO
IF NOT EXISTS(SELECT * FROM sysobjects WHERE name = 'tb_DangKyCungCap' and xtype='U')
BEGIN
	CREATE TABLE tb_DangKyCungCap
	(
		[MaDKCC] [NVARCHAR] (7) PRIMARY KEY,
		[MaNhaCC] [NVARCHAR] (8) NOT NULL,
		[MaLoaiDV] [NVARCHAR] (6) NOT NULL,
		[DongXe] [NVARCHAR] (15) NOT NULL,
		[MaMP] [NVARCHAR] (5) NOT NULL,
		[NgayBatDauCC] [DATETIME] NOT NULL,
		[NgayKetThucCC] [DATETIME] NOT NULL,
		[SoLuongXeDK] [INT] NOT NULL,
	)
END;

GO
 
Insert Into tb_NhaCungCap ([MaNhaCC], [TenNhaCC], [DiaChi], [SoDT], [MaSoThue]) Values ('NCC001', N'Cty TNHH Toàn Phát', 'Hai Chau', '051133999888', '568941')
Insert Into tb_NhaCungCap ([MaNhaCC], [TenNhaCC], [DiaChi], [SoDT], [MaSoThue]) Values ('NCC002', N'Cty Cổ Phần Đông Du', 'Lien Chieu', '051133999889', '456789')
Insert Into tb_NhaCungCap ([MaNhaCC], [TenNhaCC], [DiaChi], [SoDT], [MaSoThue]) Values ('NCC003', N'Ông Nguyễn Văn A', 'Hoa Thuan', '051133999890', '321456')
Insert Into tb_NhaCungCap ([MaNhaCC], [TenNhaCC], [DiaChi], [SoDT], [MaSoThue]) Values ('NCC004', N'Cty Cổ Phần Toàn Cầu Xanh', 'Hai Chau', '05113658945', '513364')
Insert Into tb_NhaCungCap ([MaNhaCC], [TenNhaCC], [DiaChi], [SoDT], [MaSoThue]) Values ('NCC005', N'Cty TNHH AMA', 'Thanh Khe', '051103875466', '546546')
Insert Into tb_NhaCungCap ([MaNhaCC], [TenNhaCC], [DiaChi], [SoDT], [MaSoThue]) Values ('NCC006', N'Bà Trần Thị Bích Vân', 'Lien Chieu', '05113587469', '524545')
Insert Into tb_NhaCungCap ([MaNhaCC], [TenNhaCC], [DiaChi], [SoDT], [MaSoThue]) Values ('NCC007', N'Cty TNHH Phan Thành', 'Thanh Khe', '05113987456', '113021')
Insert Into tb_NhaCungCap ([MaNhaCC], [TenNhaCC], [DiaChi], [SoDT], [MaSoThue]) Values ('NCC008', N'Ông Phan Đình Nam', 'Hoa Thuan', '05113532456', '121230')
Insert Into tb_NhaCungCap ([MaNhaCC], [TenNhaCC], [DiaChi], [SoDT], [MaSoThue]) Values ('NCC009', N'Tập đoàn Đông Nam Á', 'Lien Chieu', '05113987121', '533654')
Insert Into tb_NhaCungCap ([MaNhaCC], [TenNhaCC], [DiaChi], [SoDT], [MaSoThue]) Values ('NCC010', N'Cty Cổ Phần Rạng đông', 'Lien Chieu', '05113569654', '187864')
 
 
Insert Into tb_LoaiDichVu ([MaLoaiDV], [TenLoaiDV]) Values ('DV01', N'Dịch vụ xe taxi')
Insert Into tb_LoaiDichVu ([MaLoaiDV], [TenLoaiDV]) Values ('DV02', N'Dịch vụ xe buýt công cộng theo tuyến cố định')
Insert Into tb_LoaiDichVu ([MaLoaiDV], [TenLoaiDV]) Values ('DV03', N'Dịch vụ cho thuê xe theo hợp đồng')
 
Insert Into tb_MucPhi ([MaMP],[DonGia],[MoTa]) Values ('MP01', '10000', N'Áp dụng từ ngày 1/2015')
Insert Into tb_MucPhi ([MaMP],[DonGia],[MoTa]) Values ('MP02', '15000', N'Áp dụng từ ngày 2/2015')
Insert Into tb_MucPhi ([MaMP],[DonGia],[MoTa]) Values ('MP03', '20000', N'Áp dụng từ ngày 1/2010')
Insert Into tb_MucPhi ([MaMP],[DonGia],[MoTa]) Values ('MP04', '25000', N'Áp dụng từ ngày 2/2011')
 
Insert Into tb_DongXe ([DongXe],[HangXe],[SoChoNgoi]) Values ('Hiace', 'Toyota', 16)
Insert Into tb_DongXe ([DongXe],[HangXe],[SoChoNgoi]) Values ('Vios', 'Toyota', 5)
Insert Into tb_DongXe ([DongXe],[HangXe],[SoChoNgoi]) Values ('Escape', 'Ford', 5)
Insert Into tb_DongXe ([DongXe],[HangXe],[SoChoNgoi]) Values ('Cerato', 'KIA', 7)
Insert Into tb_DongXe ([DongXe],[HangXe],[SoChoNgoi]) Values ('Forte', 'KIA', 5)
Insert Into tb_DongXe ([DongXe],[HangXe],[SoChoNgoi]) Values ('Starex', 'Huyndai', 7)
Insert Into tb_DongXe ([DongXe],[HangXe],[SoChoNgoi]) Values ('Grand-i10', 'Huyndai', 7)
 
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK001', 'NCC001', 'DV01', 'Hiace', 'MP01', '2015/11/20', '2016/11/20', 4)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK002', 'NCC002', 'DV02', 'Vios', 'MP02', '2015/11/20', '2017/11/20', 3)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK003', 'NCC003', 'DV03', 'Escape', 'MP03', '2017/11/20', '2018/11/20', 5)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK004', 'NCC005', 'DV01', 'Cerato', 'MP04', '2015/11/20', '2019/11/20', 7)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK005', 'NCC002', 'DV02', 'Forte', 'MP03', '2019/11/20', '2020/11/20', 1)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK006', 'NCC004', 'DV03', 'Starex', 'MP04', '2016/11/10', '2021/11/20', 2)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK007', 'NCC005', 'DV01', 'Cerato', 'MP03', '2015/11/30', '2016/01/25', 8)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK008', 'NCC006', 'DV01', 'Vios', 'MP02', '2016/02/28', '2016/08/15', 9)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK009', 'NCC005', 'DV03', 'Grand-i10', 'MP02', '2016/04/27', '2017/04/30', 10)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK010', 'NCC006', 'DV01', 'Forte', 'MP02', '2016/11/21', '2016/02/22', 4)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK011', 'NCC007', 'DV01', 'Forte', 'MP01', '2016/12/25', '2017/02/20', 5)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK012', 'NCC007', 'DV03', 'Cerato', 'MP01', '2016/04/14', '2017/12/20', 6)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK013', 'NCC003', 'DV02', 'Cerato', 'MP01', '2015/12/21', '2016/12/21', 8)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK014', 'NCC008', 'DV02', 'Cerato', 'MP01', '2016/05/20', '2016/12/30', 1)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK015', 'NCC003', 'DV01', 'Hiace', 'MP02', '2018/04/24', '2019/11/20', 6)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK016', 'NCC001', 'DV03', 'Grand-i10', 'MP02', '2016/06/22', '2016/12/21', 8)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK017', 'NCC002', 'DV03', 'Cerato', 'MP03', '2016/09/30', '2019/09/30', 4)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK018', 'NCC008', 'DV03', 'Espace', 'MP04', '2017/12/13', '2018/09/30', 2)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK019', 'NCC003', 'DV03', 'Espace', 'MP03', '2016/01/24', '2016/12/30', 8)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK020', 'NCC002', 'DV03', 'Cerato', 'MP04', '2016/05/03', '2017/10/21', 7)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK021', 'NCC006', 'DV01', 'Forte', 'MP02', '2015/01/30', '2016/12/30', 9)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK022', 'NCC002', 'DV02', 'Cerato', 'MP04', '2016/07/25', '2017/12/30', 6)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK023', 'NCC002', 'DV01', 'Forte', 'MP03', '2017/11/30', '2018/05/20', 5)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK024', 'NCC003', 'DV03', 'Forte', 'MP04', '2017/12/23', '2019/11/30', 8)
Insert Into tb_DangKyCungCap ([MaDKCC],[MaNhaCC],[MaLoaiDV],[DongXe],[MaMP],[NgayBatDauCC],[NgayKetThucCC], [SoLuongXeDK]) Values ('DK025', 'NCC003', 'DV03', 'Hiace', 'MP02', '2016/08/24', '2017/10/25', 1)