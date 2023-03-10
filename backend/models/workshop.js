"use strict";

const { Model } = require("sequelize");

module.exports = (sequelize, DataTypes) => {
  class Workshop extends Model {}
  Workshop.init(
    {
      workshopId: {
        type: DataTypes.STRING,
        primaryKey: true,
      },
    },
    {
      sequelize,
      tableName: "workshops",
      modelName: "Workshop",
      timestamps: false,
    }
  );
  return Workshop;
};
