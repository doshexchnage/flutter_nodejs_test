const User = require('../models/User');
const Weight = require('../models/Weight');

const saveWeight = async (req, res) => {
    
  try {

    // Request Body
    const { current_weight: current_weight } = req.body;

    // Validate Entered Weight
    if (!current_weight) {
      return res.status(400).json({ msg: "Please Enter Weight" });
    }
    
    // Create New Weight Entry
    const weight = await Weight.create({ current_weight: current_weight });

    res.status(201).send(weight);
} catch (error) {
    return res.status(400).json(error);
  }
};

module.exports = { saveWeight };
