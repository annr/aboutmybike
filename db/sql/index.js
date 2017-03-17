'use strict';

var QueryFile = require('pg-promise').QueryFile;
var path = require('path');

///////////////////////////////////////////////////////////////////////////////////////////////
// Criteria for deciding whether to place a particular query into an external SQL file or to
// keep it in-line (hard-coded):
//
// - Size / complexity of the query, because having it in a separate file will let you develop
//   the query and see the immediate updates without having to restart your application.
//
// - The necessity to document your query, and possibly keeping its multiple versions commented
//   out in the query file.
//
// In fact, the only reason one might want to keep a query in-line within the code is to be able
// to easily see the relation between the query logic and its formatting parameters. However, this
// is very easy to overcome by using only Named Parameters for your query formatting.
////////////////////////////////////////////////////////////////////////////////////////////////

module.exports = {
  bike: {
    add: sql('bike/add.sql'),
    all: sql('bike/all.sql'),
    select: sql('bike/select.sql'),
    update: sql('bike/update.sql'),
    update_basics: sql('bike/update_basics.sql'),
    update_main_photo: sql('bike/update_main_photo.sql'),
  },
  amb_user: {
    add: sql('amb_user/add.sql'),
    update_last_login: sql('amb_user/update_last_login.sql'),
    select: sql('amb_user/select.sql'),
    fb_select: sql('amb_user/fb_select.sql'),
  },
  bike_info: {
    add: sql('bike_info/add.sql'),
    update: sql('bike_info/update.sql'),
  },
  photo: {
    add: sql('photo/add.sql'),
  },
  user_photo: {
    add: sql('user_photo/add.sql'),
  },
  manufacturer: {
    select: sql('manufacturer/select.sql'),
  }
};

///////////////////////////////////////////////
// Helper for linking to external query files;
function sql(file) {

    var fullPath = path.join(__dirname, file); // generating full path;

    var options = {

        // minifying the SQL is always advised;
        // see also option 'compress' in the API;
        minify: true,

        // Showing how to use static pre-formatting parameters -
        // we have variable 'schema' in each SQL (as an example);
        params: {
            schema: 'public' // replace ${schema~} with "public"
        }
    };

    var qf = new QueryFile(fullPath, options);

    if (qf.error) {
        // Something is wrong with our query file :(
        // Testing all files through queries can be cumbersome,
        // so we also report it here, while loading the module:
        console.error(qf.error);
    }

    return qf;

    // See QueryFile API:
    // http://vitaly-t.github.io/pg-promise/QueryFile.html
}

//////////////////////////////////////////////////////////////////////////
// Consider an alternative - enumerating all SQL files automatically ;)
// API: http://vitaly-t.github.io/pg-promise/utils.html#.enumSql

/*
// generating a recursive SQL tree for dynamic use of camelized names:
var enumSql = require('pg-promise').utils.enumSql;

module.exports = enumSql(__dirname, {recursive: true}, file => {
    // NOTE: 'file' contains the full path to the SQL file, as we use __dirname for enumeration.
    return new QueryFile(file, {
        minify: true,
        params: {
            schema: 'public' // replace ${schema~} with "public"
        }
    });
});
*/
