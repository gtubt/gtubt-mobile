const express = require('express')
const bodyParser = require('body-parser')
const firebaseDb = require('./firebase-database')
const postsController = require('./controllers/posts')
const userController = require('./controllers/user')
const eventController = require('./controllers/event')

const app = express()
const jsonParser = bodyParser.json()
firebaseDb.initialize()

const DEBUG_PORT = 5555
app.listen(DEBUG_PORT, () => {
  console.log(`GTUBT Cloud Functions API Server Running on Port: ${DEBUG_PORT}`)
})

app.get('/posts', postsController.getAllPosts)
app.get('/posts/:postId', postsController.getPostWithId)
app.post('/posts', jsonParser, postsController.postPost)

app.get('/event', eventController.getAllEvents)
app.get('/event/:eventId', eventController.getEventWithId)

app.get('/user/:userEmail', userController.getUserWithEmail)
app.post('/user', jsonParser, userController.postUser)

// export Express app to firebase cloud functions
module.exports = {
  app
}
