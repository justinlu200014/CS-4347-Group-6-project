const sql = require('mssql');
const config = require('./dbConfig');
/*
(async () => {
    try {
        await sql.connect(config);
        const result = await sql.query`select * from Dining`;
        console.log(result);
    } catch (err) {
        console.log("Error:", err);
    } finally {
        await sql.close();
    }
})();*/