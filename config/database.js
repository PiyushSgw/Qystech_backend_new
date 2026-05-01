const { Pool } = require('pg');
require('dotenv').config();

const config = {
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT) || 5433,
  database: process.env.DB_DATABASE || 'qsystech_db',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || 'admin',
};

const pool = new Pool(config);

const executeQuery = async (query, params = []) => {
  try {
    const result = await pool.query(query, params);
    return result.rows;
  } catch (error) {
    console.error('PostgreSQL Error:', error);
    throw error;
  }
};

const executeNonQuery = async (query, params = []) => {
  try {
    const result = await pool.query(query, params);
    return result.rowCount;
  } catch (error) {
    console.error('PostgreSQL Error:', error);
    throw error;
  }
};

const executeScalar = async (query, params = []) => {
  try {
    const result = await pool.query(query, params);
    if (result.rows && result.rows.length > 0) {
      return result.rows[0];
    }
    return null;
  } catch (error) {
    console.error('PostgreSQL Error:', error);
    throw error;
  }
};

const closeConnection = async () => {
  await pool.end();
};

module.exports = {
  executeQuery,
  executeNonQuery,
  executeScalar,
  closeConnection,
  pool
};
