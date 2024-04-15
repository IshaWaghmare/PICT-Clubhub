const router = require("express").Router();
const { createEvent } = require("../controller/event.controller.js");
const upload = require("../middlewares/multer.middleware.js");

router.post("/createEvents", upload.single("EventImage"), createEvent);

module.exports = router;
