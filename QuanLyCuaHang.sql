USE [QuanLyCuaHang]
GO
/****** Object:  StoredProcedure [dbo].[pr_DoanhThu]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[pr_DoanhThu]
as
begin
	select DATEPART(MONTH, NgayBan), sum(SoLuongBan*GiaBan)  from CTHDBanHang, HDBanHang 
	where HDBanHang.MaHDBH = CTHDBanHang.MaHDBH and DATEPART(YEAR, NgayBan) = 2018
	group by DATEPART(MONTH, NgayBan)
end
GO
/****** Object:  StoredProcedure [dbo].[pr_MHBanChay]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[pr_MHBanChay]
@thang int
as
begin
	select top 10 CTHDBanHang.MaMH ,TenMH, sum(SoLuongBan)  from TTMatHang,CTHDBanHang, HDBanHang 
	where TTMatHang.MaMH = CTHDBanHang.MaMH and HDBanHang.MaHDBH = CTHDBanHang.MaHDBH and DATEPART(MONTH, NgayBan) = @thang
	group by CTHDBanHang.MaMH , TenMH
	order by Sum(SoLuongBan) DESC
end
GO
/****** Object:  StoredProcedure [dbo].[pr_SoLuongTon]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[pr_SoLuongTon]
@thang int
as
begin
	select top 10 MaMH, TenMH, SoLuong from TTMatHang
	order by SoLuong Desc
end
GO
/****** Object:  StoredProcedure [dbo].[sp_CTHDBanHang_Insert]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CTHDBanHang_Insert] 
	@MaHDBH NVARCHAR(50),
	@MaMH NVARCHAR(50),
	@SoLuongBan INT,
	@GiaBan INT
AS
BEGIN
	INSERT dbo.CTHDBanHang
	        ( MaHDBH, MaMH, SoLuongBan, GiaBan )
	VALUES  ( @MaHDBH, @MaMH, @SoLuongBan, @GiaBan
	          )

	
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_CTHDNhap_Insert]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[sp_CTHDNhap_Insert] 
	@MaHDNhap NVARCHAR(50),
	@MaMH NVARCHAR(50),
	@SoLuongNhap INT,
	@GiaNhap INT
AS
BEGIN
	INSERT dbo.CTHDNhap
	        ( MaHDNhap, MaMH, SoLuongNhap, GiaNhap )
	VALUES  ( @MaHDNhap, @MaMH, @SoLuongNhap, @GiaNhap
	          )

	
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_CTHDXuat_Insert]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[sp_CTHDXuat_Insert] 
	@MaHDXuat NVARCHAR(50),
	@MaMH NVARCHAR(50),
	@SoLuongXuat INT,
	@GiaXuat INT
AS
BEGIN
	INSERT dbo.CTHDXuat
	        ( MaHDXuat, MaMH, SoLuongXuat, GiaXuat )
	VALUES  ( @MaHDXuat, @MaMH, @SoLuongXuat, @GiaXuat
	          )

	
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetByTop]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetByTop]
@Top nvarchar(50),
@Where nvarchar(MAX),
@Order nvarchar(50),
@Name NVARCHAR(50)
as
begin
declare @Sql nvarchar(MAX)
set @Sql='select'
if (Len(@Top)>0)
begin
set @Sql=@Sql+' top '+@Top
end
set @Sql = @Sql + '* from '+@Name
if (len(@Where)>0 )
begin
set @Sql=@Sql+' where '+@Where
end
if (len(@Order)>0 )
begin
set @Sql=@Sql+' Order by '+@Order
end

exec (@Sql)
End

GO
/****** Object:  StoredProcedure [dbo].[sp_HDBanHang_Add]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_HDBanHang_Add]
@NgayBan DATETIME,
@TenNhanVien NVARCHAR(50),
@ThanhTien INT
AS
BEGIN
	DECLARE @MAXValue VARCHAR(10),@NEWValue VARCHAR(10),@NEW_ID VARCHAR(10),@soluong INT;
	SET @soluong = (SELECT COUNT(MaHDBH) FROM dbo.HDBanHang);
	IF(@soluong>0)
	BEGIN
	SET @MAXValue = (SELECT TOP 1 MaHDBH FROM dbo.HDBanHang ORDER BY MaHDBH DESC);
	SET @NEWValue= REPLACE(@MaxValue,'HD','')+1
	SET @NEW_ID = 'HD'+
    CASE
       WHEN LEN(@NEWValue)<2
          THEN REPLICATE('0',2-LEN(@newValue))
          ELSE ''
       END +@NEWValue
	END
	ELSE SET @NEW_ID='HD01'
	INSERT dbo.HDBanHang
	        ( MaHDBH, NgayBan,TenNhanVien,ThanhTien )
	VALUES  ( @NEW_ID,
	          @NgayBan,
			  @TenNhanVien,
			  @ThanhTien 
	          )

END
GO
/****** Object:  StoredProcedure [dbo].[sp_HDBanHang_Delete]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_HDBanHang_Delete]
	@MaHDBH NVARCHAR(50)
AS
BEGIN
	DELete from CTHDBanHang where MaHDBH=@MaHDBH
	DELETE FROM dbo.HDBanHang WHERE MaHDBH=@MaHDBH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_HDBanHang_Update]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_HDBanHang_Update] 
	@MaHDBH NVARCHAR(50),
	@MaMH NVARCHAR(50),
	@NgayBan DATETIME,
	@TenNhanVien NVARCHAR(50)
AS
BEGIN
	UPDATE dbo.HDBanHang
	SET 
	MaHDBH=@MaMH,
	NgayBan=@NgayBan,
	TenNhanVien=@TenNhanVien
	WHERE MaHDBH=@MaHDBH
	
END


GO
/****** Object:  StoredProcedure [dbo].[sp_HDNhap_Add]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_HDNhap_Add]
@NgayNhap DATETIME
AS
BEGIN
	DECLARE @MAXValue VARCHAR(10),@NEWValue VARCHAR(10),@NEW_ID VARCHAR(10),@soluong INT;
	SET @soluong = (SELECT COUNT(MaHDNhap) FROM dbo.HDNhap);
	IF(@soluong>0)
	BEGIN
	SET @MAXValue = (SELECT TOP 1 MaHDNhap FROM dbo.HDNhap ORDER BY MaHDNhap DESC);
	SET @NEWValue= REPLACE(@MaxValue,'HDN','')+1
	SET @NEW_ID = 'HDN'+
    CASE
       WHEN LEN(@NEWValue)<2
          THEN REPLICATE('0',2-LEN(@newValue))
          ELSE ''
       END +@NEWValue
	END
	ELSE SET @NEW_ID='HDN01'
	INSERT dbo.HDNhap
	        ( MaHDNhap, NgayNhap )
	VALUES  ( @NEW_ID,
			  @NgayNhap 
	          )

END
GO
/****** Object:  StoredProcedure [dbo].[sp_HDNhap_Delete]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[sp_HDNhap_Delete]
	@MaHDNhap NVARCHAR(50)
AS
BEGIN
	DELETE FROM dbo.HDNhap WHERE MaHDNhap=@MaHDNhap
END

GO
/****** Object:  StoredProcedure [dbo].[sp_HDXuat_Add]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_HDXuat_Add]
@NgayXuat DATETIME
AS
BEGIN
	DECLARE @MAXValue VARCHAR(10),@NEWValue VARCHAR(10),@NEW_ID VARCHAR(10),@soluong INT;
	SET @soluong = (SELECT COUNT(MaHDXuat) FROM dbo.HDXuat);
	IF(@soluong>0)
	BEGIN
	SET @MAXValue = (SELECT TOP 1 MaHDXuat FROM dbo.HDXuat ORDER BY MaHDXuat DESC);
	SET @NEWValue= REPLACE(@MaxValue,'HDX','')+1
	SET @NEW_ID = 'HDX'+
    CASE
       WHEN LEN(@NEWValue)<2
          THEN REPLICATE('0',2-LEN(@newValue))
          ELSE ''
       END +@NEWValue
	END
	ELSE SET @NEW_ID='HDX01'
	INSERT dbo.HDXuat
	        ( MaHDXuat, NgayXuat )
	VALUES  ( @NEW_ID,
			  @NgayXuat 
	          )

END
GO
/****** Object:  StoredProcedure [dbo].[sp_HDXuat_Delete]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[sp_HDXuat_Delete]
	@MaHDXuat NVARCHAR(50)
AS
BEGIN
	DELETE FROM dbo.HDXuat WHERE MaHDXuat=@MaHDXuat
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TaiKhoan_Add]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_TaiKhoan_Add]
	@TenDangNhap NVARCHAR(50),
	@MatKhau NVARCHAR(50),
	@TenNhanVien NVARCHAR(50),
	@TrangThai INT,
	@MaQuyen NVARCHAR(50)


AS
BEGIN
	INSERT dbo.TaiKhoan
	        ( TenDangNhap,MatKhau,TenNhanVien,TrangThai,MaQuyen )
	VALUES  ( @TenDangNhap,@MatKhau,@TenNhanVien,@TrangThai,@MaQuyen 
	          )

END
GO
/****** Object:  StoredProcedure [dbo].[sp_TaiKhoan_Update]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_TaiKhoan_Update] 
	@TenDangNhap NVARCHAR(50),
	@MatKhau NVARCHAR(50),
	@TenNhanVien NVARCHAR(50),
	@TrangThai INT,
	@MaQuyen NVARCHAR(50)
AS
BEGIN
	UPDATE dbo.TaiKhoan
	SET 
	MatKhau = @MatKhau,
	TenNhanVien = @TenNhanVien,
	TrangThai = @TrangThai,
	MaQuyen = @MaQuyen
	WHERE TenDangNhap=@TenDangNhap
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TTinMatHangBan_Update]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_TTinMatHangBan_Update] 
	@MaMH NVARCHAR(50),
	@SoLuong INT
AS
BEGIN
	UPDATE dbo.TTMatHang
	SET 
	SoLuong = SoLuong-@SoLuong
	WHERE MaMH=@MaMH
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TTinMatHangNhap_Update]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[sp_TTinMatHangNhap_Update] 
	@MaMH NVARCHAR(50),
	@SoLuong INT
AS
BEGIN
	UPDATE dbo.TTMatHang
	SET 
	SoLuong = SoLuong+@SoLuong
	WHERE MaMH=@MaMH
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TTMatHang_Add]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_TTMatHang_Add]
@TenMH NVARCHAR(50),
@Size INT,
@SoLuongTon  INT,
@Gia INT,
@Mota NVARCHAR(MAX)


AS
BEGIN
	DECLARE @MAXValue VARCHAR(10),@NEWValue VARCHAR(10),@NEW_ID VARCHAR(10),@soluong INT;
	SET @soluong = (SELECT COUNT(MaMH) FROM dbo.TTMatHang);
	IF(@soluong>0)
	BEGIN
	SET @MAXValue = (SELECT TOP 1 MaMH FROM dbo.TTMatHang ORDER BY MaMH DESC);
	SET @NEWValue= REPLACE(@MaxValue,'MH','')+1
	SET @NEW_ID = 'MH'+
    CASE
       WHEN LEN(@NEWValue)<2
          THEN REPLICATE('0',2-LEN(@newValue))
          ELSE ''
       END +@NEWValue
	END
	ELSE SET @NEW_ID='MH01'
	INSERT dbo.TTMatHang
	        ( MaMH, TenMH, Size, SoLuong, Gia, MoTa )
	VALUES  ( @NEW_ID,
		   @TenMH,
		   @Size,
		   @SoLuongTon,
		   @Gia,
		   @Mota
	          )

END
GO
/****** Object:  StoredProcedure [dbo].[sp_TTMatHang_Update]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_TTMatHang_Update] 
	@MaMH NVARCHAR(50),
	@TenMH NVARCHAR(50),
	@Size INT,
	@SoLuong INT,
	@Gia INT,
	@MoTa NVARCHAR (MAX)
AS
BEGIN
	UPDATE dbo.TTMatHang
	SET 
	TenMH=@TenMH,
	Size=@Size,
	SoLuong=@SoLuong,
	Gia=@Gia,
	MoTa=@Mota
	WHERE MaMH=@MaMH
	
END
GO
/****** Object:  Table [dbo].[CTHDBanHang]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTHDBanHang](
	[MaHDBH] [nvarchar](50) NOT NULL,
	[MaMH] [nvarchar](50) NOT NULL,
	[SoLuongBan] [int] NULL,
	[GiaBan] [int] NULL,
 CONSTRAINT [PK_CTHDBanHang] PRIMARY KEY CLUSTERED 
(
	[MaHDBH] ASC,
	[MaMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CTHDNhap]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTHDNhap](
	[MaHDNhap] [nvarchar](50) NOT NULL,
	[MaMH] [nvarchar](50) NOT NULL,
	[SoLuongNhap] [int] NULL,
	[GiaNhap] [int] NULL,
 CONSTRAINT [PK_CTHDNhap] PRIMARY KEY CLUSTERED 
(
	[MaHDNhap] ASC,
	[MaMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CTHDXuat]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTHDXuat](
	[MaHDXuat] [nvarchar](50) NOT NULL,
	[MaMH] [nvarchar](50) NOT NULL,
	[SoLuongXuat] [int] NULL,
	[GiaXuat] [int] NULL,
 CONSTRAINT [PK_CTHDXuat] PRIMARY KEY CLUSTERED 
(
	[MaHDXuat] ASC,
	[MaMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HDBanHang]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HDBanHang](
	[MaHDBH] [nvarchar](50) NOT NULL,
	[NgayBan] [datetime] NULL,
	[TenNhanVien] [nvarchar](50) NULL,
	[ThanhTien] [int] NULL,
 CONSTRAINT [PK_HDBanHang] PRIMARY KEY CLUSTERED 
(
	[MaHDBH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HDNhap]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HDNhap](
	[MaHDNhap] [nvarchar](50) NOT NULL,
	[NgayNhap] [datetime] NULL,
 CONSTRAINT [PK_HDNhap] PRIMARY KEY CLUSTERED 
(
	[MaHDNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HDXuat]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HDXuat](
	[MaHDXuat] [nvarchar](50) NOT NULL,
	[NgayXuat] [datetime] NULL,
 CONSTRAINT [PK_HDXuat] PRIMARY KEY CLUSTERED 
(
	[MaHDXuat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Quyen]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quyen](
	[MaQuyen] [nvarchar](50) NOT NULL,
	[SoLuongNguoi] [int] NULL,
 CONSTRAINT [PK_Quyen] PRIMARY KEY CLUSTERED 
(
	[MaQuyen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[TenDangNhap] [nvarchar](50) NOT NULL,
	[MatKhau] [nvarchar](50) NOT NULL,
	[TenNhanVien] [nvarchar](50) NULL,
	[TrangThai] [int] NULL,
	[MaQuyen] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TaiKhoan] PRIMARY KEY CLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TTMatHang]    Script Date: 6/19/2018 10:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TTMatHang](
	[MaMH] [nvarchar](50) NOT NULL,
	[TenMH] [nvarchar](50) NULL,
	[Size] [int] NULL,
	[SoLuong] [int] NULL,
	[Gia] [int] NULL,
	[MoTa] [nvarchar](max) NULL,
 CONSTRAINT [PK_TTMatHang] PRIMARY KEY CLUSTERED 
(
	[MaMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD01', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD01', N'MH10', 1, 55)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD02', N'MH12', 2, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD02', N'MH13', 4, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD03', N'MH14', 4, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD04', N'MH10', 2, 55)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD04', N'MH12', 2, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD04', N'MH17', 2, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD05', N'MH12', 2, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD05', N'MH16', 2, 40)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD05', N'MH17', 2, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD05', N'MH19', 2, 80)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD06', N'MH02', 2, 60)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD06', N'MH03', 2, 40)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD06', N'MH11', 2, 85)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD06', N'MH17', 2, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD07', N'MH02', 2, 60)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD07', N'MH04', 2, 65)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD07', N'MH05', 2, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD07', N'MH06', 2, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD08', N'MH05', 2, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD08', N'MH07', 2, 70)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD08', N'MH08', 2, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD08', N'MH09', 2, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD09', N'MH08', 2, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD09', N'MH10', 2, 55)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD09', N'MH11', 2, 85)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD09', N'MH12', 2, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD10', N'MH11', 2, 85)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD10', N'MH12', 2, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD10', N'MH14', 2, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD11', N'MH12', 2, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD11', N'MH15', 2, 60)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD11', N'MH16', 2, 40)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD11', N'MH17', 2, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD11', N'MH18', 1, 70)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD11', N'MH19', 5, 80)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD11', N'MH20', 7, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD12', N'MH01', 8, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD12', N'MH02', 7, 60)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD12', N'MH03', 7, 40)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD12', N'MH16', 2, 40)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD12', N'MH18', 1, 70)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD12', N'MH20', 7, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD13', N'MH02', 7, 60)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD13', N'MH14', 7, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD13', N'MH20', 7, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD14', N'MH14', 7, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD15', N'MH14', 7, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD15', N'MH15', 7, 60)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD15', N'MH16', 7, 40)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD15', N'MH18', 4, 70)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD15', N'MH19', 4, 80)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD16', N'MH01', 4, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD16', N'MH03', 4, 40)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD16', N'MH16', 7, 40)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD16', N'MH19', 4, 80)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD17', N'MH01', 4, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD17', N'MH08', 4, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD17', N'MH09', 4, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD18', N'MH09', 4, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD18', N'MH12', 4, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD18', N'MH13', 4, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD19', N'MH12', 4, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD19', N'MH16', 4, 40)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD19', N'MH18', 4, 70)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD20', N'MH18', 4, 70)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD20', N'MH20', 4, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD21', N'MH05', 4, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD21', N'MH07', 4, 70)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD22', N'MH06', 4, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD22', N'MH07', 4, 70)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD23', N'MH01', 4, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD23', N'MH02', 4, 60)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD24', N'MH09', 4, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD24', N'MH15', 4, 60)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD25', N'MH12', 4, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD25', N'MH14', 4, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD25', N'MH15', 4, 60)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD25', N'MH19', 4, 80)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD25', N'MH20', 4, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD26', N'MH08', 3, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD26', N'MH12', 4, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD26', N'MH14', 4, 45)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD26', N'MH17', 4, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD26', N'MH19', 4, 80)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD27', N'MH02', 1, 60)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD27', N'MH04', 3, 65)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD27', N'MH10', 1, 55)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD27', N'MH12', 1, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD28', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD28', N'MH03', 1, 40)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD28', N'MH04', 2, 65)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD28', N'MH10', 2, 55)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD29', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD29', N'MH10', 2, 55)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD30', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD30', N'MH02', 1, 60)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD30', N'MH03', 1, 40)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD30', N'MH12', 1, 75)
GO
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD30', N'MH20', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD31', N'MH02', 1, 60)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD31', N'MH11', 2, 85)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD31', N'MH20', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD32', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD32', N'MH10', 2, 55)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD33', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD34', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD35', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD36', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD37', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD38', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD39', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD39', N'MH02', 1, 60)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD40', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD40', N'MH10', 2, 55)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD40', N'MH11', 2, 85)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD41', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD41', N'MH10', 1, 55)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD42', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD42', N'MH12', 2, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD43', N'MH03', 3, 40)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD43', N'MH04', 3, 65)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD43', N'MH12', 3, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD44', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD45', N'MH01', 4, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD45', N'MH10', 4, 55)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD46', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD47', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD48', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD49', N'MH02', 1, 60)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD51', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD52', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD52', N'MH20', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD53', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD54', N'MH10', 1, 55)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD54', N'MH11', 1, 85)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD55', N'MH20', 4, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD56', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD56', N'MH20', 2, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD57', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD58', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD59', N'MH01', 3, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD59', N'MH10', 3, 55)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD60', N'MH01', 3, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD62', N'MH01', 3, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD63', N'MH10', 1, 55)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD64', N'MH01', 1, 50)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD64', N'MH10', 3, 55)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD64', N'MH12', 5, 75)
INSERT [dbo].[CTHDBanHang] ([MaHDBH], [MaMH], [SoLuongBan], [GiaBan]) VALUES (N'HD64', N'MH20', 8, 50)
INSERT [dbo].[CTHDNhap] ([MaHDNhap], [MaMH], [SoLuongNhap], [GiaNhap]) VALUES (N'HDN01', N'MH01', 1, 50)
INSERT [dbo].[CTHDNhap] ([MaHDNhap], [MaMH], [SoLuongNhap], [GiaNhap]) VALUES (N'HDN02', N'MH01', 1, 50)
INSERT [dbo].[CTHDNhap] ([MaHDNhap], [MaMH], [SoLuongNhap], [GiaNhap]) VALUES (N'HDN03', N'MH01', 4, 50)
INSERT [dbo].[CTHDXuat] ([MaHDXuat], [MaMH], [SoLuongXuat], [GiaXuat]) VALUES (N'HDX01', N'MH01', 1, 50)
INSERT [dbo].[CTHDXuat] ([MaHDXuat], [MaMH], [SoLuongXuat], [GiaXuat]) VALUES (N'HDX02', N'MH01', 1, 50)
INSERT [dbo].[CTHDXuat] ([MaHDXuat], [MaMH], [SoLuongXuat], [GiaXuat]) VALUES (N'HDX02', N'MH10', 1, 55)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD01', CAST(N'2018-01-15 01:07:22.000' AS DateTime), N'Ha Pham', 105)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD02', CAST(N'2018-01-15 01:07:22.000' AS DateTime), N'Ha Pham', 450)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD03', CAST(N'2018-01-15 01:07:22.000' AS DateTime), N'Ha Pham', 180)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD04', CAST(N'2018-02-15 01:07:22.000' AS DateTime), N'Ha Pham', 470)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD05', CAST(N'2018-02-15 01:07:22.000' AS DateTime), N'Ha Pham', 490)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD06', CAST(N'2018-03-15 01:07:22.000' AS DateTime), N'Ha Pham', 470)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD07', CAST(N'2018-02-15 01:07:22.000' AS DateTime), N'Ha Pham', 430)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD08', CAST(N'2018-03-15 01:07:22.000' AS DateTime), N'Ha Pham', 410)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD09', CAST(N'2018-03-15 01:07:22.000' AS DateTime), N'Ha Pham', 520)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD10', CAST(N'2018-04-15 01:07:22.000' AS DateTime), N'Ha Pham', 560)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD11', CAST(N'2018-04-15 01:07:22.000' AS DateTime), N'Ha Pham', 1270)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD12', CAST(N'2018-05-15 01:07:22.000' AS DateTime), N'Ha Pham', 1600)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD13', CAST(N'2018-05-15 01:07:22.000' AS DateTime), N'Ha Pham', 1085)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD14', CAST(N'2018-01-15 01:07:22.000' AS DateTime), N'Ha Pham', 945)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD15', CAST(N'2018-02-15 01:07:22.000' AS DateTime), N'Ha Pham', 1615)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD16', CAST(N'2018-03-15 01:07:22.000' AS DateTime), N'Ha Pham', 960)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD17', CAST(N'2018-04-15 01:07:22.000' AS DateTime), N'Ha Pham', 560)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD18', CAST(N'2018-05-15 01:07:22.000' AS DateTime), N'Ha Pham', 780)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD19', CAST(N'2018-04-15 01:07:22.000' AS DateTime), N'Ha Pham', 740)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD20', CAST(N'2018-06-15 01:07:22.000' AS DateTime), N'Ha Pham', 480)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD21', CAST(N'2018-05-15 01:07:22.000' AS DateTime), N'Ha Pham', 460)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD22', CAST(N'2018-06-15 01:07:22.000' AS DateTime), N'Ha Pham', 460)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD23', CAST(N'2018-02-15 01:07:22.000' AS DateTime), N'Ha Pham', 440)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD24', CAST(N'2018-06-15 01:07:22.000' AS DateTime), N'Ha Pham', 420)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD25', CAST(N'2018-06-15 01:07:22.000' AS DateTime), N'Ha Pham', 1240)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD26', CAST(N'2018-01-15 01:07:22.000' AS DateTime), N'Ha Pham', 1315)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD27', CAST(N'2018-06-15 01:14:22.000' AS DateTime), N'Ha Pham', 385)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD28', CAST(N'2018-06-15 01:15:58.000' AS DateTime), N'Ha Pham', 330)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD29', CAST(N'2018-06-15 01:26:29.000' AS DateTime), N'Ha Pham', 160)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD30', CAST(N'2018-06-15 01:30:03.000' AS DateTime), N'Ha Pham', 275)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD31', CAST(N'2018-06-15 01:30:03.000' AS DateTime), N'Ha Pham', 280)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD32', CAST(N'2018-06-15 01:32:20.000' AS DateTime), N'Ha Pham', 160)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD33', CAST(N'2018-02-15 01:33:08.000' AS DateTime), N'Ha Pham', 50)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD34', CAST(N'2018-06-15 01:34:37.000' AS DateTime), N'Ha Pham', 50)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD35', CAST(N'2018-01-15 01:36:19.000' AS DateTime), N'Ha Pham', 50)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD36', CAST(N'2018-02-15 01:37:02.000' AS DateTime), N'Ha Pham', 50)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD37', CAST(N'2018-03-15 01:39:25.000' AS DateTime), N'Ha Pham', 50)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD38', CAST(N'2018-06-15 01:40:07.000' AS DateTime), N'Ha Pham', 50)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD39', CAST(N'2018-05-15 01:41:47.000' AS DateTime), N'Ha Pham', 110)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD40', CAST(N'2018-06-15 01:42:45.000' AS DateTime), N'Ha Pham', 330)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD41', CAST(N'2018-06-15 01:43:26.000' AS DateTime), N'Ha Pham', 105)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD42', CAST(N'2018-06-15 01:44:47.000' AS DateTime), N'Ha Pham', 200)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD43', CAST(N'2018-06-15 01:44:47.000' AS DateTime), N'Ha Pham', 735)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD44', CAST(N'2018-06-15 01:54:58.000' AS DateTime), N'Ha Pham', 50)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD45', CAST(N'2018-06-15 02:00:44.000' AS DateTime), N'Ha Pham', 420)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD46', CAST(N'2018-06-15 05:38:38.000' AS DateTime), N'Ha Pham', 50)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD47', CAST(N'2018-06-15 06:46:49.000' AS DateTime), N'Ha Pham', 50)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD48', CAST(N'2018-06-15 12:34:12.000' AS DateTime), N'Ha Pham', 50)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD49', CAST(N'2018-06-15 12:36:29.000' AS DateTime), N'Ha Pham', 60)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD50', CAST(N'2018-06-17 03:03:12.000' AS DateTime), N'Ha Pham', 50)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD51', CAST(N'2018-06-17 03:04:36.000' AS DateTime), N'Ha Pham', 50)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD52', CAST(N'2018-06-17 03:04:36.000' AS DateTime), N'Ha Pham', 100)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD53', CAST(N'2018-06-17 03:07:41.000' AS DateTime), N'Ha Pham', 50)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD54', CAST(N'2018-06-17 03:07:41.000' AS DateTime), N'Ha Pham', 140)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD55', CAST(N'2018-06-17 03:19:13.000' AS DateTime), N'Ha Pham', 250)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD56', CAST(N'2018-06-17 03:21:53.000' AS DateTime), N'Ha Pham', 150)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD57', CAST(N'2018-06-18 01:41:30.000' AS DateTime), N'Hà Phạm', 50)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD58', CAST(N'2018-06-18 02:24:19.000' AS DateTime), N'Thuy Nguyễn', 50)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD59', CAST(N'2018-06-18 09:36:05.000' AS DateTime), N'Hà Phạm', 312)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD60', CAST(N'2018-06-18 09:42:59.000' AS DateTime), N'Thuy Nguyễn', 146)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD61', CAST(N'2018-06-18 09:42:59.000' AS DateTime), N'Thuy Nguyễn', 0)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD62', CAST(N'2018-06-18 09:42:59.000' AS DateTime), N'Thuy Nguyễn', 146)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD63', CAST(N'2018-06-18 09:46:44.000' AS DateTime), N'Thuy Nguyễn', 55)
INSERT [dbo].[HDBanHang] ([MaHDBH], [NgayBan], [TenNhanVien], [ThanhTien]) VALUES (N'HD64', CAST(N'2018-06-18 09:47:07.000' AS DateTime), N'Thuy Nguyễn', 980)
INSERT [dbo].[HDNhap] ([MaHDNhap], [NgayNhap]) VALUES (N'HDN01', CAST(N'2018-06-17 07:52:54.000' AS DateTime))
INSERT [dbo].[HDNhap] ([MaHDNhap], [NgayNhap]) VALUES (N'HDN02', CAST(N'2018-06-17 07:56:56.000' AS DateTime))
INSERT [dbo].[HDNhap] ([MaHDNhap], [NgayNhap]) VALUES (N'HDN03', CAST(N'2018-06-18 01:51:39.000' AS DateTime))
INSERT [dbo].[HDXuat] ([MaHDXuat], [NgayXuat]) VALUES (N'HDX01', CAST(N'2018-06-17 08:18:32.000' AS DateTime))
INSERT [dbo].[HDXuat] ([MaHDXuat], [NgayXuat]) VALUES (N'HDX02', CAST(N'2018-06-18 09:40:27.000' AS DateTime))
INSERT [dbo].[Quyen] ([MaQuyen], [SoLuongNguoi]) VALUES (N'Chủ cửa hàng', 1)
INSERT [dbo].[Quyen] ([MaQuyen], [SoLuongNguoi]) VALUES (N'Kho', 1)
INSERT [dbo].[Quyen] ([MaQuyen], [SoLuongNguoi]) VALUES (N'Nhân viên bán hàng', 10)
INSERT [dbo].[Quyen] ([MaQuyen], [SoLuongNguoi]) VALUES (N'Quản lý kho', 1)
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [TenNhanVien], [TrangThai], [MaQuyen]) VALUES (N'admin', N'123456', N'Thuy Nguyễn', 1, N'Chủ cửa hàng')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [TenNhanVien], [TrangThai], [MaQuyen]) VALUES (N'ha', N'123456', N'Hà Phạm', 1, N'Nhân viên bán hàng')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [TenNhanVien], [TrangThai], [MaQuyen]) VALUES (N'kho', N'123456', N'Đăng Quang', 1, N'Quản lý kho')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [TenNhanVien], [TrangThai], [MaQuyen]) VALUES (N'thanh', N'123456', N'Thanh', 1, N'Nhân viên bán hàng')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [TenNhanVien], [TrangThai], [MaQuyen]) VALUES (N'thu', N'123456', N'Thuỷ Nguyễn', 1, N'Nhân viên bán hàng')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [TenNhanVien], [TrangThai], [MaQuyen]) VALUES (N'thuy', N'123456', N'Thúy đặng', 1, N'Nhân viên bán hàng')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH01', N'Áo bé trai 1', 1, 11, 50, N'Áo bé trai')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH02', N'Áo bé trai 2', 2, 31, 60, N'Áo bé trai')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH03', N'Áo bé trai 3', 3, 35, 40, N'Áo bé trai')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH04', N'Áo bé trai 4', 4, 24, 65, N'Áo bé trai')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH05', N'Áo bé trai 5', 5, 24, 45, N'Áo bé trai')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH06', N'Áo bé gái 1', 1, 12, 45, N'Áo bé gái ')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH07', N'Áo bé gái 2', 2, 34, 70, N'Áo bé gái ')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH08', N'Áo bé gái 3', 3, 23, 45, N'Áo bé gái ')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH09', N'Áo bé gái 4', 4, 24, 45, N'Áo bé gái ')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH10', N'Áo bé gái 5', 5, 6, 55, N'Áo bé gái ')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH11', N'Váy bé gái 1', 1, 15, 85, N'Váy bé gái ')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH12', N'Váy bé gái 2', 2, 11, 75, N'Váy bé gái ')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH13', N'Váy bé gái 3', 3, 18, 75, N'Váy bé gái ')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH14', N'Váy bé gái 4', 4, 19, 45, N'Váy bé gái ')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH15', N'Váy bé gái 5', 5, 45, 60, N'Váy bé gái ')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH16', N'Quần bé trai 1', 1, 35, 40, N'Quần bé trai ')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH17', N'Quần bé trai 2', 2, 12, 50, N'Quần bé trai ')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH18', N'Quần bé trai 3', 3, 34, 70, N'Quần bé trai ')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH19', N'Quần bé trai 4', 4, 45, 80, N'Quần bé trai ')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH20', N'Quần bé trai 5', 5, 40, 50, N'Quần bé trai ')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH21', N'Áo hoa bé gái 1', 1, 10, 50, N'Áo hoa bé gái 1')
INSERT [dbo].[TTMatHang] ([MaMH], [TenMH], [Size], [SoLuong], [Gia], [MoTa]) VALUES (N'MH22', N'Áo hoa bé gái 2', 2, 1, 50, N'Áo hoa bé gái 2')
ALTER TABLE [dbo].[CTHDBanHang]  WITH CHECK ADD  CONSTRAINT [FK_CTHDBanHang_HDBanHang] FOREIGN KEY([MaHDBH])
REFERENCES [dbo].[HDBanHang] ([MaHDBH])
GO
ALTER TABLE [dbo].[CTHDBanHang] CHECK CONSTRAINT [FK_CTHDBanHang_HDBanHang]
GO
ALTER TABLE [dbo].[CTHDBanHang]  WITH CHECK ADD  CONSTRAINT [FK_CTHDBanHang_TTMatHang] FOREIGN KEY([MaMH])
REFERENCES [dbo].[TTMatHang] ([MaMH])
GO
ALTER TABLE [dbo].[CTHDBanHang] CHECK CONSTRAINT [FK_CTHDBanHang_TTMatHang]
GO
ALTER TABLE [dbo].[CTHDNhap]  WITH CHECK ADD  CONSTRAINT [FK_CTHDNhap_HDNhap] FOREIGN KEY([MaHDNhap])
REFERENCES [dbo].[HDNhap] ([MaHDNhap])
GO
ALTER TABLE [dbo].[CTHDNhap] CHECK CONSTRAINT [FK_CTHDNhap_HDNhap]
GO
ALTER TABLE [dbo].[CTHDNhap]  WITH CHECK ADD  CONSTRAINT [FK_CTHDNhap_TTMatHang] FOREIGN KEY([MaMH])
REFERENCES [dbo].[TTMatHang] ([MaMH])
GO
ALTER TABLE [dbo].[CTHDNhap] CHECK CONSTRAINT [FK_CTHDNhap_TTMatHang]
GO
ALTER TABLE [dbo].[CTHDXuat]  WITH CHECK ADD  CONSTRAINT [FK_CTHDXuat_HDXuat] FOREIGN KEY([MaHDXuat])
REFERENCES [dbo].[HDXuat] ([MaHDXuat])
GO
ALTER TABLE [dbo].[CTHDXuat] CHECK CONSTRAINT [FK_CTHDXuat_HDXuat]
GO
ALTER TABLE [dbo].[CTHDXuat]  WITH CHECK ADD  CONSTRAINT [FK_CTHDXuat_TTMatHang] FOREIGN KEY([MaMH])
REFERENCES [dbo].[TTMatHang] ([MaMH])
GO
ALTER TABLE [dbo].[CTHDXuat] CHECK CONSTRAINT [FK_CTHDXuat_TTMatHang]
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_TaiKhoan_Quyen] FOREIGN KEY([MaQuyen])
REFERENCES [dbo].[Quyen] ([MaQuyen])
GO
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [FK_TaiKhoan_Quyen]
GO
