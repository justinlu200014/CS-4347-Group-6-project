const express = require('express');
const sql = require('mssql');
const config = require('./dbConfig'); // Database configuration file
const cors = require('cors');

const app = express();
const port = 5000;

app.use(cors({
  origin: 'http://localhost:3000', // Your React app's domain
  methods: ['GET', 'POST'],
}));
app.use(express.json());

app.get('/', (req, res) => {
  res.send('Welcome to the SQL query execution server');
});

sql.connect(config).then(pool => {
  console.log('Connected to SQL Server');

  app.post('/execute-query', async (req, res) => {
    const { query } = req.body;

    const transaction = new sql.Transaction(pool);
    try {
      await transaction.begin(); // Start a transaction

      // Handle DELETE query
      if (/DELETE/i.test(query)) {
        const deleteMatch = query.match(/DELETE FROM (\w+)/i);
        if (!deleteMatch) {
          return res.status(400).send({ error: 'Failed to parse table name from query' });
        }
        const tableName = deleteMatch[1];

        // Get the affected rows before deletion
        const whereClauseMatch = query.match(/WHERE\s+(.+)/i);
        let affectedRowsBeforeDelete = [];
        let whereClause = '';
        
        if (whereClauseMatch) {
          whereClause = whereClauseMatch[1];
          const selectBeforeQuery = `SELECT * FROM ${tableName} WHERE ${whereClause}`;
          const selectResult = await transaction.request().query(selectBeforeQuery);
          affectedRowsBeforeDelete = selectResult.recordset;
        }

        // Execute the DELETE query
        const result = await transaction.request().query(query);

        // Execute the same SELECT query after deletion to confirm records are gone
        const confirmationQuery = `SELECT * FROM ${tableName} WHERE ${whereClause}`;
        const confirmationResult = await transaction.request().query(confirmationQuery);

        await transaction.commit();
        return res.json({
          message: `Successfully deleted ${result.rowsAffected[0]} rows`,
          affectedRows: affectedRowsBeforeDelete,
          rowsAffected: result.rowsAffected[0],
          confirmationQuery: confirmationQuery,
          confirmationResult: confirmationResult.recordset
        });
      }
      // Handle INSERT query
      if (/INSERT INTO/i.test(query)) {
        const insertMatch = query.match(/INSERT INTO (\w+)/i);
        if (!insertMatch) {
          return res.status(400).send({ error: 'Failed to parse table name from query' });
        }
        const tableName = insertMatch[1];

        await transaction.request().query(query);

        const pkQuery = `
          SELECT COLUMN_NAME
          FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
          JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
          ON TC.CONSTRAINT_TYPE = 'PRIMARY KEY' AND TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME
          WHERE KU.TABLE_NAME = @tableName
        `;
        const pkResult = await transaction.request()
          .input('tableName', sql.NVarChar, tableName)
          .query(pkQuery);

        const primaryKeys = pkResult.recordset.map(row => row.COLUMN_NAME);
        if (primaryKeys.length === 0) {
          return res.status(400).send({ error: `No primary key found for table ${tableName}` });
        }

        const valuesMatch = query.match(/\(([^)]+)\)\s+VALUES\s+\(([^)]+)\)/i);
        if (!valuesMatch) {
          return res.status(400).send({ error: 'Failed to parse column values from query' });
        }

        const columns = valuesMatch[1].split(',').map(col => col.trim());
        const values = valuesMatch[2].split(',').map(val => val.trim());

        const whereClauses = primaryKeys.map(pk => {
          const pkIndex = columns.indexOf(pk);
          if (pkIndex === -1) {
            throw new Error(`Primary key column ${pk} not found in INSERT columns`);
          }
          return `${pk} = ${values[pkIndex]}`;
        });
        const whereClause = whereClauses.join(' AND ');

        const selectQuery = `SELECT * FROM ${tableName} WHERE ${whereClause}`;
        const selectResult = await transaction.request().query(selectQuery);

        await transaction.commit(); // Commit the transaction
        return res.json({
          message: 'Executed INSERT query and retrieved inserted row.',
          data: selectResult.recordset
        });
      }

// Handle UPDATE query
if (/UPDATE/i.test(query)) {
  const updateMatch = query.match(/UPDATE (\w+)/i);
  if (!updateMatch) {
    return res.status(400).send({ error: 'Failed to parse table name from query' });
  }
  const tableName = updateMatch[1];

  // Fetch primary key columns
  const pkQuery = `
    SELECT COLUMN_NAME
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
    JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
    ON TC.CONSTRAINT_TYPE = 'PRIMARY KEY' AND TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME
    WHERE KU.TABLE_NAME = @tableName
  `;
  const pkResult = await transaction.request()
    .input('tableName', sql.NVarChar, tableName)
    .query(pkQuery);

  const primaryKeys = pkResult.recordset.map(row => row.COLUMN_NAME);
  if (primaryKeys.length === 0) {
    return res.status(400).send({ error: `No primary key found for table ${tableName}` });
  }

  // Parse WHERE clause to get affected row
  const whereClauseMatch = query.match(/WHERE\s+(.+)/i);
  if (!whereClauseMatch) {
    return res.status(400).send({ error: 'Failed to parse WHERE clause from query' });
  }
  const whereClause = whereClauseMatch[1];

  const selectBeforeQuery = `SELECT * FROM ${tableName} WHERE ${whereClause}`;
  const selectBeforeResult = await transaction.request().query(selectBeforeQuery);

  const updateResult = await transaction.request().query(query);

  const selectAfterQuery = `SELECT * FROM ${tableName} WHERE ${whereClause}`;
  const selectAfterResult = await transaction.request().query(selectAfterQuery);

  await transaction.commit(); // Commit the transaction

  const affectedRows = updateResult.rowsAffected[0];
  if (affectedRows > 0) {
    return res.json({
      message: `Successfully updated ${affectedRows} row(s)`,
      beforeUpdate: selectBeforeResult.recordset,
      afterUpdate: selectAfterResult.recordset
    });
  } else {
    return res.json({
      message: 'No rows were affected by the update',
      beforeUpdate: selectBeforeResult.recordset,
      afterUpdate: []
    });
  }
}


      // Handle SELECT query
      if (/SELECT/i.test(query)) {
        const result = await transaction.request().query(query);

        await transaction.commit(); // Commit the transaction
        return res.json(result.recordset);
      }      


      await transaction.commit(); // Commit the transaction

    } catch (err) {
      await transaction.rollback(); // Roll back the transaction on error
      console.error('Error executing query:', err);
      return res.status(500).send({ error: `Error executing SQL query: ${err.message}` });
    }
  });

}).catch(err => {
  console.error('Error connecting to database:', err);
  process.exit(1);
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
