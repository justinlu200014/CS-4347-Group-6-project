import React, { useState } from 'react';
import './Query.css';
import axios from 'axios';

function Query() {
  const [query, setQuery] = useState('');
  const [submittedQuery, setSubmittedQuery] = useState('');
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
      setTableData(response.data);
      setError(null);
    } catch (error) {
      console.error("Query execution error:", error);
          // Check for SQL error in response
    const errorMessage = error.response && error.response.data && error.response.data.error
    ? error.response.data.error  // Make sure the error is being returned from your Express server
    : "Error executing the query. Please check the syntax and try again.";
  
  setError(errorMessage);
  setTableData([]); // Clear previous data in case of an error

    }
  

    setQuery(''); 
  };

  return (
    <div className="query-container">
      <h2 className="query-heading">Query Page</h2>
      <p className="query-description">Enter a SQL query to fetch data from the database.</p>

      <form className="query-form" onSubmit={handleQuerySubmit}>
        <textarea
          id="query"
          value={query}
          onChange={handleQueryChange}
          placeholder="Type your SQL query here :)"
          className="query-input"
          rows="4"
          required
        />
        <button type="submit" className="query-submit">Submit Query</button>
      </form>

      {submittedQuery && (
        <div className="query-results">
          <h3 className="submitted-query">Query Submitted: {submittedQuery}</h3>
          <h4 className="table-heading">Results</h4>
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
                  <td colSpan="4">
                    No results found or query error{error ? `: ${error}` : ''}
                  </td>
                </tr>
              )}
            </tbody>

          </table>
        </div>
      )}
    </div>
  );
}

export default Query;