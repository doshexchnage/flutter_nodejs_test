import React from 'react';
import { Navigate } from 'react-router-dom';

interface ProtecteRouterProps {
  token: string | null;
  children: any;
  [key: string]: any;
}
export default function ProtectedRoute(props: ProtecteRouterProps) {
  const { children, token } = props;

  if (!token) {
    <Navigate to="/login" />;
  }

  return children;
}
