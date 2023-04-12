const router = require("express").Router();
const jwt = require("jsonwebtoken");
const Joi = require("joi");
const bcrypt = require("bcryptjs");

const verifyToken = (req, res, next) => {
  const token = req.cookies["auth-token"];

  try {
    const verified = jwt.verify(token, "This is the TOKEN_SECRET");
    req.user = verified;

    next();
  } catch (error) {
    res.render("./admin/login");
  }
};

const loginValidation = (data) => {
  const schema = Joi.object({
    username: Joi.string().required(),
    password: Joi.string().required(),
  });

  return schema.validate(data);
};

router.get("/", verifyToken, (req, res) => {
  res.render("./admin/dashboard");
});

router.get("/timer", (req, res) => {
  res.render("./admin/timer");
});

router.post("/", async (req, res) => {
  const { username, password } = req.body;

  //* validate the data
  const { error } = loginValidation(req.body);
  if (error) return res.status(400).json({ error: error.details[0].message });

  //* hash passwords
  const salt = await bcrypt.genSalt(10);
  const hashPassword = await bcrypt.hash(password, salt);

  //* Password is correct
  const validPass = await bcrypt.compare("admin", hashPassword);

  if (!validPass || username != "admin")
    return res.status(400).json({ error: "Invalid password" });

  //* Create & assign a token
  const token = jwt.sign("admin", "This is the TOKEN_SECRET");

  res.cookie("auth-token", token, {
    maxAge: 1000 * 60 * 60 * 24,
    httpOnly: true,
  });

  res.status(201).render("./admin/dashboard");
});

module.exports = router;
