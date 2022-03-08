import { environment } from '../config';

export const PostAsync = (
  path: string,
  payload: any,
  headers?: { [key: string]: any }
) => {
  console.log({ headers: headers || GET_GLOBAL_HEADERS() });
  return fetch(environment.API_BASE_URL + path, {
    method: 'POST',
    headers: headers || GET_GLOBAL_HEADERS(),
    body: JSON.stringify(payload),
  });
};

export const EditAsync = (
  path: string,
  payload: any,
  headers?: { [key: string]: any }
) => {
  console.log({ headers: headers || GET_GLOBAL_HEADERS() });
  return fetch(environment.API_BASE_URL + path, {
    method: 'PUT',
    headers: headers || GET_GLOBAL_HEADERS(),
    body: JSON.stringify(payload),
  });
};

export const GetAsync = (path: string, headers?: { [key: string]: any }) => {
  console.log({ headers: headers || GET_GLOBAL_HEADERS() });
  return fetch(environment.API_BASE_URL + path, {
    method: 'GET',
    headers: headers || GET_GLOBAL_HEADERS(),
  });
};

export const DeleteAsync = (path: string, headers?: { [key: string]: any }) => {
  console.log({ headers: headers || GET_GLOBAL_HEADERS() });
  return fetch(environment.API_BASE_URL + path, {
    method: 'DElETE',
    headers: headers || GET_GLOBAL_HEADERS(),
  });
};

export const GET_GLOBAL_HEADERS = (): HeadersInit => {
  return {
    Authorization: 'Bearer ' + localStorage.getItem(environment.AUTH_STORE_KEY),
    'Content-Type': 'application/json',
  };
};

export const wait = async (seconds: number) => {
  return new Promise<void>((resolve) => {
    setTimeout(() => {
      resolve();
    }, seconds * 1000);
  });
};

export const persistToken = (token: string | null) => {
  if (!token) return localStorage.removeItem(environment.AUTH_STORE_KEY);

  localStorage.setItem(environment.AUTH_STORE_KEY, token);
};

export const getToken = () => {
  return localStorage.getItem(environment.AUTH_STORE_KEY);
};

export const formatDate = (date: string) => {
  return (
    new Date(date).toDateString() + ' / ' + new Date(date).toLocaleTimeString()
  );
};
