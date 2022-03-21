const User = require('../models/User');
const bcrypt = require("bcryptjs");
const jwt = require('jsonwebtoken');

const login = async (req, res) => {
  try {

    const { email, password } = req.body;

    const existingUser = await User.findOne({ emai: email });

    if(!existingUser) {
      return res.status(400).send('The user not found');
    }

    const isMatch =  bcrypt.compareSync(password, existingUser.password);

    if (!isMatch) {
      return res.status(400).send({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: existingUser._id, email: existingUser.email }, process.env.JWT_SECRET);

    let newuserobj = {
      ...existingUser,
      token: token,
    }

    res.status(201).json(newuserobj);
  } catch (error) {
    return res.status(400).json(error);
  }
};

module.exports = { login };
