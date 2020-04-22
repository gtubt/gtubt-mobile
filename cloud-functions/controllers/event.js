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

// export handlers
module.exports = {
  getAllEvents: getAllEvents,
  getEventWithId: getEventWithId
}
