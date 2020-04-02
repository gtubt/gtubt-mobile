const admin = require('firebase-admin');

var db = null;

const initialize = function() {
    admin.initializeApp({
        credential: admin.credential.applicationDefault(),
        databaseURL: "https://gtubtmobile-bb186.firebaseio.com"
    });
    db = admin.firestore();
}

const getInstance = function() {
    if(db == null) {
        db = admin.firestore();
    }

    return db;
}

module.exports = {
    initialize: initialize,
    getInstance: getInstance
}
