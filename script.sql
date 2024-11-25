USE [master]
GO
/****** Object:  Database [StudentRecordSystem]    Script Date: 10/18/2024 3:11:12 PM ******/
CREATE DATABASE [StudentRecordSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StudentRecordSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\StudentRecordSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StudentRecordSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\StudentRecordSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [StudentRecordSystem] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StudentRecordSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StudentRecordSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StudentRecordSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StudentRecordSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET  ENABLE_BROKER 
GO
ALTER DATABASE [StudentRecordSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StudentRecordSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET RECOVERY FULL 
GO
ALTER DATABASE [StudentRecordSystem] SET  MULTI_USER 
GO
ALTER DATABASE [StudentRecordSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StudentRecordSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StudentRecordSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StudentRecordSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [StudentRecordSystem] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [StudentRecordSystem] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'StudentRecordSystem', N'ON'
GO
ALTER DATABASE [StudentRecordSystem] SET QUERY_STORE = ON
GO
ALTER DATABASE [StudentRecordSystem] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [StudentRecordSystem]
GO
/****** Object:  Table [dbo].[Assignment]    Script Date: 10/18/2024 3:11:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assignment](
	[AssignmentID] [int] NOT NULL,
	[DueDate] [datetime] NULL,
	[Description] [varchar](45) NULL,
	[AssignmentType] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[AssignmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 10/18/2024 3:11:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseID] [int] NOT NULL,
	[CourseName] [varchar](45) NULL,
	[ClassroomNo] [varchar](10) NULL,
	[Day] [varchar](10) NULL,
	[StartTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dining]    Script Date: 10/18/2024 3:11:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dining](
	[DiningID] [int] NOT NULL,
	[StudentID] [int] NULL,
	[MealPlanBalance] [decimal](10, 2) NULL,
	[SwipesPerWeek] [int] NULL,
	[MealPlanType] [varchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[DiningID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event]    Script Date: 10/18/2024 3:11:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event](
	[EventID] [int] NOT NULL,
	[Date] [datetime] NULL,
	[EventName] [varchar](45) NULL,
	[RSVPComplete] [bit] NULL,
	[EventType] [varchar](20) NULL,
	[Description] [varchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Finances]    Script Date: 10/18/2024 3:11:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Finances](
	[FinancesID] [int] NOT NULL,
	[StudentID] [int] NULL,
	[Amount] [decimal](10, 2) NULL,
	[FinancesType] [varchar](45) NULL,
	[PaymentDeadline] [datetime] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[FinancesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Housing]    Script Date: 10/18/2024 3:11:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Housing](
	[HousingID] [int] NOT NULL,
	[StudentID] [int] NULL,
	[BuildingNo] [varchar](45) NULL,
	[RoomNo] [varchar](45) NULL,
PRIMARY KEY CLUSTERED 
(
	[HousingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Professor]    Script Date: 10/18/2024 3:11:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Professor](
	[ProfessorID] [int] NOT NULL,
	[Fname] [varchar](20) NULL,
	[Lname] [varchar](20) NULL,
	[Email] [varchar](45) NULL,
	[Office] [varchar](45) NULL,
	[OfficeHours] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProfessorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoommateAgreement]    Script Date: 10/18/2024 3:11:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoommateAgreement](
	[AgreementID] [int] NOT NULL,
	[HousingID] [int] NULL,
	[DateSigned] [date] NULL,
	[AgreementComplete] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AgreementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 10/18/2024 3:11:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[StudentID] [int] NOT NULL,
	[Fname] [varchar](20) NULL,
	[Lname] [varchar](20) NULL,
	[Username] [varchar](20) NULL,
	[Password] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TA]    Script Date: 10/18/2024 3:11:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TA](
	[TAID] [int] NOT NULL,
	[Fname] [varchar](20) NULL,
	[Lname] [varchar](20) NULL,
	[Email] [varchar](45) NULL,
	[Office] [varchar](45) NULL,
	[OfficeHours] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TAID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Dining]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[Finances]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[Housing]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[RoommateAgreement]  WITH CHECK ADD FOREIGN KEY([HousingID])
REFERENCES [dbo].[Housing] ([HousingID])
GO
USE [master]
GO
ALTER DATABASE [StudentRecordSystem] SET  READ_WRITE 
GO
