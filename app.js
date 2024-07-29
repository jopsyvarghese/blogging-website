const express = require('express');
const db = require('./db');
const guestRoute = require('./routes/guestRoute');
const authRoute = require('./routes/authRoute');
const apiRoute = require('./routes/apiRoute');
const bodyParser = require('body-parser');
const session = require('express-session');
const ejs = require('ejs');
const authUser = require('./middlewares/authUser');

const app = express();
require('dotenv').config();

const PORT = process.env.PORT || 3000;

app.set('view engine', 'ejs');
app.use(express.static('public'));

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false } // true
  }));

app.use('/protected', authUser, authRoute);

app.use('/api', apiRoute);

app.use('/', guestRoute);

app.listen(PORT, ()=> {
console.log(`Server running on Port ${PORT}`);
});