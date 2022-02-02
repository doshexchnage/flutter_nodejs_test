import React, { Component } from 'react';
import axios from 'axios';
import DatePicker from 'react-datepicker';
import "react-datepicker/dist/react-datepicker.css";
import Navbar from "../layout/Navbar";

export default class CreateWeight extends Component {
    constructor(props) {
        super(props);
        this.onChangeWeight = this.onChangeWeight.bind(this);
        this.onChangeDate = this.onChangeDate.bind(this);
        this.onSubmit = this.onSubmit.bind(this);

        this.state = {
            username: '',
            weight: 0,
            date: new Date(),
            users: []
        }
    }


    onChangeWeight(e) {
        this.setState({
            weight: e.target.value
        })
    }

    onChangeDate(date) {
        this.setState({
            date: date
        })
    }

    onSubmit(e) {
        e.preventDefault();

        const weight = {
            weight: this.state.weight,
            date: this.state.date
        }

        axios.post('http://localhost:5000/api/weights/add', weight)
            .then(res => console.log(res.data));

        window.location = '/get_weight_history';
    }

    render() {
        return (
            <div>
                <Navbar />
                <h3>Create New Weight Log</h3>
                <form onSubmit={this.onSubmit}>
                    <div className="form-group">
                        <label>Weight (in kg): </label>
                        <input
                            type="text"
                            className="form-control"
                            value={this.state.weight}
                            onChange={this.onChangeWeight}
                        />
                    </div>
                    <div className="form-group">
                        <label>Date: </label>
                        <div>
                            <DatePicker
                                selected={this.state.date}
                                onChange={this.onChangeDate}
                            />
                        </div>
                    </div>

                    <div className="form-group">
                        <input type="submit" value="Create Weight Log" className="btn btn-primary" />
                    </div>
                </form>
            </div>
        )
    }
}