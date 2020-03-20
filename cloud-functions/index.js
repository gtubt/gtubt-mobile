const express = require('express');
const bodyParser = require('body-parser')
const admin = require('firebase-admin');
const app = express();


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

    const promises = [
        usersRef.where('studentId', '==', user.studentId).get(),
        usersRef.where('email', '==', user.email).get(),
        usersRef.where('phone', '==', user.phone).get()
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
            name: user.name,
            lastname: user.lastname,
            phone: user.phone,
            email: user.email,
            studentId: user.studentId,
            year: user.year,
            department: user.department,
            profilePhoto: user.profilePhoto
        }).then(ref => {
            responseStatus = 200;
            responseMessage = `User with Added With ID: ${ref.id}`;
            responseObj = {
                Body: user,
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

module.exports = {
    app
};
