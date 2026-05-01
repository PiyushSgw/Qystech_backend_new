const fs = require('fs');
const path = require('path');
const { pool } = require('../config/database');

async function migrate() {
  try {
    console.log('Connecting to PostgreSQL...');
    await pool.connect();
    console.log('Connected successfully.');

    const schemaPath = path.join(__dirname, 'schema-postgres.sql');
    const schema = fs.readFileSync(schemaPath, 'utf8');

    console.log('Executing schema migration...');
    await pool.query(schema);
    console.log('Schema migration completed successfully.');

    console.log('Creating indexes for better performance...');
    
    // Create indexes for common queries
    const indexes = [
      'CREATE INDEX IF NOT EXISTS idx_customers_companyid ON Customers(CompanyID);',
      'CREATE INDEX IF NOT EXISTS idx_customers_areacodeid ON Customers(AreaCodeID);',
      'CREATE INDEX IF NOT EXISTS idx_salesmaster_customerid ON SalesMaster(CustomerID);',
      'CREATE INDEX IF NOT EXISTS idx_salesmaster_companyid ON SalesMaster(CompanyID);',
      'CREATE INDEX IF NOT EXISTS idx_salesmaster_salesdate ON SalesMaster(SalesDate);',
      'CREATE INDEX IF NOT EXISTS idx_servicecontracts_customerid ON ServiceContracts(CustomerID);',
      'CREATE INDEX IF NOT EXISTS idx_customersystems_customerid ON CustomerSystems(CustomerID);',
      'CREATE INDEX IF NOT EXISTS idx_complaints_salesno ON Complaints(SalesNo);',
      'CREATE INDEX IF NOT EXISTS idx_schedule_salesno ON Schedule(SalesNo);',
      'CREATE INDEX IF NOT EXISTS idx_schedule_date ON Schedule(ScheduleDate);',
      'CREATE INDEX IF NOT EXISTS idx_serviceengineers_companyid ON ServiceEngineers(CompanyID);',
      'CREATE INDEX IF NOT EXISTS idx_serviceteams_companyid ON ServiceTeams(CompanyID);',
    ];

    for (const index of indexes) {
      await pool.query(index);
    }
    console.log('Indexes created successfully.');

    console.log('Migration completed!');
  } catch (error) {
    console.error('Migration failed:', error);
    process.exit(1);
  } finally {
    await pool.end();
  }
}

migrate();
