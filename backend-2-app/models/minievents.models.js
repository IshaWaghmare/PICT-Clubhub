const mongoose = require("mongoose");
const db = require("../config/db.js");

const { Schema } = mongoose;

const miniEventSchema = new Schema(
  {
    title: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    datetime: {
      type: String,
      required: true,
    },
    location: {
      type: String,
      required: true,
    },
    imageUrl: {
      type: String,
    },
    link: {
      type: String,
      required: true,
    },
  },
  { timestamps: true }
);

const MiniEvent = db.model("MiniEvent", miniEventSchema);

module.exports = MiniEvent;
