import { Route, Routes, BrowserRouter, Navigate } from 'react-router-dom';
import { getToken } from '../helpers';
import Dashboard from './Dashboard';

import Login from './Login';
import Register from './Register';

export default function Layout() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route path="/sign_up" element={<Register />} />
        <Route path="/dashboard" element={<Dashboard />} />
        <Route
          path="/dashboard"
          element={
            !getToken() ? (
              <Navigate to="/login" />
            ) : (
              <Navigate to="/dashboard" />
            )
          }
        />
        <Route path="*" element={<Login />} />
      </Routes>
    </BrowserRouter>
  );
}
