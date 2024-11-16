import React from 'react';
import './Welcome.css';

const Welcome = ({ user, handleLogin }) => {
  return (
    <div className="welcome-container">
      <div className="welcome-content">
        <h1 className="welcome-title">Welcome!</h1>
        
        {user ? (
          <div className="user-info">
            <img
              src={user.photoURL}
              alt="Profile"
              className="profile-picture"
            />
            <p className="welcome-message">Hello, {user.displayName}!</p>
            <p className="welcome-description">
              Welcome to the Student Database. Use the sidebar to perform CRUD operations.
            </p>
          </div>
        ) : (
          <div className="guest-info">
            <p className="welcome-message">
              Please sign in to access the Student Database.
            </p>
            <button
              onClick={handleLogin}
              className="login-button"
            >
              Sign in with Google
            </button>
          </div>
        )}
      </div>
    </div>
  );
};

export default Welcome;
