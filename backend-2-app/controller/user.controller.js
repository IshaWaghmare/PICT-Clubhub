const User = require("../models/user.models.js");
const UserService = require("../services/user.services.js");
const bcrypt = require("bcrypt");

exports.register = async (req, res, next) => {
  try {
    const { username, email, password } = req.body;

    const success = await UserService.registerUser(username, email, password);

    res.json({ status: true, success: "User registered successfully" });
    return;
  } catch (error) {
    throw error;
  }
};

exports.login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    let user = await UserService.loginUser(email);

    if (!user) {
      throw new Error("User doesnt exist");
    }

    const isMatch = await bcrypt.compare(password, user.password);

    // const isMatch = await user.comparePassword(password);
    // const isMatch = await comparePasswords(password);
    if (isMatch == false) {
      throw new Error("Password Invalid!");
    }

    //store data in jwt
    let tokenData = { _id: User._id, email: User.email };

    const token = await UserService.generateToken(tokenData, "secretkey", "1d");

    res.status(200).json({
      status: true,
      success: "sendData",
      token: token,
      user: {
        id: user._id,
        username: user.username,
        email: user.email,
        role: user.role,
      },
    });
  } catch (error) {
    console.log(error, "err---->");
    throw error;
  }
};

// module.exports = register;
// module.exports = login;
