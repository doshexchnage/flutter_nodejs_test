import React from 'react';

export type FormEvent = React.FormEvent<HTMLFormElement>;
export type InputChangeEvent = React.ChangeEvent<HTMLInputElement>;

export type ErrorType = { message: string; level: 'warn' | 'danger' | 'bland' };
