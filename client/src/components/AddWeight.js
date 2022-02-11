import { useState } from 'react'

const AddWeight = ({ onAdd }) => {
  const [text, setText] = useState('')

  const onSubmit = (e) => {
    e.preventDefault()

    if (!text) {
      alert('Please enter your weight')
      return
    }

    if (isNaN(text)) {
      alert('Please enter a number')
      return
    }

    onAdd(Number(text))

    setText('')
  }

  return (
    <form onSubmit={onSubmit}>
      
      <div className = 'form-control' style={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
      }}>
          <input
            type='text'
            placeholder='Add Weight'
            value={text}
            onChange={(e) => setText(e.target.value)}
          />
          <input 
            type='submit' 
            value='Save Weight' 
            className='btn btn-block' 
          />
      </div>
    </form>
  )
}

export default AddWeight
