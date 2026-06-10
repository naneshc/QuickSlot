const functions = require('firebase-functions');
const app = require('./src/app');

// Export Express app as a v1 Cloud Function named 'quickslot'
exports.quickslot = functions.https.onRequest(app);
