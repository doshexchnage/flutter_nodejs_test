import React from 'react';
import { useNavigate } from 'react-router';
import { persistToken } from '../helpers';

export default function Footer() {
  const navigate = useNavigate();

  const handleLogout = () => {
    persistToken(null);
    navigate('/login');
  };

  return (
    <footer>
      <button className="btn--tertiary" onClick={handleLogout}>
        Logout 👋🏾
      </button>
    </footer>
  );
}
