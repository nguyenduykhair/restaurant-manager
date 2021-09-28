USE [master]
GO
/****** Object:  Database [milano]    Script Date: 9/27/2021 9:48:57 AM ******/
CREATE DATABASE [milano]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'milano', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\milano.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'milano_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\milano_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [milano] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [milano].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [milano] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [milano] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [milano] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [milano] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [milano] SET ARITHABORT OFF 
GO
ALTER DATABASE [milano] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [milano] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [milano] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [milano] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [milano] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [milano] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [milano] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [milano] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [milano] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [milano] SET  ENABLE_BROKER 
GO
ALTER DATABASE [milano] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [milano] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [milano] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [milano] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [milano] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [milano] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [milano] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [milano] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [milano] SET  MULTI_USER 
GO
ALTER DATABASE [milano] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [milano] SET DB_CHAINING OFF 
GO
ALTER DATABASE [milano] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [milano] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [milano] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [milano] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [milano] SET QUERY_STORE = OFF
GO
USE [milano]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END


GO
/****** Object:  Table [dbo].[Account]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](1000) NOT NULL,
	[Type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL,
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'K9', N'Tan', N'1962026656160185351301320480154111117132155', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'oman', N'Oman', N'1962026656160185351301320480154111117132155', 0)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'oman2', N'Oman2', N'1962026656160185351301320480154111117132155', 0)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'staff', N'staff', N'1962026656160185351301320480154111117132155', 0)
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (32, CAST(N'2021-09-15' AS Date), CAST(N'2021-09-15' AS Date), 1, 1, 20, 232)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (33, CAST(N'2021-09-15' AS Date), CAST(N'2021-09-15' AS Date), 3, 1, 10, 72)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (34, CAST(N'2021-09-15' AS Date), CAST(N'2021-09-15' AS Date), 5, 1, 0, 174)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (35, CAST(N'2021-09-16' AS Date), CAST(N'2021-09-16' AS Date), 1, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (36, CAST(N'2021-09-16' AS Date), NULL, 1, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (37, CAST(N'2021-09-16' AS Date), CAST(N'2021-09-16' AS Date), 2, 1, 0, 240)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (38, CAST(N'2021-09-16' AS Date), CAST(N'2021-09-16' AS Date), 3, 1, 0, 999.999)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (39, CAST(N'2021-09-18' AS Date), NULL, 2, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (40, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 240)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (41, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (42, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (43, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (44, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (45, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (46, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (47, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (48, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (49, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (50, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (51, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (52, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (53, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 240)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (54, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (55, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (56, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (57, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (58, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (59, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (60, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 3, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (61, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 6, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (62, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 6, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (63, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 6, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (64, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 6, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (65, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 6, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (66, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 6, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (67, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 12, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (68, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 12, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (69, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 12, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (70, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 12, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (71, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 12, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (72, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 12, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (73, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 12, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (74, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 12, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (75, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 4, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (76, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 4, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (77, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 4, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (78, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 4, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (79, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 4, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (80, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 4, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (81, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 4, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (82, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 4, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (83, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 4, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (84, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 4, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (85, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 4, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (86, CAST(N'2021-09-26' AS Date), CAST(N'2021-09-26' AS Date), 4, 1, 0, 120)
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (79, 32, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (80, 32, 2, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (81, 33, 2, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (82, 33, 6, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (83, 34, 4, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (84, 34, 7, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (85, 35, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (87, 36, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (88, 36, 5, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (89, 37, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (90, 38, 5, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (91, 39, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (92, 40, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (93, 41, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (94, 42, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (95, 43, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (96, 44, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (97, 45, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (98, 46, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (99, 47, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (100, 48, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (101, 49, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (102, 50, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (103, 51, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (104, 52, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (105, 53, 1, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (106, 54, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (107, 55, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (108, 56, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (109, 57, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (110, 58, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (111, 59, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (112, 60, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (113, 61, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (114, 62, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (115, 63, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (116, 64, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (117, 65, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (118, 66, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (119, 67, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (120, 68, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (121, 69, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (122, 70, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (123, 71, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (124, 72, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (125, 73, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (126, 74, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (127, 75, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (128, 76, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (129, 77, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (130, 78, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (131, 79, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (132, 80, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (133, 81, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (134, 82, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (135, 83, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (136, 84, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (137, 85, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (138, 86, 1, 1)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (1, N'Mực một nắng nước sa tế', 1, 120000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (2, N'Nghêu hấp xả', 1, 50000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (3, N'Dú dê nướng sữa', 2, 60000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (4, N'Heo rừng nướng muối ớt', 3, 75000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (5, N'Cơm chiên mushi', 4, 999999)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (6, N'7Up', 5, 15000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (7, N'Cafe', 5, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (8, N'Mực một nắng nước sa tế', 1, 120000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (9, N'Nghêu hấp xả', 1, 50000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (10, N'Dú dê nướng sữa', 2, 60000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (11, N'Heo rừng nướng muối ớt', 3, 75000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (12, N'Cơm chiên mushi', 4, 999999)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (13, N'7Up', 5, 15000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (14, N'Cafe', 5, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (15, N'Mực một nắng nước sa tế', 1, 120000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (17, N'Mực một nắng nước sa tế', 1, 120000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (19, N'Mực một nắng nước sa tế', 1, 120000)
SET IDENTITY_INSERT [dbo].[Food] OFF
GO
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (1, N'Hải sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (2, N'Nông sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (3, N'Lâm sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (4, N'Sản sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (5, N'Nước')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (6, N'Hải sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (7, N'Nông sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (8, N'Lâm sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (9, N'Sản sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (10, N'Nước')
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (1, N'Bàn 0', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (2, N'Bàn 1', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (3, N'Bàn 2', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (4, N'Bàn 3', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (5, N'Bàn 4', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (6, N'Bàn 5', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (7, N'Bàn 6', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (8, N'Bàn 7', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (9, N'Bàn 8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (10, N'Bàn 9', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (11, N'Bàn 10', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (12, N'Bàn 0', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (13, N'Bàn 1', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (14, N'Bàn 2', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (15, N'Bàn 3', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (16, N'Bàn 4', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (17, N'Bàn 5', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (18, N'Bàn 6', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (19, N'Bàn 7', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (20, N'Bàn 8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (21, N'Bàn 9', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (22, N'Bàn 10', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (23, N'Bàn 0', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (24, N'Bàn 1', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (25, N'Bàn 2', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (26, N'Bàn 3', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (27, N'Bàn 4', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (28, N'Bàn 5', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (29, N'Bàn 6', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (30, N'Bàn 7', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (31, N'Bàn 8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (32, N'Bàn 9', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (33, N'Bàn 10', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (34, N'Bàn 0', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (35, N'Bàn 1', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (36, N'Bàn 2', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (37, N'Bàn 3', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (38, N'Bàn 4', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (39, N'Bàn 5', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (40, N'Bàn 6', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (41, N'Bàn 7', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (42, N'Bàn 8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (43, N'Bàn 9', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (44, N'Bàn 10', N'Trống')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (N'Kter') FOR [DisplayName]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [PassWord]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[FoodCategory] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Bàn chưa có tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Trống') FOR [status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[SwitchTable]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SwitchTable]
@idTable1 INT, @idTable2 INT
AS BEGIN
    DECLARE @idFirstBill INT
    DECLARE @idSecondBill INT

	DECLARE @isFirstTablEmty INT = 1
	DECLARE @isSecondTablEmty INT = 1
    
	SELECT @idSecondBill = id FROM dbo.Bill WHERE idTable =  @idTable2 AND status = 0
	SELECT @idFirstBill = id FROM dbo.Bill WHERE idTable =  @idTable1 AND status = 0

	PRINT @idFirstBill
	PRINT @idSecondBill
	PRINT '---------------'


	IF(@idFirstBill IS NULL)
	BEGIN
	    PRINT '0000001'
		INSERT	dbo.Bill
				( DateCheckIn ,
				  DateCheckOut ,
				  idTable ,
				  status
				)
		VALUES  ( GETDATE() , -- DateCheckIn - date
				  NULL , -- DateCheckOut - date
				  @idTable1 , -- idTable - int
				  0  -- status - int
				)
        SELECT @idFirstBill  = MAX(id) FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0

	END
	SELECT @isFirstTablEmty  = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idFirstBill

	PRINT @idFirstBill
	PRINT @idSecondBill
	PRINT '---------------'


	IF(@idSecondBill IS NULL)
	BEGIN
	    PRINT '0000002'
		INSERT	dbo.Bill
				( DateCheckIn ,
				  DateCheckOut ,
				  idTable ,
				  status
				)
		VALUES  ( GETDATE() , -- DateCheckIn - date
				  NULL , -- DateCheckOut - date
				  @idTable2 , -- idTable - int
				  0  -- status - int
				)
        SELECT @idFirstBill  = MAX(id) FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0

	END
	SELECT @isSecondTablEmty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idSecondBill

	PRINT @idFirstBill
	PRINT @idSecondBill
	PRINT '---------------'

	SELECT id INTO IDBillInfoTable FROM dbo.BillInfo WHERE idBill = @idSecondBill

	UPDATE dbo.BillInfo SET idBill = @idSecondBill WHERE idBill = @idFirstBill

	UPDATE dbo.BillInfo SET idBill =  @idFirstBill WHERE id IN (SELECT * FROM IDBillInfoTable)

	DROP TABLE IDBillInfoTable
	   IF (@isFirstTablEmty = 0)
	       UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable2
       IF (@isSecondTablEmty = 0)
	       UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable1
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetAccountByUserName]
@userName nvarchar(100)
AS 
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateAndPage]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetListBillByDateAndPage]
@checkIn date, @checkOut date, @page int
AS 
BEGIN
	DECLARE @pageRows INT = 10
	DECLARE @selectRows INT = @pageRows
	DECLARE @exceptRows INT = (@page - 1) * @pageRows
	
	;WITH BillShow AS( SELECT b.ID, t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable)
	
	SELECT TOP (@selectRows) * FROM BillShow WHERE id NOT IN (SELECT TOP (@exceptRows) id FROM BillShow)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateForReport]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetListBillByDateForReport]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT t.name, b.totalPrice, DateCheckIn, DateCheckOut, discount
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetNumBillByDate]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetNumBillByDate]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT COUNT(*)
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetTableList]
AS SELECT * FROM dbo.TableFood
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertBill]
@idTable INT
AS
BEGIN
     INSERT	dbo.Bill
        ( DateCheckIn ,
          DateCheckOut ,
          idTable ,
          status,
		  discount
        )
     VALUES  ( GETDATE() , -- DateCheckIn - date
          NULL , -- DateCheckOut - date
          @idTable, -- idTable - int
          0 , -- status - int
		  0
        )
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertBillInfo]
@idBill INT, @idFood INT, @count INT
AS
BEGIN
    -- kiểm tra xem thử Bill có tồn tại hay không
	DECLARE @isExitsBillInfo INT
	DECLARE @foodCount INT = 1

	SELECT @isExitsBillInfo = id, @foodCount = b.count 
	FROM dbo.BillInfo AS b
	WHERE idBill = @idBill AND idFood = @idFood

	IF (@isExitsBillInfo > 0) -- kiểm tra thức ăn có tồn tại trong danh sách hay không 
	BEGIN
	   DECLARE @newCount INT = @foodCount + @count -- @count đưa vô
	  
	   IF (@newCount > 0)  -- thì insert
	       UPDATE dbo.BillInfo SET count = @foodCount + @count WHERE idFood = @idFood
       ELSE -- nếu như count âm thì nó sẽ trừ bớt
	       DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood
	END
	ELSE
	BEGIN
		INSERT	dbo.BillInfo
			( idBill, idFood, count )
		VALUES  ( @idBill ,-- idBill - int
				  @idFood, -- idFood - int
				  @count  -- count - int
				  )
    END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_Login]
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTable]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_SwitchTable]
@idTable1 INT, @idTable2 INT
AS BEGIN
    DECLARE @idFirstBill INT
    DECLARE @idSecondBill INT

	DECLARE @isFirstTablEmty INT = 1
	DECLARE @isSecondTablEmty INT = 1
    
	SELECT @idSecondBill = id FROM dbo.Bill WHERE idTable =  @idTable2 AND status = 0
	SELECT @idFirstBill = id FROM dbo.Bill WHERE idTable =  @idTable1 AND status = 0

	PRINT @idFirstBill
	PRINT @idSecondBill
	PRINT '---------------'


	IF(@idFirstBill IS NULL)
	BEGIN
	    PRINT '0000001'
		INSERT	dbo.Bill
				( DateCheckIn ,
				  DateCheckOut ,
				  idTable ,
				  status
				)
		VALUES  ( GETDATE() , -- DateCheckIn - date
				  NULL , -- DateCheckOut - date
				  @idTable1 , -- idTable - int
				  0  -- status - int
				)
        SELECT @idFirstBill  = MAX(id) FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0

	END
	SELECT @isFirstTablEmty  = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idFirstBill

	PRINT @idFirstBill
	PRINT @idSecondBill
	PRINT '---------------'


	IF(@idSecondBill IS NULL)
	BEGIN
	    PRINT '0000002'
		INSERT	dbo.Bill
				( DateCheckIn ,
				  DateCheckOut ,
				  idTable ,
				  status
				)
		VALUES  ( GETDATE() , -- DateCheckIn - date
				  NULL , -- DateCheckOut - date
				  @idTable2 , -- idTable - int
				  0  -- status - int
				)
        SELECT @idSecondBill  = MAX(id) FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0

	END
	SELECT @isSecondTablEmty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idSecondBill

	PRINT @idFirstBill
	PRINT @idSecondBill
	PRINT '---------------'

	SELECT id INTO IDBillInfoTable FROM dbo.BillInfo WHERE idBill = @idSecondBill

	UPDATE dbo.BillInfo SET idBill = @idSecondBill WHERE idBill = @idFirstBill

	UPDATE dbo.BillInfo SET idBill =  @idFirstBill WHERE id IN (SELECT * FROM IDBillInfoTable)

	DROP TABLE IDBillInfoTable
	   IF (@isFirstTablEmty = 0)
	       UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable2
       IF (@isSecondTablEmty = 0)
	       UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable1
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 9/27/2021 9:48:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateAccount]
@userName NVARCHAR(100), @displayName NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0
	
	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE USERName = @userName AND PassWord = @password
	
	IF (@isRightPass = 1)
	BEGIN
		IF (@newPassword = NULL OR @newPassword = '')
		BEGIN
			UPDATE dbo.Account SET DisplayName = @displayName WHERE UserName = @userName
		END		
		ELSE
			UPDATE dbo.Account SET DisplayName = @displayName, PassWord = @newPassword WHERE UserName = @userName
	end
END
GO
USE [master]
GO
ALTER DATABASE [milano] SET  READ_WRITE 
GO
