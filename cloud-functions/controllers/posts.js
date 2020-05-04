const firebaseDb = require('../firebase-database')
const utils = require('../utils')

const getAllPosts = function (req, res, next) {
  var postsRef = firebaseDb.getInstance().collection('posts')
  postsRef.get()
    .then(snapshot => {
      if (snapshot.empty) {
        return res.status(404).json(utils.getResponseObj(null, 'No posts found', 404))
      }

      var postList = []
      snapshot.forEach(doc => {
        var postData = doc.data()
        postList.push(postData)
      })

      return res.status(200).json(utils.getResponseObj(postList, 'All posts received', 200))
    })
    .catch(err => {
      console.log('Error getting document', err)
      return res.status(404).json(utils.getResponseObj(null, 'Error getting document', 404))
    })
}

const getPostWithId = function (req, res, next) {
  var postId = req.params.postId

  const docRef = firebaseDb.getInstance().collection('posts').doc(postId)
  docRef.get()
    .then(doc => {
      if (!doc.exists) {
        return res.status(404).json(utils.getResponseObj(null, 'No such post found', 404))
      }

      return res.status(200).json(utils.getResponseObj(doc.data(), 'Post received', 200))
    }).catch(err => {
      console.log('Error getting document', err)
      return res.status(404).json(utils.getResponseObj(null, 'Error getting document', 404))
    })
}

const postPost = function (req, res, next) {
  const post = req.body
  const postsRef = firebaseDb.getInstance().collection('posts')
  postsRef.add({
    title: utils.toTitleCase(post.title),
    body: post.body,
    coverImageUrl: post.coverImageUrl,
    summary: post.summary,
    type: post.type,
    startDate: post.startDate,
    endDate: post.endDate
  })
    .then(ref => {
      var postRef = postsRef.doc(ref.id)
      postRef.update({ id: ref.id })
        .then(updateResponse => {
          return res.status(200).json(utils.getResponseObj({ id: ref.id }, `Post added with ID: ${ref.id}`, 200))
        }).catch(err => {
          console.log('Error creating post', err)
          return res.status(404).json(utils.getResponseObj(null, 'Error creating post', 404))
        })
    }).catch(err => {
      console.log('Error getting document', err)
      return res.status(404).json(utils.getResponseObj(null, 'Error getting document', 404))
    })
}

// export handlers
module.exports = {
  getAllPosts: getAllPosts,
  getPostWithId: getPostWithId,
  postPost: postPost
}
