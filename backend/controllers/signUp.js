const User = require('../models/User');
const jwt = require('jsonwebtoken');

const maxAge = 3 * 24 * 60 * 60;
const createToken = (id) => {
    return jwt.sign({ id }, process.env.JWT_SECRET, {
        expiresIn: maxAge
    }) 
};

const signUp = async (req, res) => {
  try {

    // Request Body
    const { name, email, password, confirm_password } = req.body;

    // Validate Name
    if (!name) {
      return res.status(400).json({ msg: "Please Enter Name" });
    }

    // Validate Email
    if (!email) {
      return res.status(400).json({ msg: "Please Enter Email" });
    }

    // Validate Password
    if (!password) {
      return res.status(400).json({ msg: "Please Enter Password" });
    }

    // Validate Confirm Password
    if (!confirm_password) {
      return res.status(400).json({ msg: "Please Enter Confirm Password" });
    }

    // Validate Password Length
    if (password.length < 6) {
      return res.status(400).json({ msg: "Password should be atleast 6 characters" });
    }

    // Check If Both Passwords Match
    if (password !== confirm_password) {
      return res.status(400).json({ msg: "Passwords do match" });
    }

    // Check If User Exists
    const existingUser = await User.findOne({ email });

    if (existingUser) {
      return res.status(400).json({ msg: "User Already Exists" });
    }
    
    // Create New User If User Doesnt Exist
    const newUser = await User.create({ name: name, email: email, password: password });
    const token = createToken(newUser._id);
    res.cookie('token', token, { httpOnly: true, maxAge: maxAge * 1000 });

    let newuserobj = { 
      name: newUser.name,
      email: newUser.email,
      password: newUser.password, 
      token: token 
    };

    res.status(201).json(newuserobj);
  } catch (error) {
    return res.status(400).json(error);
  }
};

module.exports = { signUp };
