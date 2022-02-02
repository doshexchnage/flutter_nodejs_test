import React, { Component } from "react";
import { Link } from "react-router-dom";
import { logoutUser} from "../../actions/authActions";
import {connect} from "react-redux";
import PropTypes from "prop-types";

class Navbar extends Component {
    onLogoutClick = e => {
        e.preventDefault();
        this.props.logoutUser();
    };
  render() {
    return (
      <div className="navbar-fixed navbar-dark bg-dark navbar-expand-lg">
        <nav className="z-depth-0">

            <ul className="navbar-nav mr-auto">
              <li className="navbar-item">
                <Link to="/get_weight_history" className="nav-link">Weight Tracker</Link>
              </li>
              <li className="navbar-item">
                <Link to="/save_weight" className="nav-link">Create Weight</Link>
              </li>
                <li>
                    <button
                        style={{
                            width: "150px",
                            borderRadius: "3px",
                            letterSpacing: "1.5px",
                        }}
                        onClick={this.onLogoutClick}
                        className="btn ms-auto waves-effect waves-light hoverable red accent-3"
                    >
                        Logout
                    </button>
                </li>
            </ul>

        </nav>
      </div>
    );
  }
}

Navbar.propTypes = {
    logoutUser: PropTypes.func.isRequired,
    auth: PropTypes.object.isRequired
};

const mapStateToProps = state => ({
    auth: state.auth
});

export default connect(
    mapStateToProps,
    { logoutUser }
)(Navbar);


