const MiniEvent = require("../models/minievents.models.js");

exports.createMiniEvent = async (req, res) => {
  try {
    const { title, description, datetime, location, imageUrl, link } = req.body;

    const miniEvent = MiniEvent({
      title,
      description,
      datetime,
      location,
      imageUrl,
      link,
    });

    await miniEvent.save();

    res.status(201).json({ event: miniEvent });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.getMiniEvents = async (req, res) => {
  try {
    const miniEvents = await MiniEvent.find();

    res.status(200).json({ events: miniEvents.reverse() });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
