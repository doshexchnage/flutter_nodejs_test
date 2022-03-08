import { ChangeEvent, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { persistToken, PostAsync, wait } from '../helpers';
import { IAuthPayload } from '../models/auth-payload.model';
import { ErrorType, FormEvent } from '../types';

export default function Login() {
  const [payload, setPayload] = useState<IAuthPayload>({} as IAuthPayload);
  const [response, setResponse] = useState<any>();

  const [error, setError] = useState<ErrorType>();

  const navigate = useNavigate();

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
    console.log(payload);

    try {
      const _response = await PostAsync('/auth/login', payload);
      const data = await _response.json();

      setResponse(data);

      if (data?.token) {
        persistToken(data?.token);

        await wait(1);
        navigate('/dashboard');
      }

      if (data?.invalidCredentials) {
        setError({
          message: 'Invalid credentails',
          level: 'danger',
        });
      }

      if (data?.validationError) {
        setError({
          message: 'Please enter valid details',
          level: 'danger',
        });
      }
    } catch (error) {
      setResponse('Error ' + JSON.stringify(error));
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        name="email"
        onChange={handleChange}
        placeholder="Email Address"
        required
      />
      <input
        type="password"
        name="password"
        onChange={handleChange}
        title="Need at least 6 characters"
        placeholder="Password"
        pattern=".{6,}"
        required
      />
      <button type="submit">Login</button>
      <Link to="/sign_up" className="link">
        Register
      </Link>

      {error && <output>{error.message}</output>}
    </form>
  );
}
