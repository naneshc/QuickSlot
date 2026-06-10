const admin = require('firebase-admin');
const path = require('path');
const fs = require('fs');
require('dotenv').config();

let db;

try {
  // Check if we are running in a Firebase Functions environment
  // (which automatically sets the FIREBASE_CONFIG env var)
  if (process.env.FIREBASE_CONFIG || process.env.FUNCTIONS_EMULATOR) {
    admin.initializeApp();
    console.log('Firebase Admin SDK initialized automatically in Firebase environment.');
  } else {
    // Fall back to local service account key file for local runs
    const serviceAccountPath = path.join(__dirname, '../../firebase-service-account.json');
    
    if (fs.existsSync(serviceAccountPath)) {
      const serviceAccount = require(serviceAccountPath);
      admin.initializeApp({
        credential: admin.credential.cert(serviceAccount)
      });
      console.log('Firebase Admin SDK initialized successfully via local service account JSON.');
    } else {
      // Last-ditch attempt: default application credentials
      admin.initializeApp();
      console.log('Firebase Admin SDK initialized using default application credentials.');
    }
  }
  
  db = admin.firestore();
  db.settings({ ignoreUndefinedProperties: true });
} catch (error) {
  console.error('CRITICAL: Failed to initialize Firebase Admin SDK.', error.message);
  process.exit(1);
}

module.exports = { admin, db };
