import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/booking_entity.dart';

abstract class BookingRepository {
  Future<Result<List<BookingEntity>, Failure>> getUserBookings(String userId);
  Future<Result<void, Failure>> cancelBooking(String bookingId);
}
