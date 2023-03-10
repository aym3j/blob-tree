const router = require("express").Router();
const { User, Workshop } = require("../models/");
const fs = require("fs");
const Canvas = require("canvas");
const sequelize = require("sequelize");

router.get("/:workshop", async (req, res) => {
  //* checking if the workshop exists
  const workshopExist = await User.findOne({
    where: { workshopId: req.params.workshop },
  });

  if (!workshopExist)
    return res
      .status(400)
      .send(
        "<html><body><img src='http://localhost:3000/error.png'></body></html>"
      );

  // SELECT COUNT(id) AS "NB", "currentState" FROM users WHERE "workshopId"='1'  GROUP BY "currentState";
  const currentState = await User.findAll({
    where: { workshopId: req.params.workshop },
    attributes: [
      "currentState",
      [sequelize.fn("COUNT", sequelize.col("id")), "nb"],
    ],
    group: "currentState",
  });

  const futureState = await User.findAll({
    where: { workshopId: req.params.workshop },
    attributes: [
      "futureState",
      [sequelize.fn("COUNT", sequelize.col("id")), "nb"],
    ],
    group: "futureState",
  });

  const states = [
    { x: 50, y: 50 },
    { x: 100, y: 150 },
    { x: 80, y: 200 },
    { x: 150, y: 70 },
    { x: 200, y: 170 },
  ];

  fs.readFile(__dirname + "/../assets/source.png", async (err, data) => {
    const img = await Canvas.loadImage(data);
    var canvas = new Canvas.Canvas(img.width, img.height);
    var ctx = canvas.getContext("2d");

    ctx.drawImage(img, 0, 0, img.width, img.height);

    // represent current states
    ctx.fillStyle = "red";
    ctx.strokeStyle = "red";

    currentState.forEach((state) => {
      const nbStates = state.dataValues.nb;
      const x = states[state.dataValues.currentState - 1].x;
      const y = states[state.dataValues.currentState - 1].y;
      for (let i = 0; i < nbStates; i++) {
        const randNb = Math.random() * 30 - 15;

        ctx.beginPath();
        ctx.arc(x + randNb, y + randNb, 3, 0, 2 * Math.PI, false);
        ctx.fill();
        ctx.stroke();
        ctx.closePath();
      }
    });

    ctx.fillStyle = "green";
    ctx.strokeStyle = "green";
    futureState.forEach((state) => {
      console.log(state.dataValues);
      const nbStates = state.dataValues.nb;
      const x = states[state.dataValues.futureState - 1].x;
      const y = states[state.dataValues.futureState - 1].y;
      for (let i = 0; i < nbStates; i++) {
        const randNb = Math.random() * 30 - 15;

        ctx.beginPath();
        ctx.arc(x + randNb, y + randNb, 3, 0, 2 * Math.PI, false);
        ctx.fill();
        ctx.stroke();
        ctx.closePath();
      }
    });

    res.send(
      '<html><body><img style="display: block; margin-left: auto; margin-right: auto; width: 50%;" src="' +
        canvas.toDataURL() +
        '" /></body></html>'
    );
  });
});

module.exports = router;
