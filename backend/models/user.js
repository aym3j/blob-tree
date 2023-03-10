"use strict";

const { Model } = require("sequelize");

module.exports = (sequelize, DataTypes) => {
  class User extends Model {
    static associate({ Workshop }) {
      User.belongsTo(Workshop, { foreignKey: "workshopId" });
    }
  }
  User.init(
    {
      nom: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      prenom: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      email: {
        type: DataTypes.STRING,
      },
      password: {
        type: DataTypes.STRING,
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
