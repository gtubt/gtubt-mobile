const express = require('express');
const bodyParser = require('body-parser');
const admin = require('firebase-admin');
const app = express();
const libphonenumber = require('libphonenumber-js');

admin.initializeApp({
    credential: admin.credential.applicationDefault(),
    databaseURL: "https://gtubtmobile-bb186.firebaseio.com"
});
const db = admin.firestore();

var jsonParser = bodyParser.json();

const PORT = 5555;

app.listen(PORT, () => {
    console.log(`GTUBT Cloud Functions API Server Running on Port: ${PORT}`);
});

app.get('/posts/:postId', (req, res, next) => {
    var postId = req.params.postId;

    const docRef = db.collection('posts').doc(postId);
    const getDoc = docRef.get()
    .then(doc => {
        if (!doc.exists) {
            return res.status(404).send('Not Found');
        }

        return res.send(doc.data());
    }).catch(err => {
        console.log('Error getting document', err);
        res.status(404).send('Not found');
    });
});

app.get('/posts', (req, res, next) => {
    var postsRef = db.collection('posts');
    var allPosts = postsRef.get()
    .then(snapshot => {
        var postList = [];
        snapshot.forEach(doc => {
            var postData = doc.data();
            postData.id = doc.id;
            postList.push(postData);
        });

        return res.json(postList);
    })
    .catch(err => {
        console.log('Error getting documents', err);
        res.status(404).send('Not found');
    });
});

app.post('/create-user', jsonParser, (req, res, next) => {
    const user = req.body;
    const usersRef = db.collection('users');

    const sanitizedPhoneNumber = libphonenumber.parsePhoneNumberFromString(user.phone, 'TR').formatNational();

    const promises = [
        usersRef.where('studentId', '==', user.studentId).get(),
        usersRef.where('email', '==', user.email).get(),
        usersRef.where('phone', '==', sanitizedPhoneNumber).get()
    ];

    Promise.all(promises)
    .then((snapshots) => {
        // given student id already exists
        if (!snapshots[0].empty) {
            responseStatus = 400;
            responseObj = {
                Body: null,
                Message: 'A user with the given studentId already exists.',
                Code: responseStatus
            };
            res.status(responseStatus).json(responseObj);
            return;
        }

        // given email already exists
        if (!snapshots[1].empty) {
            responseStatus = 400;
            responseObj = {
                Body: null,
                Message: 'A user with the given e-mail address already exists.',
                Code: responseStatus
            };
            res.status(responseStatus).json(responseObj);
            return;
        }

        // given phone number already exists
        if (!snapshots[2].empty) {
            responseStatus = 400;
            responseObj = {
                Body: null,
                Message: 'A user with the given phone number already exists.',
                Code: responseStatus
            };
            res.status(responseStatus).json(responseObj);
            return;
        }

        usersRef.add({
            name: toTitleCase(user.name),
            lastname: toTitleCase(user.lastname),
            phone: sanitizedPhoneNumber,
            email: user.email,
            studentId: user.studentId,
            year: user.year,
            department: user.department,
            profilePhoto: user.profilePhoto
        }).then(ref => {
            responseStatus = 200;
            responseMessage = `User added with ID: ${ref.id}`;
            responseBody = {
                id: ref.id
            }
            responseObj = {
                Body: responseBody,
                Message: responseMessage,
                Code: responseStatus
            };
            res.status(responseStatus).json(responseObj);
            return;
        }).catch(err => {
            console.log('Error getting documents', err);    
            responseStatus = 400;
            responseMessage = 'There has been a problem creating the user';
            responseObj = {
                Body: null,
                Message: responseMessage,
                Code: responseStatus
            }
            res.status(responseStatus).send(responseMessage);
            return;
        });
    });
});

app.get('/get-user/:userEmail', (req, res, next) => {
    var userEmail = req.params.userEmail;

    var responseStatus = 200;
    var responseMessage = '';
    var responseObj = null;

    const usersRef = db.collection('users');
    const getDoc = usersRef.where('email', '==', userEmail).get()
    .then(snapshot => {
        if (snapshot.empty) {
            // if user not found
            responseStatus = 404;
            responseMessage = 'User with given email not found';
            responseObj = {
                Body: null,
                Message: responseMessage,
                Code: responseStatus
            }            
            return res.status(responseStatus).json(responseObj);
        } else {
            // if user found
            var responseBody = snapshot.docs[0].data();
            responseStatus = 200;
            responseMessage = 'User found';
            responseObj = {
                Body: responseBody,
                Message: responseMessage,
                Code: responseStatus
            }
            return res.status(responseStatus).json(responseObj);
        }
    }).catch(err => {
        // an error occured while querying
        responseStatus = 400;
        responseMessage = 'There has been an error during the database query'
        responseObj = {
            Body: null,
            Message: responseMessage,
            Code: responseStatus
        }
        console.log('Error getting document', err);
        return res.status(responseStatus).json(responseObj);
    });
});

function toTitleCase(str) {
   var splitStr = str.toLowerCase().split(' ');
   for (var i = 0; i < splitStr.length; i++) {
       splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);
   }
   return splitStr.join(' ');
}

module.exports = {
    app
};
