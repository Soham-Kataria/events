const express = require('express')
const router = express.Router();

// const{createTicket, updateEvent} = require('../controller/event.controller.js')
const{auth} = require('../middlewares/auth.middleware.js');
const { updateticket, getTickets, deadLine } = require('../controller/ticket.controller.js');

router.patch('/:eventId/tickets/:ticketId/update', auth, updateticket);
router.get('/:eventId/tickets', auth, getTickets);
router.get('/:eventId/tickets/:ticketId', auth, deadLine);


module.exports = router;