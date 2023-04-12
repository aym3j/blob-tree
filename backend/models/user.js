"use strict";

const { Model } = require("sequelize");

module.exports = (sequelize, DataTypes) => {
  class User extends Model {
    static associate({ Workshop }) {
      User.belongsTo(Workshop, {
        foreignKey: "workshopId",
        onDelete: "cascade",
      });
    }
  }
  User.init(
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
      },
      workshopId: {
        type: DataTypes.STRING,
      },
      currentState: {
        type: DataTypes.INTEGER,
      },
      futureState: {
        type: DataTypes.INTEGER,
      },
      submit: {
        type: DataTypes.BOOLEAN,
        defaultValue: false,
      },
    },
    {
      sequelize,
      tableName: "users",
      modelName: "User",
      timestamps: false,
    }
  );
  return User;
};
