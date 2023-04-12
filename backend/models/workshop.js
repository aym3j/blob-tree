"use strict";

const { Model } = require("sequelize");

module.exports = (sequelize, DataTypes) => {
  class Workshop extends Model {}
  Workshop.init(
    {
      workshopId: {
        type: DataTypes.STRING,
        primaryKey: true,
        validate: {
          notEmpty: true,
        },
      },
      description: {
        type: DataTypes.STRING,
      },
      active: {
        type: DataTypes.BOOLEAN,
        defaultValue: false,
      },
      pinCode: {
        type: DataTypes.STRING(4),
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
