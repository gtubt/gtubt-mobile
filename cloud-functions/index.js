const express = require('express');
const admin = require('firebase-admin');
const app = express();

admin.initializeApp({
    credential: admin.credential.applicationDefault(),
    databaseURL: "https://gtubtmobile-bb186.firebaseio.com"
});
const db = admin.firestore();

const PORT = 5555;
const USERS = [
    {
        id: 1,
        firstName: 'John',
        lastName: 'Smith'
    },
    {
        id: 2,
        firstName: 'Jane',
        lastName: 'Williams'
    }
];

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});

app.get('/post/:postId', (req, res, next) => {
    var postId = req.params.postId;

    const docRef = db.collection('posts').doc(postId);
    const getDoc = docRef.get()
    .then(doc => {
        if (!doc.exists) {
            return res.send('Not Found');
        }

        return res.send(doc.data());
    }).catch(err => {
        console.log('Error getting document', err);
    });
});

app.get('/post', (req, res, next) => {
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
    });
});

module.exports = {
    app
};
