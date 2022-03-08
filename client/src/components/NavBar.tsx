import React from 'react';

export default function NavBar(props: { createClick: () => any }) {
  return (
    <nav>
      <div className="message">Welcome back</div>
      <button onClick={props.createClick}>Add Weight</button>
    </nav>
  );
}
