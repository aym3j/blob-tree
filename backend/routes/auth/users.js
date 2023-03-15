const { User } = require("../../models");
const router = require("express").Router();
const Joi = require("joi");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const verifyToken = require("./verifyToken");

const registerValidation = (data) => {
  const schema = Joi.object({
    nom: Joi.string().required(),
    prenom: Joi.string().required(),
    email: Joi.string().email().required(),
    password: Joi.string().required(),
  });

  return schema.validate(data);
};

const loginValidation = (data) => {
  const schema = Joi.object({
    email: Joi.string().email().required(),
    password: Joi.string().required(),
  });

  return schema.validate(data);
};

router.post("/register", async (req, res) => {
  //* validate the data
  const { error } = registerValidation(req.body);
  if (error) return res.status(400).json({ error: error.details[0].message });

  //* checking if the user is already in the database
  const emailExist = await User.findOne({ where: { email: req.body.email } });
  if (emailExist)
    return res.status(400).json({ error: "Email already exists" });

  //* hash passwords
  const salt = await bcrypt.genSalt(10);
  const hashPassword = await bcrypt.hash(req.body.password, salt);

  try {
    //* create a new user
    const user = await User.create({
      nom: req.body.nom,
      prenom: req.body.prenom,
      email: req.body.email,
      password: hashPassword,
    });

    const token = jwt.sign({ _id: user.id }, "This is the TOKEN_SECRET");

    res.header("auth-token", token);
    res.status(201).header("auth-token", token).json(user);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

router.post("/login", async (req, res) => {
  //* validate the data
  const { error } = loginValidation(req.body);
  if (error) return res.status(400).json({ error: error.details[0].message });

  //* checking if the email exists
  const user = await User.findOne({ where: { email: req.body.email } });
  if (!user)
    return res.status(400).json({ error: "Email or password is wrong" });

  //* Password is correct
  const validPass = await bcrypt.compare(req.body.password, user.password);
  if (!validPass) return res.status(400).json({ error: "Invalid password" });

  //* Create & assign a token
  const token = jwt.sign({ _id: user.id }, "This is the TOKEN_SECRET");

  res.header("auth-token", token);
  res.status(201).json(user);
});

router.patch("/", verifyToken, async (req, res) => {
  const { workshopId, currentState, futureState } = req.body;

  try {
    const user = await User.findOne({ where: { id: req.user._id } });

    console.log(user);

    if (workshopId) user.workshopId = workshopId;
    if (currentState) user.currentState = currentState;
    if (futureState) user.futureState = futureState;

    await user.save();

    res.json(user);
  } catch (err) {
    logger.error(err.message);
    res.status(400).json({ error: err.message });
  }
});

module.exports = router;
