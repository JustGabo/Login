USE [master]
GO
/****** Object:  Database [LoginDB]    Script Date: 16/08/2018 06:54:31 p.m. ******/
CREATE DATABASE [LoginDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LoginDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\LoginDB.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'LoginDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\LoginDB_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
USE [LoginDB]
GO
/****** Object:  Table [dbo].[User]    Script Date: 16/08/2018 06:54:31 p.m. ******/
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 16/08/2018 06:54:31 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Login] @username varchar(50), @password varchar(50), @output varchar(100) output
as
if @username = ''
begin
	set @output = 'Error: Missing username'
	return
end
if @password = ''
begin
	set @output = 'Error: Missing password'
	return
end

declare @name varchar(50)
declare @surname varchar(50)
select @name = [Name], @surname = [Surname] from [User]
where [Username] = @username and [Password] = @password
set @output = @name + ' ' + @surname

if @output is null
begin
	set @output = 'Error: Wrong username and/or password'
end

GO
USE [master]
GO
ALTER DATABASE [LoginDB] SET  READ_WRITE 
GO
