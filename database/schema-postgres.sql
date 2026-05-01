-- Qsystech Service Management System Database Schema (PostgreSQL)
-- This file contains all table creation scripts for PostgreSQL

-- Companies Table
CREATE TABLE IF NOT EXISTS Companies (
    CompanyID SERIAL PRIMARY KEY,
    CompanyCode VARCHAR(50) UNIQUE NOT NULL,
    CompanyName VARCHAR(200) NOT NULL,
    Address VARCHAR(500),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Website VARCHAR(200),
    GSTIN VARCHAR(50),
    Logo TEXT,
    Status BOOLEAN DEFAULT true,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Users Table
CREATE TABLE IF NOT EXISTS Users (
    UserID SERIAL PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    CompanyID INT REFERENCES Companies(CompanyID),
    Role VARCHAR(50) DEFAULT 'User',
    Status BOOLEAN DEFAULT true,
    LastLogin TIMESTAMP,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- UserAccess Table (Role-based access control)
CREATE TABLE IF NOT EXISTS UserAccess (
    AccessID SERIAL PRIMARY KEY,
    UserID INT REFERENCES Users(UserID),
    FormName VARCHAR(100) NOT NULL,
    CanView BOOLEAN DEFAULT false,
    CanAdd BOOLEAN DEFAULT false,
    CanEdit BOOLEAN DEFAULT false,
    CanDelete BOOLEAN DEFAULT false,
    CanSearch BOOLEAN DEFAULT false,
    CanPrint BOOLEAN DEFAULT false,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- AreaCodes Table
CREATE TABLE IF NOT EXISTS AreaCodes (
    AreaCodeID SERIAL PRIMARY KEY,
    AreaCode VARCHAR(20) UNIQUE NOT NULL,
    Description VARCHAR(200),
    Priority INT DEFAULT 0,
    CompanyID INT REFERENCES Companies(CompanyID),
    Status BOOLEAN DEFAULT true,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ContractCategories Table
CREATE TABLE IF NOT EXISTS ContractCategories (
    CategoryID SERIAL PRIMARY KEY,
    CategoryCode VARCHAR(20) UNIQUE NOT NULL,
    CategoryName VARCHAR(100) NOT NULL,
    Description VARCHAR(500),
    CompanyID INT REFERENCES Companies(CompanyID),
    Status BOOLEAN DEFAULT true,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ContractIntervals Table
CREATE TABLE IF NOT EXISTS ContractIntervals (
    IntervalID SERIAL PRIMARY KEY,
    IntervalDays INT NOT NULL,
    IntervalName VARCHAR(50) NOT NULL,
    Description VARCHAR(200),
    CompanyID INT REFERENCES Companies(CompanyID),
    Status BOOLEAN DEFAULT true,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ServiceIntervals Table
CREATE TABLE IF NOT EXISTS ServiceIntervals (
    ServiceIntervalID SERIAL PRIMARY KEY,
    IntervalDays INT NOT NULL,
    IntervalName VARCHAR(50) NOT NULL,
    Description VARCHAR(200),
    CompanyID INT REFERENCES Companies(CompanyID),
    Status BOOLEAN DEFAULT true,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Systems (Master Catalog) Table
CREATE TABLE IF NOT EXISTS Systems (
    SystemID SERIAL PRIMARY KEY,
    SystemCode VARCHAR(20) UNIQUE NOT NULL,
    SystemName VARCHAR(200) NOT NULL,
    Description VARCHAR(500),
    CompanyID INT REFERENCES Companies(CompanyID),
    Status BOOLEAN DEFAULT true,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Services (Master Catalog) Table
CREATE TABLE IF NOT EXISTS Services (
    ServiceID SERIAL PRIMARY KEY,
    ServiceCode VARCHAR(20) UNIQUE NOT NULL,
    ServiceName VARCHAR(200) NOT NULL,
    Description VARCHAR(500),
    CompanyID INT REFERENCES Companies(CompanyID),
    Status BOOLEAN DEFAULT true,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Items (Master Catalog) Table
CREATE TABLE IF NOT EXISTS Items (
    ItemID SERIAL PRIMARY KEY,
    ItemCode VARCHAR(20) UNIQUE NOT NULL,
    ItemName VARCHAR(200) NOT NULL,
    Description VARCHAR(500),
    Unit VARCHAR(20),
    CompanyID INT REFERENCES Companies(CompanyID),
    Status BOOLEAN DEFAULT true,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ItemStock Table
CREATE TABLE IF NOT EXISTS ItemStock (
    StockID SERIAL PRIMARY KEY,
    ItemID INT REFERENCES Items(ItemID),
    CompanyID INT REFERENCES Companies(CompanyID),
    Quantity DECIMAL(18,2) DEFAULT 0,
    Price DECIMAL(18,2) DEFAULT 0,
    ReorderLevel DECIMAL(18,2) DEFAULT 0,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ServiceCost Table
CREATE TABLE IF NOT EXISTS ServiceCost (
    ServiceCostID SERIAL PRIMARY KEY,
    CategoryID INT REFERENCES ContractCategories(CategoryID),
    ServiceID INT REFERENCES Services(ServiceID),
    Cost DECIMAL(18,2) DEFAULT 0,
    ServiceTime INT DEFAULT 0, -- in minutes
    CompanyID INT REFERENCES Companies(CompanyID),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SystemCost Table
CREATE TABLE IF NOT EXISTS SystemCost (
    SystemCostID SERIAL PRIMARY KEY,
    CategoryID INT REFERENCES ContractCategories(CategoryID),
    SystemID INT REFERENCES Systems(SystemID),
    Cost DECIMAL(18,2) DEFAULT 0,
    CompanyID INT REFERENCES Companies(CompanyID),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ItemCost Table
CREATE TABLE IF NOT EXISTS ItemCost (
    ItemCostID SERIAL PRIMARY KEY,
    CategoryID INT REFERENCES ContractCategories(CategoryID),
    ItemID INT REFERENCES Items(ItemID),
    Cost DECIMAL(18,2) DEFAULT 0,
    CompanyID INT REFERENCES Companies(CompanyID),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ServiceHours Table
CREATE TABLE IF NOT EXISTS ServiceHours (
    ServiceHoursID SERIAL PRIMARY KEY,
    DayOfWeek INT NOT NULL, -- 1=Monday, 7=Sunday
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    CompanyID INT REFERENCES Companies(CompanyID),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ServiceTeams Table
CREATE TABLE IF NOT EXISTS ServiceTeams (
    TeamID SERIAL PRIMARY KEY,
    TeamName VARCHAR(100) NOT NULL,
    Description VARCHAR(500),
    CompanyID INT REFERENCES Companies(CompanyID),
    Status BOOLEAN DEFAULT true,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ServiceEngineers Table
CREATE TABLE IF NOT EXISTS ServiceEngineers (
    EngineerID SERIAL PRIMARY KEY,
    EngineerName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100),
    TeamID INT REFERENCES ServiceTeams(TeamID),
    CompanyID INT REFERENCES Companies(CompanyID),
    Status BOOLEAN DEFAULT true,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Customers Table
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID SERIAL PRIMARY KEY,
    CustomerCode VARCHAR(20) UNIQUE NOT NULL,
    CustomerName VARCHAR(200) NOT NULL,
    Flat VARCHAR(50),
    Block VARCHAR(50),
    Road VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    Mobile VARCHAR(20),
    Email VARCHAR(100),
    Telephone VARCHAR(20),
    Fax VARCHAR(20),
    AreaCodeID INT REFERENCES AreaCodes(AreaCodeID),
    CompanyID INT REFERENCES Companies(CompanyID),
    Status BOOLEAN DEFAULT true,
    Description VARCHAR(500),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CustomerSystems Table
CREATE TABLE IF NOT EXISTS CustomerSystems (
    CustomerSystemID SERIAL PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    SystemID INT REFERENCES Systems(SystemID),
    SystemType VARCHAR(100),
    SerialNumber VARCHAR(100),
    InstallDate TIMESTAMP,
    Status BOOLEAN DEFAULT true,
    Notes VARCHAR(500),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ServiceContracts Table
CREATE TABLE IF NOT EXISTS ServiceContracts (
    ContractID SERIAL PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    CustomerSystemID INT REFERENCES CustomerSystems(CustomerSystemID),
    CategoryID INT REFERENCES ContractCategories(CategoryID),
    ContractPeriod INT, -- in months
    Frequency INT, -- in months
    StartDate TIMESTAMP,
    EndDate TIMESTAMP,
    Status BOOLEAN DEFAULT true,
    Notes VARCHAR(500),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SalesMaster Table
CREATE TABLE IF NOT EXISTS SalesMaster (
    SalesNo SERIAL PRIMARY KEY,
    SalesDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CustomerID INT REFERENCES Customers(CustomerID),
    CategoryID INT REFERENCES ContractCategories(CategoryID),
    ContractTypeID INT,
    ServiceIntervalID INT REFERENCES ServiceIntervals(ServiceIntervalID),
    ContractIntervalID INT REFERENCES ContractIntervals(IntervalID),
    ContractStartDate TIMESTAMP,
    PlanType VARCHAR(20) DEFAULT 'Plan', -- 'Plan' or 'Complaint'
    Description TEXT,
    Notes TEXT,
    TotalAmount DECIMAL(18,2) DEFAULT 0,
    TotalServiceTime INT DEFAULT 0, -- in minutes
    CompanyID INT REFERENCES Companies(CompanyID),
    Status BOOLEAN DEFAULT true,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SalesMasterSystems Table
CREATE TABLE IF NOT EXISTS SalesMasterSystems (
    SalesSystemID SERIAL PRIMARY KEY,
    SalesNo INT REFERENCES SalesMaster(SalesNo),
    SystemID INT REFERENCES Systems(SystemID),
    Quantity INT DEFAULT 1,
    Cost DECIMAL(18,2) DEFAULT 0,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SalesMasterServices Table
CREATE TABLE IF NOT EXISTS SalesMasterServices (
    SalesServiceID SERIAL PRIMARY KEY,
    SalesNo INT REFERENCES SalesMaster(SalesNo),
    ServiceID INT REFERENCES Services(ServiceID),
    Quantity INT DEFAULT 1,
    Cost DECIMAL(18,2) DEFAULT 0,
    ServiceTime INT DEFAULT 0,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SalesMasterItems Table
CREATE TABLE IF NOT EXISTS SalesMasterItems (
    SalesItemID SERIAL PRIMARY KEY,
    SalesNo INT REFERENCES SalesMaster(SalesNo),
    ItemID INT REFERENCES Items(ItemID),
    Quantity INT DEFAULT 1,
    Cost DECIMAL(18,2) DEFAULT 0,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Schedule Table
CREATE TABLE IF NOT EXISTS Schedule (
    ScheduleID SERIAL PRIMARY KEY,
    SalesNo INT REFERENCES SalesMaster(SalesNo),
    ScheduleDate TIMESTAMP NOT NULL,
    ServiceTime TIME,
    EngineerID INT REFERENCES ServiceEngineers(EngineerID),
    ServiceStatus VARCHAR(20) DEFAULT 'Pending', -- 'Pending', 'Confirmed', 'Completed', 'Cancelled'
    IsOverride BOOLEAN DEFAULT false,
    Notes VARCHAR(500),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Complaints Table
CREATE TABLE IF NOT EXISTS Complaints (
    ComplaintID SERIAL PRIMARY KEY,
    SalesNo INT REFERENCES SalesMaster(SalesNo),
    ComplaintDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Description TEXT,
    Status VARCHAR(20) DEFAULT 'Open', -- 'Open', 'In Progress', 'Resolved', 'Closed'
    Resolution TEXT,
    ResolvedDate TIMESTAMP,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SalesMasterPlan Table
CREATE TABLE IF NOT EXISTS SalesMasterPlan (
    PlanID SERIAL PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    PlanType VARCHAR(50) DEFAULT 'Plan', -- 'Plan', 'Complaint'
    Frequency VARCHAR(50), -- 'Weekly', 'Monthly', 'Quarterly', 'Yearly'
    Notes TEXT,
    CreatedBy INT REFERENCES Users(UserID),
    UpdatedBy INT REFERENCES Users(UserID),
    Status BOOLEAN DEFAULT true,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SalesMasterPlanSystem Table
CREATE TABLE IF NOT EXISTS SalesMasterPlanSystem (
    PlanSystemID SERIAL PRIMARY KEY,
    PlanID INT REFERENCES SalesMasterPlan(PlanID) ON DELETE CASCADE,
    SystemID INT REFERENCES Systems(SystemID),
    Quantity INT DEFAULT 1,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SalesMasterPlanService Table
CREATE TABLE IF NOT EXISTS SalesMasterPlanService (
    PlanServiceID SERIAL PRIMARY KEY,
    PlanID INT REFERENCES SalesMasterPlan(PlanID) ON DELETE CASCADE,
    ServiceID INT REFERENCES Services(ServiceID),
    Quantity INT DEFAULT 1,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SalesMasterPlanItem Table
CREATE TABLE IF NOT EXISTS SalesMasterPlanItem (
    PlanItemID SERIAL PRIMARY KEY,
    PlanID INT REFERENCES SalesMasterPlan(PlanID) ON DELETE CASCADE,
    ItemID INT REFERENCES Items(ItemID),
    Quantity INT DEFAULT 1,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Holidays Table
CREATE TABLE IF NOT EXISTS Holidays (
    HolidayID SERIAL PRIMARY KEY,
    HolidayName VARCHAR(200) NOT NULL,
    HolidayDate DATE NOT NULL,
    Description VARCHAR(500),
    CompanyID INT REFERENCES Companies(CompanyID),
    Status BOOLEAN DEFAULT true,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
