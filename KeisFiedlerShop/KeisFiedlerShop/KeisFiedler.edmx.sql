
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 07/07/2014 16:05:30
-- Generated from EDMX file: C:\Users\morten\Documents\KeisGit\KeisFiedlerShop\KeisFiedlerShop\KeisFiedler.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [KeisFiedler];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_CategoryProduct]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProductSet] DROP CONSTRAINT [FK_CategoryProduct];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[UserSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserSet];
GO
IF OBJECT_ID(N'[dbo].[ProductSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProductSet];
GO
IF OBJECT_ID(N'[dbo].[CategorySet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CategorySet];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'UserSet'
CREATE TABLE [dbo].[UserSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(max)  NOT NULL,
    [password] nvarchar(max)  NOT NULL,
    [userlevel] smallint  NOT NULL,
    [email] nvarchar(max)  NOT NULL,
    [address] nvarchar(max)  NOT NULL,
    [zipcode] nvarchar(max)  NOT NULL,
    [username] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'ProductSet'
CREATE TABLE [dbo].[ProductSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Category_Id] int  NOT NULL
);
GO

-- Creating table 'CategorySet'
CREATE TABLE [dbo].[CategorySet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [name] nvarchar(max)  NOT NULL,
    [description] nvarchar(max)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'UserSet'
ALTER TABLE [dbo].[UserSet]
ADD CONSTRAINT [PK_UserSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ProductSet'
ALTER TABLE [dbo].[ProductSet]
ADD CONSTRAINT [PK_ProductSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'CategorySet'
ALTER TABLE [dbo].[CategorySet]
ADD CONSTRAINT [PK_CategorySet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Category_Id] in table 'ProductSet'
ALTER TABLE [dbo].[ProductSet]
ADD CONSTRAINT [FK_CategoryProduct]
    FOREIGN KEY ([Category_Id])
    REFERENCES [dbo].[CategorySet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CategoryProduct'
CREATE INDEX [IX_FK_CategoryProduct]
ON [dbo].[ProductSet]
    ([Category_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------