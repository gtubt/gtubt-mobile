const functions = require('firebase-functions');
const admin = require('firebase-admin');
const url = require('url');

admin.initializeApp();

const db = admin.firestore();

exports.article = functions.https.onRequest((req, res) => {
	var url_parts = url.parse(req.url, true);
	var query = url_parts.query;

	if(typeof query.id !== 'undefined' && query.id) {
		const docRef = db.collection('articles').doc(query.id);
		const getDoc = docRef.get()
		.then(doc => {
			if (!doc.exists) {
				return res.send('Not Found');
			}

			return res.send(doc.data());
		}).catch(err => {
			console.log('Error getting document', err);
		});
	}
	else {
		var articlesRef = db.collection('articles');
		var allArticles = articlesRef.get()
		.then(snapshot => {
			let articlesList = snapshot.docs.map(doc => {
				return doc.data();
			}); 
			return res.json(articlesList);
		})
		.catch(err => {
			console.log('Error getting documents', err);
		});
	}
});