const fs = require('fs')

function readStore() {
  try {
    const source = fs.readFileSync(process.env.DB_PATH, 'utf8')
    const data = JSON.parse(source) || null
    return data
  } catch (error) {
    throw new Error(error.message)
  }
}
module.exports = readStore
