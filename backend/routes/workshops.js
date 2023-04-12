const router = require("express").Router();
const { Workshop } = require("../models");

router.get("/", async (req, res) => {
  try {
    const workshops = await Workshop.findAll();

    res.status(200).json(
      workshops.map((e) => {
        return {
          workshopId: e.workshopId,
          description: e.description,
        };
      })
    );
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

router.post("/", async (req, res) => {
  try {
    //* create a new workshop
    const workshop = await Workshop.create({
      workshopId: req.body.workshopId,
      description: req.body.description,
    });

    res.status(201).json(workshop);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

router.patch("/:workshopId", async (req, res) => {
  const { workshopId } = req.params;
  const { active, pinCode } = req.body;

  try {
    const workshop = await Workshop.findOne({
      where: { workshopId },
    });

    workshop.active = active;
    workshop.pinCode = pinCode;

    await workshop.save();

    res.json(workshop);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

router.delete("/:workshopId", async (req, res) => {
  const { workshopId } = req.params;
  try {
    const workshop = await Workshop.findOne({ where: { workshopId } });
    await workshop.destroy();

    res.json({ message: "workshop deleted" });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

module.exports = router;
