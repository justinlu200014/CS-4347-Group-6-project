import React from 'react';
import { useNavigate } from 'react-router-dom';
import { auth } from '../firebaseConfig';
import './Quit.css';

function Quit({ setUser }) {
  const navigate = useNavigate();

  const handleLogout = async () => {
    try {
      await auth.signOut();
      setUser(null); // Explicitly update user state in App
      navigate('/'); // Redirect to home page
    } catch (error) {
      console.error("Error during logout:", error);
    }
  };

  return (
    <div className="quit-container">
      <div className="quit-content">
        <h1 className="quit-title">Ready to Leave?</h1>
        <p className="quit-message">Thank you for using the Student Database System</p>
        <button
          onClick={handleLogout}
          className="logout-button"
        >
          Logout
        </button>
      </div>
    </div>
  );
}

export default Quit;