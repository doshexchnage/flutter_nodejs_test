const Weight = require('../models/Weight');

const getWeightHistory = async (req, res) => {
  try {
      
    const weight = await Weight.find();

    res.status(201).send(weight);
} catch (error) {
    return res.status(400).json(error);
  }
};

module.exports = { getWeightHistory };
