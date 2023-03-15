const router = require("express").Router();
const { User } = require("../models/");
const fs = require("fs");
const Canvas = require("canvas");
const sequelize = require("sequelize");

router.get("/:workshop", async (req, res) => {
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

  fs.readFile(
    __dirname + "/../public/images/test_image.png",
    async (err, data) => {
      const img = await Canvas.loadImage(data);

      var canvas = new Canvas.Canvas(img.width, img.height);

      var ctx = canvas.getContext("2d");
      ctx.drawImage(img, 0, 0, img.width, img.height);

      const WIDTH = img.width; // 728
      const HEIGHT = img.height; // 1030

      const states = [
        { x: WIDTH * 0.15, y: HEIGHT * 0.82 },
        { x: WIDTH * 0.35, y: HEIGHT * 0.92 },
        { x: WIDTH * 0.45, y: HEIGHT * 0.78 },
        { x: WIDTH * 0.64, y: HEIGHT * 0.85 },
        { x: WIDTH * 0.81, y: HEIGHT * 0.93 },
        { x: WIDTH * 0.29, y: HEIGHT * 0.66 },
        { x: WIDTH * 0.5, y: HEIGHT * 0.6 },
        { x: WIDTH * 0.91, y: HEIGHT * 0.58 },
        { x: WIDTH * 0.88, y: HEIGHT * 0.76 },
        { x: WIDTH * 0.36, y: HEIGHT * 0.41 },
        { x: WIDTH * 0.57, y: HEIGHT * 0.46 },
        { x: WIDTH * 0.69, y: HEIGHT * 0.46 },
        { x: WIDTH * 0.88, y: HEIGHT * 0.41 },
        { x: WIDTH * 0.11, y: HEIGHT * 0.4 },
        { x: WIDTH * 0.45, y: HEIGHT * 0.24 },
        { x: WIDTH * 0.65, y: HEIGHT * 0.32 },
        { x: WIDTH * 0.67, y: HEIGHT * 0.19 },
        { x: WIDTH * 0.78, y: HEIGHT * 0.27 },
        { x: WIDTH * 0.09, y: HEIGHT * 0.18 },
        { x: WIDTH * 0.45, y: HEIGHT * 0.08 },
        { x: WIDTH * 0.89, y: HEIGHT * 0.08 },
      ];

      // represent current states
      ctx.fillStyle = "blue";
      ctx.strokeStyle = "blue";
      currentState.forEach((state) => {
        const nbStates = state.dataValues.nb;
        const x = states[state.dataValues.currentState - 1].x;
        const y = states[state.dataValues.currentState - 1].y;
        for (let i = 0; i < nbStates; i++) {
          const randX = Math.random() * 40 - 20;
          const randY = Math.random() * 40 - 20;

          ctx.beginPath();
          ctx.arc(x + randX, y + randY, 10, 0, 2 * Math.PI, false);
          ctx.fill();
          ctx.stroke();
          ctx.closePath();
        }
      });

      // represent future states
      ctx.fillStyle = "red";
      ctx.strokeStyle = "red";
      futureState.forEach((state) => {
        const nbStates = state.dataValues.nb;
        const x = states[state.dataValues.futureState - 1].x;
        const y = states[state.dataValues.futureState - 1].y;
        for (let i = 0; i < nbStates; i++) {
          const randX = Math.random() * 40 - 20;
          const randY = Math.random() * 40 - 20;

          ctx.beginPath();
          ctx.arc(x + randX, y + randY, 10, 0, 2 * Math.PI, false);
          ctx.fill();
          ctx.stroke();
          ctx.closePath();
        }
      });

      res.send(
        '<html><body><img style="display: block; height: 100%;  margin: 0 auto;" src="' +
          canvas.toDataURL() +
          '" /></body></html>'
      );
    }
  );
});

module.exports = router;
