const { Pool } = require('pg')
const pool = new Pool({
host:     process.env.POSTGRESQL_ADDON_HOST,
user:     process.env.POSTGRESQL_ADDON_USER,
password: process.env.POSTGRESQL_ADDON_PASSWORD,
database: process.env.POSTGRESQL_ADDON_DB,
port:     process.env.POSTGRESQL_ADDON_PORT,
allowExitOnIdle: true
})

module.exports = pool