const functions = require('firebase-functions');
const admin = require('firebase-admin');
const url = require('url');

admin.initializeApp();

const db = admin.firestore();

exports.post = functions.https.onRequest((req, res) => {
	var url_parts = url.parse(req.url, true);
	var query = url_parts.query;

	if(typeof query.id !== 'undefined' && query.id) {
		const docRef = db.collection('posts').doc(query.id);
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
		var articlesRef = db.collection('posts');
		var allArticles = articlesRef.get()
		.then(snapshot => {
			/*let articlesList = snapshot.docs.map(doc => {
				var article_data = doc.data();
				article_data.id = doc.id;
				return data;
			});*/

			var articlesList = [];

			snapshot.forEach(doc => {
				var articleData = doc.data();
				articleData.id = doc.id;
				articlesList.push(articleData);
	        });

			return res.json(articlesList);
		})
		.catch(err => {
			console.log('Error getting documents', err);
		});
	}
});