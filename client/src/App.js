import { useState } from 'react'
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom'
import Header from './components/Header'
import UserActions from './components/UserActions'
import AddWeight from './components/AddWeight'
import WeightEntries from './components/WeightEntries'
import LoginForm from './components/LoginForm'
import RegistrationForm from './components/RegistrationForm'
// import APICalls from './components/APICalls'
import * as apiCalls from './components/APICalls'

const backendUrl = 'http://localhost:3000'
apiCalls.initApiCalls(backendUrl);

const App = () => {
  
  const APP_STATES = {
    LOGIN: 'login',
    REGISTER: 'register',
    WEIGHT_TRACKER: 'weightTracker'
  }

  const [appState, setAppState] = useState(APP_STATES.LOGIN)  

  const [weightHistory, setWeights] = useState([])

  // these weight functions could be improved with a switch
  const onAddWeight = async (weightValue) => {
    if (await apiCalls.saveWeight(weightValue)) {
      setWeights(await apiCalls.getWeightHistory());       
    }    
  }

  const onUpdateWeight = async (weight, newWeight) => {
    if (await apiCalls.updateWeight(weight, newWeight)) {
      setWeights(await apiCalls.getWeightHistory()) 
    }    
  }

  const onDeleteWeight = async (weight) => {
    if (await apiCalls.deleteWeight(weight)) {
      setWeights(await apiCalls.getWeightHistory()) 
    }    
  }

  return (
    <Router>
      <div className='container'>
        <Routes>
          <Route
            path='/'
            element={
              <>
                <Header />
                <UserActions 
                  loggedIn={(appState===APP_STATES.WEIGHT_TRACKER)}
                  register={(appState===APP_STATES.REGISTER)}
                  onRegister={() => {setAppState(APP_STATES.REGISTER)}}
                  onLogin={() => {setAppState(APP_STATES.LOGIN)}}
                  onLogout={() => {apiCalls.logout();setAppState(APP_STATES.LOGIN);}}
                />
                {appState === APP_STATES.LOGIN && 
                  <LoginForm
                    apiLogin={apiCalls.login}
                    nextState={async () => {setAppState(APP_STATES.WEIGHT_TRACKER);
                    setWeights( await apiCalls.getWeightHistory());
                    }}
                  />
                }
                {appState === APP_STATES.REGISTER && 
                  <RegistrationForm
                    apiRegister={apiCalls.register}
                    nextState={() => {setAppState(APP_STATES.LOGIN)}}
                  />
                }
                {appState === APP_STATES.WEIGHT_TRACKER && 
                  <>
                    <AddWeight 
                      onAdd={onAddWeight}
                    /> 
                    { weightHistory.length > 0 ? (
                        <WeightEntries 
                          weightHistory={weightHistory}
                          onDelete={onDeleteWeight}
                          onUpdate={onUpdateWeight}
                        />
                      ): (
                        'No weight history found.'
                      )

                    }
                  </>
                }
              </>
            }
          />
        
        </Routes>
        
      </div>
    </Router>
  )
}

export default App
