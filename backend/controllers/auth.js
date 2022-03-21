const Weight = require('../models/Weight');

const auth = async (req, res) => {
  try {

    let currentUser = res.locals.currentUser;
    
    if(!currentUser) return res.status(401).json({auth: false, message: 'Unauthorized'});
    
    jwt.verify(token, `${process.env.JWT_SECRET}`, (err, decodedtoken) => {
        if(err) return res.status(401).json({auth: false, message: err.message});
        res.status(200).json({auth: true, message: "Authorized"})
    });

} catch (error) {
    return res.status(400).json(error);
  }
};

module.exports = { auth };
