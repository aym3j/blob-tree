"use strict";

module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.bulkInsert(
      "users",
      [
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 4,
          futureState: 3,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 4,
          futureState: 1,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 2,
          futureState: 4,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 2,
          futureState: 2,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 2,
          futureState: 2,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "2",
          currentState: 2,
          futureState: 2,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "2",
          currentState: 2,
          futureState: 2,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "2",
          currentState: 2,
          futureState: 2,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "2",
          currentState: 2,
          futureState: 2,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "3",
          currentState: 2,
          futureState: 2,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "4",
          currentState: 2,
          futureState: 2,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "4",
          currentState: 2,
          futureState: 2,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "4",
          currentState: 2,
          futureState: 2,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "4",
          currentState: 2,
          futureState: 2,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "5",
          currentState: 2,
          futureState: 2,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "5",
          currentState: 2,
          futureState: 2,
        },
      ],
      {}
    );
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.bulkDelete("users", null, {});
  },
};
