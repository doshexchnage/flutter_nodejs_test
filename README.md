Run a simple weight-tracker app server.

//create a .env file with the following entries
DB_PATH=./store/store.json
TOKEN_SECRET=YOUR_SECRET

HOW TO OBTAIN 'YOUR_SECRET'
//run require('crypto').randomBytes(64).toString('hex') in a node.js env

//create an empty {} json file on preferred DB_PATH


//CMD -> node index.js