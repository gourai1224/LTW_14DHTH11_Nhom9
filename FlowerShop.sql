/* =========================================================
   ĐỀ 2 – BÁN HOA ONLINE
   - Danh mục 2 lớp: Group (Cha) → Category (Con)
   - Order đơn giản đủ cho bài kiểm tra
   ========================================================= */

-- Khởi tạo DB
IF DB_ID('FlowerShop') IS NOT NULL
BEGIN
    DROP DATABASE FlowerShop;
END;
GO
CREATE DATABASE FlowerShop COLLATE SQL_Latin1_General_CP1_CI_AS;
GO
USE FlowerShop;
GO

/****** Object:  Table [dbo].[AppUser]    Script Date: 11/9/2025 12:04:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUser](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](120) NOT NULL,
	[PasswordHash] [varchar](256) NOT NULL,
	[FullName] [nvarchar](120) NULL,
	[Phone] [varchar](20) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 11/9/2025 12:04:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[CartId] [int] IDENTITY(1,1) NOT NULL,
	[CartToken] [varchar](64) NOT NULL,
	[UserId] [int] NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
	[UpdatedAt] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartItem]    Script Date: 11/9/2025 12:04:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItem](
	[CartItemId] [int] IDENTITY(1,1) NOT NULL,
	[CartId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](12, 0) NOT NULL,
	[Note] [nvarchar](200) NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CartItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 11/9/2025 12:04:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NOT NULL,
	[CatSlug] [varchar](60) NOT NULL,
	[CatName] [nvarchar](120) NOT NULL,
	[Description] [nvarchar](300) NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoryGroup]    Script Date: 11/9/2025 12:04:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryGroup](
	[GroupId] [int] IDENTITY(1,1) NOT NULL,
	[GroupCode] [varchar](40) NOT NULL,
	[GroupName] [nvarchar](120) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerAddress]    Script Date: 11/9/2025 12:04:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerAddress](
	[AddressId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Line1] [nvarchar](200) NOT NULL,
	[Ward] [nvarchar](100) NULL,
	[District] [nvarchar](100) NULL,
	[Province] [nvarchar](100) NULL,
	[Note] [nvarchar](200) NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 11/9/2025 12:04:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[CustomerName] [nvarchar](120) NOT NULL,
	[Phone] [varchar](20) NOT NULL,
	[AddressLine] [nvarchar](220) NULL,
	[MessageCard] [nvarchar](240) NULL,
	[Status] [varchar](20) NOT NULL,
	[TotalAmount] [decimal](12, 0) NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItem]    Script Date: 11/9/2025 12:04:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItem](
	[OrderItemId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[ProductName] [nvarchar](180) NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](12, 0) NOT NULL,
	[Note] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 11/9/2025 12:04:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[SKU] [varchar](40) NOT NULL,
	[ProductName] [nvarchar](180) NOT NULL,
	[Slug] [varchar](90) NOT NULL,
	[MainImage] [nvarchar](250) NOT NULL,
	[Summary] [nvarchar](300) NULL,
	[Price] [decimal](12, 0) NOT NULL,
	[Stock] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime2](0) NOT NULL,
 CONSTRAINT [PK__Product__B40CC6CD917C516B] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImage]    Script Date: 11/9/2025 12:04:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImage](
	[ImageId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[ImageUrl] [nvarchar](260) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AppUser] ON 
GO
INSERT [dbo].[AppUser] ([UserId], [Email], [PasswordHash], [FullName], [Phone], [IsActive], [CreatedAt]) VALUES (1, N'demo@flower.vn', N'123456_hashed', N'Khách Demo', N'0900000000', 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[AppUser] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 
GO
INSERT [dbo].[Category] ([CategoryId], [GroupId], [CatSlug], [CatName], [Description], [SortOrder], [IsActive], [CreatedAt]) VALUES (1, 1, N'birthday', N'Sinh nhật', NULL, 1, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Category] ([CategoryId], [GroupId], [CatSlug], [CatName], [Description], [SortOrder], [IsActive], [CreatedAt]) VALUES (2, 1, N'grandopening', N'Khai trương', NULL, 2, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Category] ([CategoryId], [GroupId], [CatSlug], [CatName], [Description], [SortOrder], [IsActive], [CreatedAt]) VALUES (3, 1, N'anniversary', N'Kỷ niệm', NULL, 3, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Category] ([CategoryId], [GroupId], [CatSlug], [CatName], [Description], [SortOrder], [IsActive], [CreatedAt]) VALUES (4, 1, N'congrats', N'Chúc mừng', NULL, 4, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Category] ([CategoryId], [GroupId], [CatSlug], [CatName], [Description], [SortOrder], [IsActive], [CreatedAt]) VALUES (5, 2, N'for-mom', N'Tặng Mẹ', NULL, 1, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Category] ([CategoryId], [GroupId], [CatSlug], [CatName], [Description], [SortOrder], [IsActive], [CreatedAt]) VALUES (6, 2, N'for-friend', N'Tặng Bạn', NULL, 2, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Category] ([CategoryId], [GroupId], [CatSlug], [CatName], [Description], [SortOrder], [IsActive], [CreatedAt]) VALUES (7, 2, N'for-partner', N'Đối tác', NULL, 3, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Category] ([CategoryId], [GroupId], [CatSlug], [CatName], [Description], [SortOrder], [IsActive], [CreatedAt]) VALUES (8, 2, N'for-love', N'Người thương', NULL, 4, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Category] ([CategoryId], [GroupId], [CatSlug], [CatName], [Description], [SortOrder], [IsActive], [CreatedAt]) VALUES (9, 3, N'red', N'Đỏ', NULL, 1, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Category] ([CategoryId], [GroupId], [CatSlug], [CatName], [Description], [SortOrder], [IsActive], [CreatedAt]) VALUES (10, 3, N'white', N'Trắng', NULL, 2, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Category] ([CategoryId], [GroupId], [CatSlug], [CatName], [Description], [SortOrder], [IsActive], [CreatedAt]) VALUES (11, 3, N'pastel', N'Pastel', NULL, 3, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Category] ([CategoryId], [GroupId], [CatSlug], [CatName], [Description], [SortOrder], [IsActive], [CreatedAt]) VALUES (12, 3, N'yellow', N'Vàng', NULL, 4, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[CategoryGroup] ON 
GO
INSERT [dbo].[CategoryGroup] ([GroupId], [GroupCode], [GroupName], [SortOrder], [IsActive], [CreatedAt]) VALUES (1, N'occasion', N'Hoa theo Dịp', 1, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[CategoryGroup] ([GroupId], [GroupCode], [GroupName], [SortOrder], [IsActive], [CreatedAt]) VALUES (2, N'recipient', N'Hoa theo Người nhận', 2, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[CategoryGroup] ([GroupId], [GroupCode], [GroupName], [SortOrder], [IsActive], [CreatedAt]) VALUES (3, N'color', N'Hoa theo Màu sắc', 3, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[CategoryGroup] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerAddress] ON 
GO
INSERT [dbo].[CustomerAddress] ([AddressId], [UserId], [Line1], [Ward], [District], [Province], [Note], [CreatedAt]) VALUES (1, 1, N'12 Trần Hưng Đạo', N'P.1', N'Q.5', N'TP.HCM', N'Nhận giờ hành chính', CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[CustomerAddress] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (1, 1, N'FLR-001', N'Hồng Pastel 01', N'hong-pastel-01', N'1.jpg', N'Hoa hồng phối baby tông pastel', CAST(450000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (2, 1, N'FLR-002', N'Hồng Pastel 02', N'hong-pastel-02', N'2.jpg', N'Hoa hồng pastel giấy gói cao cấp', CAST(470000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (3, 1, N'FLR-003', N'Bó Sinh Nhật 01', N'bo-sinh-nhat-01', N'3.jpg', N'Bó tặng sinh nhật tươi 3–5 ngày', CAST(380000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (4, 1, N'FLR-004', N'Bó Khai Trương 01', N'bo-khai-truong-01', N'4.jpg', N'Bó hoa chúc mừng khai trương', CAST(520000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (5, 1, N'FLR-005', N'Bó Chúc Mừng 01', N'bo-chuc-mung-01', N'5.jpg', N'Bó rực rỡ tông đỏ vàng', CAST(490000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (6, 1, N'FLR-006', N'Bó Trắng Thanh Lịch', N'bo-trang-thanh-lich', N'6.jpg', N'Hoa trắng chủ đạo', CAST(410000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (7, 1, N'FLR-007', N'Bó Pastel Ngọt Ngào', N'bo-pastel-ngot-ngao', N'7.jpg', N'Phối nhiều tông pastel', CAST(465000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (8, 1, N'FLR-008', N'Bó Tặng Mẹ 01', N'bo-tang-me-01', N'8.jpg', N'Bó nhẹ nhàng cho Mẹ', CAST(430000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (9, 1, N'FLR-009', N'Bó Đối Tác 01', N'bo-doi-tac-01', N'9.jpg', N'Thanh lịch cho đối tác', CAST(620000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (10, 1, N'FLR-010', N'Bó Người Thương 01', N'bo-nguoi-thuong-01', N'10.jpg', N'Lãng mạn cho người thương', CAST(520000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (11, 1, N'FLR-011', N'Bó Bạn Bè 01', N'bo-ban-be-01', N'11.jpg', N'Trẻ trung cho bạn bè', CAST(350000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (12, 1, N'FLR-012', N'Bó Vàng Ấm Áp', N'bo-vang-am-ap', N'12.jpg', N'Tông vàng nổi bật', CAST(480000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-01T16:43:24.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (13, 2, N'FLR-013', N'Khai Trương 01', N'khai-truong-01', N'13.jpg', N'Giỏ hoa chúc mừng khai trương sang trọng', CAST(520000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:03:33.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (14, 2, N'FLR-014', N'Khai Trương 02', N'khai-truong-02', N'14.jpg', N'Bình hoa tone đỏ vàng rực rỡ', CAST(560000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:03:33.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (15, 2, N'FLR-015', N'Khai Trương 03', N'khai-truong-03', N'15.jpg', N'Giỏ hoa chúc mừng thành công', CAST(600000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:03:33.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (16, 2, N'FLR-016', N'Khai Trương 04', N'khai-truong-04', N'16.jpg', N'Bó hoa hồng vàng tươi', CAST(490000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:03:33.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (17, 2, N'FLR-017', N'Khai Trương 05', N'khai-truong-05', N'17.jpg', N'Lẵng hoa phong cách hiện đại', CAST(580000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:03:33.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (18, 3, N'FLR-018', N'Kỷ Niệm 01', N'ky-niem-01', N'18.jpg', N'Hoa hồng và baby nhẹ nhàng', CAST(450000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (19, 3, N'FLR-019', N'Kỷ Niệm 02', N'ky-niem-02', N'19.jpg', N'Bó pastel cho ngày kỷ niệm', CAST(470000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (20, 3, N'FLR-020', N'Kỷ Niệm 03', N'ky-niem-03', N'20.jpg', N'Giỏ hoa tình yêu', CAST(500000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (21, 3, N'FLR-021', N'Kỷ Niệm 04', N'ky-niem-04', N'21.jpg', N'Hoa tulip lãng mạn', CAST(550000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (22, 3, N'FLR-022', N'Kỷ Niệm 05', N'ky-niem-05', N'22.jpg', N'Bó hoa kỷ niệm nhẹ nhàng', CAST(490000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (23, 4, N'FLR-023', N'Chúc Mừng 01', N'chuc-mung-01', N'1.jpg', N'Hoa hướng dương rực rỡ', CAST(480000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (24, 4, N'FLR-024', N'Chúc Mừng 02', N'chuc-mung-02', N'2.jpg', N'Bó hoa tươi sáng cho ngày vui', CAST(510000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (25, 4, N'FLR-025', N'Chúc Mừng 03', N'chuc-mung-03', N'3.jpg', N'Lẵng hoa rộn ràng sắc màu', CAST(530000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (26, 4, N'FLR-026', N'Chúc Mừng 04', N'chuc-mung-04', N'4.jpg', N'Bó hoa tone cam vàng', CAST(500000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (27, 4, N'FLR-027', N'Chúc Mừng 05', N'chuc-mung-05', N'5.jpg', N'Hoa chúc mừng công việc mới', CAST(560000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (28, 5, N'FLR-028', N'Tặng Mẹ 01', N'tang-me-01', N'6.jpg', N'Hoa cẩm chướng và baby', CAST(420000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (29, 5, N'FLR-029', N'Tặng Mẹ 02', N'tang-me-02', N'7.jpg', N'Giỏ hoa hồng tím nhẹ nhàng', CAST(440000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (30, 5, N'FLR-030', N'Tặng Mẹ 03', N'tang-me-03', N'8.jpg', N'Bó hoa pastel sang trọng', CAST(460000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (31, 5, N'FLR-031', N'Tặng Mẹ 04', N'tang-me-04', N'9.jpg', N'Hoa tulip dịu dàng', CAST(480000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (32, 5, N'FLR-032', N'Tặng Mẹ 05', N'tang-me-05', N'10.jpg', N'Giỏ hoa ấm áp cho Mẹ', CAST(500000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (33, 6, N'FLR-033', N'Tặng Bạn 01', N'tang-ban-01', N'11.jpg', N'Hoa baby và hồng trắng', CAST(350000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (34, 6, N'FLR-034', N'Tặng Bạn 02', N'tang-ban-02', N'12.jpg', N'Bó nhỏ xinh tươi', CAST(370000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (35, 6, N'FLR-035', N'Tặng Bạn 03', N'tang-ban-03', N'13.jpg', N'Bó pastel trẻ trung', CAST(390000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (36, 6, N'FLR-036', N'Tặng Bạn 04', N'tang-ban-04', N'14.jpg', N'Giỏ hoa rực rỡ', CAST(410000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (37, 6, N'FLR-037', N'Tặng Bạn 05', N'tang-ban-05', N'15.jpg', N'Hoa hướng dương năng động', CAST(430000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (38, 7, N'FLR-038', N'Đối Tác 01', N'doi-tac-01', N'16.jpg', N'Hoa sang trọng cho đối tác', CAST(550000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (39, 7, N'FLR-039', N'Đối Tác 02', N'doi-tac-02', N'17.jpg', N'Hoa tone xanh trắng tinh tế', CAST(570000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (40, 7, N'FLR-040', N'Đối Tác 03', N'doi-tac-03', N'18.jpg', N'Giỏ hoa doanh nghiệp', CAST(600000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (41, 7, N'FLR-041', N'Đối Tác 04', N'doi-tac-04', N'19.jpg', N'Lẵng hoa hiện đại', CAST(590000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (42, 7, N'FLR-042', N'Đối Tác 05', N'doi-tac-05', N'20.jpg', N'Hoa chúc mừng đối tác', CAST(620000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (43, 8, N'FLR-043', N'Người Thương 01', N'nguoi-thuong-01', N'21.jpg', N'Hoa hồng đỏ lãng mạn', CAST(520000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (44, 8, N'FLR-044', N'Người Thương 02', N'nguoi-thuong-02', N'22.jpg', N'Bó pastel nhẹ nhàng', CAST(500000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (45, 8, N'FLR-045', N'Người Thương 03', N'nguoi-thuong-03', N'1.jpg', N'Hoa baby tình cảm', CAST(480000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (46, 8, N'FLR-046', N'Người Thương 04', N'nguoi-thuong-04', N'2.jpg', N'Hoa tulip đỏ quyến rũ', CAST(550000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (47, 8, N'FLR-047', N'Người Thương 05', N'nguoi-thuong-05', N'3.jpg', N'Hoa hồng pastel tình yêu', CAST(530000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (48, 9, N'FLR-048', N'Tông Đỏ 01', N'do-01', N'4.jpg', N'Hoa hồng đỏ chủ đạo', CAST(510000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (49, 9, N'FLR-049', N'Tông Đỏ 02', N'do-02', N'5.jpg', N'Hoa đỏ mix vàng', CAST(530000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (50, 9, N'FLR-050', N'Tông Đỏ 03', N'do-03', N'6.jpg', N'Hoa đỏ truyền thống', CAST(550000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (51, 9, N'FLR-051', N'Tông Đỏ 04', N'do-04', N'7.jpg', N'Hoa đỏ hiện đại', CAST(520000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (52, 9, N'FLR-052', N'Tông Đỏ 05', N'do-05', N'8.jpg', N'Hoa đỏ sang trọng', CAST(540000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (53, 10, N'FLR-053', N'Tông Trắng 01', N'trang-01', N'9.jpg', N'Hoa trắng tinh khôi', CAST(420000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (54, 10, N'FLR-054', N'Tông Trắng 02', N'trang-02', N'10.jpg', N'Bó hoa trắng nhẹ nhàng', CAST(440000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (55, 10, N'FLR-055', N'Tông Trắng 03', N'trang-03', N'11.jpg', N'Hoa trắng sang trọng', CAST(460000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (56, 10, N'FLR-056', N'Tông Trắng 04', N'trang-04', N'12.jpg', N'Hoa trắng điểm xanh', CAST(470000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (57, 10, N'FLR-057', N'Tông Trắng 05', N'trang-05', N'13.jpg', N'Hoa trắng hiện đại', CAST(490000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (58, 11, N'FLR-058', N'Tông Pastel 01', N'pastel-01', N'14.jpg', N'Hoa pastel nhẹ nhàng', CAST(450000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (59, 11, N'FLR-059', N'Tông Pastel 02', N'pastel-02', N'15.jpg', N'Bó pastel baby và hồng', CAST(470000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (60, 11, N'FLR-060', N'Tông Pastel 03', N'pastel-03', N'16.jpg', N'Giỏ pastel sang trọng', CAST(480000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (61, 11, N'FLR-061', N'Tông Pastel 04', N'pastel-04', N'17.jpg', N'Hoa pastel mix vàng', CAST(460000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (62, 11, N'FLR-062', N'Tông Pastel 05', N'pastel-05', N'18.jpg', N'Bó pastel dịu dàng', CAST(440000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (63, 12, N'FLR-063', N'Tông Vàng 01', N'vang-01', N'19.jpg', N'Hoa hướng dương tươi sáng', CAST(470000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (64, 12, N'FLR-064', N'Tông Vàng 02', N'vang-02', N'20.jpg', N'Bó hoa vàng cam ấm áp', CAST(490000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (65, 12, N'FLR-065', N'Tông Vàng 03', N'vang-03', N'21.jpg', N'Giỏ hoa vàng trẻ trung', CAST(510000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (66, 12, N'FLR-066', N'Tông Vàng 04', N'vang-04', N'22.jpg', N'Hoa vàng pastel dịu nhẹ', CAST(480000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
INSERT [dbo].[Product] ([ProductId], [CategoryId], [SKU], [ProductName], [Slug], [MainImage], [Summary], [Price], [Stock], [IsActive], [CreatedAt]) VALUES (67, 12, N'FLR-067', N'Tông Vàng 05', N'vang-05', N'1.jpg', N'Hoa vàng nắng sớm', CAST(500000 AS Decimal(12, 0)), 999, 1, CAST(N'2025-11-08T21:06:15.0000000' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImage] ON 
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (49, 11, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (50, 11, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (51, 11, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (52, 11, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (53, 5, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (54, 5, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (55, 5, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (56, 5, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (57, 9, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (58, 9, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (59, 9, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (60, 9, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (61, 4, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (62, 4, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (63, 4, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (64, 4, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (65, 10, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (66, 10, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (67, 10, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (68, 10, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (69, 7, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (70, 7, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (71, 7, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (72, 7, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (73, 3, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (74, 3, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (75, 3, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (76, 3, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (77, 8, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (78, 8, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (79, 8, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (80, 8, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (81, 6, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (82, 6, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (83, 6, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (84, 6, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (85, 12, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (86, 12, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (87, 12, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (88, 12, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (89, 23, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (90, 23, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (91, 23, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (92, 23, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (93, 24, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (94, 24, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (95, 24, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (96, 24, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (97, 25, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (98, 25, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (99, 25, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (100, 25, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (101, 26, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (102, 26, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (103, 26, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (104, 26, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (105, 27, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (106, 27, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (107, 27, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (108, 27, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (109, 48, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (110, 48, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (111, 48, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (112, 48, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (113, 49, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (114, 49, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (115, 49, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (116, 49, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (117, 50, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (118, 50, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (119, 50, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (120, 50, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (121, 51, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (122, 51, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (123, 51, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (124, 51, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (125, 52, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (126, 52, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (127, 52, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (128, 52, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (129, 38, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (130, 38, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (131, 38, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (132, 38, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (133, 39, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (134, 39, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (135, 39, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (136, 39, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (137, 40, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (138, 40, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (139, 40, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (140, 40, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (141, 41, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (142, 41, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (143, 41, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (144, 41, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (145, 42, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (146, 42, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (147, 42, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (148, 42, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (149, 1, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (150, 1, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (151, 1, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (152, 1, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (153, 2, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (154, 2, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (155, 2, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (156, 2, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (157, 13, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (158, 13, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (159, 13, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (160, 13, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (161, 14, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (162, 14, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (163, 14, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (164, 14, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (165, 15, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (166, 15, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (167, 15, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (168, 15, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (169, 16, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (170, 16, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (171, 16, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (172, 16, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (173, 17, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (174, 17, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (175, 17, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (176, 17, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (177, 18, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (178, 18, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (179, 18, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (180, 18, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (181, 19, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (182, 19, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (183, 19, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (184, 19, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (185, 20, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (186, 20, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (187, 20, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (188, 20, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (189, 21, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (190, 21, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (191, 21, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (192, 21, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (193, 22, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (194, 22, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (195, 22, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (196, 22, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (197, 43, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (198, 43, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (199, 43, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (200, 43, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (201, 44, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (202, 44, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (203, 44, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (204, 44, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (205, 45, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (206, 45, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (207, 45, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (208, 45, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (209, 46, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (210, 46, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (211, 46, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (212, 46, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (213, 47, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (214, 47, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (215, 47, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (216, 47, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (217, 58, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (218, 58, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (219, 58, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (220, 58, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (221, 59, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (222, 59, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (223, 59, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (224, 59, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (225, 60, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (226, 60, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (227, 60, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (228, 60, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (229, 61, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (230, 61, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (231, 61, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (232, 61, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (233, 62, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (234, 62, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (235, 62, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (236, 62, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (237, 33, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (238, 33, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (239, 33, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (240, 33, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (241, 34, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (242, 34, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (243, 34, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (244, 34, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (245, 35, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (246, 35, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (247, 35, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (248, 35, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (249, 36, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (250, 36, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (251, 36, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (252, 36, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (253, 37, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (254, 37, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (255, 37, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (256, 37, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (257, 28, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (258, 28, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (259, 28, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (260, 28, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (261, 29, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (262, 29, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (263, 29, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (264, 29, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (265, 30, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (266, 30, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (267, 30, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (268, 30, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (269, 31, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (270, 31, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (271, 31, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (272, 31, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (273, 32, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (274, 32, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (275, 32, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (276, 32, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (277, 53, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (278, 53, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (279, 53, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (280, 53, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (281, 54, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (282, 54, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (283, 54, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (284, 54, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (285, 55, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (286, 55, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (287, 55, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (288, 55, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (289, 56, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (290, 56, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (291, 56, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (292, 56, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (293, 57, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (294, 57, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (295, 57, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (296, 57, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (297, 63, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (298, 63, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (299, 63, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (300, 63, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (301, 64, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (302, 64, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (303, 64, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (304, 64, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (305, 65, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (306, 65, N'hinhphu_8.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (307, 65, N'hinhphu_9.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (308, 65, N'hinhphu_0.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (309, 66, N'hinhphu_1.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (310, 66, N'hinhphu_2.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (311, 66, N'hinhphu_3.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (312, 66, N'hinhphu_4.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (313, 67, N'hinhphu_5.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (314, 67, N'hinhphu_6.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (315, 67, N'hinhphu_7.jpg')
GO
INSERT [dbo].[ProductImage] ([ImageId], [ProductId], [ImageUrl]) VALUES (316, 67, N'hinhphu_8.jpg')
GO
SET IDENTITY_INSERT [dbo].[ProductImage] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__AppUser__A9D10534EBD8B40E]    Script Date: 11/9/2025 12:04:05 AM ******/
ALTER TABLE [dbo].[AppUser] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Cart__733C9848880E6A62]    Script Date: 11/9/2025 12:04:05 AM ******/
ALTER TABLE [dbo].[Cart] ADD UNIQUE NONCLUSTERED 
(
	[CartToken] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Category_Slug]    Script Date: 11/9/2025 12:04:05 AM ******/
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [UQ_Category_Slug] UNIQUE NONCLUSTERED 
(
	[CatSlug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Category__3B9743804A11E2C1]    Script Date: 11/9/2025 12:04:05 AM ******/
ALTER TABLE [dbo].[CategoryGroup] ADD UNIQUE NONCLUSTERED 
(
	[GroupCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Product__BC7B5FB686A5704A]    Script Date: 11/9/2025 12:04:05 AM ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [UQ__Product__BC7B5FB686A5704A] UNIQUE NONCLUSTERED 
(
	[Slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Product__CA1ECF0DAADD792C]    Script Date: 11/9/2025 12:04:05 AM ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [UQ__Product__CA1ECF0DAADD792C] UNIQUE NONCLUSTERED 
(
	[SKU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AppUser] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[AppUser] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT (sysutcdatetime()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[CartItem] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT ((0)) FOR [SortOrder]
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[CategoryGroup] ADD  DEFAULT ((0)) FOR [SortOrder]
GO
ALTER TABLE [dbo].[CategoryGroup] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[CategoryGroup] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[CustomerAddress] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT ('PENDING') FOR [Status]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT ((0)) FOR [TotalAmount]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF__Product__Stock__4E88ABD4]  DEFAULT ((9999)) FOR [Stock]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF__Product__IsActiv__4F7CD00D]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF__Product__Created__5070F446]  DEFAULT (sysutcdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[AppUser] ([UserId])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_User]
GO
ALTER TABLE [dbo].[CartItem]  WITH CHECK ADD  CONSTRAINT [FK_CartItem_Cart] FOREIGN KEY([CartId])
REFERENCES [dbo].[Cart] ([CartId])
GO
ALTER TABLE [dbo].[CartItem] CHECK CONSTRAINT [FK_CartItem_Cart]
GO
ALTER TABLE [dbo].[CartItem]  WITH CHECK ADD  CONSTRAINT [FK_CartItem_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[CartItem] CHECK CONSTRAINT [FK_CartItem_Product]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Group] FOREIGN KEY([GroupId])
REFERENCES [dbo].[CategoryGroup] ([GroupId])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Group]
GO
ALTER TABLE [dbo].[CustomerAddress]  WITH CHECK ADD  CONSTRAINT [FK_CustomerAddress_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[AppUser] ([UserId])
GO
ALTER TABLE [dbo].[CustomerAddress] CHECK CONSTRAINT [FK_CustomerAddress_User]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[AppUser] ([UserId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_Order]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[ProductImage]  WITH CHECK ADD  CONSTRAINT [FK_ProductImage_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[ProductImage] CHECK CONSTRAINT [FK_ProductImage_Product]
GO
ALTER TABLE [dbo].[CartItem]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO

-- 1. Tạo bảng
CREATE TABLE Admin (
    AdminID NVARCHAR(10) PRIMARY KEY,
    Email VARCHAR(50),
    MatKhau VARCHAR(50) NOT NULL,
    HoTen NVARCHAR(50),
    IsActive BIT DEFAULT 1
);
GO

-- 2. Thêm dữ liệu
INSERT INTO Admin (AdminID, Email, MatKhau, HoTen)
VALUES ('1', 'admin@gmail.com', '123', N'Admin');

-- 3. Kiểm tra
SELECT * FROM Admin;