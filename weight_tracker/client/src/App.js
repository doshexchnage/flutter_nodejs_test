import React, { Component } from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import jwt_decode from "jwt-decode";
import setAuthToken from "./utils/setAuthToken";
import { setCurrentUser, logoutUser } from "./actions/authActions";
import { Provider } from "react-redux";
import store from "./store";
import Landing from "./components/layout/Landing";
import Register from "./components/auth/Register";
import Login from "./components/auth/Login";
import PrivateRoute from "./components/private-route/PrivateRoute";
import EditWeight from "./components/dashboard/edit-weight.component";
import WeightsList from "./components/dashboard/weights-list.component";
import CreateWeight from "./components/dashboard/create-weight.component";
import "./App.css";

if (localStorage.jwtToken) {
  const token = localStorage.jwtToken;
  setAuthToken(token);
  const decoded = jwt_decode(token);
  store.dispatch(setCurrentUser(decoded));
  const currentTime = Date.now() / 1000;
  if (decoded.exp < currentTime) {
    store.dispatch(logoutUser());
    window.location.href = "./login";
  }
}


class App extends Component {
  render() {
    return (
      <Provider store={store}>
        <Router>
          <div className="App container_custom" >
            <Route exact path="/" component={Landing} />
            <Route exact path="/login" component={Login} />
            <Route exact path="/sign_up" component={Register} />
            <Switch>
              <PrivateRoute exact path="/get_weight_history" component={WeightsList} />
              <PrivateRoute exact path="/edit/:id" component={EditWeight} />
              <PrivateRoute exact path="/save_weight" component={CreateWeight} />
            </Switch>
          </div>
        </Router>
      </Provider>
    );
  }
}
export default App;
