const { User } = require("../../models");
const router = require("express").Router();
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

router.post("/login", async (req, res) => {
  console.log(req.body);
  if (req.body.password == "admin" && req.body.user == "admin") {
    //* Create & assign a token
    const token = jwt.sign("admin", "This is the TOKEN_SECRET");
    console.log("here");

    res.header("auth-token", token);
    res.status(201).redirect("/dashboard.html");
  } else res.status(400).send("Invalid password");
});

module.exports = router;
