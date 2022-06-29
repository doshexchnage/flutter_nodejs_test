var express = require('express');
var rootRouter = express.Router();

const auth = require('./authentication')
const weight = require('./weight')

rootRouter.use('/auth', auth);
rootRouter.use('/weight', weight);

module.exports = rootRouter;