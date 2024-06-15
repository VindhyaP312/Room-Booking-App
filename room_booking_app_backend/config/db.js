const mongoose = require('mongoose')

const url = `mongodb+srv://Vindhya:Vini%40123abc@cluster0.gge3izm.mongodb.net/roomBookingApplication?retryWrites=true&w=majority&appName=Cluster0`;

const connection = mongoose.connect(url)
    .then( () => {
        console.log('Connected to Mongo database ')
    })
    .catch( (err) => {
        console.error(`Error connecting to the Mongo database. \n${err}`);
    });
    
module.exports = connection;


