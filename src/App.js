import React, { useEffect, useState } from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import Welcome from './pages/Welcome';
import Query from './pages/Query';
import Insert from './pages/Insert';
import Delete from './pages/Delete';
import Update from './pages/Update';
import Quit from './pages/Quit';
import { auth, provider, signInWithPopup } from './firebaseConfig';
import './App.css';

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
      <div className="flex min-h-screen bg-gray-50">
        <Sidebar isLoggedIn={!!user} />
        <div className="flex-1 ml-64">
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