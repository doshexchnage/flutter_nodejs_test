import React, { Component } from 'react';
import axios from 'axios';
import DatePicker from 'react-datepicker';
import "react-datepicker/dist/react-datepicker.css";

export default class EditWeight extends Component {
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

    componentDidMount() {
        axios.get('http://localhost:5000/api/weights/'+this.props.match.params.id)
            .then(response => {
                this.setState({
                    username: response.data.username,
                    weight: response.data.weight,
                    date: new Date(response.data.date)
                })
            })
            .catch(function (error) {
                console.log(error);
            })


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
            // username: this.state.username,
            weight: this.state.weight,
            date: this.state.date
        }


        axios.post('http://localhost:5000/api/weights/update/' + this.props.match.params.id, weight)
            .then(res => console.log(res.data));

        window.location = '/get_weight_history';
    }

    render() {
        return (
            <div>
                <h3>Edit Weight Log</h3>
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
                        <input type="submit" value="Edit Weight Log" className="btn btn-primary" />
                    </div>
                </form>
            </div>
        )
    }
}