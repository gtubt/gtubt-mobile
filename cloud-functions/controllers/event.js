const firebaseDb = require('../firebase-database')
const utils = require('../utils')

const getAllEvents = function (req, res, next) {
  var eventsRef = firebaseDb.getInstance().collection('events')
  eventsRef.get()
    .then(snapshot => {
      if (snapshot.empty) {
        return res.status(404).json(utils.getResponseObj(null, 'No events found', 404))
      }

      var eventList = []
      snapshot.forEach(doc => {
        var eventData = doc.data()
        eventList.push(eventData)
      })

      return res.status(200).json(utils.getResponseObj(eventList, 'All events received', 200))
    })
    .catch(err => {
      console.log('Error getting document', err)
      return res.status(404).json(utils.getResponseObj(null, 'Error getting document', 404))
    })
}

const getEventWithId = function (req, res, next) {
  var eventId = req.params.eventId

  const docRef = firebaseDb.getInstance().collection('events').doc(eventId)
  docRef.get()
    .then(doc => {
      if (!doc.exists) {
        return res.status(404).json(utils.getResponseObj(null, 'No such event found', 404))
      }

      return res.status(200).json(utils.getResponseObj(doc.data(), 'Event received', 200))
    }).catch(err => {
      console.log('Error getting document', err)
      return res.status(404).json(utils.getResponseObj(null, 'Error getting document', 404))
    })
}

const deleteEventWithId = function (req, res, next) {
  var eventId = req.params.eventId

  const docRef = firebaseDb.getInstance().collection('events').doc(eventId)
  docRef.get()
    .then(userDoc => {
      docRef.delete()
        .then(() => {
          return res.status(200).json(utils.getResponseObj(null, 'Event deleted successfully', 200))
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

const postEvent = function (req, res, next) {
  const event = req.body
  const eventsRef = firebaseDb.getInstance().collection('events')
  eventsRef.add({
    title: utils.toTitleCase(event.title),
    description: event.description,
    date: event.date,
    coverImageUrl: event.coverImageUrl
  })
    .then(ref => {
      var eventRef = eventsRef.doc(ref.id)
      eventRef.update({ id: ref.id })
        .then(updateResponse => {
          return res.status(200).json(utils.getResponseObj({ id: ref.id }, `Event added with ID: ${ref.id}`, 200))
        }).catch(err => {
          console.log('Error creating post', err)
          return res.status(404).json(utils.getResponseObj(null, 'Error creating event', 404))
        })
    }).catch(err => {
      console.log('Error getting document', err)
      return res.status(404).json(utils.getResponseObj(null, 'Error getting document', 404))
    })
}

// export handlers
module.exports = {
  getAllEvents: getAllEvents,
  getEventWithId: getEventWithId,
  deleteEventWithId: deleteEventWithId,
  postEvent: postEvent
}
