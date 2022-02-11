import Button from './Button'

const UserActions = ({ loggedIn, register, onLogin, onRegister, onLogout }) => {

  return (

    <div className='useractions'>
      {!loggedIn && (
        <Button
        color='green'
        text={register ? 'Login' : 'Sign up'}
        onClick={register? onLogin : onRegister}
        /> 
      )}
      {loggedIn && (
        <Button
          color='green'
          text={'Log out'}
          onClick={onLogout}
        />
      )}
    </div>
     
  )
}

export default UserActions
