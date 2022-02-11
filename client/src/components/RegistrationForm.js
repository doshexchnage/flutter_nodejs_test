import { useState } from 'react'

const RegistrationForm = ({ apiRegister, nextState }) => {
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')

  const onSubmit = async (e) => {
    e.preventDefault()

    if (!username) {
      alert('Please enter username')
      return
    }

    if (!password) {
      alert('Please enter password')
      return
    }

    if (await apiRegister(username, password)) {
      nextState();
    }

    setUsername('')
    setPassword('')
  }

  return (
    <form onSubmit={onSubmit}>
      <div className = 'form-control-vertical' style={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
      }}>
          <input
            type='text'
            placeholder='Enter username'
            value={username}
            onChange={(e) => setUsername(e.target.value)}
          />
          <input
            type='password'
            placeholder='Enter password'
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
          <input 
            type='submit' 
            value='Sign up' 
            className='btn btn-block' 
          />
      </div>
    </form>
  )
}

export default RegistrationForm