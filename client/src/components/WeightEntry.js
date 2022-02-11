import { useState} from 'react'
import { FaTimesCircle, FaEdit, FaUndo, FaCheck } from 'react-icons/fa'

const WeightEntry = ({ weight, onDelete, onUpdate }) => {

  const reactIconStyle = {cursor: 'pointer', height: 30, width: 30, float: 'right'}
  const [update, setUpdate] = useState(false)
  const [text, setText] = useState(weight.weight)
  
  const onUpdateConfirmed = async () => {

    if ((!text) || (isNaN(text))) {
      alert('Please enter valid weight value')
      return
    }

    onUpdate(weight, Number(text));
    setUpdate(false);
    
  }


  const defaultView = 
  <div
    className={'weight'}
  >
    <h3>
      {weight.weight}
      <pre style={{tabSize: 1}} >                   </pre>
      <FaEdit
        style={Object.assign({}, { color: 'blue'}, reactIconStyle)}
        onClick={() => {setUpdate(true)}}
      />
      <pre style={{tabSize: 4}} >  </pre>
      <FaTimesCircle
      style={Object.assign({}, { color: 'red'}, reactIconStyle)}
      onClick={() => onDelete(weight)}
      />
    </h3>
    
    
    
    <p>{new Date(weight.created_date).toLocaleString('en-UK')}</p>
  </div>

  const updateView = 
  <div
    className={'weight'}
  >
    <h3>
 
      <input
        type='text'
        placeholder='Update Weight'
        value={text}
        onChange={(e) => setText(e.target.value)}
        style={ {
          display: 'inline-flex',
          height: 30,
          width: '50%',          
          padding: '3px 7px',
          fontSize: 17
        }}

      />
      
      <FaCheck
          style={Object.assign({}, { color: 'green'}, reactIconStyle)}
          onClick={() => {onUpdateConfirmed()}}
      />
      <pre style={{tabSize: 1}} >     </pre>
      <FaUndo
          style={Object.assign({}, { color: 'blue'}, reactIconStyle)}
          onClick={() =>  setUpdate(false)}
      />
      
      
      
    </h3>
    
    
      
    <p>{new Date(weight.created_date).toLocaleString('en-UK')}</p>
  </div>

    

  return (update ? updateView : defaultView )
}

export default WeightEntry
