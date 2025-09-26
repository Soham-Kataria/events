const express = require("express");
const dotenv = require("dotenv");
const cors = require("cors");

const userRoutes = require("./routes/user.routes");
const eventRoutes = require("./routes/event.routes.js");
const ticketRoutes = require("./routes/ticket.routes.js");
const orderRoutes = require("./routes/order.routes.js");
const paymentRoutes = require("./routes/payment.routes.js");
const qrRoutes = require("./routes/qr.routes");
// index.js inside routes folder
// index.js inside routes folder
// const errorHandler = require('./middlewares/errorHandler');
dotenv.config();
const app = express();
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/api/qr", qrRoutes);

app.use("/api/users", userRoutes);
app.use("/api/events", eventRoutes);
app.use("/api/events", ticketRoutes);
app.use("/api/users", orderRoutes);
app.use("/api/users", paymentRoutes);

module.exports = app;
