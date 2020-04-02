const firebaseDb = require('../firebase-database');

const getAllPosts = function(req, res, next) {
    var postsRef = firebaseDb.getInstance().collection('posts');
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
}

const getPostWithId = function(req, res, next) {
    var postId = req.params.postId;

    const docRef = firebaseDb.getInstance().collection('posts').doc(postId);
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
}

// export handlers
module.exports = {
    getAllPosts: getAllPosts,
    getPostWithId: getPostWithId
}
