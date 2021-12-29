CREATE DATABASE FamilySports
USE FamilySports

/*
drop table InvoiceItems
drop table invoices
drop table Products
drop table Categories
drop table CategoryType
drop table Currencies
drop table Agents
drop table clients
drop table companies
drop table CountryRegion
drop table countries 
drop table Regions
*/

CREATE TABLE Regions
(
RegionID INT IDENTITY(1,1) PRIMARY KEY,
RegionName VARCHAR(30)
)

CREATE TABLE Countries
(
CountryID INT IDENTITY(1,1) PRIMARY KEY,
CountryName VARCHAR(100)
)
GO

CREATE TABLE CountryRegion
(
ID INT IDENTITY(1,1) PRIMARY KEY,
CountryID INT,
RegionID INT,
CONSTRAINT cr_cntrid_fk FOREIGN KEY(CountryID) REFERENCES Countries(CountryID),
CONSTRAINT cr_rgid_fk FOREIGN KEY(RegionID) REFERENCES Regions(RegionID)
)

CREATE TABLE Agents
(
AgentID INT IDENTITY(1,1) PRIMARY KEY,
CompanyName VARCHAR(50),
Fee DECIMAL(8,2),
Phone VARCHAR(25),
Address VARCHAR(100),
City VARCHAR(50),
ZIP VARCHAR(25),
Country INT,
Email VARCHAR(50),
ActiveStatus CHAR(1),
CONSTRAINT sup_cntr_fk FOREIGN KEY(Country) REFERENCES Countries(CountryID),
CONSTRAINT sup_act_ck CHECK(ActiveStatus IN (0,1))
)

CREATE TABLE Currencies
(
CurrencyID INT IDENTITY(1,1) PRIMARY KEY,
ShortName VARCHAR(10),
Currency VARCHAR(50),
Exchange DECIMAL(8,2),
ExchangeDate DATE
)
CREATE TABLE Companies
(
ID INT IDENTITY(1,1) PRIMARY KEY,
CompanyName VARCHAR(50),
Phone VARCHAR(25),
Address VARCHAR(100),
City VARCHAR(50),
ZIP VARCHAR(25),
Country INT,
CONSTRAINT com_cntr_fk FOREIGN KEY(Country) REFERENCES Countries(CountryID)
)

CREATE TABLE Clients
(
ClientID INT IDENTITY(1,1) PRIMARY KEY,
FirstName VARCHAR(30),
LastName VARCHAR(30),
Company INT,
Title VARCHAR(30),
Email VARCHAR(50),
CONSTRAINT cl_com_fk FOREIGN KEY(Company) REFERENCES Companies(ID)
)

CREATE TABLE CategoryType
(
ID INT IDENTITY(1,1) PRIMARY KEY,
TypeName VARCHAR(50)
)

CREATE TABLE Categories
(
ID INT IDENTITY(1,1) PRIMARY KEY,
CategoryName VARCHAR(50),
CategoryType INT,
CONSTRAINT ct_type_id FOREIGN KEY(CategoryType) REFERENCES CategoryType(ID)
)

CREATE TABLE Products
(
ID INT IDENTITY(1,1) PRIMARY KEY,
ProductName VARCHAR(50),
ProductStatus INT,
Category INT,
Price DECIMAL(8,2),
PriceUpdate DATE,
CONSTRAINT prod_st_ck CHECK(ProductStatus IN(0,1)),
CONSTRAINT prod_cat_id FOREIGN KEY(Category) REFERENCES Categories(ID)
)

CREATE TABLE Invoices
(
ID INT IDENTITY(1,1) PRIMARY KEY,
InvoiceDate DATE,
Currency INT,
Client INT,
VAT DECIMAL(8,2),
Agent INT,
CONSTRAINT inv_cur_fk FOREIGN KEY(Currency) REFERENCES Currencies(CurrencyID),
CONSTRAINT inv_cl_fk FOREIGN KEY(Client) REFERENCES Clients(ClientID),
CONSTRAINT inv_sup_fk FOREIGN KEY(Agent) REFERENCES Agents(AgentID)
)

CREATE TABLE InvoiceItems
(
ID INT IDENTITY(1,1) PRIMARY KEY,
InvoiceID INT,
Product INT,
Quantity INT,
Discount DECIMAL(8,2),
CONSTRAINT ii_prod_fk FOREIGN KEY(Product) REFERENCES Products(ID),
CONSTRAINT ii_iid_fk FOREIGN KEY(InvoiceID) REFERENCES Invoices(ID)
)