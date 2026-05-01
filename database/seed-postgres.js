const fs = require('fs');
const path = require('path');
const { pool } = require('../config/database');

async function seed() {
  try {
    console.log('Connecting to PostgreSQL...');
    await pool.connect();
    console.log('Connected successfully.');

    const seedPath = path.join(__dirname, 'seed-postgres.sql');
    const seed = fs.readFileSync(seedPath, 'utf8');

    console.log('Executing seed data...');
    await pool.query(seed);
    console.log('Seed data inserted successfully.');

    console.log('Seeding completed!');
  } catch (error) {
    console.error('Seeding failed:', error);
    process.exit(1);
  } finally {
    await pool.end();
  }
}

seed();
