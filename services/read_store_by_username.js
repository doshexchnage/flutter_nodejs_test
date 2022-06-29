const readStore = require('../services/read_store')

function readStoreByUsername(username) {
  try {
    const source = readStore()
    const data = source[username] || null
    return data
  } catch (error) {
    throw new Error(error.message)
  }
}
module.exports = readStoreByUsername
