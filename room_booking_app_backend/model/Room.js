const mongoose = require('mongoose')
// const db = require('../config/db')

const roomSchema = new mongoose.Schema({
//roomNumber,purpose,clubName
roomNumber:{
    type:String,
    required:true
},
purpose:{
    type:String,
    required:true
},
clubName:{
    type:String,
    required:true
}
});

const Room = mongoose.model('room',roomSchema);

module.exports = Room;