-- 1. Liệt kê những dòng xe có số chỗ ngồi trên 5 chỗ
SELECT *
FROM tb_DongXe
WHERE SoChoNgoi > 5

-- 2. Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp những dòng xe
-- thuộc hãng xe “Toyota” với mức phí có đơn giá là 15.000 VNĐ/km hoặc những dòng xe
-- thuộc hãng xe “KIA” với mức phí có đơn giá là 20.000 VNĐ/km
SELECT ncc.TenNhaCC, ncc.DiaChi, ncc.SoDT, ncc.MaSoThue
FROM tb_DangKyCungCap dkcc
	JOIN tb_MucPhi mp ON dkcc.MaMP = mp.MaMP
	JOIN tb_DongXe dx ON dkcc.DongXe = dx.DongXe
	JOIN tb_NhaCungCap ncc ON dkcc.MaNhaCC = ncc.MaNhaCC
WHERE (dx.HangXe = 'Toyota' AND mp.DonGia = 15000)
	OR (dx.HangXe = 'KIA' AND mp.DonGia = 20000)

-- 3. Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên nhà cung cấp và giảm dần theo mã số thuế
SELECT *
FROM tb_NhaCungCap
ORDER BY TenNhaCC ASC, MaSoThue DESC

-- 4. Đếm số lần đăng ký cung cấp phương tiện tương ứng cho từng nhà cung cấp với
-- yêu cầu chỉ đếm cho những nhà cung cấp thực hiện đăng ký cung cấp có ngày bắt đầu cung cấp là “20/11/2015”
SELECT ncc.TenNhaCC ,COUNT(ncc.TenNhaCC) AS so_lan_CC
FROM tb_DangKyCungCap dkcc
	JOIN tb_NhaCungCap ncc ON dkcc.MaNhaCC = ncc.MaNhaCC
WHERE dkcc.NgayBatDauCC = '2015-11-20'
GROUP BY ncc.TenNhaCC

-- 5. Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe chỉ được liệt kê một lần
SELECT HangXe
FROM tb_DongXe
GROUP BY HangXe

-- 6. Nhà cung cấp chưa đăng ký cung cấp
WITH "cte_ncc_chuadk" AS (
	SELECT ncc.MaNhaCC
	FROM tb_NhaCungCap ncc
	EXCEPT
	SELECT dkcc.MaNhaCC
	FROM tb_DangKyCungCap dkcc
)
SELECT ncc.MaNhaCC, TenNhaCC, DiaChi, SoDT, MaSoThue
FROM cte_ncc_chuadk cte
JOIN tb_NhaCungCap ncc ON cte.MaNhaCC = ncc.MaNhaCC

-- 7. Hãng xe đăng ký cung cấp có nhiều xe đăng ký nhất
WITH "cte_soluongxe_dk" AS (
	SELECT DongXe, COUNT(*) AS so_luong
	FROM tb_DangKyCungCap
	GROUP BY DongXe
)
SELECT dx.HangXe, SUM(cte.so_luong) AS so_luong
FROM cte_soluongxe_dk cte
	JOIN tb_DongXe dx ON cte.DongXe = dx.DongXe
GROUP BY dx.HangXe
ORDER BY SUM(cte.so_luong) DESC

-- 8. Dịch vụ được đăng ký nhiều nhất
SELECT dv.MaLoaiDV, dv.TenLoaiDV, COUNT(*) AS soluong
FROM tb_DangKyCungCap dkcc
	JOIN tb_LoaiDichVu dv ON dkcc.MaLoaiDV = dv.MaLoaiDV
GROUP BY dv.MaLoaiDV, dv.TenLoaiDV
ORDER BY COUNT(*) DESC

-- 9. Dịch vụ có thời hạn đăng ký theo tháng
SELECT ncc.TenNhaCC, dv.TenLoaiDV, dkcc.DongXe, mp.DonGia, DATEDIFF(MONTH, dkcc.NgayBatDauCC, dkcc.NgayKetThucCC) AS so_thang
FROM tb_DangKyCungCap dkcc
	JOIN tb_NhaCungCap ncc ON dkcc.MaNhaCC = ncc.MaNhaCC
	JOIN tb_LoaiDichVu dv ON dkcc.MaLoaiDV = dv.MaLoaiDV
	JOIN tb_MucPhi mp ON dkcc.MaMP = mp.MaMP
ORDER BY so_thang DESC

-- 10. Nhà cung cấp đăng ký từ 2 lần trở lên
SELECT MaNhaCC, COUNT(*)
FROM tb_DangKyCungCap
GROUP BY MaNhaCC

-- 11. Ngày bắt đầu cung cấp đầu tiên của mỗi nhà cung cấp
WITH cte_ngay_bdcc AS (
	SELECT dkcc.MaNhaCC, dkcc.NgayBatDauCC ,ROW_NUMBER() OVER(PARTITION BY dkcc.MaNhaCC ORDER BY dkcc.NgayBatDauCC) AS RN
	FROM tb_DangKyCungCap dkcc
)
SELECT ncc.MaNhaCC, ncc.TenNhaCC, cte.NgayBatDauCC
FROM tb_NhaCungCap ncc
	JOIN cte_ngay_bdcc cte ON ncc.MaNhaCC = cte.MaNhaCC
WHERE cte.RN = 1


