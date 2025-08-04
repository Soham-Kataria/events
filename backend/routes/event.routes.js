const express = require('express')
const router = express.Router()


const {createEvent, updateEvent, getEvents, deleteEvent, searchEvent} = require('../controller/event.controller.js');
const { hasRole, auth } = require('../middlewares/auth.middleware.js');

router.post('/createEvent',auth,createEvent);
router.patch('/updateEvent/:id',auth,hasRole(['manager','admin']),updateEvent);
router.get('/getEvents',getEvents);
router.get('/searchEvent',searchEvent);
router.delete('/deleteEvent/:id',auth,hasRole(['manager','admin']),deleteEvent);
module.exports = router;
