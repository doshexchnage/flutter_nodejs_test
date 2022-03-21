const User = require('../models/User');
const Weight = require('../models/Weight');

const deleteWeight = async (req, res) => {
  try {
        
    const weight = await Weight.findById(req.params.id);
    
    if(weight === null) res.status(401).send({ message : "Weight not found" });
    
    Weight.deleteOne({ _id: req.params.id }, function(err) {
        if (!err) {
            res.status(200).send({ message : "Weight deleted" });
        } else {
            res.status(500).send({ message : "error" });
    }});

} catch (error) {
    return res.status(400).json(error);
}
};

module.exports = { deleteWeight };
