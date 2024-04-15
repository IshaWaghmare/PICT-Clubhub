const {
  createMiniEvent,
  getMiniEvents,
} = require("../controller/minievent.controller.js");

const router = require("express").Router();

router.post("/createEvent", createMiniEvent);
router.get("/getEvents", getMiniEvents);

module.exports = router;
