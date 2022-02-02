const mongoose = require("mongoose");
const Schema = mongoose.Schema



const WeightSchema = new Schema({
    username: {type: String, required: true,},
    weight: { type: Number, required: true},
    date: { type: Date, required: true},
}, {
    timestamps: true,
});

module.exports = Weight = mongoose.model('Weight', WeightSchema);