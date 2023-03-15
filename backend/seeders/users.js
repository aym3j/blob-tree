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
          currentState: 16,
          futureState: 17,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 6,
          futureState: 7,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 7,
          futureState: 8,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 10,
          futureState: 7,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 17,
          futureState: 16,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 18,
          futureState: 16,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 14,
          futureState: 17,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 21,
          futureState: 5,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 12,
          futureState: 11,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 13,
          futureState: 12,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 5,
          futureState: 9,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 21,
          futureState: 21,
        },
        {
          nom: "John",
          prenom: "Doe",
          workshopId: "1",
          currentState: 15,
          futureState: 8,
        },
      ],
      {}
    );
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.bulkDelete("users", null, {});
  },
};
