--
-- File generated with SQLiteStudio v3.3.3 on mar. mar. 1 07:59:31 2022
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: dim_category
CREATE TABLE dim_category (
    CategoryId   INTEGER        PRIMARY KEY,
    CategoryName VARCHAR (25),
    Description  VARCHAR (1000) 
);

-- Table: dim_customer
CREATE TABLE dim_customer (CustomerId VARCHAR (8) PRIMARY KEY NOT NULL, CompanyName VARCHAR (80), ContactName VARCHAR (80), ContactTitle VARCHAR (80), Address VARCHAR (80), City VARCHAR (25), Region VARCHAR (25), PostalCode VARCHAR (10), Country VARCHAR (25), Phone VARCHAR (20));

-- Table: dim_employee
CREATE TABLE dim_employee (
    EmployeeId      INTEGER        PRIMARY KEY,
    LastName        VARCHAR (50),
    FirstName       VARCHAR (50),
    Title           VARCHAR (80),
    TitleOfCourtesy VARCHAR (80),
    BirthDate       DATE,
    HireDate        DATE,
    Address         VARCHAR (80),
    City            VARCHAR (80),
    Region          VARCHAR (80),
    PostalCode      VARCHAR (10),
    Country         VARCHAR (25),
    Extension       VARCHAR (5),
    Photo           BLOB,
    Notes           VARCHAR (8000),
    ReportsTo       INTEGER,
    PhotoPath       VARCHAR (1000) 
);

-- Table: dim_EmployeeTerritory
CREATE TABLE dim_EmployeeTerritory (
    EmployeeTerritoryId VARCHAR (10) PRIMARY KEY,
    EmployeeId          INTEGER      NOT NULL
                                     REFERENCES dim_employee (EmployeeId),
    TerritoryId         VARCHAR (5)  REFERENCES dim_territory (TerritoryId) 
                                     NOT NULL
);


-- Table: dim_product
CREATE TABLE dim_product (ProductId INTEGER PRIMARY KEY AUTOINCREMENT, ProductName VARCHAR (8000), SupplierId INTEGER NOT NULL REFERENCES dim_supplier (SupplierId), CategoryId INTEGER NOT NULL REFERENCES dim_category (CategoryId), QuantityPerUnit VARCHAR (25), UnitPrice DECIMAL NOT NULL, UnitsInStock INTEGER NOT NULL, UnitsOnOrder INTEGER NOT NULL, ReorderLevel INTEGER NOT NULL, Discontinued INTEGER NOT NULL);

-- Table: dim_shipper
CREATE TABLE dim_shipper (
    ShipperId   INTEGER        PRIMARY KEY,
    CompanyName VARCHAR (50),
    Phone       VARCHAR (15) 
);


-- Table: dim_supplier
CREATE TABLE dim_supplier (
    SupplierId   INTEGER        PRIMARY KEY,
    CompanyName  VARCHAR (80),
    ContactName  VARCHAR (50),
    ContactTitle VARCHAR (80),
    Address      VARCHAR (80),
    City         VARCHAR (30),
    Region       VARCHAR (30),
    PostalCode   VARCHAR (10),
    Country      VARCHAR (30),
    Phone        VARCHAR (15),
    HomePage     VARCHAR (8000) 
);

-- Table: dim_territory
CREATE TABLE dim_territory (
    TerritoryId          VARCHAR (5)  PRIMARY KEY,
    TerritoryDescription VARCHAR (25) 
);


-- Table: fact_Order
CREATE TABLE fact_Order (ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, OrderId VARCHAR (10) NOT NULL, CustomerId VARCHAR (8) REFERENCES dim_customer (CustomerId) NOT NULL, EmployeeId INTEGER NOT NULL REFERENCES dim_employee (EmployeeId), OrderDate DATETIME, ProductId INTEGER REFERENCES dim_product (ProductId) NOT NULL, ShipperId INTEGER REFERENCES dim_shipper (ShipperId) NOT NULL);


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
