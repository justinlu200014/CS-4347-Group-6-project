import React, { useState } from 'react';
import axios from 'axios';
import './Query.css';

function Delete() {
  const [query, setQuery] = useState('');
  const [submittedQuery, setSubmittedQuery] = useState('');
  const [result, setResult] = useState(null);
  const [error, setError] = useState(null);

  const handleQueryChange = (e) => {
    setQuery(e.target.value);
  };

  const handleQuerySubmit = async (e) => {
    e.preventDefault();
    setSubmittedQuery(query);
    setResult(null);
    setError(null);

    try {
      const response = await axios.post('http://localhost:5000/execute-query', { query });
      
      if (response.data.error) {
        setError(response.data.error);
      } else {
        setResult(response.data);
      }
    } catch (error) {
      setError(error.response?.data?.error || 'An error occurred while executing the query');
    }

    setQuery(''); // Reset query field after submission
  };

  return (
    <div className="query-container">
      <h2 className="query-heading">Delete Records</h2>
      <p className="query-description">
        Enter a SQL query to delete data from the database.
      </p>

      <form className="query-form" onSubmit={handleQuerySubmit}>
        <textarea
          id="query"
          value={query}
          onChange={handleQueryChange}
          placeholder="Type your DELETE statement here!"
          className="query-input"
          rows="4"
          required
        />
        <button type="submit" className="query-submit">Execute Delete</button>
      </form>

      {submittedQuery && (
        <div className="query-results">
          <h3 className="submitted-query">Executed Query: {submittedQuery}</h3>
          
          {error && (
            <div className="error-message">
              <h4>Error:</h4>
              <p>{error}</p>
            </div>
          )}

          {result && (
            <div className="success-message">
              <h4>Success:</h4>
              <p>{result.message}</p>
              
              {result.affectedRows && result.affectedRows.length > 0 && (
                <div className="deleted-rows">
                  <h4>Deleted Records:</h4>
                  <table className="results-table">
                    <thead>
                      <tr>
                        {Object.keys(result.affectedRows[0]).map((key) => (
                          <th key={key}>{key}</th>
                        ))}
                      </tr>
                    </thead>
                    <tbody>
                      {result.affectedRows.map((row, index) => (
                        <tr key={index}>
                          {Object.values(row).map((cell, idx) => (
                            <td key={idx}>{cell}</td>
                          ))}
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}

              {/* Confirmation Section */}
              <div className="confirmation-section">
                <h4>Deletion Confirmation</h4>
                <p>Confirmation Query: {result.confirmationQuery}</p>
                
                {result.confirmationResult && result.confirmationResult.length === 0 ? (
                  <div className="confirmation-message success">
                    <p>✓ Confirmed: Records were successfully deleted (no matching records found)</p>
                  </div>
                ) : (
                  <div className="confirmation-message warning">
                    <p>⚠ Warning: Some matching records still exist in the database</p>
                    {result.confirmationResult && result.confirmationResult.length > 0 && (
                      <table className="results-table">
                        <thead>
                          <tr>
                            {Object.keys(result.confirmationResult[0]).map((key) => (
                              <th key={key}>{key}</th>
                            ))}
                          </tr>
                        </thead>
                        <tbody>
                          {result.confirmationResult.map((row, index) => (
                            <tr key={index}>
                              {Object.values(row).map((cell, idx) => (
                                <td key={idx}>{cell}</td>
                              ))}
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    )}
                  </div>
                )}
              </div>
            </div>
          )}
        </div>
      )}

      <style jsx>{`
        .confirmation-section {
          margin-top: 20px;
          padding: 15px;
          border: 1px solid #ddd;
          border-radius: 4px;
        }

        .confirmation-message {
          margin-top: 10px;
          padding: 10px;
          border-radius: 4px;
        }

        .confirmation-message.success {
          background-color: #e8f5e9;
          color: #2e7d32;
        }

        .confirmation-message.warning {
          background-color: #fff3e0;
          color: #ef6c00;
        }

        .deleted-rows {
          margin-bottom: 20px;
        }
      `}</style>
    </div>
  );
}

export default Delete;