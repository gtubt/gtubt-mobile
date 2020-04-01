exports.getAll = function(req, res, db) {
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
}

exports.getWithId = function(req, res, db) {
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
}