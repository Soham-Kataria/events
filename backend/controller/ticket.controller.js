const express = require("express");
const app = express();
app.use(express.json());
const Ticket = require("../models/ticket.model.js");
const Event = require('../models/event.model.js');
const { now } = require("mongoose");

exports.updateticket = async (req, res, next) => {
  try {
    const {
      ticketPrice,
      totalTickets,
      ticketsAvail,
      ticketsSold,
      ticketType,
      isFree,
      bookingStartLine,
      bookingDeadLine,
      status,
    } = req.body;
     const { eventId, ticketId } = req.params;
    const event = await Event.findById(eventId);
    const ticket = event.tickets.id(ticketId);

    if (!event) {
      return res.status(404).json({ message: "Event not found" });
    }

    if (!ticket) {
      return res.status(404).json({ message: "Ticket not found" });
    }

    const now = new Date();

    if (new Date(ticket.bookingStartLine) <= now) {
      return res.status(400).json({
        message: "Cannot update ticket. Booking has already started.",
      });
    }

    const validTypes = ['VIP', 'General', 'Early Bird'];
    const validStatuses = ["active", "inactive", "cancelled"];

    if (ticketType && !validTypes.includes(ticketType)) {
      return res.status(400).json({ message: "Invalid ticket type" });
    }

    if (status && !validStatuses.includes(status)) {
      return res.status(400).json({ message: "Invalid status" });
    }

    if (isFree !== undefined && typeof isFree !== "boolean") {
      return res.status(400).json({ message: "isFree must be a boolean" });
    }

    if (totalTickets !== undefined && totalTickets < ticket.ticketsSold) {
        return res.status(400).json({message: `totalTickets cannot be less than ticketsSold (${ticket.ticketsSold})`});
    }

    ticket.ticketPrice = ticketPrice ?? ticket.ticketPrice;
    ticket.totalTickets = totalTickets ?? ticket.totalTickets;
    ticket.ticketsAvail = ticketsAvail ?? ticket.ticketsAvail;
    ticket.ticketsSold = ticketsSold ?? ticket.ticketsSold;
    ticket.ticketType = ticketType??ticket.ticketType;
    ticket.isFree = isFree??ticket.isFree;
    ticket.bookingStartLine = bookingStartLine ?? ticket.bookingStartLine;
    ticket.bookingDeadLine = bookingDeadLine ?? ticket.bookingDeadLine;
    ticket.status = status??ticket.status;
   
    await event.save();

    res.status(200).json({ message: "Ticket updated", ticket })
   
  } 
  catch (error) {
    next(error)
  }
};


exports.getTickets = async (req,res,next) => {
  try {
    const event = await Event.findById(req.params.eventId);
    if (!event) {
      return res.status(404).json({ message: "Event not found" });
    }
    const tickets = event.tickets;

    if (!tickets || tickets.length==0) {
      return res.status(404).json({ message: "Event currently does not have any tickets" });
    }

    return res.status(200).json(tickets)

  } catch (error) {
    next(error);
  }
};

exports.deadLine = async (req, res, next) => {
  try {
    const { eventId, ticketId } = req.params;
    const event = await Event.findById(eventId);
    if (!event) {
      return res.status(404).json({ message: "Event not found" });
    }

    const ticket = event.tickets.id(ticketId);
    if (!ticket) {
      return res.status(404).json({ message: "Ticket not found" });
    }

    const bookingDeadline = new Date(ticket.bookingDeadLine);

    const intervalId = setInterval(() => {
      const now = new Date();
      const timeRemaining = bookingDeadline - now;

      if (timeRemaining <= 0) {
        clearInterval(intervalId);
        console.log("Booking deadline passed");
        return;
      }

      const days = Math.floor(timeRemaining / (1000 * 60 * 60 * 24));
      const hours = Math.floor((timeRemaining % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      const minutes = Math.floor((timeRemaining % (1000 * 60 * 60)) / (1000 * 60));
      const seconds = Math.floor((timeRemaining % (1000 * 60)) / 1000);

      console.log({ days, hours, minutes, seconds });

      // Stop when only 5 seconds are left
      if (seconds === 5 && minutes === 0 && hours === 0 && days === 0) {
        clearInterval(intervalId);
        console.log("Stopped at 5 seconds remaining.");
      }
    }, 1000);

    // Send initial response to client
    return res.json({
      message: "Countdown started on server (check console)",
    });
  } catch (error) {
    next(error);
  }
};




//  let date = new Date();
//     let days;
//     let hours;
//     let minutes;
//     let seconds;
//     let timeRemaining =ticket.bookingDeadLine - date;
//     const diff =()=>{

//       if(timeRemaining<0) return res.json({message:"Booking closed"})

//       days = Math.floor(timeRemaining / (1000 * 60 * 60 * 24));

//       hours = Math.floor((timeRemaining % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));

//       minutes = Math.floor((timeRemaining % (1000 * 60 * 60)) / (1000 * 60));

//       seconds = Math.floor((timeRemaining % (1000 * 60)) / 1000);

//       // timeRemaining = ticket.bookingDeadLine - date;
//       date=date-seconds;
//       console.log({day:days,hour:hours,minute:minutes,scond:seconds, Time:timeRemaining}) 
//     }
