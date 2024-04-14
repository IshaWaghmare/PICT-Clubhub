const mongoose = require("mongoose");
const bcrypt = require("bcrypt");
const db = require("../config/db.js");

const { Schema } = mongoose;

const userSchema = new Schema(
  {
    username: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      lowercase: true,
      required: true,
      unique: true,
    },
    password: {
      type: String,
      required: true,
      unique: true,
    },
    role: {
      type: String,
      default: "user",
      enum: ["user", "admin"],
    },
  },
  { timestamps: true }
);

userSchema.pre("save", async function (next) {
  try {
    // const salt = await(bcrypt.genSalt(10));
    const hashpass = await bcrypt.hash(this.password, 10);

    this.password = hashpass;
    next();
  } catch (error) {
    throw error;
  }
});

const User = db.model("User", userSchema);

module.exports = User;
