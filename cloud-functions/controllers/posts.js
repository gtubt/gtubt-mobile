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
      postList.sort((a, b) => (a.startDate > b.startDate) ? 1 : -1)
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

const updatePost = function (req, res) {
  var postId = req.params.id
  const postBody = req.body
  const postsRef = firebaseDb.getInstance().collection('posts')
  var post
  postRef = postsRef.doc(postId)
  postRef.get()
    .then(postDoc => {
      post = postDoc.data()

      // We shouldnt let them update these fields.
      postBody.id = post.id

      Object.assign(post, postBody)
      postRef.update(postBody)
        .then(() => {
          return res.status(200).json(utils.getResponseObj(post, 'Post updated successfully', 200))
        })
        .catch(err => {
          // an error occured while querying
          console.log('Error updating document', err)
          return res.status(400).json(utils.getResponseObj(null, 'Error updating document', 400))
        })
    })
    .catch(err => {
      // an error occured while querying
      console.log('Error getting document', err)
      return res.status(404).json(utils.getResponseObj(null, 'Error getting document', 404))
    })
}

const deletePost = function (req, res) {
  var postId = req.params.id
  const postsRef = firebaseDb.getInstance().collection('posts')
  var postRef = postsRef.doc(postId)
  postRef.get()
    .then(postDoc => {
      postRef.delete()
        .then(() => {
          return res.status(200).json(utils.getResponseObj(null, 'Post deleted successfully', 200))
        }).catch(err => {
          // an error occured while querying
          console.log('Error deleting document', err)
          return res.status(400).json(utils.getResponseObj(null, 'Error deleting document', 400))
        })
    })
    .catch(err => {
      // an error occured while querying
      console.log('Error getting document', err)
      return res.status(404).json(utils.getResponseObj(null, 'Error getting document', 404))
    })
}

// export handlers
module.exports = {
  getAllPosts: getAllPosts,
  getPostWithId: getPostWithId,
  postPost: postPost,
  updatePost: updatePost,
  deletePost: deletePost
}
