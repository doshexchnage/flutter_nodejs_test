const User = require('../models/User');
const Weight = require('../models/Weight');

const updateWeight = async (req, res) => {
  try {

    const user = await User.findById(res.locals.user);

    const updatedWeight = await Weight.findByIdAndUpdate(
        req.params.id, 
        {
            current_weight: req.body.current_weight,
            updated_at: Date.now(),
            updated_by: user._id
        }, 
        {
            runValidators: true, 
            new: true, 
        }
    );

    await updatedWeight.save();

    res.status(200).send({ message : "weight updated", weight: updatedWeight });
} catch (error) {
    return res.status(400).json(error);
  }
};

module.exports = { updateWeight };
