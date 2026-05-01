-- Qsystech Service Management System Seed Data (PostgreSQL)
-- This file contains sample data for testing

-- Default Company
INSERT INTO Companies (CompanyCode, CompanyName, Address, City, State, Country, Phone, Email, Website, Status)
VALUES ('DEFAULT', 'Qsystech Solutions', '123 Business Park', 'Manama', 'Capital', 'Bahrain', '+973-12345678', 'info@qsystech.com', 'https://qsystech.com', true)
ON CONFLICT (CompanyCode) DO UPDATE SET CompanyName = EXCLUDED.CompanyName, Address = EXCLUDED.Address, City = EXCLUDED.City;

-- Default Admin User (Password: admin123 - should be changed in production)
INSERT INTO Users (Username, Password, FullName, Email, Role, CompanyID, Status)
SELECT 'admin', '$2b$10$V9dfFWOXKH.lDUOaTWXwHuV2PtptQN5YGyzctQxsh8eiFoHE2.Qcq', 'Administrator', 'admin@qsystech.com', 'Admin', CompanyID, true
FROM Companies WHERE CompanyCode = 'DEFAULT'
ON CONFLICT (Username) DO NOTHING;

-- Area Codes
INSERT INTO AreaCodes (AreaCode, Description, Priority, CompanyID, Status)
SELECT '001', 'Manama Central', 1, CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT '002', 'Riffa', 2, CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT '003', 'Muharraq', 3, CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT '004', 'Isa Town', 4, CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
ON CONFLICT (AreaCode) DO NOTHING;

-- Contract Categories
INSERT INTO ContractCategories (CategoryCode, CategoryName, Description, CompanyID, Status)
SELECT 'AMC', 'Annual Maintenance Contract', 'Yearly service contract', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'SMC', 'Service Maintenance Contract', 'Periodic service contract', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'EMC', 'Emergency Maintenance Contract', '24/7 emergency support', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
ON CONFLICT (CategoryCode) DO NOTHING;

-- Contract Intervals
INSERT INTO ContractIntervals (IntervalDays, IntervalName, Description, CompanyID, Status)
SELECT 30, 'Monthly', 'Monthly service interval', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 90, 'Quarterly', 'Quarterly service interval', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 180, 'Half Yearly', 'Half yearly service interval', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 365, 'Yearly', 'Yearly service interval', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT';

-- Service Intervals
INSERT INTO ServiceIntervals (IntervalDays, IntervalName, Description, CompanyID, Status)
SELECT 7, 'Weekly', 'Weekly service interval', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 15, 'Bi-Weekly', 'Bi-weekly service interval', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 30, 'Monthly', 'Monthly service interval', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 60, 'Bi-Monthly', 'Bi-monthly service interval', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT';

-- Systems
INSERT INTO Systems (SystemCode, SystemName, Description, CompanyID, Status)
SELECT 'FIRE-001', 'Fire Alarm System', 'Complete fire detection and alarm system', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'CCTV-001', 'CCTV Surveillance', 'Closed circuit television monitoring', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'ACC-001', 'Access Control', 'Biometric and card access control', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'PA-001', 'Public Address System', 'Audio announcement system', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'NET-001', 'Network Infrastructure', 'Structured cabling and networking', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT';

-- Services
INSERT INTO Services (ServiceCode, ServiceName, Description, CompanyID, Status)
SELECT 'SRV-001', 'Fire Alarm Inspection', 'Regular fire alarm system inspection', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'SRV-002', 'CCTV Maintenance', 'Camera and DVR maintenance', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'SRV-003', 'Access Control Service', 'Biometric device maintenance', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'SRV-004', 'Network Support', 'Network troubleshooting and support', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'SRV-005', 'Emergency Response', '24/7 emergency technical support', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT';

-- Items
INSERT INTO Items (ItemCode, ItemName, Description, Unit, CompanyID, Status)
SELECT 'ITM-001', 'Smoke Detector', 'Photoelectric smoke detector', 'Piece', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'ITM-002', 'CCTV Camera', 'HD dome camera', 'Piece', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'ITM-003', 'Access Card', 'RFID access card', 'Piece', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'ITM-004', 'Cable Cat6', 'Network cable Cat6', 'Meter', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'ITM-005', 'Control Panel', 'Fire alarm control panel', 'Piece', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT';

-- Service Teams
INSERT INTO ServiceTeams (TeamName, Description, CompanyID, Status)
SELECT 'Team Alpha', 'Primary service team for Manama', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'Team Beta', 'Secondary service team for Riffa', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'Team Gamma', 'Emergency response team', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT';

-- Service Engineers
INSERT INTO ServiceEngineers (EngineerName, Phone, Email, TeamID, CompanyID, Status)
SELECT 'Ahmed Ali', '+973-11111111', 'ahmed@qsystech.com', TeamID, CompanyID, true FROM ServiceTeams st, Companies c WHERE st.TeamName = 'Team Alpha' AND c.CompanyCode = 'DEFAULT'
UNION ALL SELECT 'Mohammed Hassan', '+973-22222222', 'mohammed@qsystech.com', TeamID, CompanyID, true FROM ServiceTeams st, Companies c WHERE st.TeamName = 'Team Alpha' AND c.CompanyCode = 'DEFAULT'
UNION ALL SELECT 'Saeed Ahmed', '+973-33333333', 'saeed@qsystech.com', TeamID, CompanyID, true FROM ServiceTeams st, Companies c WHERE st.TeamName = 'Team Beta' AND c.CompanyCode = 'DEFAULT'
UNION ALL SELECT 'Khalid Omar', '+973-44444444', 'khalid@qsystech.com', TeamID, CompanyID, true FROM ServiceTeams st, Companies c WHERE st.TeamName = 'Team Gamma' AND c.CompanyCode = 'DEFAULT';

-- Customers
INSERT INTO Customers (CustomerCode, CustomerName, Flat, Block, Road, City, State, Country, Mobile, Email, Telephone, AreaCodeID, CompanyID, Status)
SELECT 'CUST-001', 'ABC Trading Co', '101', 'Block 321', 'Road 45', 'Manama', 'Capital', 'Bahrain', '+973-55555555', 'info@abctrading.com', '+973-55555556', AreaCodeID, CompanyID, true FROM AreaCodes ac, Companies c WHERE ac.AreaCode = '001' AND c.CompanyCode = 'DEFAULT'
UNION ALL SELECT 'CUST-002', 'XYZ Industries', '205', 'Block 456', 'Road 78', 'Riffa', 'Southern', 'Bahrain', '+973-66666666', 'contact@xyzind.com', '+973-66666667', AreaCodeID, CompanyID, true FROM AreaCodes ac, Companies c WHERE ac.AreaCode = '002' AND c.CompanyCode = 'DEFAULT'
UNION ALL SELECT 'CUST-003', 'Tech Solutions LLC', 'Floor 3', 'Block 789', 'Road 12', 'Muharraq', 'Muharraq', 'Bahrain', '+973-77777777', 'sales@techsol.com', '+973-77777778', AreaCodeID, CompanyID, true FROM AreaCodes ac, Companies c WHERE ac.AreaCode = '003' AND c.CompanyCode = 'DEFAULT';

-- Service Hours
INSERT INTO ServiceHours (DayOfWeek, StartTime, EndTime, CompanyID)
SELECT 1, '08:00:00', '17:00:00', CompanyID FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 2, '08:00:00', '17:00:00', CompanyID FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 3, '08:00:00', '17:00:00', CompanyID FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 4, '08:00:00', '17:00:00', CompanyID FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 5, '08:00:00', '17:00:00', CompanyID FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 6, '09:00:00', '14:00:00', CompanyID FROM Companies WHERE CompanyCode = 'DEFAULT';

-- Sample Service Costs
INSERT INTO ServiceCost (CategoryID, ServiceID, Cost, ServiceTime, CompanyID)
SELECT CategoryID, ServiceID, 50.00, 60, CompanyID FROM ContractCategories cc, Services s, Companies c WHERE cc.CategoryCode = 'AMC' AND s.ServiceCode = 'SRV-001' AND c.CompanyCode = 'DEFAULT'
UNION ALL SELECT CategoryID, ServiceID, 75.00, 90, CompanyID FROM ContractCategories cc, Services s, Companies c WHERE cc.CategoryCode = 'AMC' AND s.ServiceCode = 'SRV-002' AND c.CompanyCode = 'DEFAULT'
UNION ALL SELECT CategoryID, ServiceID, 40.00, 45, CompanyID FROM ContractCategories cc, Services s, Companies c WHERE cc.CategoryCode = 'SMC' AND s.ServiceCode = 'SRV-003' AND c.CompanyCode = 'DEFAULT'
UNION ALL SELECT CategoryID, ServiceID, 100.00, 120, CompanyID FROM ContractCategories cc, Services s, Companies c WHERE cc.CategoryCode = 'EMC' AND s.ServiceCode = 'SRV-005' AND c.CompanyCode = 'DEFAULT';

-- Sample System Costs
INSERT INTO SystemCost (CategoryID, SystemID, Cost, CompanyID)
SELECT CategoryID, SystemID, 500.00, CompanyID FROM ContractCategories cc, Systems s, Companies c WHERE cc.CategoryCode = 'AMC' AND s.SystemCode = 'FIRE-001' AND c.CompanyCode = 'DEFAULT'
UNION ALL SELECT CategoryID, SystemID, 750.00, CompanyID FROM ContractCategories cc, Systems s, Companies c WHERE cc.CategoryCode = 'AMC' AND s.SystemCode = 'CCTV-001' AND c.CompanyCode = 'DEFAULT'
UNION ALL SELECT CategoryID, SystemID, 300.00, CompanyID FROM ContractCategories cc, Systems s, Companies c WHERE cc.CategoryCode = 'SMC' AND s.SystemCode = 'ACC-001' AND c.CompanyCode = 'DEFAULT';

-- Sample Item Costs
INSERT INTO ItemCost (CategoryID, ItemID, Cost, CompanyID)
SELECT CategoryID, ItemID, 25.00, CompanyID FROM ContractCategories cc, Items i, Companies c WHERE cc.CategoryCode = 'AMC' AND i.ItemCode = 'ITM-001' AND c.CompanyCode = 'DEFAULT'
UNION ALL SELECT CategoryID, ItemID, 150.00, CompanyID FROM ContractCategories cc, Items i, Companies c WHERE cc.CategoryCode = 'AMC' AND i.ItemCode = 'ITM-002' AND c.CompanyCode = 'DEFAULT'
UNION ALL SELECT CategoryID, ItemID, 10.00, CompanyID FROM ContractCategories cc, Items i, Companies c WHERE cc.CategoryCode = 'SMC' AND i.ItemCode = 'ITM-003' AND c.CompanyCode = 'DEFAULT';

-- Sample Holidays
INSERT INTO Holidays (HolidayName, HolidayDate, Description, CompanyID, Status)
SELECT 'Eid Al-Fitr', '2026-04-10', 'Eid Al-Fitr celebration', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'Eid Al-Adha', '2026-06-17', 'Eid Al-Adha celebration', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT'
UNION ALL SELECT 'National Day', '2026-12-16', 'Bahrain National Day', CompanyID, true FROM Companies WHERE CompanyCode = 'DEFAULT';

-- Sample Customer Systems
INSERT INTO CustomerSystems (CustomerID, SystemID, SystemType, SerialNumber, InstallDate, Status, Notes)
SELECT CustomerID, SystemID, 'Fire Alarm', 'FA-2026-001', '2026-01-15', true, 'Main building installation' FROM Customers c, Systems s WHERE c.CustomerCode = 'CUST-001' AND s.SystemCode = 'FIRE-001'
UNION ALL SELECT CustomerID, SystemID, 'CCTV', 'CCTV-2026-001', '2026-01-15', true, '16 cameras installed' FROM Customers c, Systems s WHERE c.CustomerCode = 'CUST-001' AND s.SystemCode = 'CCTV-001'
UNION ALL SELECT CustomerID, SystemID, 'Access Control', 'ACC-2026-001', '2026-02-01', true, 'Main entrance' FROM Customers c, Systems s WHERE c.CustomerCode = 'CUST-002' AND s.SystemCode = 'ACC-001'
UNION ALL SELECT CustomerID, SystemID, 'PA System', 'PA-2026-001', '2026-03-10', true, 'Warehouse area' FROM Customers c, Systems s WHERE c.CustomerCode = 'CUST-003' AND s.SystemCode = 'PA-001';

-- Sample Service Contracts
INSERT INTO ServiceContracts (CustomerID, CustomerSystemID, CategoryID, ContractPeriod, Frequency, StartDate, EndDate, Status, Notes)
SELECT cs.CustomerID, cs.CustomerSystemID, cc.CategoryID, 12, 3, '2026-01-15', '2027-01-15', true, 'Annual maintenance contract' FROM CustomerSystems cs, ContractCategories cc WHERE cs.SystemType = 'Fire Alarm' AND cc.CategoryCode = 'AMC'
UNION ALL SELECT cs.CustomerID, cs.CustomerSystemID, cc.CategoryID, 6, 1, '2026-01-15', '2026-07-15', true, 'Quarterly service' FROM CustomerSystems cs, ContractCategories cc WHERE cs.SystemType = 'CCTV' AND cc.CategoryCode = 'SMC'
UNION ALL SELECT cs.CustomerID, cs.CustomerSystemID, cc.CategoryID, 12, 6, '2026-02-01', '2027-02-01', true, 'Annual maintenance' FROM CustomerSystems cs, ContractCategories cc WHERE cs.SystemType = 'Access Control' AND cc.CategoryCode = 'AMC';

-- Sample Sales Master
INSERT INTO SalesMaster (SalesDate, CustomerID, CategoryID, PlanType, Description, TotalAmount, CompanyID, Status)
SELECT '2026-01-15', CustomerID, CategoryID, 'Plan', 'Initial installation of fire alarm system', 500.00, CompanyID, true FROM Customers c, ContractCategories cc, Companies co WHERE c.CustomerCode = 'CUST-001' AND cc.CategoryCode = 'AMC' AND co.CompanyCode = 'DEFAULT'
UNION ALL SELECT '2026-01-20', CustomerID, CategoryID, 'Plan', 'CCTV system installation', 750.00, CompanyID, true FROM Customers c, ContractCategories cc, Companies co WHERE c.CustomerCode = 'CUST-001' AND cc.CategoryCode = 'AMC' AND co.CompanyCode = 'DEFAULT'
UNION ALL SELECT '2026-02-01', CustomerID, CategoryID, 'Plan', 'Access control system', 300.00, CompanyID, true FROM Customers c, ContractCategories cc, Companies co WHERE c.CustomerCode = 'CUST-002' AND cc.CategoryCode = 'AMC' AND co.CompanyCode = 'DEFAULT';

-- Sample Sales Master Systems
INSERT INTO SalesMasterSystems (SalesNo, SystemID, Quantity, Cost)
SELECT SalesNo, SystemID, 1, 500.00 FROM SalesMaster sm, Systems s WHERE sm.Description LIKE '%fire alarm%' AND s.SystemCode = 'FIRE-001'
UNION ALL SELECT SalesNo, SystemID, 1, 750.00 FROM SalesMaster sm, Systems s WHERE sm.Description LIKE '%CCTV%' AND s.SystemCode = 'CCTV-001'
UNION ALL SELECT SalesNo, SystemID, 1, 300.00 FROM SalesMaster sm, Systems s WHERE sm.Description LIKE '%access control%' AND s.SystemCode = 'ACC-001';

-- Sample Complaints
INSERT INTO Complaints (SalesNo, ComplaintDate, Description, Status, Resolution)
SELECT SalesNo, '2026-02-10', 'False alarm triggered multiple times', 'Resolved', 'Sensor sensitivity adjusted' FROM SalesMaster WHERE Description LIKE '%fire alarm%'
UNION ALL SELECT SalesNo, '2026-03-05', 'Camera 3 not recording', 'In Progress', 'Technician dispatched' FROM SalesMaster WHERE Description LIKE '%CCTV%';
