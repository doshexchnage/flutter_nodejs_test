import * as express from 'express';
import * as cors from 'cors';

// const router = require('./routes');
import Router from './routes';
import SetupDatabase from './database';
import { errorHandler } from './middlewares';

const app = express();

//Setup Middleware
app.use(cors());
app.use(express.json());

app.use(errorHandler);

//Setup router
Router(app);

//Setup Database
SetupDatabase();

//Start server
const PORT = process.env.PORT;
const target = 'localhost';
app.listen(PORT, () => console.log(`App started on ${target}:${PORT}`));
