import React, { useEffect, useState } from 'react';
import { BrowserRouter as Router, Routes, Route, useNavigate } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import Query from './pages/Query';
import Insert from './pages/Insert';
import Delete from './pages/Delete';
import Update from './pages/Update';
import Quit from './pages/Quit';
import { auth, provider, signInWithPopup } from './firebaseConfig';
import './App.css';

const Welcome = ({ user, handleLogin }) => {
  return (
    <div className="text-center p-8">
      <h1 className="text-5xl font-bold mb-6">Welcome!</h1>
      {user ? (
        <div>
          <p className="text-2xl mb-4">Hello, {user.displayName}</p>
          <img
            src={user.photoURL}
            alt="Profile"
            className="w-64 h-64 rounded-full mx-auto mb-6"
          />
          <p className="text-xl mb-6">Welcome to the Student Database. Use the sidebar to perform CRUD operations.</p>

        </div>
      ) : (
        <button
          onClick={handleLogin}
          className="px-6 py-3 bg-blue-500 text-white rounded hover:bg-blue-600 transition-colors"
        >
          Sign in with Google
        </button>
      )}
    </div>
  );
};

const App = () => {
  const [user, setUser] = useState(null);

  // Listen to auth state changes
  useEffect(() => {
    const unsubscribe = auth.onAuthStateChanged((user) => {
      setUser(user);
    });
    return () => unsubscribe();
  }, []);

  const handleLogin = async () => {
    try {
      const result = await signInWithPopup(auth, provider);
      setUser(result.user);
    } catch (error) {
      console.error("Error during sign-in", error);
    }
  };

  return (
    <Router>
      <div style={{ display: 'flex' }}>
        <Sidebar isLoggedIn={!!user} />
        <div style={{ marginLeft: '250px', padding: '20px' }}>
          <Routes>
            <Route
              path="/"
              element={<Welcome user={user} handleLogin={handleLogin} />}
            />
            <Route path="/query" element={<Query />} />
            <Route path="/insert" element={<Insert />} />
            <Route path="/delete" element={<Delete />} />
            <Route path="/update" element={<Update />} />
            <Route path="/quit" element={<Quit setUser={setUser} />} />
          </Routes>
        </div>
      </div>
    </Router>
  );
};

export default App;