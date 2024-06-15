const express = require('express');
const db = require('./config/db');
const User = require('./model/User');
const roomRoutes = require('./routes/roomRoute');
const bodyParser = require('body-parser');
const cors = require('cors');
const ejs = require('ejs');
// const session = require('express-session');
// var MongoDBStore = require('connect-mongodb-session')(session);

const app = express();

app.use(cors());  

// app.set('view engine','ejs');

// app.use(session({
//     secret: "This is a secret",
//     resave: false,
//     saveUninitialized: true,
//     // cookies:
// }))

app.use(bodyParser.json());

app.use('/room-booking',roomRoutes)

app.listen(2000,()=>{
    console.log("Connected to server at 2000");
});
