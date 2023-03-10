"use strict";

module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.bulkInsert(
      "workshops",
      [
        {
          workshopId: "1",
        },
        {
          workshopId: "2",
        },
        {
          workshopId: "3",
        },
        {
          workshopId: "4",
        },
        {
          workshopId: "5",
        },
      ],
      {}
    );
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.bulkDelete("User", null, {});
  },
};
