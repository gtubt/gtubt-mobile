const getResponseObj = function(body, message, status) {
    return {
        Body: body,
        Message: message,
        Status: status
    };
}

const toTitleCase = function (str) {
    var splitStr = str.toLowerCase().split(' ');
    for (var i = 0; i < splitStr.length; i++) {
        splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);
    }
    return splitStr.join(' ');
}

// export functions
module.exports = {
    getResponseObj: getResponseObj,
    toTitleCase: toTitleCase
}
