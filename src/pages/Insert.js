import React, { useState } from 'react';
import './Query.css';
import axios from 'axios';

function Insert() {
  const [query, setQuery] = useState('');
  const [submittedQuery, setSubmittedQuery] = useState('');
  const [selectQuery, setSelectQuery] = useState('');
  const [tableData, setTableData] = useState([]);
  const [error, setError] = useState(null);

  const handleQueryChange = (e) => {
    setQuery(e.target.value);
  };

  const handleQuerySubmit = async (e) => {
    e.preventDefault();
    setSubmittedQuery(query);
  
    try {
      const response = await axios.post('http://localhost:5000/execute-query', { query });
      const { message, data } = response.data;
  
      // Set the message containing the select query and the resulting data if successful
      setSelectQuery(message); // Show the SELECT query used
      setTableData(data); // Show the data retrieved from the SELECT query
      setError(null);
    } catch (error) {
      console.error("Query execution error:", error);
      if (error.response && error.response.data && error.response.data.error) {
        setError(`SQL Error: ${error.response.data.error}`); // Display SQL error message
      } else {
        setError("Error executing the query. Please check the syntax and try again.");
      }
      setTableData([]); // Clear results on error
      setSelectQuery(''); // Clear select query message on error
    }
  
    setQuery(''); // Clear the query input
  };
  
  return (
    <div className="query-container">
      <h2 className="query-heading">Insert Page</h2>
      <p className="query-description">Enter a SQL query to insert data into the database.</p>

      <form className="query-form" onSubmit={handleQuerySubmit}>
        <textarea
          id="query"
          value={query}
          onChange={handleQueryChange}
          placeholder="Type your SQL INSERT query here"
          className="query-input"
          rows="4"
          required
        />
        <button type="submit" className="query-submit">Submit Query</button>
      </form>

      {submittedQuery && (
        <div className="query-results">
          <h3 className="submitted-query">Query Submitted: {submittedQuery}</h3>
          {error && <p className="error-message">{error}</p>}

          {!error && selectQuery && (
            <>
              <h4 className="table-heading">Executed Query: {selectQuery}</h4>
              <table className="results-table">
                <thead>
                  <tr>
                    {tableData.length > 0 &&
                      Object.keys(tableData[0]).map((key) => <th key={key}>{key}</th>)
                    }
                  </tr>
                </thead>
                <tbody>
                  {tableData.length > 0 ? (
                    tableData.map((row, index) => (
                      <tr key={index}>
                        {Object.values(row).map((cell, idx) => (
                          <td key={idx}>{cell}</td>
                        ))}
                      </tr>
                    ))
                  ) : (
                    <tr>
                      <td colSpan="4">No results found</td>
                    </tr>
                  )}
                </tbody>
              </table>
            </>
          )}
        </div>
      )}
    </div>
  );
}

export default Insert;
