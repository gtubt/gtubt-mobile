const express = require('express');
const bodyParser = require('body-parser');
const admin = require('firebase-admin');
const app = express();

const postsGetEndpoints = require('./posts/get');
const userGetEndpoints = require('./user/get');
const userPostEndpoints = require('./user/post');

admin.initializeApp({
    credential: admin.credential.applicationDefault(),
    databaseURL: "https://gtubtmobile-bb186.firebaseio.com"
});
const db = admin.firestore();

var jsonParser = bodyParser.json();

const DEBUG_PORT = 5555;
app.listen(DEBUG_PORT, () => {
    console.log(`GTUBT Cloud Functions API Server Running on Port: ${DEBUG_PORT}`);
});

app.get('/posts', (req, res, next) => {
    return postsGetEndpoints.getAll(req, res, db);
});

app.get('/posts/:postId', (req, res, next) => {
    return postsGetEndpoints.getWithId(req, res, db);
});

app.post('/user', jsonParser, (req, res, next) => {
    return userPostEndpoints.post(req, res, db);
});

app.get('/user/:userEmail', (req, res, next) => {
    return userGetEndpoints.getWithEmail(req, res, db);
});


module.exports = {
    app
};
