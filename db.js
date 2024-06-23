const mysql = require('mysql2/promise');
require('dotenv').config();

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD, 
    database: process.env.DB_NAME
});

pool.getConnection((err, connection) => {
    if(err) {
        console.log('Error connecting to database');
        process.exit(1);
    } else {
        connection.release();
        console.log('Database connected successfully');
    }
});

module.exports = pool;

