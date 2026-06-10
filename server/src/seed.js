const { db } = require('./config/firebase');

const venues = [
  {
    id: 'venue_1',
    name: 'Smash Badminton Arena',
    type: 'Badminton',
    location: 'Sector 62, Noida',
    imageUrl: 'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=500&auto=format&fit=crop&q=80',
    pricePerHour: 300,
    rating: 4.8,
    description: 'Premium indoor badminton courts with professional synthetic flooring and excellent LED lighting.'
  },
  {
    id: 'venue_2',
    name: 'Camp Nou Football Turf',
    type: 'Football Turf',
    location: 'Downtown, Sector 15',
    imageUrl: 'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?w=500&auto=format&fit=crop&q=80',
    pricePerHour: 800,
    rating: 4.7,
    description: 'High-quality 5-a-side and 7-a-side AstroTurf grounds. Open 24/7 with dugout facilities.'
  },
  {
    id: 'venue_3',
    name: 'Apex Cricket Nets',
    type: 'Cricket Turf',
    location: 'West End, Gurugram',
    imageUrl: 'https://images.unsplash.com/photo-1531415080290-b9b682e54736?w=500&auto=format&fit=crop&q=80',
    pricePerHour: 500,
    rating: 4.5,
    description: 'Indoor and outdoor cricket nets equipped with bowling machines and professional coaching staff.'
  },
  {
    id: 'venue_4',
    name: 'Golden State Basketball Court',
    type: 'Basketball',
    location: 'Uptown, Saket',
    imageUrl: 'https://images.unsplash.com/photo-1544698310-74ea9d1c8258?w=500&auto=format&fit=crop&q=80',
    pricePerHour: 400,
    rating: 4.6,
    description: 'Full-sized indoor basketball court with wooden flooring and adjustable hoops.'
  }
];

async function seedData() {
  console.log('Starting database seeding...');
  try {
    const batch = db.batch();

    for (const venue of venues) {
      const docRef = db.collection('venues').doc(venue.id);
      batch.set(docRef, venue);
      console.log(`Prepared seed for: ${venue.name}`);
    }

    await batch.commit();
    console.log('Database seeded successfully!');
    process.exit(0);
  } catch (error) {
    console.error('Error seeding database:', error);
    process.exit(1);
  }
}

seedData();
