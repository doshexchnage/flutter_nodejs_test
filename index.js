require('dotenv').config()

const express = require('express')
const rootRouter = require('./routers')
var cors = require('cors') 
const swaggerUi = require("swagger-ui-express");
  swaggerDocument = require('./swagger.json');
const app = express()
const PORT = 3000



app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

app.use(cors())
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/api', rootRouter)

app.listen(PORT, (error) => {
  if (!error)
    console.log(
      'Server is Successfully Running, and App is listening on port ' + PORT,
    )
  else console.log("Error occurred, server can't start", error)
})
