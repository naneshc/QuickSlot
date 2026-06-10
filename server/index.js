const { onRequest } = require('firebase-functions/v2/https');
const app = require('./src/app');

// Export Express app as a Cloud Function named 'api'
// This will map all endpoints under the '/api' prefix or root depending on your Firebase rewrite rules.
// By default, it generates a URL: https://<region>-<project-id>.cloudfunctions.net/api
exports.api = onRequest({ 
  cors: true, 
  maxInstances: 10 // limits active instances to optimize Firebase free tier usage
}, app);
