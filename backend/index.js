const express = require("express");
const { sequelize } = require("./models/index");
const app = express();

// to return an interger with count
// https://github.com/sequelize/sequelize/issues/2383#issuecomment-58006083
require("pg").defaults.parseInt8 = true;

app.use(express.json());
app.use(express.static("assets"));

app.use("/api/user", require("./routes/auth"));
app.use("/api/user", require("./routes/posts"));
app.use("/visio", require("./routes/visio"));

app.listen(3000, () => {
  console.log(`server is running on port 3000`);

  sequelize
    .authenticate()
    .then(() => console.log("Connection has been established successfully."))
    .catch((err) => console.error("Unable to connect to the database:", err));
});

// .sync({ force: true })
