import React, { ChangeEvent, FormEvent, useRef, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { PostAsync, wait } from '../helpers';
import { IAuthPayload } from '../models/auth-payload.model';
import { ErrorType } from '../types';

export default function Register() {
  const [payload, setPayload] = useState<IAuthPayload>({} as IAuthPayload);
  const [response, setResponse] = useState<any>();

  const [error, setError] = useState<ErrorType>();

  const navigate = useNavigate();

  const loginRef = useRef<HTMLAnchorElement>(null);

  const handleChange = (event: ChangeEvent<HTMLInputElement>) => {
    const {
      target: { name, value },
    } = event;

    const _data: any = {
      ...payload,
      [name]: value,
    };

    setPayload(_data);
  };

  const handleSubmit = async (event: FormEvent) => {
    event.preventDefault();

    setError(undefined);

    if (!passwordMatch()) return;

    try {
      const _response = await PostAsync('/auth/sign_up', payload);
      const data = await _response.json();

      setResponse(data);

      if (response?.success) {
        await wait(1);

        navigate('/login');
      }

      if (data?.exist) {
        setError({
          message: 'Account already exist',
          level: 'warn',
        });
      }
    } catch (error) {
      setResponse('Error ' + JSON.stringify(error));
    }
  };

  const passwordMatch = () => {
    const match = payload.password === payload.confirm_password;

    if (!match) {
      setError({
        level: 'warn',
        message: 'Passwords do not match',
      });
    }

    return match;
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        name="fullname"
        onChange={handleChange}
        placeholder="Fullname"
        required
      />
      <input
        type="email"
        name="email"
        onChange={handleChange}
        placeholder="Email Address"
        required
      />
      <input
        type="password"
        name="password"
        placeholder="Password"
        onChange={handleChange}
        title="need at least 6 characters"
        pattern=".{6,}"
        required
      />
      <input
        type="password"
        name="confirm_password"
        placeholder="Confirm Password"
        onChange={handleChange}
        title="need at least 6 characters"
        pattern=".{6,}"
        required
      />

      <button type="submit">Register</button>
      <Link to="/login" ref={loginRef} className="link">
        Login
      </Link>

      {error && <output>{error.message}</output>}
    </form>
  );
}
