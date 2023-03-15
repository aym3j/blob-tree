const router = require("express").Router();
const verify = require("./auth/verifyToken");
const { Workshop } = require("../models");

router.get("/", async (req, res) => {
  try {
    const workshops = await Workshop.findAll();

    res.status(200).json(workshops.map((e) => e.workshopId));
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

router.get("/active", async (req, res) => {
  try {
    const workshops = await Workshop.findAll({ where: { active: true } });

    res.status(200).json(workshops.map((e) => e.workshopId));
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

router.post("/", async (req, res) => {
  try {
    //* create a new workshop
    const workshop = await Workshop.create({
      workshopId: req.body.workshopId,
    });

    res.status(201).json(workshop);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

router.patch("/", async (req, res) => {
  console.log(req.body);

  try {
    const workshop = await Workshop.findOne({
      where: { workshopId: req.body.workshopId },
    });

    workshop.active = req.body.active;

    await workshop.save();

    res.json(workshop);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

module.exports = router;
