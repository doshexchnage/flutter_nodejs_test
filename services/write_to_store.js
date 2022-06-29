const fs = require('fs')
const readStore = require('../services/read_store')

function writeToStore(params) {
  try {
    const source = readStore()
    const mutated = Object.assign({}, source, params)
    return fs.writeFile(process.env.DB_PATH, JSON.stringify(mutated), () => {})
  } catch (error) {
    throw new Error(error.message)
  }
}
module.exports = writeToStore
