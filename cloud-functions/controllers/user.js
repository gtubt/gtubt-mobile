const firebaseDb = require('../firebase-database')
const libphonenumber = require('libphonenumber-js')
const utils = require('../utils')

const getUserWithEmail = function (req, res, next) {
  var userEmail = req.params.userEmail

  const usersRef = firebaseDb.getInstance().collection('users')
  usersRef.where('email', '==', userEmail).get()
    .then(snapshot => {
      if (snapshot.empty) {
        // if user not found
        return res.status(404).json(utils.getResponseObj(null, 'User with this E-Mail not found', 404))
      }

      // if user found
      var userData = snapshot.docs[0].data()
      return res.status(200).json(utils.getResponseObj(userData, 'User received', 200))
    }).catch(err => {
      // an error occured while querying
      console.log('Error getting document', err)
      return res.status(404).json(utils.getResponseObj(null, 'Error getting document', 404))
    })
}

const postUser = function (req, res, next) {
  const user = req.body
  const usersRef = firebaseDb.getInstance().collection('users')

  const sanitizedPhoneNumber = libphonenumber.parsePhoneNumberFromString(user.phone, 'TR').formatNational()

  const promises = [
    usersRef.where('studentId', '==', user.studentId).get(),
    usersRef.where('email', '==', user.email).get(),
    usersRef.where('phone', '==', sanitizedPhoneNumber).get()
  ]

  Promise.all(promises)
    .then((snapshots) => {
      // given student id already exists
      if (!snapshots[0].empty) {
        return res.status(400).json(utils.getResponseObj(null, 'A user with this StudentID already exists', 400))
      }

      // given email already exists
      if (!snapshots[1].empty) {
        return res.status(400).json(utils.getResponseObj(null, 'A user with this E-Mail already exists', 400))
      }

      // given phone number already exists
      if (!snapshots[2].empty) {
        return res.status(400).json(utils.getResponseObj(null, 'A user with this phone number already exists', 400))
      }

      usersRef.add({
        name: utils.toTitleCase(user.name),
        lastname: utils.toTitleCase(user.lastname),
        phone: sanitizedPhoneNumber,
        email: user.email,
        studentId: user.studentId,
        year: user.year,
        department: user.department,
        profilePhoto: user.profilePhoto
      }).then(ref => {
        var userRef = usersRef.doc(ref.id)

        userRef.update({ id: ref.id })
          .then(updateResponse => {
            return res.status(200).json(utils.getResponseObj({ id: ref.id }, `User added with ID: ${ref.id}`, 200))
          }).catch(err => {
            console.log('Error creating user', err)
            return res.status(404).json(utils.getResponseObj(null, 'Error creating user', 404))
          })
      }).catch(err => {
        console.log('Error getting document', err)
        return res.status(404).json(utils.getResponseObj(null, 'Error getting document', 404))
      })
    })
}

const updateUser = function (req, res) {
  var userId = req.params.id
  var userBody = req.body
  var user
  const usersRef = firebaseDb.getInstance().collection('users')
  var userRef = usersRef.doc(userId)
  userRef.get()
    .then(userDoc => {
      user = userDoc.data()

      // We shouldnt let them update these fields.
      userBody.id = user.id
      userBody.studentId = user.studentId

      // Sanitization process.
      if (userBody.phone) {
        userBody.phone = libphonenumber.parsePhoneNumberFromString(userBody.phone, 'TR').formatNational()
      }

      if (userBody.name) {
        userBody.name = utils.toTitleCase(userBody.name)
      }

      if (userBody.lastname) {
        userBody.lastname = utils.toTitleCase(userBody.lastname)
      }

      Object.assign(user, userBody)
      userRef.update(userBody)
        .then(() => {
          return res.status(200).json(utils.getResponseObj(user, 'User updated successfully', 200))
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

const deleteUser = function (req, res) {
  var userId = req.params.id
  var user = undefined
  const usersRef = firebaseDb.getInstance().collection('users')
  var userRef = usersRef.doc(userId)
  userRef.get()
    .then(userDoc => {
      user = userDoc.data()
      userRef.delete()
        .then(() => {
          return res.status(200).json(utils.getResponseObj(null, 'User deleted successfully', 200))
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
  getUserWithEmail: getUserWithEmail,
  postUser: postUser,
  updateUser: updateUser,
  deleteUser: deleteUser,
}
