const bodyParser = require("body-parser");
const express = require("express");
const app = express();
const userRouter = require("./routers/user.routers.js");
const eventRouter = require("./routers/event.routers.js");
const miniEventRouter = require("./routers/minievent.routes.js");

app.use(bodyParser.json());

app.use("/", userRouter);
app.use("/", eventRouter);
app.use("/", miniEventRouter);

module.exports = app;
