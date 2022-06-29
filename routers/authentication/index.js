const express = require('express')
const { writeToStore, readStoreByUsername } = require('../../services')
const { generateAccessToken } = require('../../utils')

var router = express.Router()

router.post('/login', (req, res, next) => {
  try {
    // add validation
    const { email, password } = req.body
    let existingUser
    let token

    existingUser = readStoreByUsername(email)

    if (!existingUser || existingUser.password != password) {
      const error = Error('Wrong password please check at once')
      return res.status(401).json({ success: false, message: error.message })
    }

    //Creating jwt token
    token = generateAccessToken(email)
    res.status(200).json({
      success: true,
      data: {
        email,
        token,
      },
    })
  } catch (e) {
    const error = new Error('Unable to login user')
    return res.status(401).json({ success: false, message: error.message })
  }
})

router.post('/signup', (req, res, next) => {
  let token
  const { name, email, password } = req.body
  const newUser = {
    [email]: {
      name,
      email,
      password, //TODO: hash password
    },
  }

  try {
    existingUser = readStoreByUsername(email)
    if (existingUser) {
      const error = Error('User already registered')
      return res.status(401).json({ success: false, message: error.message })
    }

    writeToStore(newUser)
    token = generateAccessToken(email)

    res.status(200).json({
      success: true,
      data: { name, email, token },
    })
  } catch (e) {
    const error = Error('unable to signup user')
    return res.status(401).json({ success: false, message: error.message })
  }
})

module.exports = router
