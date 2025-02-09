const { register, login } = require("../controller/user.controller.js");

const router = require("express").Router();

router.post("/registration", register);
router.post("/login", login);

module.exports = router;
