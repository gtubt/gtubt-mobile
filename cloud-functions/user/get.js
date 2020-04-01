exports.getWithEmail = function(req, res, db) {
    var userEmail = req.params.userEmail;

    var responseStatus = 200;
    var responseMessage = '';
    var responseObj = null;

    const usersRef = db.collection('users');
    const getDoc = usersRef.where('email', '==', userEmail).get()
    .then(snapshot => {
        if (snapshot.empty) {
            // if user not found
            responseStatus = 404;
            responseMessage = 'User with given email not found';
            responseObj = {
                Body: null,
                Message: responseMessage,
                Code: responseStatus
            }            
            return res.status(responseStatus).json(responseObj);
        } else {
            // if user found
            var responseBody = snapshot.docs[0].data();
            responseStatus = 200;
            responseMessage = 'User found';
            responseObj = {
                Body: responseBody,
                Message: responseMessage,
                Code: responseStatus
            }
            return res.status(responseStatus).json(responseObj);
        }
    }).catch(err => {
        // an error occured while querying
        responseStatus = 400;
        responseMessage = 'There has been an error during the database query'
        responseObj = {
            Body: null,
            Message: responseMessage,
            Code: responseStatus
        }
        console.log('Error getting document', err);
        return res.status(responseStatus).json(responseObj);
    });
}