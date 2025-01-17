USE [master]
GO
/****** Object:  Database [SHOPPING]    Script Date: 11/4/2024 7:43:46 PM ******/
CREATE DATABASE [SHOPPING]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SHOPPING', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SHOPPING.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SHOPPING_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SHOPPING_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SHOPPING] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SHOPPING].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SHOPPING] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SHOPPING] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SHOPPING] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SHOPPING] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SHOPPING] SET ARITHABORT OFF 
GO
ALTER DATABASE [SHOPPING] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SHOPPING] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SHOPPING] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SHOPPING] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SHOPPING] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SHOPPING] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SHOPPING] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SHOPPING] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SHOPPING] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SHOPPING] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SHOPPING] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SHOPPING] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SHOPPING] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SHOPPING] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SHOPPING] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SHOPPING] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SHOPPING] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SHOPPING] SET RECOVERY FULL 
GO
ALTER DATABASE [SHOPPING] SET  MULTI_USER 
GO
ALTER DATABASE [SHOPPING] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SHOPPING] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SHOPPING] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SHOPPING] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SHOPPING] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SHOPPING] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SHOPPING', N'ON'
GO
ALTER DATABASE [SHOPPING] SET QUERY_STORE = ON
GO
ALTER DATABASE [SHOPPING] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SHOPPING]
GO
/****** Object:  Table [dbo].[bill]    Script Date: 11/4/2024 7:43:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bill](
	[bill_id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [bigint] NOT NULL,
	[total] [money] NOT NULL,
	[payment] [varchar](250) NOT NULL,
	[address] [ntext] NOT NULL,
	[date] [date] NOT NULL,
	[phone] [bigint] NOT NULL,
 CONSTRAINT [PK_bill] PRIMARY KEY CLUSTERED 
(
	[bill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bill_detail]    Script Date: 11/4/2024 7:43:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bill_detail](
	[detail_id] [bigint] IDENTITY(1,1) NOT NULL,
	[bill_id] [bigint] NOT NULL,
	[product_id] [varchar](100) NOT NULL,
	[quantity] [int] NOT NULL,
	[size] [nchar](10) NOT NULL,
	[color] [nvarchar](150) NOT NULL,
	[price] [money] NOT NULL,
 CONSTRAINT [PK_bill_detail] PRIMARY KEY CLUSTERED 
(
	[detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart]    Script Date: 11/4/2024 7:43:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart](
	[cart_id] [bigint] NOT NULL,
	[product_id] [varchar](100) NOT NULL,
	[product_name] [varchar](255) NOT NULL,
	[product_img] [varchar](255) NOT NULL,
	[product_price] [float] NOT NULL,
	[total] [float] NOT NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [PK_cart] PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 11/4/2024 7:43:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [varchar](255) NOT NULL,
 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 11/4/2024 7:43:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[product_id] [varchar](100) NOT NULL,
	[category_id] [int] NOT NULL,
	[product_name] [nvarchar](max) NOT NULL,
	[product_price] [money] NOT NULL,
	[product_describe] [nvarchar](max) NOT NULL,
	[quantity] [int] NOT NULL,
	[img] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_color]    Script Date: 11/4/2024 7:43:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_color](
	[product_id] [varchar](100) NOT NULL,
	[color] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_size]    Script Date: 11/4/2024 7:43:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_size](
	[product_id] [varchar](100) NOT NULL,
	[size] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 11/4/2024 7:43:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[user_id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_name] [nvarchar](200) NULL,
	[user_email] [varchar](255) NOT NULL,
	[user_pass] [nvarchar](255) NOT NULL,
	[isAdmin] [nvarchar](50) NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[bill] ON 

INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (45, 5, 648000.0000, N'MOMO', N'Cà Mau', CAST(N'2024-10-29' AS Date), 919208356)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (46, 5, 298000.0000, N'MOMO', N'Bạc Liêu', CAST(N'2024-10-29' AS Date), 888195313)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (47, 5, 378000.0000, N'VNPAY', N'Cà Mau', CAST(N'2024-10-28' AS Date), 88195313)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (48, 5, 270000.0000, N'Chua thanh toán (VNPAY)', N'Cà Mau', CAST(N'2024-10-27' AS Date), 383298183)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (49, 5, 417000.0000, N'Chua thanh toán (VNPAY)', N'Cần Thơ', CAST(N'2024-10-27' AS Date), 888195313)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (50, 5, 567000.0000, N'COD', N'Cà Mau', CAST(N'2024-10-29' AS Date), 888195313)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (51, 5, 278000.0000, N'COD', N'Cà Mau', CAST(N'2024-10-30' AS Date), 862882603)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (52, 5, 189000.0000, N'COD', N'An Giang', CAST(N'2024-11-02' AS Date), 862882603)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (53, 5, 259000.0000, N'MOMO', N'Cần Thơ', CAST(N'2024-11-02' AS Date), 888195313)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (54, 5, 270000.0000, N'VNPAY', N'Đồng Tháp', CAST(N'2024-11-04' AS Date), 888195313)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (55, 5, 259000.0000, N'MOMO', N'An Giang', CAST(N'2024-11-02' AS Date), 2)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (56, 5, 810000.0000, N'VNPAY', N'Cà Mau', CAST(N'2024-11-02' AS Date), 3)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (57, 5, 149000.0000, N'MOMO', N'Cần Thơ', CAST(N'2024-11-02' AS Date), 383298183)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (58, 5, 417000.0000, N'VNPAY', N'Đồng Tháp', CAST(N'2024-11-01' AS Date), 345678)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (59, 5, 149000.0000, N'COD', N'An Giang', CAST(N'2024-11-03' AS Date), 23544353)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (60, 5, 517000.0000, N'MOMO', N'Cà Mau', CAST(N'2024-11-03' AS Date), 888195313)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (61, 5, 139000.0000, N'VNPAY', N'Cần Thơ', CAST(N'2024-11-03' AS Date), 32)
SET IDENTITY_INSERT [dbo].[bill] OFF
GO
SET IDENTITY_INSERT [dbo].[bill_detail] ON 

INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (40, 45, N'T2129', 1, N'XS        ', N'White', 270000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (41, 45, N'T2099', 2, N'S         ', N'Purple', 378000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (42, 46, N'AT533', 2, N'S         ', N'White', 298000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (43, 47, N'T2099', 2, N'L         ', N'Purple', 378000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (44, 48, N'T2129', 1, N'XS        ', N'White', 270000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (45, 49, N'AT536', 3, N'S         ', N'Red', 417000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (46, 50, N'T2099', 3, N'S         ', N'Purple', 567000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (47, 51, N'AT536', 2, N'S         ', N'Red', 278000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (48, 52, N'T2099', 1, N'S         ', N'Purple', 189000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (49, 53, N'T2127', 1, N'L         ', N'Black', 259000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (50, 54, N'T2129', 1, N'XS        ', N'White', 270000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (51, 55, N'T2128', 1, N'XS        ', N'White', 259000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (52, 56, N'T2129', 3, N'XS        ', N'White', 810000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (53, 57, N'AT533', 1, N'S         ', N'White', 149000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (54, 58, N'AT536', 3, N'S         ', N'Red', 417000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (55, 59, N'AT533', 1, N'S         ', N'White', 149000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (56, 60, N'T2099', 2, N'S         ', N'Purple', 378000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (57, 60, N'AT536', 1, N'L         ', N'Red', 139000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (58, 61, N'AT536', 1, N'S         ', N'Red', 139000.0000)
SET IDENTITY_INSERT [dbo].[bill_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([category_id], [category_name]) VALUES (1, N'SHIRT')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (2, N'T-SHIRT')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (3, N'OUTERWEAR')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (4, N'HOODIES')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (5, N'SHORT&PANTS')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (6, N'ACCESSORIES')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (7, N'SNEAKERS')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (14, N'SWEATSHIRTS')
SET IDENTITY_INSERT [dbo].[category] OFF
GO
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'AC600', 6, N'Prism Tote Bag', 500000.0000, N'Logo ở cả hai mặt và hai dây đeo vai', 67, N'images/AC600.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'AC601', 6, N'Bitplay Weekender Tote Bag', 1600000.0000, N'Túi Tote Bitplay Everyday có nhiều ngăn và khóa kéo', 59, N'images/AC601.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'AC602', 6, N'2024 Canvas Tote Bags', 500000.0000, N'Túi xách in chữ đeo vai đựng sách', 73, N'images/AC602.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'AT533', 2, N'Champion Graphic Big Logo T-Shirt', 149000.0000, N'Cổ Tròn 
Vạt Ngang
 Tay Ngắn
Hình In Trước', 186, N'images/AT533.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'AT536', 2, N'Champion Change The World', 139000.0000, N'Cổ Tròn
Vạt Ngang 
Tay Ngắn
Hình Thêu Trước', 410, N'images/AT536.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'HD400', 4, N'The Earth Embroidered Hoodie In Green', 300000.0000, N'Nón Cố Định
Một Túi Lớn
Hình Thêu Trước
Và Sau', 183, N'images/HD400.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'HD401', 4, N'HD756', 200000.0000, N'Nón Cố Định
Một Túi Lớn
Hình In Trước
Và Sau', 284, N'images/HD401.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'HD402', 4, N'Three Hundred Basic Hoodie In Acid Washed Grey', 420000.0000, N'Nón Cố Định
Một Túi Lớn
Wash Đá Bọt', 215, N'images/HD402.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'HD403', 4, N'Three Hundred Reflective Hoodie Short Sleeve In Black', 200000.0000, N'Nón Cố Định
Hai Túi Trước
Hình In Sau
Phản Quang
Oversized', 273, N'images/HD403.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'HD404', 4, N'Champion Embroidered Logo Hoodie In Brown', 215000.0000, N'Nón Cố Định
Một Túi Lớn
Tay Bo
Hình Thêu Trước ', 351, N'images/HD404.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'HD405', 4, N'Change Bandana Embroidered Logo Hoodie In White', 200000.0000, N'Nón Cố Định
Một Túi Lớn
Hình Thêu Trước
', 283, N'images/HD405.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'OW300', 3, N'UNISEX INF 7083', 680000.0000, N'Áo khoác sơ mi dày tay RETRO Nhật Bản', 134, N'images/OW300.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'OW301', 3, N'INF 5234', 680000.0000, N'Áo khoác mũ trùm chống gió khóa kéo ngoài trời dã ngoại', 75, N'images/OW301.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'OW302', 3, N'Ulzzang', 179000.0000, N'Áo Khoác BOMBER DÙ 2 LỚP BASIC TRƠN Form Rộng', 264, N'images/OW302.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'OW303', 3, N'Ulzzang', 399000.0000, N'Áo khoác jean trơn unisex', 195, N'images/OW303.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'OW304', 3, N'WHJPE4V38U', 2320000.0000, N'Áo Khoác WHOAU Long Padding ', 49, N'images/OW304.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SK700', 7, N'DC Shoes Manteca 4 SN DM231005', 2990000.0000, N'Giày Thể Thao DC Shoes Manteca 4 SN DM231005', 100, N'images/SK700.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SK701', 7, N'Converse Cruise', 1700000.0000, N'Thoải mái nhẹ nhàng, phong cách thập niên 90', 100, N'images/SK701.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SK702', 7, N'Second Sunday Ice Cream', 300000.0000, N'Sneaker nữ đế tăng chiều cao 4cm', 100, N'images/SK702.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SK703', 7, N'Nike Air Force 1 Shadow DV7449-100', 3450000.0000, N'Giày Thể Thao Nữ trắng', 100, N'images/SK703.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SK704', 7, N'Zaydn Spencer', 1600000.0000, N'Đế giày mềm mại và nhẹ', 100, N'images/SK704.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SK705', 7, N'New Balance 574', 3600000.0000, N'Đế giày mềm mại, nhẹ, thoáng khí', 100, N'images/SK705.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SM601', 1, N'Oxford Shirt SS052', 195000.0000, N'Áo Sơ Mi Ngắn Tay Teelab', 189, N'images/SM601.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SM602', 1, N'Waffle Shirt SS050', 195000.0000, N'Áo Sơ Mi Ngắn Tay Teelab', 186, N'images/SM602.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SM603', 1, N'Pandax Shirt', 229000.0000, N'Áo sơ mi tay ngắn vải lụa mềm chống nhăn', 242, N'images/SM603.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SM604', 1, N'TE9059', 100000.0000, N'Áo sơ mi unisex tay ngắn, rũ', 83, N'images/SM604.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SP500', 5, N'Lakers icon edition short', 350000.0000, N'Có 2 túi zip lớn 2 bên giúp thuận tiện cho việc chứa đồ', 211, N'images/SP500.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SP501', 5, N'RB "ALL DAY" V2', 280000.0000, N'Quần có túi 2 bên, lưng thun cùng dây rút', 180, N'images/SP501.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SP502', 5, N'Quần tập', 220000.0000, N'Quần có túi 2 bên, lưng thun co dãn, có dây rút linh hoạt.', 149, N'images/SP502.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SP503', 5, N'Quần tập', 280000.0000, N'Quần có túi 2 bên ,lưng thun co giãn, có dây rút linh hoạt', 194, N'images/SP503.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SP504', 5, N'Parachute cargo pants', 465000.0000, N'nút thắt ngay lưng quần, ống quần có chi tiết xếp li thời trang', 265, N'images/SP504.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SP505', 5, N'AherBiu Dress Pants for Women', 425000.0000, N'AherBiu Dress Pants Wide Leg', 166, N'images/SP505.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SP506', 5, N'SHEIN Quần short nữ', 185000.0000, N' Màu trơn vừa vặn có viền diềm xếp nếp và dây thắt lưng co giãn', 265, N'images/SP506.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'SP507', 5, N'Quần đùi nữ', 90000.0000, N'quần short nữ cạp chun', 356, N'images/SP507.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'T2099', 2, N'No Smile Tee Purple', 189000.0000, N'Cổ Tròn 
Tay Ngắn
 Vạt Ngang 
Hình Phía Trước
Và Sau', 49, N'images/T2099.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'T2106', 2, N'Shin-chan Tee', 229000.0000, N'Cổ Tròn 
Tay Ngắn 
Vạt Ngang 
Hình In Trước', 95, N'images/T2106.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'T2109', 2, N'Tie Dye Orange Mint Tee', 290000.0000, N'Cổ Tròn 
Tay Ngắn Vạt Ngang 
Hình In Trước
Và Sau
Tie Tye', 75, N'images/T2109.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'T2119', 2, N'The Sun Tie Dye', 280000.0000, N'Cổ Tròn 
Tay Ngắn 
Vạt Ngang 
Hình In Trước
Và Sau
Tie Tye', 82, N'images/T2119.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'T2127', 2, N'Fucking Awesome Tee In Black', 259000.0000, N'Cổ Tròn 
Tay Ngắn 
Vạt Ngang 
Hình Phía Trước
Và Sau', 94, N'images/T2127.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'T2128', 2, N'Fucking Awesome Tee', 259000.0000, N'Cổ Tròn 
Tay Ngắn
 Vạt Ngang 
Hình Phía Trước
Và Sau
', 62, N'images/T2128.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'T2129', 2, N'I''m Not Psycho Tee', 270000.0000, N'Cổ Tròn 
Tay Ngắn
 Vạt Ngang 
Hình Phía Trước
Và Sau', 102, N'images/T2129.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'T2130', 2, N'Acid Washed Dark', 240000.0000, N'Cổ Tròn
Tay Ngắn
 Vạt Ngang
Stone Wash', 300, N'images/T2130.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'T2131', 2, N'Exceptional Tee With Distressed', 250000.0000, N'Cổ Tròn 
Tay Ngắn
 Vạt Ngang 
Hình Phía Trước
Và Sau
Stone Wash', 198, N'images/T2131.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'TD481', 14, N'''''Sinner'''' Sweater', 360000.0000, N'Cổ Tròn 
Vạt Ngang
 Tay Dài Bo
Hình In Mặt Trước Và Sau ', 29, N'images/TD481.png')
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img]) VALUES (N'TD509', 14, N'Champion Sweater', 169000.0000, N'Cổ Tròn 
Vạt Ngang
Tay Dài Bo
Hình Thêu Trước ', 447, N'images/TD509.png')
GO
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2131', N'Grey')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2131', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2130', N'Grey')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2119', N'Pink')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2119', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'AT533', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'AT533', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'AT536', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'AT536', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'AT536', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'AT536', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'TD509', N'Purple')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'TD509', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'TD509', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'TD509', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'TD481', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2109', N'Orange')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2128', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2128', N'Green')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2127', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2099', N'Pink')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2129', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2106', N'Yellow')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM601', N'Pink')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM601', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM601', N'Grey')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'OW300', N'Brown')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'OW300', N'Beige')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'OW300', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM602', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM602', N'Beige')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM603', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM604', N'')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'OW301', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'OW301', N'Grey')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'OW301', N'Purple')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'OW301', N'Pink')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'OW301', N'Beige')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'OW302', N'')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'OW303', N'')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'OW304', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'HD400', N'Green')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'HD401', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'HD402', N'Grey')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'HD403', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'HD404', N'Brown')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'HD404', N'Yellow')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'HD404', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'HD405', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SP500', N'')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SP501', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SP501', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SP502', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SP502', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SP503', N'')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SP504', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SP505', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SP505', N'Grey')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SP506', N'Green')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SP506', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SP507', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SP507', N'Pink')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SP507', N'Yellow')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'AC600', N'Ecru')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'AC601', N'Grey')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'AC602', N'Beige')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SK700', N'Green')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SK701', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SK701', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SK701', N'Pink')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SK702', N'')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SK703', N'Beige')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SK704', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SK704', N'Beige')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SK705', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SK705', N'Beige')
GO
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2131', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2131', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2131', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2130', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2130', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2119', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2119', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'AT533', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'AT533', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'AT533', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'AT536', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'AT536', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'AT536', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'TD509', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'TD509', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'TD509', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'TD509', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'TD481', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'TD481', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2109', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2109', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2099', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2099', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2099', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2128', N'XS')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2128', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2128', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2127', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2129', N'XS')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2129', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2129', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2129', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2106', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2106', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2106', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2106', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2106', N'3XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM601', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM601', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM601', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'OW300', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'OW300', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'OW300', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM602', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM602', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM602', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM603', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM603', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM603', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM604', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM604', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'OW301', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'OW301', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'OW301', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'OW301', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'OW301', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'OW302', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'OW302', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'OW303', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'OW303', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'OW304', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'OW304', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD400', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD400', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD400', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD401', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD401', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD401', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD402', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD402', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD403', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD403', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD403', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD403', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD404', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD404', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD404', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD405', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD405', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'HD405', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP500', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP500', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP500', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP500', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP501', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP501', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP501', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP501', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP502', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP502', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP502', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP502', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP503', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP503', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP503', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP503', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP504', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP504', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP504', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP505', N'S')
GO
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP505', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP505', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP505', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP506', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP506', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SP506', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'AC600', N'')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'AC601', N'')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'AC602', N'')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK700', N'37')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK700', N'38')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK700', N'39')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK700', N'40')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK700', N'41')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK700', N'42')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK701', N'37')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK701', N'38')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK701', N'39')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK701', N'40')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK701', N'41')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK701', N'42')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK702', N'36')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK702', N'37')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK702', N'38')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK702', N'39')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK702', N'40')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK703', N'36')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK703', N'37')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK703', N'38')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK703', N'39')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK703', N'40')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK704', N'37')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK704', N'38')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK704', N'39')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK704', N'40')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK704', N'41')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK704', N'42')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK705', N'37')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK705', N'38')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK705', N'39')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK705', N'40')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK705', N'41')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SK705', N'42')
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin]) VALUES (1, N'Admin', N'Nhom6@gmail.com', N'Nhom6@', N'TRUE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin]) VALUES (3, N'Minh', N'Minh2503@gmail.com', N'123456', N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin]) VALUES (4, N'Quanghuy', N'Qhuy@gmail.com', N'1234', N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin]) VALUES (5, N'Giahuy', N'giahuy444@gmail.com', N'123', N'FALSE')
SET IDENTITY_INSERT [dbo].[users] OFF
GO
ALTER TABLE [dbo].[bill]  WITH CHECK ADD  CONSTRAINT [FK_bill_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[bill] CHECK CONSTRAINT [FK_bill_users]
GO
ALTER TABLE [dbo].[bill_detail]  WITH CHECK ADD  CONSTRAINT [FK_bill_detail_bill] FOREIGN KEY([bill_id])
REFERENCES [dbo].[bill] ([bill_id])
GO
ALTER TABLE [dbo].[bill_detail] CHECK CONSTRAINT [FK_bill_detail_bill]
GO
ALTER TABLE [dbo].[bill_detail]  WITH CHECK ADD  CONSTRAINT [FK_bill_detail_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[bill_detail] CHECK CONSTRAINT [FK_bill_detail_product]
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD  CONSTRAINT [FK_cart_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[cart] CHECK CONSTRAINT [FK_cart_product]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK_product_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([category_id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_product_category]
GO
ALTER TABLE [dbo].[product_color]  WITH CHECK ADD  CONSTRAINT [FK_product_color_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[product_color] CHECK CONSTRAINT [FK_product_color_product]
GO
ALTER TABLE [dbo].[product_size]  WITH CHECK ADD  CONSTRAINT [FK_product_size_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[product_size] CHECK CONSTRAINT [FK_product_size_product]
GO
USE [master]
GO
ALTER DATABASE [SHOPPING] SET  READ_WRITE 
GO
