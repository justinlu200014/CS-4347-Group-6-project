import React from 'react';
import { NavLink } from 'react-router-dom';
import { Link } from 'react-router-dom';
import './Sidebar.css';

const Sidebar = ({ isLoggedIn }) => {
  const navItems = [
    { path: '/query', text: 'Query' },
    { path: '/insert', text: 'Insert' },
    { path: '/delete', text: 'Delete' },
    { path: '/update', text: 'Update' },
    { path: '/quit', text: 'Quit' }
  ];

  return (
    <div className="sidebar">
      <Link to="/" className="logo-link">
        <img src="/sample-logo.png" alt="Logo" className="logo" />
      </Link>
      <nav>
        <ul className="navList">
          {navItems.map(({ path, text }) => (
            <li key={path}>
              <NavLink
                className={`navLink ${!isLoggedIn ? 'disabled' : ''}`}
                to={isLoggedIn ? path : '#'}
                onClick={(e) => !isLoggedIn && e.preventDefault()}
                style={!isLoggedIn ? {
                  pointerEvents: 'none',
                  opacity: 0.5,
                  cursor: 'not-allowed'
                } : {}}
              >
                {text}
              </NavLink>
            </li>
          ))}
        </ul>
      </nav>
    </div>
  );
};

export default Sidebar;