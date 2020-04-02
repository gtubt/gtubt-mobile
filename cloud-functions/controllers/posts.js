const firebaseDb = require('../firebase-database');
const utils = require('../utils');

const getAllPosts = function(req, res, next) {
    var postsRef = firebaseDb.getInstance().collection('posts');
    var allPosts = postsRef.get()
    .then(snapshot => {
        if(snapshot.empty) {
            return res.status(404).json(utils.getResponseObj(null, 'No posts found', 404));
        }

        var postList = [];
        snapshot.forEach(doc => {
            var postData = doc.data();
            postData.id = doc.id;
            postList.push(postData);
        });

        return res.status(200).json(utils.getResponseObj(postList, 'All posts received', 200));
    })
    .catch(err => {
        console.log('Error getting document', err);
        return res.status(404).json(utils.getResponseObj(null, 'Error getting document', 404));
    });
}

const getPostWithId = function(req, res, next) {
    var postId = req.params.postId;

    const docRef = firebaseDb.getInstance().collection('posts').doc(postId);
    const getDoc = docRef.get()
    .then(doc => {
        if (!doc.exists) {
            return res.status(404).json(utils.getResponseObj(null, 'No such post found', 404));
        }

        return res.status(200).json(utils.getResponseObj(doc.data(), 'Post received', 200));
    }).catch(err => {
        console.log('Error getting document', err);
        return res.status(404).json(utils.getResponseObj(null, 'Error getting document', 404));
    });
}

// export handlers
module.exports = {
    getAllPosts: getAllPosts,
    getPostWithId: getPostWithId
}
