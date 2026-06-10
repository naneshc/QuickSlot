const API_URL = process.env.API_URL || 'http://localhost:5000';
const VENUE_ID = 'venue_1';
const DATE = '2026-07-20';
const TIME_SLOT = '17:00-18:00';

async function testConcurrency() {
  console.log('--- QuickSlot Concurrency Test ---');
  console.log(`Targeting: Venue: ${VENUE_ID}, Date: ${DATE}, Slot: ${TIME_SLOT}`);
  console.log(`Sending requests to: ${API_URL}/bookings`);

  // We will issue 10 concurrent requests with different User IDs
  const requests = Array.from({ length: 10 }).map((_, index) => {
    const userId = `user_test_${index + 1}`;
    
    return fetch(`${API_URL}/bookings`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-User-Id': userId
      },
      body: JSON.stringify({
        venueId: VENUE_ID,
        date: DATE,
        timeSlot: TIME_SLOT
      })
    })
    .then(async (res) => {
      const data = await res.json();
      return {
        userId,
        status: res.status,
        data
      };
    })
    .catch((err) => {
      return {
        userId,
        status: 'ERROR',
        error: err.message
      };
    });
  });

  try {
    console.log('Sending 10 concurrent booking requests...');
    const results = await Promise.all(requests);

    console.log('\n--- Results Summary ---');
    let successCount = 0;
    let conflictCount = 0;
    let errorCount = 0;

    results.forEach((r) => {
      console.log(`User: ${r.userId} -> Status: ${r.status} (${JSON.stringify(r.data || r.error)})`);
      if (r.status === 201) successCount++;
      else if (r.status === 409) conflictCount++;
      else errorCount++;
    });

    console.log('\n--- Final Verdict ---');
    console.log(`Successful Bookings: ${successCount}`);
    console.log(`Conflict rejections (409): ${conflictCount}`);
    console.log(`Errors/Other: ${errorCount}`);

    if (successCount === 1 && conflictCount === 9) {
      console.log('✅ PASS: Exactly one booking succeeded and all others were rejected with 409 Conflict!');
    } else {
      console.log('❌ FAIL: Expected exactly 1 success and 9 conflicts.');
    }
  } catch (error) {
    console.error('Test failed to run:', error);
  }
}

// Check server health first, then run test
async function run() {
  try {
    const health = await fetch(`${API_URL}/health`);
    if (health.ok) {
      await testConcurrency();
    } else {
      console.error('Server is not healthy. Please make sure the server is running and connected to Firestore.');
    }
  } catch (err) {
    console.error(`Could not connect to server at ${API_URL}. Is it running? Error: ${err.message}`);
  }
}

run();
