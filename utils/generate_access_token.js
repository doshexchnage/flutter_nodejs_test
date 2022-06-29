const jwt = require('jsonwebtoken')

function generateAccessToken(username) {
  return jwt.sign(username, process.env.TOKEN_SECRET)
}

module.exports = generateAccessToken
