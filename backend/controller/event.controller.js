const express = require("express");
const app = express();
app.use(express.json());
const Event = require("../models/event.model.js");
const Ticket = require("../models/ticket.model.js");

exports.createEvent = async (req, res, next) => {
  try {
    const {
      title,
      description,
      categories,
      eventStatus,
      venue,
      eventDate,
      endDate,
      tickets,
    } = req.body;
    const eventExists = await Event.findOne({ title });

    if (eventExists) {
      return res.status(400).json({ message: "Event already exists" });
    }

    const Tickets = tickets.map((ticket) => ({
      ...ticket,
      ticketsAvail: ticket.totalTickets,
    }));

    const event = await Event.create({
      title,
      description,
      categories,
      eventStatus,
      venue,
      eventDate,
      endDate,
      createdBy: req.user.id,
      tickets: Tickets,
    });

    return res.status(200).json({
      id: event._id,
      title: event.title,
      description: event.description,
      categories: event.categories,
      eventStatus: event.eventStatus,
      venue: event.venue,
      eventDate: event.eventDate,
      endDate: event.endDate,
      createdBy: event.createdBy,
      tickets: event.tickets,
    });
  } catch (error) {
    next(error);
  }
};

exports.updateEvent = async (req, res, next) => {
  try {
    const event = await Event.findById(req.params.id);

    if (!event) {
      return res.status(400).json({ message: "Event does not exists." });
    }

    (event.title = req.body.title || event.title),
      (event.description = req.body.description || event.description),
      (event.categories = req.body.categories || event.categories),
      (event.eventStatus = req.body.eventStatus || event.eventStatus);
    (event.venue = req.body.venue || event.venue),
      (event.eventDate = req.body.eventDate || event.eventDate),
      (event.endDate = req.body.endDate || event.endDate),
      (event.tickets = req.body.tickets || event.tickets);

    await event.save();

    return res
      .status(200)
      .json({
        message: "Event has updated",
        id: event._id,
        title: event.title,
        description: event.description,
        categories: event.categories,
        eventStatus: event.eventStatus,
        venue: event.venue,
        eventDate: event.eventDate,
        endDate: event.endDate,
        createdBy: event.createdBy,
        tickets: event.tickets,
      });
  } catch (error) {
    next(error);
  }
};

exports.getEvents = async (req, res, next) => {
  try {
    const events = await Event.find({});
    if (events.length === 0) {
      return res
        .status(400)
        .json({ message: "Event not fetched or Event list is empty" });
    }

    res.status(200).json(events);
  } catch (error) {
    next(error);
  }
};

exports.deleteEvent = async (req, res, next) => {
  try {
    const event = await Event.findById(req.params.id);
    if (!event) {
      return res.status(404).json({ message: "No events found" });
    }

    await Event.deleteOne({ _id: event.id });

    return res.status(200).json({
      title: event.title,
      message: "Event is deleted",
    });
  } catch (error) {
    next(error);
  }
};

exports.searchEvent = async (req, res, next) => {
  try {
    if (!req.body) {
      return res
        .status(404)
        .json({ message: "Please enter a Name of an Event." });
    }
    const event = await Event.findOne(req.body);
    if (!event) {
      return res.status(404).json({ message: "No events found" });
    }

    res.status(200).json(event);
  } catch (error) {
    next(error);
  }
};
