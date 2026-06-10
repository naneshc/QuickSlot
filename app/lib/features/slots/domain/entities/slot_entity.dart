class SlotEntity {
  final String timeSlot;
  final String status; // 'available' or 'booked'
  final String? bookingId;
  final String? userId;

  const SlotEntity({
    required this.timeSlot,
    required this.status,
    this.bookingId,
    this.userId,
  });

  bool get isBooked => status == 'booked';
  bool get isAvailable => status == 'available';
}
