import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';
import Navbar from "../layout/Navbar";


const Weight = props => (
    <tr>
        <td>{props.weight.username}</td>
        <td>{props.weight.weight}</td>
        <td>{props.weight.date.substring(0,10)}</td>
        <td>
            <Link to={"/edit/"+props.weight._id}>edit</Link> | <a href="/get_weight_history" onClick={() => { props.deleteWeight(props.weight._id) }}>delete</a>
        </td>
    </tr>
)

export default class WeightsList extends Component {
    constructor(props) {
        super(props);

        this.deleteWeight = this.deleteWeight.bind(this)

        this.state = {weights: []};
    }

    componentDidMount(id) {
        const token = localStorage.getItem('token');
        axios.get('http://localhost:5000/api/weights/', { headers: {"authorization" : `Bearer ${token}`} })
            .then(response => {
                this.setState({ weights: response.data })
            })
            .catch((error) => {
                console.log(error);
            })
    }

    deleteWeight(id) {
        axios.delete('http://localhost:5000/api/weights/'+id)
            .then(response => { console.log(response.data)});

        this.setState({
            weights: this.state.weights.filter(el => el._id !== id)
        })
    }

    weightList() {
        return this.state.weights.map(currentweight => {
            return <Weight weight={currentweight} deleteWeight={this.deleteWeight} key={currentweight._id}/>;
        })
    }

    render() {
        return (
            <div>
                <Navbar />
                <h3>Logged Weights</h3>
                <table className="table">
                    <thead className="thead-light">
                    <tr>
                        <th>Username</th>
                        <th>Weight</th>
                        <th>Date</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    { this.weightList() }
                    </tbody>
                </table>
            </div>
        )
    }
}