USE [master]
GO
/****** Object:  Database [BidNile]    Script Date: 11/20/2026 8:11:20 PM ******/
CREATE DATABASE [BidNile]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BidNile', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\BidNile.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BidNile_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\BidNile_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BidNile] SET COMPATIBILITY_LEVEL = 170
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BidNile].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BidNile] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BidNile] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BidNile] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BidNile] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BidNile] SET ARITHABORT OFF 
GO
ALTER DATABASE [BidNile] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BidNile] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BidNile] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BidNile] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BidNile] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BidNile] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BidNile] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BidNile] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BidNile] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BidNile] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BidNile] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BidNile] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BidNile] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BidNile] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BidNile] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BidNile] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BidNile] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BidNile] SET RECOVERY FULL 
GO
ALTER DATABASE [BidNile] SET  MULTI_USER 
GO
ALTER DATABASE [BidNile] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BidNile] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BidNile] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BidNile] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BidNile] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BidNile] SET OPTIMIZED_LOCKING = OFF 
GO
ALTER DATABASE [BidNile] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BidNile] SET QUERY_STORE = ON
GO
ALTER DATABASE [BidNile] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BidNile]
GO
/****** Object:  Schema [Auctions]    Script Date: 11/20/2026 8:11:20 PM ******/
CREATE SCHEMA [Auctions]
GO
/****** Object:  Schema [Catalogue]    Script Date: 11/20/2026 8:11:20 PM ******/
CREATE SCHEMA [Catalogue]
GO
/****** Object:  Schema [Marketing]    Script Date: 11/20/2026 8:11:20 PM ******/
CREATE SCHEMA [Marketing]
GO
/****** Object:  Schema [Membership]    Script Date: 11/20/2026 8:11:20 PM ******/
CREATE SCHEMA [Membership]
GO
/****** Object:  Schema [Operations]    Script Date: 11/20/2026 8:11:20 PM ******/
CREATE SCHEMA [Operations]
GO
/****** Object:  Table [Auctions].[Auction]    Script Date: 11/20/2026 8:11:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auctions].[Auction](
	[AuctionId] [bigint] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NOT NULL,
	[StartingPrice] [decimal](12, 2) NOT NULL,
	[ReservePrice] [decimal](12, 2) NULL,
	[BidIncrement] [decimal](12, 2) NOT NULL,
	[StartsAt] [datetimeoffset](3) NOT NULL,
	[EndsAt] [datetimeoffset](3) NOT NULL,
	[Status] [varchar](15) NOT NULL,
	[BuyNowPrice] [decimal](12, 2) NULL,
 CONSTRAINT [PK_Auction] PRIMARY KEY CLUSTERED 
(
	[AuctionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auctions].[Bid]    Script Date: 11/20/2026 8:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auctions].[Bid](
	[BidId] [bigint] IDENTITY(1,1) NOT NULL,
	[AuctionId] [bigint] NOT NULL,
	[BidderId] [uniqueidentifier] NOT NULL,
	[Amount] [decimal](12, 2) NOT NULL,
	[PlacedAt] [datetime2](3) NOT NULL,
	[DeviceIp] [varchar](45) NOT NULL,
 CONSTRAINT [PK_Bid] PRIMARY KEY CLUSTERED 
(
	[BidId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Catalogue].[Category]    Script Date: 11/20/2026 8:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Catalogue].[Category](
	[CategoryId] [int] NOT NULL,
	[ParentCategoryId] [int] NULL,
	[EnglishName] [varchar](50) NOT NULL,
	[ArabicName] [varchar](50) NOT NULL,
	[CommissionRate] [decimal](4, 2) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Catalogue].[Item]    Script Date: 11/20/2026 8:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Catalogue].[Item](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](150) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[ConditionScore] [tinyint] NOT NULL,
	[Specifications] [nvarchar](max) NOT NULL,
	[SellerId] [uniqueidentifier] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[WarehouseId] [int] NULL,
	[InspectorId] [uniqueidentifier] NULL,
	[ListedAt] [datetime2](3) NOT NULL,
	[IsFeatured] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Catalogue].[ItemPhoto]    Script Date: 11/20/2026 8:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Catalogue].[ItemPhoto](
	[ItemId] [int] NOT NULL,
	[Position] [tinyint] NOT NULL,
	[Url] [varchar](500) NOT NULL,
	[IsMain] [bit] NOT NULL,
 CONSTRAINT [PK_ItemPhoto] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC,
	[Position] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Marketing].[AuctionFollower]    Script Date: 11/20/2026 8:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Marketing].[AuctionFollower](
	[AuctionId] [bigint] NOT NULL,
	[MemberId] [uniqueidentifier] NOT NULL,
	[FollowedAt] [datetime2](3) NOT NULL,
 CONSTRAINT [PK_AuctionFollower] PRIMARY KEY CLUSTERED 
(
	[AuctionId] ASC,
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Membership].[City]    Script Date: 11/20/2026 8:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Membership].[City](
	[CityId] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [nvarchar](60) NOT NULL,
	[CountryCode] [char](2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Membership].[Member]    Script Date: 11/20/2026 8:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Membership].[Member](
	[MemberId] [uniqueidentifier] NOT NULL,
	[FullName] [nvarchar](150) NOT NULL,
	[Email] [varchar](254) NOT NULL,
	[MobileNumber] [varchar](16) NOT NULL,
	[NationalIdOrPassport] [varchar](20) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[CreatedAt] [datetime2](3) NOT NULL,
	[CityId] [int] NOT NULL,
	[ReferredByMemberId] [uniqueidentifier] NULL,
	[PreferredLanguage] [char](2) NOT NULL,
	[VerifiedAt] [datetime2](0) NULL,
PRIMARY KEY CLUSTERED 
(
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Membership].[Wallet]    Script Date: 11/20/2026 8:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Membership].[Wallet](
	[MemberId] [uniqueidentifier] NOT NULL,
	[Balance] [decimal](12, 2) NOT NULL,
	[HeldAmount] [decimal](12, 2) NOT NULL,
	[Currency] [char](3) NOT NULL,
	[UpdatedAt] [datetime2](3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Operations].[Employee]    Script Date: 11/20/2026 8:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Operations].[Employee](
	[MemberId] [uniqueidentifier] NOT NULL,
	[WarehouseId] [int] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[MemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Operations].[Warehouse]    Script Date: 11/20/2026 8:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Operations].[Warehouse](
	[WarehouseId] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseName] [nvarchar](80) NOT NULL,
	[MaxItems] [smallint] NOT NULL,
	[CityId] [int] NOT NULL,
	[Latitude] [float] NOT NULL,
	[Longitude] [decimal](9, 6) NOT NULL,
	[ManagerMemberId] [uniqueidentifier] NOT NULL,
	[ManagerStartDate] [date] NOT NULL,
 CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED 
(
	[WarehouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [Auctions].[Auction] ON 

INSERT [Auctions].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartsAt], [EndsAt], [Status], [BuyNowPrice]) VALUES (5, 1, CAST(12000.00 AS Decimal(12, 2)), CAST(14000.00 AS Decimal(12, 2)), CAST(250.00 AS Decimal(12, 2)), CAST(N'2026-10-01T10:00:00.0000000+02:00' AS DateTimeOffset), CAST(N'2026-10-05T22:00:00.0000000+02:00' AS DateTimeOffset), N'Live', CAST(18500.00 AS Decimal(12, 2)))
INSERT [Auctions].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartsAt], [EndsAt], [Status], [BuyNowPrice]) VALUES (6, 2, CAST(5000.00 AS Decimal(12, 2)), CAST(6500.00 AS Decimal(12, 2)), CAST(100.00 AS Decimal(12, 2)), CAST(N'2026-09-20T09:00:00.0000000+02:00' AS DateTimeOffset), CAST(N'2026-09-25T20:00:00.0000000+02:00' AS DateTimeOffset), N'Ended', CAST(9000.00 AS Decimal(12, 2)))
INSERT [Auctions].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartsAt], [EndsAt], [Status], [BuyNowPrice]) VALUES (7, 3, CAST(18000.00 AS Decimal(12, 2)), CAST(20000.00 AS Decimal(12, 2)), CAST(500.00 AS Decimal(12, 2)), CAST(N'2026-10-02T12:00:00.0000000+02:00' AS DateTimeOffset), CAST(N'2026-10-06T23:00:00.0000000+02:00' AS DateTimeOffset), N'Live', CAST(26000.00 AS Decimal(12, 2)))
INSERT [Auctions].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartsAt], [EndsAt], [Status], [BuyNowPrice]) VALUES (8, 4, CAST(8000.00 AS Decimal(12, 2)), CAST(9500.00 AS Decimal(12, 2)), CAST(200.00 AS Decimal(12, 2)), CAST(N'2026-10-10T08:00:00.0000000+03:00' AS DateTimeOffset), CAST(N'2026-10-15T21:00:00.0000000+03:00' AS DateTimeOffset), N'PendingReview', CAST(13000.00 AS Decimal(12, 2)))
INSERT [Auctions].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartsAt], [EndsAt], [Status], [BuyNowPrice]) VALUES (9, 5, CAST(1500.00 AS Decimal(12, 2)), NULL, CAST(50.00 AS Decimal(12, 2)), CAST(N'2026-10-12T10:00:00.0000000+02:00' AS DateTimeOffset), CAST(N'2026-10-18T18:00:00.0000000+02:00' AS DateTimeOffset), N'Draft', NULL)
INSERT [Auctions].[Auction] ([AuctionId], [ItemId], [StartingPrice], [ReservePrice], [BidIncrement], [StartsAt], [EndsAt], [Status], [BuyNowPrice]) VALUES (10, 6, CAST(2000.00 AS Decimal(12, 2)), CAST(2500.00 AS Decimal(12, 2)), CAST(100.00 AS Decimal(12, 2)), CAST(N'2026-10-03T11:00:00.0000000+03:00' AS DateTimeOffset), CAST(N'2026-10-07T19:00:00.0000000+03:00' AS DateTimeOffset), N'Cancelled', CAST(4000.00 AS Decimal(12, 2)))
SET IDENTITY_INSERT [Auctions].[Auction] OFF
GO
INSERT [Catalogue].[Category] ([CategoryId], [ParentCategoryId], [EnglishName], [ArabicName], [CommissionRate]) VALUES (1, NULL, N'Electronics', N'??????????', CAST(10.00 AS Decimal(4, 2)))
INSERT [Catalogue].[Category] ([CategoryId], [ParentCategoryId], [EnglishName], [ArabicName], [CommissionRate]) VALUES (2, 1, N'Laptops', N'????????', CAST(8.50 AS Decimal(4, 2)))
INSERT [Catalogue].[Category] ([CategoryId], [ParentCategoryId], [EnglishName], [ArabicName], [CommissionRate]) VALUES (3, NULL, N'Watches', N'?????', CAST(12.00 AS Decimal(4, 2)))
INSERT [Catalogue].[Category] ([CategoryId], [ParentCategoryId], [EnglishName], [ArabicName], [CommissionRate]) VALUES (4, 3, N'LuxuryWatches', N'????? ?????', CAST(15.00 AS Decimal(4, 2)))
INSERT [Catalogue].[Category] ([CategoryId], [ParentCategoryId], [EnglishName], [ArabicName], [CommissionRate]) VALUES (5, NULL, N'HomeDecor', N'????? ?????', CAST(9.00 AS Decimal(4, 2)))
INSERT [Catalogue].[Category] ([CategoryId], [ParentCategoryId], [EnglishName], [ArabicName], [CommissionRate]) VALUES (6, NULL, N'Collectibles', N'???????', CAST(14.00 AS Decimal(4, 2)))
GO
SET IDENTITY_INSERT [Catalogue].[Item] ON 

INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (1, N'Lenovo ThinkPad T14 Gen 3', N'لابتوب بحالة ممتازة للاستخدام البرمجي', 9, N'{"cpu":"Core i7-1265U","ram_gb":16,"storage":"512GB NVMe"}', N'11111111-1111-1111-1111-111111111101', 2, 1, N'11111111-1111-1111-1111-111111111102', CAST(N'2026-09-12T10:00:00.0000000' AS DateTime2), 1)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (2, N'Seiko Presage Cocktail', N'ساعة أوتوماتيك أصلية بالعلبة الأصلية', 9, N'{"movement":"Automatic","case_mm":40,"water_resistant_m":50}', N'11111111-1111-1111-1111-111111111103', 4, 2, N'11111111-1111-1111-1111-111111111104', CAST(N'2026-09-13T11:30:00.0000000' AS DateTime2), 1)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (3, N'MacBook Air M2', N'خفيف وسريع جداً للعمل والدراسة', 10, N'{"cpu":"Apple M2","ram_gb":16,"storage":"256GB SSD"}', N'11111111-1111-1111-1111-111111111105', 2, 1, N'11111111-1111-1111-1111-111111111102', CAST(N'2026-09-14T09:00:00.0000000' AS DateTime2), 1)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (4, N'Omega Seamaster Vintage', N'ساعة كلاسيكية نادرة بحالة جيدة', 8, N'{"movement":"Mechanical","case_mm":36,"strap":"Leather"}', N'11111111-1111-1111-1111-111111111107', 4, 4, N'11111111-1111-1111-1111-111111111109', CAST(N'2026-09-15T14:20:00.0000000' AS DateTime2), 0)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (5, N'Ceramic Table Lamp', N'أباجورة سيراميك يدوية الصنع', 8, N'{"material":"Ceramic","height_cm":42,"bulb_type":"E27"}', N'11111111-1111-1111-1111-111111111108', 5, 3, N'11111111-1111-1111-1111-111111111106', CAST(N'2026-09-16T16:00:00.0000000' AS DateTime2), 0)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (6, N'First Edition Poetry Book', N'نسخة قديمة محفوظة بعناية', 7, N'{"language":"Arabic","pages":320,"year_printed":1978}', N'11111111-1111-1111-1111-111111111110', 6, 5, N'11111111-1111-1111-1111-111111111109', CAST(N'2026-09-17T12:00:00.0000000' AS DateTime2), 0)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (7, N'Lenovo ThinkPad T14 Gen 3', N'لابتوب بحالة ممتازة للاستخدام البرمجي', 9, N'{"cpu":"Core i7-1265U","ram_gb":16,"storage":"512GB NVMe"}', N'11111111-1111-1111-1111-111111111101', 2, 1, N'11111111-1111-1111-1111-111111111102', CAST(N'2026-09-12T10:00:00.0000000' AS DateTime2), 1)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (8, N'Seiko Presage Cocktail', N'ساعة أوتوماتيك أصلية بالعلبة الأصلية', 9, N'{"movement":"Automatic","case_mm":40,"water_resistant_m":50}', N'11111111-1111-1111-1111-111111111103', 4, 2, N'11111111-1111-1111-1111-111111111104', CAST(N'2026-09-13T11:30:00.0000000' AS DateTime2), 1)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (9, N'MacBook Air M2', N'خفيف وسريع جداً للعمل والدراسة', 10, N'{"cpu":"Apple M2","ram_gb":16,"storage":"256GB SSD"}', N'11111111-1111-1111-1111-111111111105', 2, 1, N'11111111-1111-1111-1111-111111111102', CAST(N'2026-09-14T09:00:00.0000000' AS DateTime2), 1)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (10, N'Omega Seamaster Vintage', N'ساعة كلاسيكية نادرة بحالة جيدة', 8, N'{"movement":"Mechanical","case_mm":36,"strap":"Leather"}', N'11111111-1111-1111-1111-111111111107', 4, 4, N'11111111-1111-1111-1111-111111111109', CAST(N'2026-09-15T14:20:00.0000000' AS DateTime2), 0)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (11, N'Ceramic Table Lamp', N'أباجورة سيراميك يدوية الصنع', 8, N'{"material":"Ceramic","height_cm":42,"bulb_type":"E27"}', N'11111111-1111-1111-1111-111111111108', 5, 3, N'11111111-1111-1111-1111-111111111106', CAST(N'2026-09-16T16:00:00.0000000' AS DateTime2), 0)
INSERT [Catalogue].[Item] ([ItemId], [Title], [Description], [ConditionScore], [Specifications], [SellerId], [CategoryId], [WarehouseId], [InspectorId], [ListedAt], [IsFeatured]) VALUES (12, N'First Edition Poetry Book', N'نسخة قديمة محفوظة بعناية', 7, N'{"language":"Arabic","pages":320,"year_printed":1978}', N'11111111-1111-1111-1111-111111111110', 6, 5, N'11111111-1111-1111-1111-111111111109', CAST(N'2026-09-17T12:00:00.0000000' AS DateTime2), 0)
SET IDENTITY_INSERT [Catalogue].[Item] OFF
GO
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [Url], [IsMain]) VALUES (1, 1, N'https://example.com/photos/item1-1.jpg', 1)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [Url], [IsMain]) VALUES (1, 2, N'https://example.com/photos/item1-2.jpg', 0)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [Url], [IsMain]) VALUES (2, 1, N'https://example.com/photos/item2-1.jpg', 1)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [Url], [IsMain]) VALUES (3, 1, N'https://example.com/photos/item3-1.jpg', 1)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [Url], [IsMain]) VALUES (4, 1, N'https://example.com/photos/item4-1.jpg', 1)
INSERT [Catalogue].[ItemPhoto] ([ItemId], [Position], [Url], [IsMain]) VALUES (5, 1, N'https://example.com/photos/item5-1.jpg', 1)
GO
SET IDENTITY_INSERT [Membership].[City] ON 

INSERT [Membership].[City] ([CityId], [CityName], [CountryCode]) VALUES (6, N'دبي', N'AE')
INSERT [Membership].[City] ([CityId], [CityName], [CountryCode]) VALUES (1, N'الإسكندرية', N'EG')
INSERT [Membership].[City] ([CityId], [CityName], [CountryCode]) VALUES (3, N'الجيزة', N'EG')
INSERT [Membership].[City] ([CityId], [CityName], [CountryCode]) VALUES (2, N'القاهرة', N'EG')
INSERT [Membership].[City] ([CityId], [CityName], [CountryCode]) VALUES (4, N'الرياض', N'SA')
INSERT [Membership].[City] ([CityId], [CityName], [CountryCode]) VALUES (5, N'جدة', N'SA')
SET IDENTITY_INSERT [Membership].[City] OFF
GO
INSERT [Membership].[Member] ([MemberId], [FullName], [Email], [MobileNumber], [NationalIdOrPassport], [BirthDate], [CreatedAt], [CityId], [ReferredByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'11111111-1111-1111-1111-111111111101', N'رويدا يحيى', N'rowida.yahia@example.com', N'+201001112201', N'29901010200101', CAST(N'2003-03-15' AS Date), CAST(N'2026-09-01T10:00:00.0000000' AS DateTime2), 1, NULL, N'ar', CAST(N'2026-09-01T10:05:00.0000000' AS DateTime2))
INSERT [Membership].[Member] ([MemberId], [FullName], [Email], [MobileNumber], [NationalIdOrPassport], [BirthDate], [CreatedAt], [CityId], [ReferredByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'11111111-1111-1111-1111-111111111102', N'أحمد محمود', N'ahmed.mahmoud@example.com', N'+201001112202', N'29805120100202', CAST(N'1998-05-12' AS Date), CAST(N'2026-09-02T11:15:00.0000000' AS DateTime2), 2, N'11111111-1111-1111-1111-111111111101', N'ar', CAST(N'2026-09-02T11:20:00.0000000' AS DateTime2))
INSERT [Membership].[Member] ([MemberId], [FullName], [Email], [MobileNumber], [NationalIdOrPassport], [BirthDate], [CreatedAt], [CityId], [ReferredByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'11111111-1111-1111-1111-111111111103', N'سلمى حسن', N'salma.hassan@example.com', N'+201001112203', N'30007200200303', CAST(N'2000-07-20' AS Date), CAST(N'2026-09-03T12:30:00.0000000' AS DateTime2), 1, N'11111111-1111-1111-1111-111111111101', N'en', CAST(N'2026-09-03T12:40:00.0000000' AS DateTime2))
INSERT [Membership].[Member] ([MemberId], [FullName], [Email], [MobileNumber], [NationalIdOrPassport], [BirthDate], [CreatedAt], [CityId], [ReferredByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'11111111-1111-1111-1111-111111111104', N'عمر طارق', N'omar.tarek@example.com', N'+201001112204', N'29702180100404', CAST(N'1997-02-18' AS Date), CAST(N'2026-09-04T09:20:00.0000000' AS DateTime2), 3, N'11111111-1111-1111-1111-111111111102', N'ar', CAST(N'2026-09-04T09:30:00.0000000' AS DateTime2))
INSERT [Membership].[Member] ([MemberId], [FullName], [Email], [MobileNumber], [NationalIdOrPassport], [BirthDate], [CreatedAt], [CityId], [ReferredByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'11111111-1111-1111-1111-111111111105', N'نورا سمير', N'noura.samir@example.com', N'+201001112205', N'30111050200505', CAST(N'2001-11-05' AS Date), CAST(N'2026-09-05T14:10:00.0000000' AS DateTime2), 2, NULL, N'en', CAST(N'2026-09-05T14:25:00.0000000' AS DateTime2))
INSERT [Membership].[Member] ([MemberId], [FullName], [Email], [MobileNumber], [NationalIdOrPassport], [BirthDate], [CreatedAt], [CityId], [ReferredByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'11111111-1111-1111-1111-111111111106', N'كريم عادل', N'karim.adel@example.com', N'+201001112206', N'29608140100606', CAST(N'1996-08-14' AS Date), CAST(N'2026-09-06T16:00:00.0000000' AS DateTime2), 1, N'11111111-1111-1111-1111-111111111103', N'ar', NULL)
INSERT [Membership].[Member] ([MemberId], [FullName], [Email], [MobileNumber], [NationalIdOrPassport], [BirthDate], [CreatedAt], [CityId], [ReferredByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'11111111-1111-1111-1111-111111111107', N'فهد العتيبي', N'fahad.otaibi@example.com', N'+966501112207', N'SA102938475607', CAST(N'1995-03-10' AS Date), CAST(N'2026-09-07T08:45:00.0000000' AS DateTime2), 4, NULL, N'ar', CAST(N'2026-09-07T09:00:00.0000000' AS DateTime2))
INSERT [Membership].[Member] ([MemberId], [FullName], [Email], [MobileNumber], [NationalIdOrPassport], [BirthDate], [CreatedAt], [CityId], [ReferredByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'11111111-1111-1111-1111-111111111108', N'ريم القحطاني', N'reem.qahtani@example.com', N'+966501112208', N'SA102938475608', CAST(N'1999-12-01' AS Date), CAST(N'2026-09-08T13:15:00.0000000' AS DateTime2), 5, N'11111111-1111-1111-1111-111111111107', N'en', CAST(N'2026-09-08T13:20:00.0000000' AS DateTime2))
INSERT [Membership].[Member] ([MemberId], [FullName], [Email], [MobileNumber], [NationalIdOrPassport], [BirthDate], [CreatedAt], [CityId], [ReferredByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'11111111-1111-1111-1111-111111111109', N'منصور المنصوري', N'mansoor.m@example.com', N'+971501112209', N'AE784199283709', CAST(N'1994-06-25' AS Date), CAST(N'2026-09-09T15:00:00.0000000' AS DateTime2), 6, NULL, N'en', CAST(N'2026-09-09T15:10:00.0000000' AS DateTime2))
INSERT [Membership].[Member] ([MemberId], [FullName], [Email], [MobileNumber], [NationalIdOrPassport], [BirthDate], [CreatedAt], [CityId], [ReferredByMemberId], [PreferredLanguage], [VerifiedAt]) VALUES (N'11111111-1111-1111-1111-111111111110', N'مريم إبراهيم', N'mariam.ibrahim@example.com', N'+201001112210', N'30204090201010', CAST(N'2002-04-09' AS Date), CAST(N'2026-09-10T17:30:00.0000000' AS DateTime2), 1, N'11111111-1111-1111-1111-111111111101', N'ar', CAST(N'2026-09-10T17:45:00.0000000' AS DateTime2))
GO
INSERT [Membership].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [UpdatedAt]) VALUES (N'11111111-1111-1111-1111-111111111101', CAST(25000.00 AS Decimal(12, 2)), CAST(1500.00 AS Decimal(12, 2)), N'EGP', CAST(N'2026-10-01T12:00:00.0000000' AS DateTime2))
INSERT [Membership].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [UpdatedAt]) VALUES (N'11111111-1111-1111-1111-111111111102', CAST(40000.00 AS Decimal(12, 2)), CAST(5000.00 AS Decimal(12, 2)), N'EGP', CAST(N'2026-10-01T12:05:00.0000000' AS DateTime2))
INSERT [Membership].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [UpdatedAt]) VALUES (N'11111111-1111-1111-1111-111111111103', CAST(18000.00 AS Decimal(12, 2)), CAST(2000.00 AS Decimal(12, 2)), N'EGP', CAST(N'2026-10-01T12:10:00.0000000' AS DateTime2))
INSERT [Membership].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [UpdatedAt]) VALUES (N'11111111-1111-1111-1111-111111111104', CAST(32000.00 AS Decimal(12, 2)), CAST(4500.00 AS Decimal(12, 2)), N'EGP', CAST(N'2026-10-01T12:15:00.0000000' AS DateTime2))
INSERT [Membership].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [UpdatedAt]) VALUES (N'11111111-1111-1111-1111-111111111105', CAST(15000.00 AS Decimal(12, 2)), CAST(1000.00 AS Decimal(12, 2)), N'EGP', CAST(N'2026-10-01T12:20:00.0000000' AS DateTime2))
INSERT [Membership].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [UpdatedAt]) VALUES (N'11111111-1111-1111-1111-111111111106', CAST(9500.00 AS Decimal(12, 2)), CAST(500.00 AS Decimal(12, 2)), N'EGP', CAST(N'2026-10-01T12:25:00.0000000' AS DateTime2))
INSERT [Membership].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [UpdatedAt]) VALUES (N'11111111-1111-1111-1111-111111111107', CAST(60000.00 AS Decimal(12, 2)), CAST(8000.00 AS Decimal(12, 2)), N'SAR', CAST(N'2026-10-01T12:30:00.0000000' AS DateTime2))
INSERT [Membership].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [UpdatedAt]) VALUES (N'11111111-1111-1111-1111-111111111108', CAST(22000.00 AS Decimal(12, 2)), CAST(2500.00 AS Decimal(12, 2)), N'SAR', CAST(N'2026-10-01T12:35:00.0000000' AS DateTime2))
INSERT [Membership].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [UpdatedAt]) VALUES (N'11111111-1111-1111-1111-111111111109', CAST(50000.00 AS Decimal(12, 2)), CAST(6000.00 AS Decimal(12, 2)), N'AED', CAST(N'2026-10-01T12:40:00.0000000' AS DateTime2))
INSERT [Membership].[Wallet] ([MemberId], [Balance], [HeldAmount], [Currency], [UpdatedAt]) VALUES (N'11111111-1111-1111-1111-111111111110', CAST(12000.00 AS Decimal(12, 2)), CAST(1200.00 AS Decimal(12, 2)), N'EGP', CAST(N'2026-10-01T12:45:00.0000000' AS DateTime2))
GO
INSERT [Operations].[Employee] ([MemberId], [WarehouseId]) VALUES (N'11111111-1111-1111-1111-111111111102', 1)
INSERT [Operations].[Employee] ([MemberId], [WarehouseId]) VALUES (N'11111111-1111-1111-1111-111111111104', 2)
INSERT [Operations].[Employee] ([MemberId], [WarehouseId]) VALUES (N'11111111-1111-1111-1111-111111111106', 3)
INSERT [Operations].[Employee] ([MemberId], [WarehouseId]) VALUES (N'11111111-1111-1111-1111-111111111107', 4)
INSERT [Operations].[Employee] ([MemberId], [WarehouseId]) VALUES (N'11111111-1111-1111-1111-111111111108', 4)
INSERT [Operations].[Employee] ([MemberId], [WarehouseId]) VALUES (N'11111111-1111-1111-1111-111111111109', 5)
GO
SET IDENTITY_INSERT [Operations].[Warehouse] ON 

INSERT [Operations].[Warehouse] ([WarehouseId], [WarehouseName], [MaxItems], [CityId], [Latitude], [Longitude], [ManagerMemberId], [ManagerStartDate]) VALUES (1, N'مخزن سموحة الرئيسي', 500, 1, 31.21564, CAST(29.955270 AS Decimal(9, 6)), N'11111111-1111-1111-1111-111111111102', CAST(N'2026-01-10' AS Date))
INSERT [Operations].[Warehouse] ([WarehouseId], [WarehouseName], [MaxItems], [CityId], [Latitude], [Longitude], [ManagerMemberId], [ManagerStartDate]) VALUES (2, N'مخزن القاهرة الجديدة', 800, 2, 30.007413, CAST(31.491299 AS Decimal(9, 6)), N'11111111-1111-1111-1111-111111111104', CAST(N'2026-02-01' AS Date))
INSERT [Operations].[Warehouse] ([WarehouseId], [WarehouseName], [MaxItems], [CityId], [Latitude], [Longitude], [ManagerMemberId], [ManagerStartDate]) VALUES (3, N'مخزن الجيزة اللوجستي', 600, 3, 30.013056, CAST(31.208853 AS Decimal(9, 6)), N'11111111-1111-1111-1111-111111111106', CAST(N'2026-02-15' AS Date))
INSERT [Operations].[Warehouse] ([WarehouseId], [WarehouseName], [MaxItems], [CityId], [Latitude], [Longitude], [ManagerMemberId], [ManagerStartDate]) VALUES (4, N'مخزن الرياض المركزي', 900, 4, 24.713552, CAST(46.675296 AS Decimal(9, 6)), N'11111111-1111-1111-1111-111111111107', CAST(N'2026-03-01' AS Date))
INSERT [Operations].[Warehouse] ([WarehouseId], [WarehouseName], [MaxItems], [CityId], [Latitude], [Longitude], [ManagerMemberId], [ManagerStartDate]) VALUES (5, N'مخزن دبي الذكي', 750, 6, 25.204849, CAST(55.270782 AS Decimal(9, 6)), N'11111111-1111-1111-1111-111111111109', CAST(N'2026-03-20' AS Date))
SET IDENTITY_INSERT [Operations].[Warehouse] OFF
GO
/****** Object:  Index [UQ_Bid_Auction_Amount]    Script Date: 11/20/2026 8:11:21 PM ******/
ALTER TABLE [Auctions].[Bid] ADD  CONSTRAINT [UQ_Bid_Auction_Amount] UNIQUE NONCLUSTERED 
(
	[AuctionId] ASC,
	[Amount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Category_EnglishName]    Script Date: 11/20/2026 8:11:21 PM ******/
ALTER TABLE [Catalogue].[Category] ADD  CONSTRAINT [UQ_Category_EnglishName] UNIQUE NONCLUSTERED 
(
	[EnglishName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_City_CountryCode_CityName]    Script Date: 11/20/2026 8:11:21 PM ******/
ALTER TABLE [Membership].[City] ADD  CONSTRAINT [UQ_City_CountryCode_CityName] UNIQUE NONCLUSTERED 
(
	[CountryCode] ASC,
	[CityName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Member_Email]    Script Date: 11/20/2026 8:11:21 PM ******/
ALTER TABLE [Membership].[Member] ADD  CONSTRAINT [UQ_Member_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Member_MobileNumber]    Script Date: 11/20/2026 8:11:21 PM ******/
ALTER TABLE [Membership].[Member] ADD  CONSTRAINT [UQ_Member_MobileNumber] UNIQUE NONCLUSTERED 
(
	[MobileNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Member_NationalIdOrPassport]    Script Date: 11/20/2026 8:11:21 PM ******/
ALTER TABLE [Membership].[Member] ADD  CONSTRAINT [UQ_Member_NationalIdOrPassport] UNIQUE NONCLUSTERED 
(
	[NationalIdOrPassport] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Warehouse_ManagerMemberId]    Script Date: 11/20/2026 8:11:21 PM ******/
ALTER TABLE [Operations].[Warehouse] ADD  CONSTRAINT [UQ_Warehouse_ManagerMemberId] UNIQUE NONCLUSTERED 
(
	[ManagerMemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Warehouse_Name]    Script Date: 11/20/2026 8:11:21 PM ******/
ALTER TABLE [Operations].[Warehouse] ADD  CONSTRAINT [UQ_Warehouse_Name] UNIQUE NONCLUSTERED 
(
	[WarehouseName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [Auctions].[Auction] ADD  CONSTRAINT [DF_Auction_BidIncrement]  DEFAULT ((50.00)) FOR [BidIncrement]
GO
ALTER TABLE [Auctions].[Auction] ADD  CONSTRAINT [DF_Auction_Status]  DEFAULT ('PendingReview') FOR [Status]
GO
ALTER TABLE [Auctions].[Bid] ADD  CONSTRAINT [DF_Bid_PlacedAt]  DEFAULT (sysdatetime()) FOR [PlacedAt]
GO
ALTER TABLE [Catalogue].[Item] ADD  CONSTRAINT [DF_Item_ListedAt]  DEFAULT (sysdatetime()) FOR [ListedAt]
GO
ALTER TABLE [Catalogue].[Item] ADD  CONSTRAINT [DF_Item_IsFeatured]  DEFAULT ((0)) FOR [IsFeatured]
GO
ALTER TABLE [Catalogue].[ItemPhoto] ADD  CONSTRAINT [DF_ItemPhoto_IsMain]  DEFAULT ((0)) FOR [IsMain]
GO
ALTER TABLE [Marketing].[AuctionFollower] ADD  CONSTRAINT [DF_AuctionFollower_FollowedAt]  DEFAULT (sysdatetime()) FOR [FollowedAt]
GO
ALTER TABLE [Membership].[Member] ADD  CONSTRAINT [DF_Member_MemberId]  DEFAULT (newid()) FOR [MemberId]
GO
ALTER TABLE [Membership].[Member] ADD  CONSTRAINT [DF_Member_CreatedAt]  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [Membership].[Member] ADD  CONSTRAINT [DF_Member_PreferredLanguage]  DEFAULT ('ar') FOR [PreferredLanguage]
GO
ALTER TABLE [Membership].[Wallet] ADD  CONSTRAINT [DF_Wallet_Balance]  DEFAULT ((0)) FOR [Balance]
GO
ALTER TABLE [Membership].[Wallet] ADD  CONSTRAINT [DF_Wallet_HeldAmount]  DEFAULT ((0)) FOR [HeldAmount]
GO
ALTER TABLE [Membership].[Wallet] ADD  CONSTRAINT [DF_Wallet_Currency]  DEFAULT ('EGP') FOR [Currency]
GO
ALTER TABLE [Membership].[Wallet] ADD  CONSTRAINT [DF_Wallet_UpdatedAt]  DEFAULT (sysdatetime()) FOR [UpdatedAt]
GO
ALTER TABLE [Auctions].[Auction]  WITH CHECK ADD  CONSTRAINT [FK_Auction_Item] FOREIGN KEY([ItemId])
REFERENCES [Catalogue].[Item] ([ItemId])
GO
ALTER TABLE [Auctions].[Auction] CHECK CONSTRAINT [FK_Auction_Item]
GO
ALTER TABLE [Auctions].[Bid]  WITH CHECK ADD  CONSTRAINT [FK_Bid_Auction] FOREIGN KEY([AuctionId])
REFERENCES [Auctions].[Auction] ([AuctionId])
GO
ALTER TABLE [Auctions].[Bid] CHECK CONSTRAINT [FK_Bid_Auction]
GO
ALTER TABLE [Auctions].[Bid]  WITH CHECK ADD  CONSTRAINT [FK_Bid_Bidder] FOREIGN KEY([BidderId])
REFERENCES [Membership].[Member] ([MemberId])
GO
ALTER TABLE [Auctions].[Bid] CHECK CONSTRAINT [FK_Bid_Bidder]
GO
ALTER TABLE [Catalogue].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_ParentCategory] FOREIGN KEY([ParentCategoryId])
REFERENCES [Catalogue].[Category] ([CategoryId])
GO
ALTER TABLE [Catalogue].[Category] CHECK CONSTRAINT [FK_Category_ParentCategory]
GO
ALTER TABLE [Catalogue].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Category] FOREIGN KEY([CategoryId])
REFERENCES [Catalogue].[Category] ([CategoryId])
GO
ALTER TABLE [Catalogue].[Item] CHECK CONSTRAINT [FK_Item_Category]
GO
ALTER TABLE [Catalogue].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Inspector] FOREIGN KEY([InspectorId])
REFERENCES [Operations].[Employee] ([MemberId])
GO
ALTER TABLE [Catalogue].[Item] CHECK CONSTRAINT [FK_Item_Inspector]
GO
ALTER TABLE [Catalogue].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Seller] FOREIGN KEY([SellerId])
REFERENCES [Membership].[Member] ([MemberId])
GO
ALTER TABLE [Catalogue].[Item] CHECK CONSTRAINT [FK_Item_Seller]
GO
ALTER TABLE [Catalogue].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Warehouse] FOREIGN KEY([WarehouseId])
REFERENCES [Operations].[Warehouse] ([WarehouseId])
GO
ALTER TABLE [Catalogue].[Item] CHECK CONSTRAINT [FK_Item_Warehouse]
GO
ALTER TABLE [Catalogue].[ItemPhoto]  WITH CHECK ADD  CONSTRAINT [FK_ItemPhoto_Item] FOREIGN KEY([ItemId])
REFERENCES [Catalogue].[Item] ([ItemId])
ON DELETE CASCADE
GO
ALTER TABLE [Catalogue].[ItemPhoto] CHECK CONSTRAINT [FK_ItemPhoto_Item]
GO
ALTER TABLE [Marketing].[AuctionFollower]  WITH CHECK ADD  CONSTRAINT [FK_AuctionFollower_Auction] FOREIGN KEY([AuctionId])
REFERENCES [Auctions].[Auction] ([AuctionId])
GO
ALTER TABLE [Marketing].[AuctionFollower] CHECK CONSTRAINT [FK_AuctionFollower_Auction]
GO
ALTER TABLE [Marketing].[AuctionFollower]  WITH CHECK ADD  CONSTRAINT [FK_AuctionFollower_Member] FOREIGN KEY([MemberId])
REFERENCES [Membership].[Member] ([MemberId])
GO
ALTER TABLE [Marketing].[AuctionFollower] CHECK CONSTRAINT [FK_AuctionFollower_Member]
GO
ALTER TABLE [Membership].[Member]  WITH CHECK ADD  CONSTRAINT [FK_Member_City] FOREIGN KEY([CityId])
REFERENCES [Membership].[City] ([CityId])
GO
ALTER TABLE [Membership].[Member] CHECK CONSTRAINT [FK_Member_City]
GO
ALTER TABLE [Membership].[Member]  WITH CHECK ADD  CONSTRAINT [FK_Member_ReferredBy] FOREIGN KEY([ReferredByMemberId])
REFERENCES [Membership].[Member] ([MemberId])
GO
ALTER TABLE [Membership].[Member] CHECK CONSTRAINT [FK_Member_ReferredBy]
GO
ALTER TABLE [Membership].[Wallet]  WITH CHECK ADD  CONSTRAINT [FK_Wallet_Member] FOREIGN KEY([MemberId])
REFERENCES [Membership].[Member] ([MemberId])
GO
ALTER TABLE [Membership].[Wallet] CHECK CONSTRAINT [FK_Wallet_Member]
GO
ALTER TABLE [Operations].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Member] FOREIGN KEY([MemberId])
REFERENCES [Membership].[Member] ([MemberId])
GO
ALTER TABLE [Operations].[Employee] CHECK CONSTRAINT [FK_Employee_Member]
GO
ALTER TABLE [Operations].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Warehouse] FOREIGN KEY([WarehouseId])
REFERENCES [Operations].[Warehouse] ([WarehouseId])
GO
ALTER TABLE [Operations].[Employee] CHECK CONSTRAINT [FK_Employee_Warehouse]
GO
ALTER TABLE [Operations].[Warehouse]  WITH CHECK ADD  CONSTRAINT [FK_Warehouse_City] FOREIGN KEY([CityId])
REFERENCES [Membership].[City] ([CityId])
GO
ALTER TABLE [Operations].[Warehouse] CHECK CONSTRAINT [FK_Warehouse_City]
GO
ALTER TABLE [Operations].[Warehouse]  WITH CHECK ADD  CONSTRAINT [FK_Warehouse_Manager] FOREIGN KEY([ManagerMemberId])
REFERENCES [Operations].[Employee] ([MemberId])
GO
ALTER TABLE [Operations].[Warehouse] CHECK CONSTRAINT [FK_Warehouse_Manager]
GO
ALTER TABLE [Auctions].[Auction]  WITH CHECK ADD  CONSTRAINT [CK_Auction_BidIncrement] CHECK  (([BidIncrement]>(0)))
GO
ALTER TABLE [Auctions].[Auction] CHECK CONSTRAINT [CK_Auction_BidIncrement]
GO
ALTER TABLE [Auctions].[Auction]  WITH CHECK ADD  CONSTRAINT [CK_Auction_BuyNowPrice_Gt_Start] CHECK  (([BuyNowPrice] IS NULL OR [BuyNowPrice]>[StartingPrice]))
GO
ALTER TABLE [Auctions].[Auction] CHECK CONSTRAINT [CK_Auction_BuyNowPrice_Gt_Start]
GO
ALTER TABLE [Auctions].[Auction]  WITH CHECK ADD  CONSTRAINT [CK_Auction_Dates] CHECK  (([EndsAt]>[StartsAt]))
GO
ALTER TABLE [Auctions].[Auction] CHECK CONSTRAINT [CK_Auction_Dates]
GO
ALTER TABLE [Auctions].[Auction]  WITH CHECK ADD  CONSTRAINT [CK_Auction_ReservePrice] CHECK  (([ReservePrice] IS NULL OR [ReservePrice]>=[StartingPrice]))
GO
ALTER TABLE [Auctions].[Auction] CHECK CONSTRAINT [CK_Auction_ReservePrice]
GO
ALTER TABLE [Auctions].[Auction]  WITH CHECK ADD  CONSTRAINT [CK_Auction_StartingPrice] CHECK  (([StartingPrice]>(0)))
GO
ALTER TABLE [Auctions].[Auction] CHECK CONSTRAINT [CK_Auction_StartingPrice]
GO
ALTER TABLE [Auctions].[Auction]  WITH CHECK ADD  CONSTRAINT [CK_Auction_Status] CHECK  (([Status]='Cancelled' OR [Status]='Ended' OR [Status]='Live' OR [Status]='Draft' OR [Status]='PendingReview'))
GO
ALTER TABLE [Auctions].[Auction] CHECK CONSTRAINT [CK_Auction_Status]
GO
ALTER TABLE [Auctions].[Bid]  WITH CHECK ADD  CONSTRAINT [CK_Bid_Amount] CHECK  (([Amount]>(0)))
GO
ALTER TABLE [Auctions].[Bid] CHECK CONSTRAINT [CK_Bid_Amount]
GO
ALTER TABLE [Catalogue].[Category]  WITH CHECK ADD  CONSTRAINT [CK_Category_Commission] CHECK  (([CommissionRate]>=(0) AND [CommissionRate]<=(25)))
GO
ALTER TABLE [Catalogue].[Category] CHECK CONSTRAINT [CK_Category_Commission]
GO
ALTER TABLE [Catalogue].[Item]  WITH CHECK ADD  CONSTRAINT [CK_Item_ConditionScore] CHECK  (([ConditionScore]>=(1) AND [ConditionScore]<=(10)))
GO
ALTER TABLE [Catalogue].[Item] CHECK CONSTRAINT [CK_Item_ConditionScore]
GO
ALTER TABLE [Catalogue].[Item]  WITH CHECK ADD  CONSTRAINT [CK_Item_Seller_Inspector] CHECK  (([InspectorId] IS NULL OR [InspectorId]<>[SellerId]))
GO
ALTER TABLE [Catalogue].[Item] CHECK CONSTRAINT [CK_Item_Seller_Inspector]
GO
ALTER TABLE [Catalogue].[Item]  WITH CHECK ADD  CONSTRAINT [CK_Item_Specifications] CHECK  ((isjson([Specifications])=(1)))
GO
ALTER TABLE [Catalogue].[Item] CHECK CONSTRAINT [CK_Item_Specifications]
GO
ALTER TABLE [Catalogue].[ItemPhoto]  WITH CHECK ADD  CONSTRAINT [CK_ItemPhoto_Position] CHECK  (([Position]>=(1) AND [Position]<=(20)))
GO
ALTER TABLE [Catalogue].[ItemPhoto] CHECK CONSTRAINT [CK_ItemPhoto_Position]
GO
ALTER TABLE [Membership].[City]  WITH CHECK ADD  CONSTRAINT [CK_City_CountryCode] CHECK  (([CountryCode]='AE' OR [CountryCode]='SA' OR [CountryCode]='EG'))
GO
ALTER TABLE [Membership].[City] CHECK CONSTRAINT [CK_City_CountryCode]
GO
ALTER TABLE [Membership].[Member]  WITH CHECK ADD  CONSTRAINT [CHK_Member_PreferredLanguage] CHECK  (([PreferredLanguage]='en' OR [PreferredLanguage]='ar'))
GO
ALTER TABLE [Membership].[Member] CHECK CONSTRAINT [CHK_Member_PreferredLanguage]
GO
ALTER TABLE [Membership].[Member]  WITH CHECK ADD  CONSTRAINT [CK_Member_MobileNumber] CHECK  (([MobileNumber] like '+%' AND (len([MobileNumber])>=(8) AND len([MobileNumber])<=(16))))
GO
ALTER TABLE [Membership].[Member] CHECK CONSTRAINT [CK_Member_MobileNumber]
GO
ALTER TABLE [Membership].[Member]  WITH CHECK ADD  CONSTRAINT [CK_Member_ReferredByMemberId] CHECK  (([ReferredByMemberId] IS NULL OR [ReferredByMemberId]<>[MemberId]))
GO
ALTER TABLE [Membership].[Member] CHECK CONSTRAINT [CK_Member_ReferredByMemberId]
GO
ALTER TABLE [Membership].[Wallet]  WITH CHECK ADD  CONSTRAINT [CK_Wallet_Balance] CHECK  (([Balance]>=(0)))
GO
ALTER TABLE [Membership].[Wallet] CHECK CONSTRAINT [CK_Wallet_Balance]
GO
ALTER TABLE [Membership].[Wallet]  WITH CHECK ADD  CONSTRAINT [CK_Wallet_HeldAmount] CHECK  (([HeldAmount]>=(0) AND [HeldAmount]<=[Balance]))
GO
ALTER TABLE [Membership].[Wallet] CHECK CONSTRAINT [CK_Wallet_HeldAmount]
GO
ALTER TABLE [Operations].[Warehouse]  WITH CHECK ADD  CONSTRAINT [CK_Warehouse_Latitude] CHECK  (([Latitude]>=(-90) AND [Latitude]<=(90)))
GO
ALTER TABLE [Operations].[Warehouse] CHECK CONSTRAINT [CK_Warehouse_Latitude]
GO
ALTER TABLE [Operations].[Warehouse]  WITH CHECK ADD  CONSTRAINT [CK_Warehouse_Longitude] CHECK  (([Longitude]>=(-180) AND [Longitude]<=(180)))
GO
ALTER TABLE [Operations].[Warehouse] CHECK CONSTRAINT [CK_Warehouse_Longitude]
GO
ALTER TABLE [Operations].[Warehouse]  WITH CHECK ADD  CONSTRAINT [CK_Warehouse_MaxItems] CHECK  (([MaxItems]>(0)))
GO
ALTER TABLE [Operations].[Warehouse] CHECK CONSTRAINT [CK_Warehouse_MaxItems]
GO
USE [master]
GO
ALTER DATABASE [BidNile] SET  READ_WRITE 
GO
