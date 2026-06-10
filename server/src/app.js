const express = require('express');
const cors = require('cors');
const { db } = require('./config/firebase');

const app = express();

app.use(cors());
app.use(express.json());

// List of valid hourly slots
const VALID_SLOTS = [
  '06:00-07:00', '07:00-08:00', '08:00-09:00', '09:00-10:00',
  '10:00-11:00', '11:00-12:00', '12:00-13:00', '13:00-14:00',
  '14:00-15:00', '15:00-16:00', '16:00-17:00', '17:00-18:00',
  '18:00-19:00', '19:00-20:00', '20:00-21:00', '21:00-22:00'
];

// Helper to validate date format (YYYY-MM-DD)
function isValidDate(dateString) {
  const regEx = /^\d{4}-\d{2}-\d{2}$/;
  if (!dateString.match(regEx)) return false;
  const d = new Date(dateString);
  const dNum = d.getTime();
  if (!dNum && dNum !== 0) return false; // NaN value, Invalid date
  return d.toISOString().slice(0,10) === dateString;
}

// Global logger middleware
app.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
  next();
});

// GET /venues - List venues
app.get('/venues', async (req, res) => {
  try {
    const snapshot = await db.collection('venues').get();
    const venues = [];
    snapshot.forEach(doc => {
      venues.push({ id: doc.id, ...doc.data() });
    });
    res.json(venues);
  } catch (error) {
    console.error('Error fetching venues:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// GET /venues/:id/slots?date=YYYY-MM-DD - Get slots for a date
app.get('/venues/:id/slots', async (req, res) => {
  const venueId = req.params.id;
  const { date } = req.query;

  if (!date || !isValidDate(date)) {
    return res.status(400).json({ error: 'Valid date parameter (YYYY-MM-DD) is required' });
  }

  try {
    // Check if venue exists
    const venueDoc = await db.collection('venues').doc(venueId).get();
    if (!venueDoc.exists) {
      return res.status(404).json({ error: 'Venue not found' });
    }

    // Get all bookings for this venue and date
    const bookingsSnapshot = await db.collection('bookings')
      .where('venueId', '==', venueId)
      .where('date', '==', date)
      .get();

    const bookedSlotsMap = {};
    bookingsSnapshot.forEach(doc => {
      const data = doc.data();
      bookedSlotsMap[data.timeSlot] = {
        bookingId: doc.id,
        userId: data.userId
      };
    });

    // Map all 16 slots with status
    const slots = VALID_SLOTS.map(timeSlot => {
      const isBooked = !!bookedSlotsMap[timeSlot];
      return {
        timeSlot,
        status: isBooked ? 'booked' : 'available',
        bookingId: isBooked ? bookedSlotsMap[timeSlot].bookingId : null,
        userId: isBooked ? bookedSlotsMap[timeSlot].userId : null
      };
    });

    res.json(slots);
  } catch (error) {
    console.error('Error fetching slots:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// POST /bookings - Book a slot (CONCURRENCY SAFE)
app.post('/bookings', async (req, res) => {
  const userId = req.headers['x-user-id'];
  const { venueId, date, timeSlot } = req.body;

  // Validation
  if (!userId) {
    return res.status(401).json({ error: 'Unauthorized: X-User-Id header is required' });
  }
  if (!venueId || !date || !timeSlot) {
    return res.status(400).json({ error: 'Missing venueId, date, or timeSlot' });
  }
  if (!isValidDate(date)) {
    return res.status(400).json({ error: 'Invalid date format (must be YYYY-MM-DD)' });
  }
  if (!VALID_SLOTS.includes(timeSlot)) {
    return res.status(400).json({ error: 'Invalid timeSlot value' });
  }

  const bookingId = `${venueId}_${date}_${timeSlot}`;
  const bookingRef = db.collection('bookings').doc(bookingId);
  const venueRef = db.collection('venues').doc(venueId);

  try {
    // Run Firestore Transaction
    const result = await db.runTransaction(async (transaction) => {
      // 1. Verify Venue exists
      const venueDoc = await transaction.get(venueRef);
      if (!venueDoc.exists) {
        throw { code: 'VENUE_NOT_FOUND', status: 400, message: 'Venue not found' };
      }

      // 2. Check if booking doc already exists
      const bookingDoc = await transaction.get(bookingRef);
      if (bookingDoc.exists) {
        throw { code: 'SLOT_ALREADY_BOOKED', status: 409, message: 'This slot has already been booked by another user.' };
      }

      const venueData = venueDoc.data();
      const newBooking = {
        id: bookingId,
        venueId,
        venueName: venueData.name,
        location: venueData.location,
        imageUrl: venueData.imageUrl,
        date,
        timeSlot,
        userId,
        bookedAt: new Date().toISOString(),
        status: 'booked'
      };

      // 3. Write booking doc
      transaction.set(bookingRef, newBooking);
      return newBooking;
    });

    res.status(201).json(result);
  } catch (error) {
    if (error.status) {
      console.log(`Booking rejection: ${error.message} (${error.code})`);
      return res.status(error.status).json({ error: error.message, code: error.code });
    }
    console.error('Transaction failed:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// GET /users/:id/bookings - User's bookings
app.get('/users/:id/bookings', async (req, res) => {
  const userId = req.params.id;

  try {
    const bookingsSnapshot = await db.collection('bookings')
      .where('userId', '==', userId)
      .get();

    const bookings = [];
    bookingsSnapshot.forEach(doc => {
      bookings.push(doc.data());
    });

    // Sort bookings by date ascending, then timeslot ascending
    bookings.sort((a, b) => {
      if (a.date !== b.date) {
        return a.date.localeCompare(b.date);
      }
      return a.timeSlot.localeCompare(b.timeSlot);
    });

    res.json(bookings);
  } catch (error) {
    console.error('Error fetching user bookings:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// DELETE /bookings/:id - Cancel a booking
app.delete('/bookings/:id', async (req, res) => {
  const bookingId = req.params.id;
  const userId = req.headers['x-user-id'];

  if (!userId) {
    return res.status(401).json({ error: 'Unauthorized: X-User-Id header is required' });
  }

  const bookingRef = db.collection('bookings').doc(bookingId);

  try {
    const bookingDoc = await bookingRef.get();
    if (!bookingDoc.exists) {
      return res.status(404).json({ error: 'Booking not found' });
    }

    const data = bookingDoc.data();
    if (data.userId !== userId) {
      return res.status(403).json({ error: 'Forbidden: You can only cancel your own bookings' });
    }

    await bookingRef.delete();
    res.json({ message: 'Booking canceled successfully' });
  } catch (error) {
    console.error('Error canceling booking:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

module.exports = app;
