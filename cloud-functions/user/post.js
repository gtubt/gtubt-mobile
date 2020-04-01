const libphonenumber = require('libphonenumber-js');
const utils = require('../util');

exports.post = function(req, res, db) {
    const user = req.body;
    const usersRef = db.collection('users');

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
            responseStatus = 400;
            responseObj = {
                Body: null,
                Message: 'A user with the given studentId already exists.',
                Code: responseStatus
            };
            res.status(responseStatus).json(responseObj);
            return;
        }

        // given email already exists
        if (!snapshots[1].empty) {
            responseStatus = 400;
            responseObj = {
                Body: null,
                Message: 'A user with the given e-mail address already exists.',
                Code: responseStatus
            };
            res.status(responseStatus).json(responseObj);
            return;
        }

        // given phone number already exists
        if (!snapshots[2].empty) {
            responseStatus = 400;
            responseObj = {
                Body: null,
                Message: 'A user with the given phone number already exists.',
                Code: responseStatus
            };
            res.status(responseStatus).json(responseObj);
            return;
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
            responseStatus = 200;
            responseMessage = `User added with ID: ${ref.id}`;
            responseBody = {
                id: ref.id
            }
            responseObj = {
                Body: responseBody,
                Message: responseMessage,
                Code: responseStatus
            };
            res.status(responseStatus).json(responseObj);
            return;
        }).catch(err => {
            console.log('Error getting documents', err);    
            responseStatus = 400;
            responseMessage = 'There has been a problem creating the user';
            responseObj = {
                Body: null,
                Message: responseMessage,
                Code: responseStatus
            }
            res.status(responseStatus).send(responseMessage);
            return;
        });
    });
}