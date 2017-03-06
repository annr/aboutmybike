

let sql = require('../sql').bike;

module.exports = (rep, pgp) =>

    /*
     This repository mixes hard-coded and dynamic SQL,
     primarily to show a diverse example of using both.
     */

     ({

        // Adds a new bike, and returns the bike record;
       add: name =>
            rep.one(sql.add, name, user => user.id),

        // Tries to delete a user by id, and returns the number of records deleted;
       remove: id =>
            rep.result('DELETE FROM Users WHERE id = $1', id, r => r.rowCount),

        // Tries to find a user from id;
       find: id =>
            rep.oneOrNone('SELECT * FROM Users WHERE id = $1', id),

        // Returns all user records;
       all: () =>
            rep.any('SELECT * FROM Users'),

        // Returns the total number of users;
       total: () =>
            rep.one('SELECT count(*) FROM Users', [], a => +a.count),
     });
