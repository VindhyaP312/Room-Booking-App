const Room = require('../model/Room');

const bookRoom = async(req,res)=>{   //create
    try{
        const { roomNumber, purpose, clubName } = req.body;
        const room = new Room({
            roomNumber,
            purpose,
            clubName
        });
        await room.save();
        res.status(200).json(room);
    } catch(error){
        console.log("There is an error",error);
        res.status(500).json({message:'server error'})
    }
}

const viewBookings = async(req,res) =>{   //read
    try{
        const rooms = await Room.find();
        res.status(200).json(rooms);
    } catch(error){
        console.log("There is an error",error);
        res.status(500).json({message:'server error'})
    }
}

module.exports = { bookRoom, viewBookings };