const firebaseDb = require('../firebase-database');
const libphonenumber = require('libphonenumber-js');
const utils = require('../utils');

const getUserWithEmail = function(req, res, next) {
    var userEmail = req.params.userEmail;

    const usersRef = firebaseDb.getInstance().collection('users');
    usersRef.where('email', '==', userEmail).get()
    .then(snapshot => {
        if (snapshot.empty) {
            // if user not found
            return res.status(404).json(utils.getResponseObj(null, 'User with this E-Mail not found', 404));
        }

        // if user found
        var userData = snapshot.docs[0].data();
        return res.status(200).json(utils.getResponseObj(userData, 'User received', 200));
    }).catch(err => {
        // an error occured while querying
        console.log('Error getting document', err);
        return res.status(404).json(utils.getResponseObj(null, 'Error getting document', 404));
    });
}

const postUser = function(req, res, next) {
    const user = req.body;
    const usersRef = firebaseDb.getInstance().collection('users');

    const sanitizedPhoneNumber = libphonenumber.parsePhoneNumberFromString(user.phone, 'TR').formatNational();

    const promises = [
        usersRef.where('studentId', '==', user.studentId).get(),
        usersRef.where('email', '==', user.email).get(),
        usersRef.where('phone', '==', sanitizedPhoneNumber).get()
    ];

    Promise.all(promises)
    .then((snapshots) => {
        // given student id already exists
        if (!snapshots[0].empty) {
            return res.status(400).json(utils.getResponseObj(null, 'A user with this StudentID already exists', 400));
        }

        // given email already exists
        if (!snapshots[1].empty) {
            return res.status(400).json(utils.getResponseObj(null, 'A user with this E-Mail already exists', 400));
        }

        // given phone number already exists
        if (!snapshots[2].empty) {
            return res.status(400).json(utils.getResponseObj(null, 'A user with this phone number already exists', 400));
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
            return res.status(200).json(utils.getResponseObj({id: ref.id}, `User added with ID: ${ref.id}`, 200));
        }).catch(err => {
            console.log('Error getting document', err);
            return res.status(404).json(utils.getResponseObj(null, 'Error getting document', 404));
        });
    });
}

// export handlers
module.exports = {
    getUserWithEmail: getUserWithEmail,
    postUser: postUser
}
