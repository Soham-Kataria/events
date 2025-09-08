const express = require("express");
const app = express();
app.use(express.json());
// const User = re
const Event = require("../models/event.model.js");
const Ticket = require("../models/ticket.model.js");
const Order = require("../models/order.model.js");


exports.setOrder=async (req,res,next) => {
    try {
        const userId = req.user.id;
        const {eventId,ticketId} = req.params;
        const event = await Event.findById(eventId);
        
        if (!event) {
            return res.status(404).json({ message: "Event not found" });
        }
        const ticket = event.tickets.id(ticketId);

        if (!ticket) {
            return res.status(404).json({ message: "Ticket not found" });
        }
        const {quantity,isScanned}= req.body;

        if (quantity <= 0) {
            return res.status(400).json({ message: "Quantity must be greater than 0" });
        }

        
        if (ticket.ticketsAvail < quantity) {
            return res.status(400).json({ message: "Not enough tickets available" });
        }
        ticket.ticketsAvail -= quantity;
        ticket.ticketsSold += quantity;
        const totalPrice = ticket.isFree? 0 : quantity * ticket.ticketPrice;
        console.log(totalPrice);

        const order = await Order.create({userId,eventId,ticketId,quantity,isScanned,totalPrice});
        await event.save();
        res.json(order)
        // console.log(ticket);
        
    } catch (error) {
        next(error)
    }
}



exports.getOrders = async (req,res,next) => {
    try {
        const orders = await Order.find({userId: req.user.id});
        return res.json(orders);
    } catch (error) {
        next(error);
    }
}

exports.getEventOrder = async (req,res,next) => {
    try {
        const {eventId} = req.params;
        // const event = await Event.findById(eventId);
        const orders = await Order.find({eventId:eventId});
        return res.json(orders);
        

    } catch (error) {
        
    }
}
exports.cancelOrder = async (req, res, next) => {
  try {
    const order = await Order.findById(req.params.id);
    // console.log(req.params.id)

    if (!order) {
        return res.status(404).json({ message: "Order not found" });
    }
    // Find the event
    const event = await Event.findById({_id:order.eventId});
    if (!event) {
      return res.status(404).json({ message: "Event not found" });
    }
    // Find the embedded ticket
    const ticket = event.tickets.id(order.ticketId);
    if (!ticket) {
      return res.status(404).json({ message: "Ticket not found" });
    }

    // Find the order
    

    // Update ticket stats
    ticket.ticketsAvail += order.quantity;
    ticket.ticketsSold -= order.quantity;

    await event.save();
    await order.deleteOne();

    return res.status(200).json({ message: "Order deleted successfully" , order });
  } catch (error) {
    next(error);
  }
};

exports.updateOrder = async (req,res,next) => {
    try {
        const orderId = req.params.id;

        const order = await Order.findById(orderId);
        console.log(order);
        
        if (!order) {
            return res.status(404).json({ message: "Order not found" });
        }
        if (order.status != 'Pending') {
            return res.status(400).json({ message: "Cannot make changes" });
        }
        const event = await Event.findById(order.eventId);
        
        if (!event) {
            return res.status(404).json({ message: "Event not found" });
        }
        const ticket = event.tickets.id(order.ticketId);

        if (!ticket) {
            return res.status(404).json({ message: "Ticket not found" });
        }
        const changes = req.body;      

        if (changes.quantity <= 0) {
            return res.status(400).json({ message: "Quantity must be greater than 0" });
        }

        ticket.ticketsAvail += order.quantity;
        ticket.ticketsSold -= order.quantity;

        if (ticket.ticketsAvail < changes.quantity) {
            return res.status(400).json({ message: "Not enough tickets available" });
        }

        ticket.ticketsAvail -= changes.quantity;
        ticket.ticketsSold += changes.quantity;
        const totalPrice = ticket.isFree? 0 : changes.quantity * ticket.ticketPrice;
        
        order.quantity = changes.quantity;
        order.totalPrice = totalPrice;


        await event.save();
        await order.save();

        console.log(totalPrice); 
            return res.status(200).json({
            message: "Order updated successfully",
            updatedOrder: order
        });

    } catch (error) {
        next(error)
    }
}