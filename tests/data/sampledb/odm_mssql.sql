USE [master]
GO
/****** Object:  Database [odm]    Script Date: 6/13/2016 12:41:11 PM ******/
CREATE DATABASE [odm] ON  PRIMARY
( NAME = N'OD', FILENAME = N'D:\SQL Server Databases\LittleBearExpress.mdf' , SIZE = 398208KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'OD_log', FILENAME = N'D:\SQL Server Databases\LittleBearExpress_log.ldf' , SIZE = 1536KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [odm] SET COMPATIBILITY_LEVEL = 90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [odm].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [odm] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [odm] SET ANSI_NULLS OFF
GO
ALTER DATABASE [odm] SET ANSI_PADDING OFF
GO
ALTER DATABASE [odm] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [odm] SET ARITHABORT OFF
GO
ALTER DATABASE [odm] SET AUTO_CLOSE ON
GO
ALTER DATABASE [odm] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [odm] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [odm] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [odm] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [odm] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [odm] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [odm] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [odm] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [odm] SET  DISABLE_BROKER
GO
ALTER DATABASE [odm] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [odm] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [odm] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [odm] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [odm] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [odm] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [odm] SET RECOVERY FULL
GO
ALTER DATABASE [odm] SET  MULTI_USER
GO
ALTER DATABASE [odm] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [odm] SET DB_CHAINING OFF
GO
USE [odm]
GO

/****** Object:  Table [dbo].[Categories]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[VariableID] [int] NOT NULL,
	[DataValue] [float] NOT NULL,
	[CategoryDescription] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CensorCodeCV]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CensorCodeCV](
	[Term] [nvarchar](50) NOT NULL,
	[Definition] [nvarchar](max) NULL,
 CONSTRAINT [PK_CensorCodeCV_Term] PRIMARY KEY CLUSTERED 
(
	[Term] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DataTypeCV]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataTypeCV](
	[Term] [nvarchar](255) NOT NULL,
	[Definition] [nvarchar](max) NULL,
 CONSTRAINT [PK_DataTypeCV_Term] PRIMARY KEY CLUSTERED 
(
	[Term] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DataValues]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataValues](
	[ValueID] [int] IDENTITY(1,1) NOT NULL,
	[DataValue] [float] NOT NULL,
	[ValueAccuracy] [float] NULL,
	[LocalDateTime] [datetime] NOT NULL,
	[UTCOffset] [float] NOT NULL,
	[DateTimeUTC] [datetime] NOT NULL,
	[SiteID] [int] NOT NULL,
	[VariableID] [int] NOT NULL,
	[OffsetValue] [float] NULL,
	[OffsetTypeID] [int] NULL,
	[CensorCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_DataValues_CensorCode]  DEFAULT ('nc'),
	[QualifierID] [int] NULL,
	[MethodID] [int] NOT NULL CONSTRAINT [DF_DataValues_MethodID]  DEFAULT ((0)),
	[SourceID] [int] NOT NULL,
	[SampleID] [int] NULL,
	[DerivedFromID] [int] NULL,
	[QualityControlLevelID] [int] NOT NULL CONSTRAINT [DF_DataValues_QualityControlLevelID]  DEFAULT ((-9999)),
 CONSTRAINT [PK_DataValues_ValueID] PRIMARY KEY CLUSTERED 
(
	[ValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UNIQUE_DataValues] UNIQUE NONCLUSTERED 
(
	[DataValue] ASC,
	[ValueAccuracy] ASC,
	[LocalDateTime] ASC,
	[UTCOffset] ASC,
	[DateTimeUTC] ASC,
	[SiteID] ASC,
	[VariableID] ASC,
	[OffsetValue] ASC,
	[OffsetTypeID] ASC,
	[CensorCode] ASC,
	[QualifierID] ASC,
	[MethodID] ASC,
	[SourceID] ASC,
	[SampleID] ASC,
	[DerivedFromID] ASC,
	[QualityControlLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DerivedFrom]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DerivedFrom](
	[DerivedFromID] [int] NOT NULL,
	[ValueID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GeneralCategoryCV]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GeneralCategoryCV](
	[Term] [nvarchar](255) NOT NULL,
	[Definition] [nvarchar](max) NULL,
 CONSTRAINT [PK_GeneralCategoryCV_Term] PRIMARY KEY CLUSTERED 
(
	[Term] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GroupDescriptions]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupDescriptions](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_GroupDescriptions_GroupID] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Groups]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[GroupID] [int] NOT NULL,
	[ValueID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ISOMetadata]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ISOMetadata](
	[MetadataID] [int] IDENTITY(1,1) NOT NULL,
	[TopicCategory] [nvarchar](255) NOT NULL CONSTRAINT [DF_ISOMetadata_TopicCategory]  DEFAULT ('Unknown'),
	[Title] [nvarchar](255) NOT NULL CONSTRAINT [DF_ISOMetadata_Title]  DEFAULT ('Unknown'),
	[Abstract] [nvarchar](max) NOT NULL CONSTRAINT [DF_ISOMetadata_Abstract]  DEFAULT ('Unknown'),
	[ProfileVersion] [nvarchar](255) NOT NULL CONSTRAINT [DF_ISOMetadata_ProfileVersion]  DEFAULT ('Unknown'),
	[MetadataLink] [nvarchar](500) NULL,
 CONSTRAINT [PK_ISOMetadata_MetadataID] PRIMARY KEY CLUSTERED 
(
	[MetadataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LabMethods]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LabMethods](
	[LabMethodID] [int] IDENTITY(1,1) NOT NULL,
	[LabName] [nvarchar](255) NOT NULL CONSTRAINT [DF_LabMethods_LabName]  DEFAULT ('Unknown'),
	[LabOrganization] [nvarchar](255) NOT NULL CONSTRAINT [DF_LabMethods_LabOrganization]  DEFAULT ('Unknown'),
	[LabMethodName] [nvarchar](255) NOT NULL CONSTRAINT [DF_LabMethods_LabMethodName]  DEFAULT ('Unknown'),
	[LabMethodDescription] [nvarchar](max) NOT NULL CONSTRAINT [DF_LabMethods_LabMethodDescription]  DEFAULT ('Unknown'),
	[LabMethodLink] [nvarchar](500) NULL,
 CONSTRAINT [PK_LabMethods_LabMethodID] PRIMARY KEY CLUSTERED 
(
	[LabMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Methods]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Methods](
	[MethodID] [int] IDENTITY(1,1) NOT NULL,
	[MethodDescription] [nvarchar](max) NOT NULL,
	[MethodLink] [nvarchar](500) NULL,
 CONSTRAINT [PK_Methods_MethodID] PRIMARY KEY CLUSTERED 
(
	[MethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ODMVersion]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ODMVersion](
	[VersionNumber] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OffsetTypes]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OffsetTypes](
	[OffsetTypeID] [int] IDENTITY(1,1) NOT NULL,
	[OffsetUnitsID] [int] NOT NULL,
	[OffsetDescription] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_OffsetTypes_OffsetTypeID] PRIMARY KEY CLUSTERED 
(
	[OffsetTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Qualifiers]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Qualifiers](
	[QualifierID] [int] IDENTITY(1,1) NOT NULL,
	[QualifierCode] [nvarchar](50) NULL,
	[QualifierDescription] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Qualifiers_QualifierID] PRIMARY KEY CLUSTERED 
(
	[QualifierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QualityControlLevels]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QualityControlLevels](
	[QualityControlLevelID] [int] IDENTITY(1,1) NOT NULL,
	[QualityControlLevelCode] [nvarchar](50) NOT NULL,
	[Definition] [nvarchar](255) NOT NULL,
	[Explanation] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_QualityControlLevels_QualityControlLevelID] PRIMARY KEY CLUSTERED 
(
	[QualityControlLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SampleMediumCV]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SampleMediumCV](
	[Term] [nvarchar](255) NOT NULL,
	[Definition] [nvarchar](max) NULL,
 CONSTRAINT [PK_SampleMediumCV_Term] PRIMARY KEY CLUSTERED 
(
	[Term] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Samples]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Samples](
	[SampleID] [int] IDENTITY(1,1) NOT NULL,
	[SampleType] [nvarchar](255) NOT NULL CONSTRAINT [DF_Samples_SampleType]  DEFAULT ('Unknown'),
	[LabSampleCode] [nvarchar](50) NOT NULL,
	[LabMethodID] [int] NOT NULL CONSTRAINT [DF_Samples_LabMethodID]  DEFAULT ((0)),
 CONSTRAINT [PK_Samples_SampleID] PRIMARY KEY CLUSTERED 
(
	[SampleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SampleTypeCV]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SampleTypeCV](
	[Term] [nvarchar](255) NOT NULL,
	[Definition] [nvarchar](max) NULL,
 CONSTRAINT [PK_SampleTypeCV_Term] PRIMARY KEY CLUSTERED 
(
	[Term] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SeriesCatalog]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeriesCatalog](
	[SeriesID] [int] IDENTITY(1,1) NOT NULL,
	[SiteID] [int] NULL,
	[SiteCode] [nvarchar](50) NULL,
	[SiteName] [nvarchar](255) NULL,
	[SiteType] [nvarchar](255) NULL,
	[VariableID] [int] NULL,
	[VariableCode] [nvarchar](50) NULL,
	[VariableName] [nvarchar](255) NULL,
	[Speciation] [nvarchar](255) NULL,
	[VariableUnitsID] [int] NULL,
	[VariableUnitsName] [nvarchar](255) NULL,
	[SampleMedium] [nvarchar](255) NULL,
	[ValueType] [nvarchar](255) NULL,
	[TimeSupport] [float] NULL,
	[TimeUnitsID] [int] NULL,
	[TimeUnitsName] [nvarchar](255) NULL,
	[DataType] [nvarchar](255) NULL,
	[GeneralCategory] [nvarchar](255) NULL,
	[MethodID] [int] NULL,
	[MethodDescription] [nvarchar](max) NULL,
	[SourceID] [int] NULL,
	[Organization] [nvarchar](255) NULL,
	[SourceDescription] [nvarchar](max) NULL,
	[Citation] [nvarchar](max) NULL,
	[QualityControlLevelID] [int] NULL,
	[QualityControlLevelCode] [nvarchar](50) NULL,
	[BeginDateTime] [datetime] NULL,
	[EndDateTime] [datetime] NULL,
	[BeginDateTimeUTC] [datetime] NULL,
	[EndDateTimeUTC] [datetime] NULL,
	[ValueCount] [int] NULL,
 CONSTRAINT [PK_SeriesCatalog_SeriesID] PRIMARY KEY CLUSTERED 
(
	[SeriesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sites]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sites](
	[SiteID] [int] IDENTITY(1,1) NOT NULL,
	[SiteCode] [nvarchar](50) NOT NULL,
	[SiteName] [nvarchar](255) NOT NULL,
	[Latitude] [float] NOT NULL,
	[Longitude] [float] NOT NULL,
	[LatLongDatumID] [int] NOT NULL CONSTRAINT [DF_Sites_LatLongDatumID]  DEFAULT ((0)),
	[Elevation_m] [float] NULL,
	[VerticalDatum] [nvarchar](255) NULL,
	[LocalX] [float] NULL,
	[LocalY] [float] NULL,
	[LocalProjectionID] [int] NULL,
	[PosAccuracy_m] [float] NULL,
	[State] [nvarchar](255) NULL,
	[County] [nvarchar](255) NULL,
	[Comments] [nvarchar](max) NULL,
	[SiteType] [nvarchar](255) NULL,
 CONSTRAINT [PK_Sites_SiteID] PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_Sites_SiteCode] UNIQUE NONCLUSTERED 
(
	[SiteCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SiteTypeCV]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SiteTypeCV](
	[Term] [nvarchar](255) NOT NULL,
	[Definition] [nvarchar](max) NULL,
 CONSTRAINT [PK_SiteTypeCV] PRIMARY KEY CLUSTERED 
(
	[Term] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sources]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sources](
	[SourceID] [int] IDENTITY(1,1) NOT NULL,
	[Organization] [nvarchar](255) NOT NULL,
	[SourceDescription] [nvarchar](max) NOT NULL,
	[SourceLink] [nvarchar](500) NULL,
	[ContactName] [nvarchar](255) NOT NULL CONSTRAINT [DF_Sources_ContactName]  DEFAULT ('Unknown'),
	[Phone] [nvarchar](255) NOT NULL CONSTRAINT [DF_Sources_Phone]  DEFAULT ('Unknown'),
	[Email] [nvarchar](255) NOT NULL CONSTRAINT [DF_Sources_Email]  DEFAULT ('Unknown'),
	[Address] [nvarchar](255) NOT NULL CONSTRAINT [DF_Sources_Address]  DEFAULT ('Unknown'),
	[City] [nvarchar](255) NOT NULL CONSTRAINT [DF_Sources_City]  DEFAULT ('Unknown'),
	[State] [nvarchar](255) NOT NULL CONSTRAINT [DF_Sources_State]  DEFAULT ('Unknown'),
	[ZipCode] [nvarchar](255) NOT NULL CONSTRAINT [DF_Sources_ZipCode]  DEFAULT ('Unknown'),
	[Citation] [nvarchar](max) NOT NULL CONSTRAINT [DF_Sources_Citation]  DEFAULT ('Unknown'),
	[MetadataID] [int] NOT NULL CONSTRAINT [DF_Sources_MetadataID]  DEFAULT ((0)),
 CONSTRAINT [PK_Sources_SourceID] PRIMARY KEY CLUSTERED 
(
	[SourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SpatialReferences]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpatialReferences](
	[SpatialReferenceID] [int] IDENTITY(1,1) NOT NULL,
	[SRSID] [int] NULL,
	[SRSName] [nvarchar](255) NOT NULL,
	[IsGeographic] [bit] NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_SpatialReferences_SpatialReferenceID] PRIMARY KEY CLUSTERED 
(
	[SpatialReferenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SpeciationCV]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpeciationCV](
	[Term] [nvarchar](255) NOT NULL,
	[Definition] [nvarchar](max) NULL,
 CONSTRAINT [PK_SpeciationCV_Term] PRIMARY KEY CLUSTERED 
(
	[Term] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TopicCategoryCV]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TopicCategoryCV](
	[Term] [nvarchar](255) NOT NULL,
	[Definition] [nvarchar](max) NULL,
 CONSTRAINT [PK_TopicCategoryCV_Term] PRIMARY KEY CLUSTERED 
(
	[Term] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Units]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Units](
	[UnitsID] [int] IDENTITY(1,1) NOT NULL,
	[UnitsName] [nvarchar](255) NOT NULL,
	[UnitsType] [nvarchar](255) NOT NULL,
	[UnitsAbbreviation] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Units_UnitsID] PRIMARY KEY CLUSTERED 
(
	[UnitsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ValueTypeCV]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValueTypeCV](
	[Term] [nvarchar](255) NOT NULL,
	[Definition] [nvarchar](max) NULL,
 CONSTRAINT [PK_ValueTypeCV_Term] PRIMARY KEY CLUSTERED 
(
	[Term] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VariableNameCV]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VariableNameCV](
	[Term] [nvarchar](255) NOT NULL,
	[Definition] [nvarchar](max) NULL,
 CONSTRAINT [PK_VariableNameCV_Term] PRIMARY KEY CLUSTERED 
(
	[Term] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Variables]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Variables](
	[VariableID] [int] IDENTITY(1,1) NOT NULL,
	[VariableCode] [nvarchar](50) NOT NULL,
	[VariableName] [nvarchar](255) NOT NULL,
	[Speciation] [nvarchar](255) NOT NULL CONSTRAINT [DF_Variables_Speciation]  DEFAULT ('Not Applicable'),
	[VariableUnitsID] [int] NOT NULL,
	[SampleMedium] [nvarchar](255) NOT NULL CONSTRAINT [DF_Variables_SampleMedium]  DEFAULT ('Unknown'),
	[ValueType] [nvarchar](255) NOT NULL CONSTRAINT [DF_Variables_ValueType]  DEFAULT ('Unknown'),
	[IsRegular] [bit] NOT NULL CONSTRAINT [DF_Variables_IsRegular]  DEFAULT ((0)),
	[TimeSupport] [float] NOT NULL CONSTRAINT [DF_Variables_TimeSupport]  DEFAULT ((0)),
	[TimeUnitsID] [int] NOT NULL CONSTRAINT [DF_Variables_TimeUnitsID]  DEFAULT ((103)),
	[DataType] [nvarchar](255) NOT NULL CONSTRAINT [DF_Variables_DataType]  DEFAULT ('Unknown'),
	[GeneralCategory] [nvarchar](255) NOT NULL CONSTRAINT [DF_Variables_GeneralCategory]  DEFAULT ('Unknown'),
	[NoDataValue] [float] NOT NULL CONSTRAINT [DF_Variables_NoDataValue]  DEFAULT ((-9999)),
 CONSTRAINT [PK_Variables_VariableID] PRIMARY KEY CLUSTERED 
(
	[VariableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_Variables_VariableCode] UNIQUE NONCLUSTERED 
(
	[VariableCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VerticalDatumCV]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VerticalDatumCV](
	[Term] [nvarchar](255) NOT NULL,
	[Definition] [nvarchar](max) NULL,
 CONSTRAINT [PK_VerticalDatumCV_Term] PRIMARY KEY CLUSTERED 
(
	[Term] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[Categories]  WITH NOCHECK ADD  CONSTRAINT [FK_Categories_Variables] FOREIGN KEY([VariableID])
REFERENCES [dbo].[Variables] ([VariableID])
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Variables]
GO
ALTER TABLE [dbo].[DataValues]  WITH NOCHECK ADD  CONSTRAINT [FK_DataValues_CensorCodeCV] FOREIGN KEY([CensorCode])
REFERENCES [dbo].[CensorCodeCV] ([Term])
GO
ALTER TABLE [dbo].[DataValues] CHECK CONSTRAINT [FK_DataValues_CensorCodeCV]
GO
ALTER TABLE [dbo].[DataValues]  WITH NOCHECK ADD  CONSTRAINT [FK_DataValues_Methods] FOREIGN KEY([MethodID])
REFERENCES [dbo].[Methods] ([MethodID])
GO
ALTER TABLE [dbo].[DataValues] CHECK CONSTRAINT [FK_DataValues_Methods]
GO
ALTER TABLE [dbo].[DataValues]  WITH NOCHECK ADD  CONSTRAINT [FK_DataValues_OffsetTypes] FOREIGN KEY([OffsetTypeID])
REFERENCES [dbo].[OffsetTypes] ([OffsetTypeID])
GO
ALTER TABLE [dbo].[DataValues] CHECK CONSTRAINT [FK_DataValues_OffsetTypes]
GO
ALTER TABLE [dbo].[DataValues]  WITH NOCHECK ADD  CONSTRAINT [FK_DataValues_Qualifiers] FOREIGN KEY([QualifierID])
REFERENCES [dbo].[Qualifiers] ([QualifierID])
GO
ALTER TABLE [dbo].[DataValues] CHECK CONSTRAINT [FK_DataValues_Qualifiers]
GO
ALTER TABLE [dbo].[DataValues]  WITH NOCHECK ADD  CONSTRAINT [FK_DataValues_QualityControlLevels] FOREIGN KEY([QualityControlLevelID])
REFERENCES [dbo].[QualityControlLevels] ([QualityControlLevelID])
GO
ALTER TABLE [dbo].[DataValues] CHECK CONSTRAINT [FK_DataValues_QualityControlLevels]
GO
ALTER TABLE [dbo].[DataValues]  WITH NOCHECK ADD  CONSTRAINT [FK_DataValues_Samples] FOREIGN KEY([SampleID])
REFERENCES [dbo].[Samples] ([SampleID])
GO
ALTER TABLE [dbo].[DataValues] CHECK CONSTRAINT [FK_DataValues_Samples]
GO
ALTER TABLE [dbo].[DataValues]  WITH NOCHECK ADD  CONSTRAINT [FK_DataValues_Sites] FOREIGN KEY([SiteID])
REFERENCES [dbo].[Sites] ([SiteID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[DataValues] CHECK CONSTRAINT [FK_DataValues_Sites]
GO
ALTER TABLE [dbo].[DataValues]  WITH NOCHECK ADD  CONSTRAINT [FK_DataValues_Sources] FOREIGN KEY([SourceID])
REFERENCES [dbo].[Sources] ([SourceID])
GO
ALTER TABLE [dbo].[DataValues] CHECK CONSTRAINT [FK_DataValues_Sources]
GO
ALTER TABLE [dbo].[DataValues]  WITH NOCHECK ADD  CONSTRAINT [FK_DataValues_Variables] FOREIGN KEY([VariableID])
REFERENCES [dbo].[Variables] ([VariableID])
GO
ALTER TABLE [dbo].[DataValues] CHECK CONSTRAINT [FK_DataValues_Variables]
GO
ALTER TABLE [dbo].[DerivedFrom]  WITH NOCHECK ADD  CONSTRAINT [FK_DerivedFrom_DataValues] FOREIGN KEY([ValueID])
REFERENCES [dbo].[DataValues] ([ValueID])
GO
ALTER TABLE [dbo].[DerivedFrom] CHECK CONSTRAINT [FK_DerivedFrom_DataValues]
GO
ALTER TABLE [dbo].[Groups]  WITH NOCHECK ADD  CONSTRAINT [FK_Groups_DataValues] FOREIGN KEY([ValueID])
REFERENCES [dbo].[DataValues] ([ValueID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_DataValues]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [FK_Groups_GroupDescriptions] FOREIGN KEY([GroupID])
REFERENCES [dbo].[GroupDescriptions] ([GroupID])
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [FK_Groups_GroupDescriptions]
GO
ALTER TABLE [dbo].[ISOMetadata]  WITH CHECK ADD  CONSTRAINT [FK_ISOMetadata_TopicCategoryCV] FOREIGN KEY([TopicCategory])
REFERENCES [dbo].[TopicCategoryCV] ([Term])
GO
ALTER TABLE [dbo].[ISOMetadata] CHECK CONSTRAINT [FK_ISOMetadata_TopicCategoryCV]
GO
ALTER TABLE [dbo].[OffsetTypes]  WITH CHECK ADD  CONSTRAINT [FK_OffsetTypes_Units] FOREIGN KEY([OffsetUnitsID])
REFERENCES [dbo].[Units] ([UnitsID])
GO
ALTER TABLE [dbo].[OffsetTypes] CHECK CONSTRAINT [FK_OffsetTypes_Units]
GO
ALTER TABLE [dbo].[Samples]  WITH NOCHECK ADD  CONSTRAINT [FK_Samples_LabMethods] FOREIGN KEY([LabMethodID])
REFERENCES [dbo].[LabMethods] ([LabMethodID])
GO
ALTER TABLE [dbo].[Samples] CHECK CONSTRAINT [FK_Samples_LabMethods]
GO
ALTER TABLE [dbo].[Samples]  WITH CHECK ADD  CONSTRAINT [FK_Samples_SampleTypeCV] FOREIGN KEY([SampleType])
REFERENCES [dbo].[SampleTypeCV] ([Term])
GO
ALTER TABLE [dbo].[Samples] CHECK CONSTRAINT [FK_Samples_SampleTypeCV]
GO
ALTER TABLE [dbo].[Sites]  WITH CHECK ADD  CONSTRAINT [FK_Sites_SiteTypeCV] FOREIGN KEY([SiteType])
REFERENCES [dbo].[SiteTypeCV] ([Term])
GO
ALTER TABLE [dbo].[Sites] CHECK CONSTRAINT [FK_Sites_SiteTypeCV]
GO
ALTER TABLE [dbo].[Sites]  WITH CHECK ADD  CONSTRAINT [FK_Sites_SpatialReferences] FOREIGN KEY([LatLongDatumID])
REFERENCES [dbo].[SpatialReferences] ([SpatialReferenceID])
GO
ALTER TABLE [dbo].[Sites] CHECK CONSTRAINT [FK_Sites_SpatialReferences]
GO
ALTER TABLE [dbo].[Sites]  WITH CHECK ADD  CONSTRAINT [FK_Sites_SpatialReferences1] FOREIGN KEY([LocalProjectionID])
REFERENCES [dbo].[SpatialReferences] ([SpatialReferenceID])
GO
ALTER TABLE [dbo].[Sites] CHECK CONSTRAINT [FK_Sites_SpatialReferences1]
GO
ALTER TABLE [dbo].[Sites]  WITH CHECK ADD  CONSTRAINT [FK_Sites_VerticalDatumCV] FOREIGN KEY([VerticalDatum])
REFERENCES [dbo].[VerticalDatumCV] ([Term])
GO
ALTER TABLE [dbo].[Sites] CHECK CONSTRAINT [FK_Sites_VerticalDatumCV]
GO
ALTER TABLE [dbo].[Sources]  WITH CHECK ADD  CONSTRAINT [FK_Sources_ISOMetaData] FOREIGN KEY([MetadataID])
REFERENCES [dbo].[ISOMetadata] ([MetadataID])
GO
ALTER TABLE [dbo].[Sources] CHECK CONSTRAINT [FK_Sources_ISOMetaData]
GO
ALTER TABLE [dbo].[Variables]  WITH CHECK ADD  CONSTRAINT [FK_Variables_DataTypeCV] FOREIGN KEY([DataType])
REFERENCES [dbo].[DataTypeCV] ([Term])
GO
ALTER TABLE [dbo].[Variables] CHECK CONSTRAINT [FK_Variables_DataTypeCV]
GO
ALTER TABLE [dbo].[Variables]  WITH CHECK ADD  CONSTRAINT [FK_Variables_GeneralCategoryCV] FOREIGN KEY([GeneralCategory])
REFERENCES [dbo].[GeneralCategoryCV] ([Term])
GO
ALTER TABLE [dbo].[Variables] CHECK CONSTRAINT [FK_Variables_GeneralCategoryCV]
GO
ALTER TABLE [dbo].[Variables]  WITH CHECK ADD  CONSTRAINT [FK_Variables_SampleMediumCV] FOREIGN KEY([SampleMedium])
REFERENCES [dbo].[SampleMediumCV] ([Term])
GO
ALTER TABLE [dbo].[Variables] CHECK CONSTRAINT [FK_Variables_SampleMediumCV]
GO
ALTER TABLE [dbo].[Variables]  WITH CHECK ADD  CONSTRAINT [FK_Variables_SpeciationCV] FOREIGN KEY([Speciation])
REFERENCES [dbo].[SpeciationCV] ([Term])
GO
ALTER TABLE [dbo].[Variables] CHECK CONSTRAINT [FK_Variables_SpeciationCV]
GO
ALTER TABLE [dbo].[Variables]  WITH NOCHECK ADD  CONSTRAINT [FK_Variables_Units] FOREIGN KEY([VariableUnitsID])
REFERENCES [dbo].[Units] ([UnitsID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Variables] CHECK CONSTRAINT [FK_Variables_Units]
GO
ALTER TABLE [dbo].[Variables]  WITH CHECK ADD  CONSTRAINT [FK_Variables_Units1] FOREIGN KEY([TimeUnitsID])
REFERENCES [dbo].[Units] ([UnitsID])
GO
ALTER TABLE [dbo].[Variables] CHECK CONSTRAINT [FK_Variables_Units1]
GO
ALTER TABLE [dbo].[Variables]  WITH CHECK ADD  CONSTRAINT [FK_Variables_ValueTypeCV] FOREIGN KEY([ValueType])
REFERENCES [dbo].[ValueTypeCV] ([Term])
GO
ALTER TABLE [dbo].[Variables] CHECK CONSTRAINT [FK_Variables_ValueTypeCV]
GO
ALTER TABLE [dbo].[Variables]  WITH CHECK ADD  CONSTRAINT [FK_Variables_VariableNameCV] FOREIGN KEY([VariableName])
REFERENCES [dbo].[VariableNameCV] ([Term])
GO
ALTER TABLE [dbo].[Variables] CHECK CONSTRAINT [FK_Variables_VariableNameCV]
GO
ALTER TABLE [dbo].[CensorCodeCV]  WITH CHECK ADD  CONSTRAINT [CK_CensorCodeCV_Term] CHECK  ((NOT [Term] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[CensorCodeCV] CHECK CONSTRAINT [CK_CensorCodeCV_Term]
GO
ALTER TABLE [dbo].[DataTypeCV]  WITH CHECK ADD  CONSTRAINT [CK_DataTypeCV_Term] CHECK  ((NOT [Term] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[DataTypeCV] CHECK CONSTRAINT [CK_DataTypeCV_Term]
GO
ALTER TABLE [dbo].[GeneralCategoryCV]  WITH CHECK ADD  CONSTRAINT [CK_GeneralCategoryCV_Term] CHECK  ((NOT [Term] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[GeneralCategoryCV] CHECK CONSTRAINT [CK_GeneralCategoryCV_Term]
GO
ALTER TABLE [dbo].[ISOMetadata]  WITH CHECK ADD  CONSTRAINT [CK_ISOMetadata_ProfileVersion] CHECK  ((NOT [ProfileVersion] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[ISOMetadata] CHECK CONSTRAINT [CK_ISOMetadata_ProfileVersion]
GO
ALTER TABLE [dbo].[ISOMetadata]  WITH CHECK ADD  CONSTRAINT [CK_ISOMetadata_Title] CHECK  ((NOT [Title] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[ISOMetadata] CHECK CONSTRAINT [CK_ISOMetadata_Title]
GO
ALTER TABLE [dbo].[LabMethods]  WITH CHECK ADD  CONSTRAINT [CK_LabMethods_LabMethodName] CHECK  ((NOT [LabMethodName] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[LabMethods] CHECK CONSTRAINT [CK_LabMethods_LabMethodName]
GO
ALTER TABLE [dbo].[LabMethods]  WITH CHECK ADD  CONSTRAINT [CK_LabMethods_LabName] CHECK  ((NOT [LabName] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[LabMethods] CHECK CONSTRAINT [CK_LabMethods_LabName]
GO
ALTER TABLE [dbo].[LabMethods]  WITH CHECK ADD  CONSTRAINT [CK_LabMethods_LabOrganization] CHECK  ((NOT [LabOrganization] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[LabMethods] CHECK CONSTRAINT [CK_LabMethods_LabOrganization]
GO
ALTER TABLE [dbo].[ODMVersion]  WITH CHECK ADD  CONSTRAINT [CK_ODMVersion_VersionNumber] CHECK  ((NOT [VersionNumber] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[ODMVersion] CHECK CONSTRAINT [CK_ODMVersion_VersionNumber]
GO
ALTER TABLE [dbo].[Qualifiers]  WITH CHECK ADD  CONSTRAINT [CK_Qualifiers_QualifierCode] CHECK  ((NOT [QualifierCode] like (((('%['+char((9)))+char((10)))+char((13)))+char((32)))+']%'))
GO
ALTER TABLE [dbo].[Qualifiers] CHECK CONSTRAINT [CK_Qualifiers_QualifierCode]
GO
ALTER TABLE [dbo].[QualityControlLevels]  WITH CHECK ADD  CONSTRAINT [CK_QualityControlLevels_Definition] CHECK  ((NOT [Definition] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[QualityControlLevels] CHECK CONSTRAINT [CK_QualityControlLevels_Definition]
GO
ALTER TABLE [dbo].[QualityControlLevels]  WITH CHECK ADD  CONSTRAINT [CK_QualityControlLevels_QualityControlLevelCode] CHECK  ((NOT [QualityControlLevelCode] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[QualityControlLevels] CHECK CONSTRAINT [CK_QualityControlLevels_QualityControlLevelCode]
GO
ALTER TABLE [dbo].[SampleMediumCV]  WITH CHECK ADD  CONSTRAINT [CK_SampleMediumCV_Term] CHECK  ((NOT [Term] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[SampleMediumCV] CHECK CONSTRAINT [CK_SampleMediumCV_Term]
GO
ALTER TABLE [dbo].[Samples]  WITH CHECK ADD  CONSTRAINT [CK_Samples_LabSampleCode] CHECK  ((NOT [LabSampleCode] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[Samples] CHECK CONSTRAINT [CK_Samples_LabSampleCode]
GO
ALTER TABLE [dbo].[SampleTypeCV]  WITH CHECK ADD  CONSTRAINT [CK_SampleTypeCV_Term] CHECK  ((NOT [Term] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[SampleTypeCV] CHECK CONSTRAINT [CK_SampleTypeCV_Term]
GO
ALTER TABLE [dbo].[Sites]  WITH CHECK ADD  CONSTRAINT [CK_Sites_County] CHECK  ((NOT [County] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[Sites] CHECK CONSTRAINT [CK_Sites_County]
GO
ALTER TABLE [dbo].[Sites]  WITH CHECK ADD  CONSTRAINT [CK_Sites_Latitude] CHECK  (([Latitude]>=(-90) AND [Latitude]<=(90)))
GO
ALTER TABLE [dbo].[Sites] CHECK CONSTRAINT [CK_Sites_Latitude]
GO
ALTER TABLE [dbo].[Sites]  WITH CHECK ADD  CONSTRAINT [CK_Sites_Longitude] CHECK  (([Longitude]>=(-180) AND [Longitude]<=(360)))
GO
ALTER TABLE [dbo].[Sites] CHECK CONSTRAINT [CK_Sites_Longitude]
GO
ALTER TABLE [dbo].[Sites]  WITH CHECK ADD  CONSTRAINT [CK_Sites_SiteCode] CHECK  ((NOT [SiteCode] like '%[^-.A-Z0-9/_]%' escape '/' ))
GO
ALTER TABLE [dbo].[Sites] CHECK CONSTRAINT [CK_Sites_SiteCode]
GO
ALTER TABLE [dbo].[Sites]  WITH CHECK ADD  CONSTRAINT [CK_Sites_SiteName] CHECK  ((NOT [SiteName] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[Sites] CHECK CONSTRAINT [CK_Sites_SiteName]
GO
ALTER TABLE [dbo].[Sites]  WITH CHECK ADD  CONSTRAINT [CK_Sites_State] CHECK  ((NOT [State] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[Sites] CHECK CONSTRAINT [CK_Sites_State]
GO
ALTER TABLE [dbo].[SiteTypeCV]  WITH CHECK ADD  CONSTRAINT [CK_SiteTypeCV_Term] CHECK  ((NOT [Term] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[SiteTypeCV] CHECK CONSTRAINT [CK_SiteTypeCV_Term]
GO
ALTER TABLE [dbo].[Sources]  WITH CHECK ADD  CONSTRAINT [CK_Sources_Address] CHECK  ((NOT [Address] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[Sources] CHECK CONSTRAINT [CK_Sources_Address]
GO
ALTER TABLE [dbo].[Sources]  WITH CHECK ADD  CONSTRAINT [CK_Sources_City] CHECK  ((NOT [City] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[Sources] CHECK CONSTRAINT [CK_Sources_City]
GO
ALTER TABLE [dbo].[Sources]  WITH CHECK ADD  CONSTRAINT [CK_Sources_ContactName] CHECK  ((NOT [ContactName] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[Sources] CHECK CONSTRAINT [CK_Sources_ContactName]
GO
ALTER TABLE [dbo].[Sources]  WITH CHECK ADD  CONSTRAINT [CK_Sources_Email] CHECK  ((NOT [Email] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[Sources] CHECK CONSTRAINT [CK_Sources_Email]
GO
ALTER TABLE [dbo].[Sources]  WITH CHECK ADD  CONSTRAINT [CK_Sources_Organization] CHECK  ((NOT [Organization] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[Sources] CHECK CONSTRAINT [CK_Sources_Organization]
GO
ALTER TABLE [dbo].[Sources]  WITH CHECK ADD  CONSTRAINT [CK_Sources_Phone] CHECK  ((NOT [Phone] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[Sources] CHECK CONSTRAINT [CK_Sources_Phone]
GO
ALTER TABLE [dbo].[Sources]  WITH CHECK ADD  CONSTRAINT [CK_Sources_State] CHECK  ((NOT [State] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[Sources] CHECK CONSTRAINT [CK_Sources_State]
GO
ALTER TABLE [dbo].[Sources]  WITH CHECK ADD  CONSTRAINT [CK_Sources_ZipCode] CHECK  ((NOT [ZipCode] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[Sources] CHECK CONSTRAINT [CK_Sources_ZipCode]
GO
ALTER TABLE [dbo].[SpatialReferences]  WITH CHECK ADD  CONSTRAINT [CK_SpatialReferences_SRSName] CHECK  ((NOT [SRSName] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[SpatialReferences] CHECK CONSTRAINT [CK_SpatialReferences_SRSName]
GO
ALTER TABLE [dbo].[SpeciationCV]  WITH CHECK ADD  CONSTRAINT [CK_SpeciationCV_Term] CHECK  ((NOT [Term] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[SpeciationCV] CHECK CONSTRAINT [CK_SpeciationCV_Term]
GO
ALTER TABLE [dbo].[TopicCategoryCV]  WITH CHECK ADD  CONSTRAINT [CK_TopicCategoryCV_Term] CHECK  ((NOT [Term] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[TopicCategoryCV] CHECK CONSTRAINT [CK_TopicCategoryCV_Term]
GO
ALTER TABLE [dbo].[Units]  WITH CHECK ADD  CONSTRAINT [CK_Units_UnitsAbbreviation] CHECK  ((NOT [UnitsAbbreviation] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[Units] CHECK CONSTRAINT [CK_Units_UnitsAbbreviation]
GO
ALTER TABLE [dbo].[Units]  WITH CHECK ADD  CONSTRAINT [CK_Units_UnitsName] CHECK  ((NOT [UnitsName] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[Units] CHECK CONSTRAINT [CK_Units_UnitsName]
GO
ALTER TABLE [dbo].[Units]  WITH CHECK ADD  CONSTRAINT [CK_Units_UnitsType] CHECK  ((NOT [UnitsType] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[Units] CHECK CONSTRAINT [CK_Units_UnitsType]
GO
ALTER TABLE [dbo].[ValueTypeCV]  WITH CHECK ADD  CONSTRAINT [CK_ValueTypeCV_Term] CHECK  ((NOT [Term] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[ValueTypeCV] CHECK CONSTRAINT [CK_ValueTypeCV_Term]
GO
ALTER TABLE [dbo].[VariableNameCV]  WITH CHECK ADD  CONSTRAINT [CK_VariableNameCV_Term] CHECK  ((NOT [Term] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[VariableNameCV] CHECK CONSTRAINT [CK_VariableNameCV_Term]
GO
ALTER TABLE [dbo].[Variables]  WITH CHECK ADD  CONSTRAINT [CK_Variables_VariableCode] CHECK  ((NOT [VariableCode] like '%[^-.A-Z0-9/_]%' escape '/' ))
GO
ALTER TABLE [dbo].[Variables] CHECK CONSTRAINT [CK_Variables_VariableCode]
GO
ALTER TABLE [dbo].[VerticalDatumCV]  WITH CHECK ADD  CONSTRAINT [CK_VerticalDatumCV_Term] CHECK  ((NOT [Term] like ((('%['+char((9)))+char((10)))+char((13)))+']%'))
GO
ALTER TABLE [dbo].[VerticalDatumCV] CHECK CONSTRAINT [CK_VerticalDatumCV_Term]
GO
/****** Object:  StoredProcedure [dbo].[spUpdateSeriesCatalog]    Script Date: 6/13/2016 12:41:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------------
--Modify the stored procedure to update the SeriesCatalogTable so it adds SiteType
----------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[spUpdateSeriesCatalog] AS

--Clear out the entire SeriesCatalog Table
DELETE FROM  [SeriesCatalog]

--Reset the primary key field
DBCC CHECKIDENT (SeriesCatalog, RESEED, 0)

--Recreate the records in the SeriesCatalog Table
INSERT INTO [SeriesCatalog]
SELECT     dv.SiteID, s.SiteCode, s.SiteName, s.SiteType, dv.VariableID, v.VariableCode, 
           v.VariableName, v.Speciation, v.VariableUnitsID, u.UnitsName AS VariableUnitsName, v.SampleMedium, 
           v.ValueType, v.TimeSupport, v.TimeUnitsID, u1.UnitsName AS TimeUnitsName, v.DataType, 
           v.GeneralCategory, dv.MethodID, m.MethodDescription, dv.SourceID, so.Organization, 
           so.SourceDescription, so.Citation, dv.QualityControlLevelID, qc.QualityControlLevelCode, dv.BeginDateTime, 
           dv.EndDateTime, dv.BeginDateTimeUTC, dv.EndDateTimeUTC, dv.ValueCount 
FROM  (
SELECT SiteID, VariableID, MethodID, QualityControlLevelID, SourceID, MIN(LocalDateTime) AS BeginDateTime, 
           MAX(LocalDateTime) AS EndDateTime, MIN(DateTimeUTC) AS BeginDateTimeUTC, MAX(DateTimeUTC) AS EndDateTimeUTC, 
		   COUNT(DataValue) AS ValueCount
FROM DataValues
GROUP BY SiteID, VariableID, MethodID, QualityControlLevelID, SourceID) dv
           INNER JOIN dbo.Sites s ON dv.SiteID = s.SiteID 
		   INNER JOIN dbo.Variables v ON dv.VariableID = v.VariableID 
		   INNER JOIN dbo.Units u ON v.VariableUnitsID = u.UnitsID 
		   INNER JOIN dbo.Methods m ON dv.MethodID = m.MethodID 
		   INNER JOIN dbo.Units u1 ON v.TimeUnitsID = u1.UnitsID 
		   INNER JOIN dbo.Sources so ON dv.SourceID = so.SourceID 
		   INNER JOIN dbo.QualityControlLevels qc ON dv.QualityControlLevelID = qc.QualityControlLevelID
GROUP BY   dv.SiteID, s.SiteCode, s.SiteName, s.SiteType, dv.VariableID, v.VariableCode, v.VariableName, v.Speciation,
           v.VariableUnitsID, u.UnitsName, v.SampleMedium, v.ValueType, v.TimeSupport, v.TimeUnitsID, u1.UnitsName, 
		   v.DataType, v.GeneralCategory, dv.MethodID, m.MethodDescription, dv.SourceID, so.Organization, 
		   so.SourceDescription, so.Citation, dv.QualityControlLevelID, qc.QualityControlLevelCode, dv.BeginDateTime,
		   dv.EndDateTime, dv.BeginDateTimeUTC, dv.EndDateTimeUTC, dv.ValueCount
ORDER BY   dv.SiteID, dv.VariableID, v.VariableUnitsID

GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'CensorCodeCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'CensorCodeCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'6/14/2006 9:57:00 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'6/14/2006 9:57:00 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'CensorCodeCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CensorCodeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'觹洌乧쮻峯㹭鷰' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'DataTypeCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'萌冘킱䤬ඞ繓ꖬꓜ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'DataTypeCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'6/14/2006 10:31:20 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'6/14/2006 10:31:20 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'DataTypeCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'鹰퓬⻃䤱⒑劶踏꫸' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'GeneralCategoryCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'GUID', @value=N'춤༑ᗍ䦳㖇綆᧏㍣' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'GeneralCategoryCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'6/14/2006 10:31:54 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'6/15/2006 1:59:39 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'GeneralCategoryCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GeneralCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'SampleMediumCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'SampleMediumCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'6/14/2006 10:28:35 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'6/14/2006 10:28:35 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'SampleMediumCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleMediumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'SampleTypeCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'SampleTypeCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'6/14/2006 10:40:20 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'6/14/2006 10:40:20 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'SampleTypeCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SampleTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'TopicCategoryCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'TopicCategoryCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'6/15/2006 2:03:32 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'6/15/2006 2:03:32 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'TopicCategoryCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TopicCategoryCV'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'ValueTypeCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'ValueTypeCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'6/14/2006 10:29:10 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'6/14/2006 10:29:31 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ValueTypeCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ValueTypeCV'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'VariableCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'VariableCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'6/14/2006 10:00:56 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'6/14/2006 10:01:17 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'VariableCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VariableNameCV'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Term' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'VerticalDatumCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Term'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'50' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'Definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'VerticalDatumCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV', @level2type=N'COLUMN',@level2name=N'Definition'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'6/14/2006 11:21:53 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'6/14/2006 11:21:53 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'VerticalDatumCV' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VerticalDatumCV'
GO
USE [master]
GO
ALTER DATABASE [odm] SET  READ_WRITE
GO
