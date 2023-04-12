const express = require("express");
const sequelize = require("./models/index").sequelize;
var bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");

const app = express();

// to return an interger with count
// https://github.com/sequelize/sequelize/issues/2383#issuecomment-58006083
require("pg").defaults.parseInt8 = true;

app.use(cookieParser());
app.use(express.json());
app.use(express.static("public"));
app.use(bodyParser.urlencoded({ extended: true }));

app.set("views", "./views");
app.set("view engine", "ejs");

app.use("/admin", require("./routes/admin"));
app.use("/", require("./routes/users").viewRouter);

app.use("/visio", require("./routes/visio"));
app.use("/api/users", require("./routes/users").router);
app.use("/api/workshops", require("./routes/workshops"));

app.listen(3000, () => {
  console.log(`server is running on port 3000`);

  sequelize
    .authenticate()
    // .sync({ force: true })
    .then(() => console.log("Connection has been established successfully."))
    .catch((err) => console.error("Unable to connect to the database:", err));
});
