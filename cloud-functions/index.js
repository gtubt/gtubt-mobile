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
app.patch('/posts/:id', jsonParser, postsController.updatePost)
app.delete('/posts/:id', postsController.deletePost)

app.get('/event', eventController.getAllEvents)
app.get('/event/:eventId', eventController.getEventWithId)
app.patch('/event/:eventId', jsonParser, eventController.updateEvent)
app.delete('/event/:eventId', eventController.deleteEventWithId)
app.post('/event', jsonParser, eventController.postEvent)

app.get('/user/:userEmail', userController.getUserWithEmail)
app.post('/user', jsonParser, userController.postUser)
app.patch('/user/:id', jsonParser, userController.updateUser)
app.delete('/user/:id', userController.deleteUser)
// export Express app to firebase cloud functions
module.exports = {
  app
}
