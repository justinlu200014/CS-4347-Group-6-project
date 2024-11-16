import React, { useState } from 'react';
import axios from 'axios';
import './Query.css';

function Update() {
  const [query, setQuery] = useState('');
  const [submittedQuery, setSubmittedQuery] = useState('');
  const [beforeData, setBeforeData] = useState([]);  // To store "before" data
  const [afterData, setAfterData] = useState([]);    // To store "after" data
  const [error, setError] = useState(null);

  const handleQueryChange = (e) => {
    setQuery(e.target.value);
  };

  const handleQuerySubmit = async (e) => {
    e.preventDefault();
    setSubmittedQuery(query);

    try {
      const response = await axios.post('http://localhost:5000/execute-query', { query });

      if (response.data.beforeUpdate && response.data.afterUpdate) {
        setBeforeData(response.data.beforeUpdate);  // Set the "before" data
        setAfterData(response.data.afterUpdate);    // Set the "after" data
        setError(null);
      } else if (response.data.message === 'No rows were affected by the update.') {
        setBeforeData(response.data.beforeUpdate);  // Set the "before" data
        setAfterData([]);                          // No "after" data
        setError(response.data.message);
      }
    } catch (error) {
      console.error("Query execution error:", error);
      setError(error.response ? error.response.data.error : "Error executing the query. Please check the syntax and try again.");
      setBeforeData([]);  // Clear previous data in case of an error
      setAfterData([]);
    }

    setQuery('');
  };

  return (
    <div className="query-container">
      <h2 className="query-heading">Update Page</h2>
      <p className="query-description">Enter a SQL query to update data from the database.</p>

      <form className="query-form" onSubmit={handleQuerySubmit}>
        <textarea
          id="query"
          value={query}
          onChange={handleQueryChange}
          placeholder="Type your SQL UPDATE query here"
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
          
          {beforeData.length > 0 && (
            <div>
              <h4 className="table-heading">Before Update</h4>
              <table className="results-table">
                <thead>
                  <tr>
                    {Object.keys(beforeData[0]).map((key) => <th key={key}>{key}</th>)}
                  </tr>
                </thead>
                <tbody>
                  {beforeData.map((row, index) => (
                    <tr key={index}>
                      {Object.values(row).map((cell, idx) => <td key={idx}>{cell}</td>)}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}

          {afterData.length > 0 && (
            <div>
              <h4 className="table-heading">After Update</h4>
              <table className="results-table">
                <thead>
                  <tr>
                    {Object.keys(afterData[0]).map((key) => <th key={key}>{key}</th>)}
                  </tr>
                </thead>
                <tbody>
                  {afterData.map((row, index) => (
                    <tr key={index}>
                      {Object.values(row).map((cell, idx) => <td key={idx}>{cell}</td>)}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      )}
    </div>
  );
}

export default Update;
