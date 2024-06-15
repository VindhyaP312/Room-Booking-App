const express = require('express');
const router = express.Router();
const roomController = require('../controller/roomController');

//post
router.post('/book-a-room',roomController.bookRoom);

//get
router.get('/view-bookings',roomController.viewBookings);


module.exports = router;