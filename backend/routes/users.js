const { User, Workshop } = require("../models");

const router = require("express").Router();
const viewRouter = require("express").Router();

viewRouter.get("/", (req, res) => {
  res.render("./user/login");
});

viewRouter.get("/form", (req, res) => {
  res.render("./user/form");
});

viewRouter.get("/thanks", (req, res) => {
  res.render("./user/thanks");
});

viewRouter.get("/sorry", (req, res) => {
  res.render("./user/sorry");
});

router.post("/:id", async (req, res) => {
  const { id } = req.params;
  const { pinCode } = req.body;

  try {
    const uuidReg =
      /^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$/gi;

    const workshop = await Workshop.findOne({
      where: { pinCode: pinCode, active: true },
      attributes: ["workshopId"],
    });

    if (uuidReg.test(id)) {
      const user = await User.findOne({ where: { id: id } });

      if (user && workshop) {
        if (user.workshopId == workshop.dataValues.workshopId && user.submit) {
          return res
            .status(406)
            .json({ message: "You've already submit the form" });
        }
        user.workshopId = workshop.dataValues.workshopId;

        await user.save();
        return res.status(200).json(user);
      }
    }

    const user = await User.create({
      workshopId: workshop.dataValues.workshopId,
    });

    res.status(200).json(user);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

router.patch("/:id", async (req, res) => {
  const { id } = req.params;
  const { currentState, futureState } = req.body;

  try {
    const user = await User.findOne({ where: { id } });

    user.currentState = currentState;
    user.futureState = futureState;
    user.submit = true;

    await user.save();

    res.json(user);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

module.exports = { router, viewRouter };
