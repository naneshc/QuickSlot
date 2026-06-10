import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

class GetUserBookings {
  final BookingRepository repository;

  GetUserBookings(this.repository);

  Future<Result<List<BookingEntity>, Failure>> call(String userId) async {
    return await repository.getUserBookings(userId);
  }
}
