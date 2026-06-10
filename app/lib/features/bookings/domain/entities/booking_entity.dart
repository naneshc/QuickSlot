class BookingEntity {
  final String id;
  final String venueId;
  final String venueName;
  final String location;
  final String imageUrl;
  final String date;
  final String timeSlot;
  final String userId;
  final String bookedAt;
  final String status;

  const BookingEntity({
    required this.id,
    required this.venueId,
    required this.venueName,
    required this.location,
    required this.imageUrl,
    required this.date,
    required this.timeSlot,
    required this.userId,
    required this.bookedAt,
    required this.status,
  });
}
