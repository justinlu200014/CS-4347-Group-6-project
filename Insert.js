import React, { useState } from 'react';
import axios from 'axios';

function Insert() {
  const [query, setQuery] = useState('');
  const [responseData, setResponseData] = useState(null);
  const [errorMessage, setErrorMessage] = useState(null);

  // Handle query submission
  const handleQuerySubmit = async (e) => {
    e.preventDefault();

    // Reset previous response and error
    setResponseData(null);
    setErrorMessage(null);

    try {
      const response = await axios.post('http://localhost:5000/execute-query', { query });

      // Check if the response contains a message indicating insert/update
      if (response.data.beforeUpdate && response.data.afterUpdate) {
        setResponseData({
          message: 'Update Query Result:',
          beforeUpdate: response.data.beforeUpdate,
          afterUpdate: response.data.afterUpdate,
        });
      } else if (response.data.data) {
        setResponseData({
          message: 'Insert Query Result:',
          data: response.data.data,
        });
      } else {
        setErrorMessage('Unexpected response structure');
      }
    } catch (err) {
      console.error('Error:', err);
      setErrorMessage('Error executing query. Please check the console.');
    }
  };

  return (
    <div>
      <h1>Execute SQL Query (Insert / Update)</h1>

      <form onSubmit={handleQuerySubmit}>
        <div>
          <label>SQL Query:</label>
          <textarea
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            rows="4"
            cols="50"
            placeholder="Write your SQL Insert or Update query here..."
          ></textarea>
        </div>
        <button type="submit">Submit Query</button>
      </form>

      {errorMessage && <div style={{ color: 'red' }}>{errorMessage}</div>}

      {responseData && (
        <div>
          <h3>{responseData.message}</h3>
          {responseData.beforeUpdate && (
            <>
              <h4>Before Update:</h4>
              <pre>{JSON.stringify(responseData.beforeUpdate, null, 2)}</pre>
            </>
          )}
          {responseData.afterUpdate && (
            <>
              <h4>After Update:</h4>
              <pre>{JSON.stringify(responseData.afterUpdate, null, 2)}</pre>
            </>
          )}
          {responseData.data && (
            <>
              <h4>Inserted Row:</h4>
              <pre>{JSON.stringify(responseData.data, null, 2)}</pre>
            </>
          )}
        </div>
      )}
    </div>
  );
}

export default Insert;
